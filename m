Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3FD650370
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 09:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfFXHbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 03:31:49 -0400
Received: from mga17.intel.com ([192.55.52.151]:21026 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbfFXHbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 03:31:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jun 2019 00:31:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,411,1557212400"; 
   d="scan'208";a="184049844"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.29])
  by fmsmga004.fm.intel.com with ESMTP; 24 Jun 2019 00:31:36 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH -mm] mm, swap: Fix THP swap out
References: <20190624022336.12465-1-ying.huang@intel.com>
        <20190624033438.GB6563@ming.t460p>
        <87imsvbnie.fsf@yhuang-dev.intel.com>
        <20190624072830.GA10539@ming.t460p>
Date:   Mon, 24 Jun 2019 15:31:35 +0800
In-Reply-To: <20190624072830.GA10539@ming.t460p> (Ming Lei's message of "Mon,
        24 Jun 2019 15:28:31 +0800")
Message-ID: <87ef3jbfs8.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ming Lei <ming.lei@redhat.com> writes:

> On Mon, Jun 24, 2019 at 12:44:41PM +0800, Huang, Ying wrote:
>> Ming Lei <ming.lei@redhat.com> writes:
>> 
>> > Hi Huang Ying,
>> >
>> > On Mon, Jun 24, 2019 at 10:23:36AM +0800, Huang, Ying wrote:
>> >> From: Huang Ying <ying.huang@intel.com>
>> >> 
>> >> 0-Day test system reported some OOM regressions for several
>> >> THP (Transparent Huge Page) swap test cases.  These regressions are
>> >> bisected to 6861428921b5 ("block: always define BIO_MAX_PAGES as
>> >> 256").  In the commit, BIO_MAX_PAGES is set to 256 even when THP swap
>> >> is enabled.  So the bio_alloc(gfp_flags, 512) in get_swap_bio() may
>> >> fail when swapping out THP.  That causes the OOM.
>> >> 
>> >> As in the patch description of 6861428921b5 ("block: always define
>> >> BIO_MAX_PAGES as 256"), THP swap should use multi-page bvec to write
>> >> THP to swap space.  So the issue is fixed via doing that in
>> >> get_swap_bio().
>> >> 
>> >> BTW: I remember I have checked the THP swap code when
>> >> 6861428921b5 ("block: always define BIO_MAX_PAGES as 256") was merged,
>> >> and thought the THP swap code needn't to be changed.  But apparently,
>> >> I was wrong.  I should have done this at that time.
>> >> 
>> >> Fixes: 6861428921b5 ("block: always define BIO_MAX_PAGES as 256")
>> >> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> >> Cc: Ming Lei <ming.lei@redhat.com>
>> >> Cc: Michal Hocko <mhocko@kernel.org>
>> >> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> >> Cc: Hugh Dickins <hughd@google.com>
>> >> Cc: Minchan Kim <minchan@kernel.org>
>> >> Cc: Rik van Riel <riel@redhat.com>
>> >> Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
>> >> ---
>> >>  mm/page_io.c | 7 ++-----
>> >>  1 file changed, 2 insertions(+), 5 deletions(-)
>> >> 
>> >> diff --git a/mm/page_io.c b/mm/page_io.c
>> >> index 2e8019d0e048..4ab997f84061 100644
>> >> --- a/mm/page_io.c
>> >> +++ b/mm/page_io.c
>> >> @@ -29,10 +29,9 @@
>> >>  static struct bio *get_swap_bio(gfp_t gfp_flags,
>> >>  				struct page *page, bio_end_io_t end_io)
>> >>  {
>> >> -	int i, nr = hpage_nr_pages(page);
>> >>  	struct bio *bio;
>> >>  
>> >> -	bio = bio_alloc(gfp_flags, nr);
>> >> +	bio = bio_alloc(gfp_flags, 1);
>> >>  	if (bio) {
>> >>  		struct block_device *bdev;
>> >>  
>> >> @@ -41,9 +40,7 @@ static struct bio *get_swap_bio(gfp_t gfp_flags,
>> >>  		bio->bi_iter.bi_sector <<= PAGE_SHIFT - 9;
>> >>  		bio->bi_end_io = end_io;
>> >>  
>> >> -		for (i = 0; i < nr; i++)
>> >> -			bio_add_page(bio, page + i, PAGE_SIZE, 0);
>> >
>> > bio_add_page() supposes to work, just wondering why it doesn't recently.
>> 
>> Yes.  Just checked and bio_add_page() works too.  I should have used
>> that.  The problem isn't bio_add_page(), but bio_alloc(), because nr ==
>> 512 > 256, mempool cannot be used during swapout, so swapout will fail.
>
> Then we can pass 1 to bio_alloc(), together with single bio_add_page()
> for making the code more readable.
>

Yes.  Will send out v2 to replace __bio_add_page() with bio_add_page().

Best Regards,
Huang, Ying
