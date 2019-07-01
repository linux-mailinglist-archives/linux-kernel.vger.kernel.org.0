Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE3F50041
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 05:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbfFXDfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jun 2019 23:35:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40906 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbfFXDfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 23:35:14 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8A6FD85546;
        Mon, 24 Jun 2019 03:35:04 +0000 (UTC)
Received: from ming.t460p (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 953A719C65;
        Mon, 24 Jun 2019 03:34:45 +0000 (UTC)
Date:   Mon, 24 Jun 2019 11:34:40 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH -mm] mm, swap: Fix THP swap out
Message-ID: <20190624033438.GB6563@ming.t460p>
References: <20190624022336.12465-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624022336.12465-1-ying.huang@intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 24 Jun 2019 03:35:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huang Ying,

On Mon, Jun 24, 2019 at 10:23:36AM +0800, Huang, Ying wrote:
> From: Huang Ying <ying.huang@intel.com>
> 
> 0-Day test system reported some OOM regressions for several
> THP (Transparent Huge Page) swap test cases.  These regressions are
> bisected to 6861428921b5 ("block: always define BIO_MAX_PAGES as
> 256").  In the commit, BIO_MAX_PAGES is set to 256 even when THP swap
> is enabled.  So the bio_alloc(gfp_flags, 512) in get_swap_bio() may
> fail when swapping out THP.  That causes the OOM.
> 
> As in the patch description of 6861428921b5 ("block: always define
> BIO_MAX_PAGES as 256"), THP swap should use multi-page bvec to write
> THP to swap space.  So the issue is fixed via doing that in
> get_swap_bio().
> 
> BTW: I remember I have checked the THP swap code when
> 6861428921b5 ("block: always define BIO_MAX_PAGES as 256") was merged,
> and thought the THP swap code needn't to be changed.  But apparently,
> I was wrong.  I should have done this at that time.
> 
> Fixes: 6861428921b5 ("block: always define BIO_MAX_PAGES as 256")
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Rik van Riel <riel@redhat.com>
> Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
> ---
>  mm/page_io.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/page_io.c b/mm/page_io.c
> index 2e8019d0e048..4ab997f84061 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -29,10 +29,9 @@
>  static struct bio *get_swap_bio(gfp_t gfp_flags,
>  				struct page *page, bio_end_io_t end_io)
>  {
> -	int i, nr = hpage_nr_pages(page);
>  	struct bio *bio;
>  
> -	bio = bio_alloc(gfp_flags, nr);
> +	bio = bio_alloc(gfp_flags, 1);
>  	if (bio) {
>  		struct block_device *bdev;
>  
> @@ -41,9 +40,7 @@ static struct bio *get_swap_bio(gfp_t gfp_flags,
>  		bio->bi_iter.bi_sector <<= PAGE_SHIFT - 9;
>  		bio->bi_end_io = end_io;
>  
> -		for (i = 0; i < nr; i++)
> -			bio_add_page(bio, page + i, PAGE_SIZE, 0);

bio_add_page() supposes to work, just wondering why it doesn't recently.

Could you share me one test case for reproducing it?

> -		VM_BUG_ON(bio->bi_iter.bi_size != PAGE_SIZE * nr);
> +		__bio_add_page(bio, page, PAGE_SIZE * hpage_nr_pages(page), 0);
>  	}
>  	return bio;

Actually the above code can be simplified as:

diff --git a/mm/page_io.c b/mm/page_io.c
index 2e8019d0e048..c20b4189d0a1 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -29,7 +29,7 @@
 static struct bio *get_swap_bio(gfp_t gfp_flags,
 				struct page *page, bio_end_io_t end_io)
 {
-	int i, nr = hpage_nr_pages(page);
+	int nr = hpage_nr_pages(page);
 	struct bio *bio;
 
 	bio = bio_alloc(gfp_flags, nr);
@@ -41,8 +41,7 @@ static struct bio *get_swap_bio(gfp_t gfp_flags,
 		bio->bi_iter.bi_sector <<= PAGE_SHIFT - 9;
 		bio->bi_end_io = end_io;
 
-		for (i = 0; i < nr; i++)
-			bio_add_page(bio, page + i, PAGE_SIZE, 0);
+		bio_add_page(bio, page, PAGE_SIZE * nr, 0);
 		VM_BUG_ON(bio->bi_iter.bi_size != PAGE_SIZE * nr);
 	}
 	return bio;


Thanks,
Ming
