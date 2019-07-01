Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8A01B1B4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 10:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbfEMIJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 04:09:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:45696 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725928AbfEMIJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 04:09:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C4E52ADAB;
        Mon, 13 May 2019 08:09:30 +0000 (UTC)
Date:   Mon, 13 May 2019 10:09:29 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     ying.huang@intel.com, hannes@cmpxchg.org,
        mgorman@techsingularity.net, kirill.shutemov@linux.intel.com,
        hughd@google.com, shakeelb@google.com,
        william.kucharski@oracle.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] mm: vmscan: correct nr_reclaimed for THP
Message-ID: <20190513080929.GC24036@dhcp22.suse.cz>
References: <1557505420-21809-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557505420-21809-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 11-05-19 00:23:40, Yang Shi wrote:
> Since commit bd4c82c22c36 ("mm, THP, swap: delay splitting THP after
> swapped out"), THP can be swapped out in a whole.  But, nr_reclaimed
> still gets inc'ed by one even though a whole THP (512 pages) gets
> swapped out.
> 
> This doesn't make too much sense to memory reclaim.  For example, direct
> reclaim may just need reclaim SWAP_CLUSTER_MAX pages, reclaiming one THP
> could fulfill it.  But, if nr_reclaimed is not increased correctly,
> direct reclaim may just waste time to reclaim more pages,
> SWAP_CLUSTER_MAX * 512 pages in worst case.

You are technically right here. This has been a known issue for a while.
I am wondering whether somebody actually noticed some misbehavior.
Swapping out is a rare event and you have to have a considerable number
of THPs to notice.

> This change may result in more reclaimed pages than scanned pages showed
> by /proc/vmstat since scanning one head page would reclaim 512 base pages.

This is quite nasty and confusing. I am worried that having those two
unsynced begs for subtle issues. Can we account THP as scanning 512 base
pages as well?

> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Hugh Dickins <hughd@google.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---
> v2: Added Shakeel's Reviewed-by
>     Use hpage_nr_pages instead of compound_order per Huang Ying and William Kucharski
> 
>  mm/vmscan.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index fd9de50..4226d6b 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1446,7 +1446,11 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>  
>  		unlock_page(page);
>  free_it:
> -		nr_reclaimed++;
> +		/* 
> +		 * THP may get swapped out in a whole, need account
> +		 * all base pages.
> +		 */
> +		nr_reclaimed += hpage_nr_pages(page);
>  
>  		/*
>  		 * Is there need to periodically free_page_list? It would
> -- 
> 1.8.3.1
> 

-- 
Michal Hocko
SUSE Labs
