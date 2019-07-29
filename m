Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C666A7868E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 09:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfG2HpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 03:45:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:35986 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726862AbfG2HpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 03:45:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7FC2CAE5E;
        Mon, 29 Jul 2019 07:45:24 +0000 (UTC)
Date:   Mon, 29 Jul 2019 09:45:23 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Miguel de Dios <migueldedios@google.com>,
        Wei Wang <wvw@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH] mm: release the spinlock on zap_pte_range
Message-ID: <20190729074523.GC9330@dhcp22.suse.cz>
References: <20190729071037.241581-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729071037.241581-1-minchan@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 29-07-19 16:10:37, Minchan Kim wrote:
> In our testing(carmera recording), Miguel and Wei found unmap_page_range
> takes above 6ms with preemption disabled easily. When I see that, the
> reason is it holds page table spinlock during entire 512 page operation
> in a PMD. 6.2ms is never trivial for user experince if RT task couldn't
> run in the time because it could make frame drop or glitch audio problem.

Where is the time spent during the tear down? 512 pages doesn't sound
like a lot to tear down. Is it the TLB flushing?

> This patch adds preemption point like coyp_pte_range.
> 
> Reported-by: Miguel de Dios <migueldedios@google.com>
> Reported-by: Wei Wang <wvw@google.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>  mm/memory.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 2e796372927fd..bc3e0c5e4f89b 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1007,6 +1007,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  				struct zap_details *details)
>  {
>  	struct mm_struct *mm = tlb->mm;
> +	int progress = 0;
>  	int force_flush = 0;
>  	int rss[NR_MM_COUNTERS];
>  	spinlock_t *ptl;
> @@ -1022,7 +1023,16 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  	flush_tlb_batched_pending(mm);
>  	arch_enter_lazy_mmu_mode();
>  	do {
> -		pte_t ptent = *pte;
> +		pte_t ptent;
> +
> +		if (progress >= 32) {
> +			progress = 0;
> +			if (need_resched())
> +				break;
> +		}
> +		progress += 8;

Why 8?

> +
> +		ptent = *pte;
>  		if (pte_none(ptent))
>  			continue;
>  
> @@ -1123,8 +1133,11 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  	if (force_flush) {
>  		force_flush = 0;
>  		tlb_flush_mmu(tlb);
> -		if (addr != end)
> -			goto again;
> +	}
> +
> +	if (addr != end) {
> +		progress = 0;
> +		goto again;
>  	}
>  
>  	return addr;
> -- 
> 2.22.0.709.g102302147b-goog

-- 
Michal Hocko
SUSE Labs
