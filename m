Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7560782DD3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 10:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732288AbfHFIgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 04:36:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:57730 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728845AbfHFIgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 04:36:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3ACB5ABC7;
        Tue,  6 Aug 2019 08:36:07 +0000 (UTC)
Date:   Tue, 6 Aug 2019 10:36:05 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dave.hansen@intel.com, Ingo Molnar <mingo@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH V2] fork: Improve error message for corrupted page tables
Message-ID: <20190806083605.GA19060@dhcp22.suse.cz>
References: <3ef8a340deb1c87b725d44edb163073e2b6eca5a.1565059496.git.sai.praneeth.prakhya@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ef8a340deb1c87b725d44edb163073e2b6eca5a.1565059496.git.sai.praneeth.prakhya@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05-08-19 20:05:27, Sai Praneeth Prakhya wrote:
> When a user process exits, the kernel cleans up the mm_struct of the user
> process and during cleanup, check_mm() checks the page tables of the user
> process for corruption (E.g: unexpected page flags set/cleared). For
> corrupted page tables, the error message printed by check_mm() isn't very
> clear as it prints the loop index instead of page table type (E.g: Resident
> file mapping pages vs Resident shared memory pages). The loop index in
> check_mm() is used to index rss_stat[] which represents individual memory
> type stats. Hence, instead of printing index, print memory type, thereby
> improving error message.
> 
> Without patch:
> --------------
> [  204.836425] mm/pgtable-generic.c:29: bad p4d 0000000089eb4e92(800000025f941467)
> [  204.836544] BUG: Bad rss-counter state mm:00000000f75895ea idx:0 val:2
> [  204.836615] BUG: Bad rss-counter state mm:00000000f75895ea idx:1 val:5
> [  204.836685] BUG: non-zero pgtables_bytes on freeing mm: 20480
> 
> With patch:
> -----------
> [   69.815453] mm/pgtable-generic.c:29: bad p4d 0000000084653642(800000025ca37467)
> [   69.815872] BUG: Bad rss-counter state mm:00000000014a6c03 type:MM_FILEPAGES val:2
> [   69.815962] BUG: Bad rss-counter state mm:00000000014a6c03 type:MM_ANONPAGES val:5
> [   69.816050] BUG: non-zero pgtables_bytes on freeing mm: 20480

I like this. On any occasion I am investigating an issue with an rss
inbalance I have to go back to kernel sources to see which pte type that
is.

> Also, change print function (from printk(KERN_ALERT, ..) to pr_alert()) so
> that it matches the other print statement.

good change as well. Maybe we should also lower the loglevel (in a
separate patch) as well. While this is not nice because we are
apparently leaking memory behind it shouldn't be really critical enough
to jump on normal consoles.

> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Acked-by: Dave Hansen <dave.hansen@intel.com>
> Suggested-by: Dave Hansen <dave.hansen@intel.com>
> Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
> 
> Changes from V1 to V2:
> ----------------------
> 1. Move struct definition from header file to fork.c file, so that it won't be
>    included in every compilation unit. As this struct is used *only* in fork.c,
>    include the definition in fork.c itself.
> 2. Index the struct to match respective macros.
> 3. Mention about print function change in commit message.
> 
>  kernel/fork.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index d8ae0f1b4148..f34f441c50c0 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -125,6 +125,13 @@ int nr_threads;			/* The idle threads do not count.. */
>  
>  static int max_threads;		/* tunable limit on nr_threads */
>  
> +static const char * const resident_page_types[NR_MM_COUNTERS] = {
> +	[MM_FILEPAGES]		= "MM_FILEPAGES",
> +	[MM_ANONPAGES]		= "MM_ANONPAGES",
> +	[MM_SWAPENTS]		= "MM_SWAPENTS",
> +	[MM_SHMEMPAGES]		= "MM_SHMEMPAGES",
> +};
> +
>  DEFINE_PER_CPU(unsigned long, process_counts) = 0;
>  
>  __cacheline_aligned DEFINE_RWLOCK(tasklist_lock);  /* outer */
> @@ -649,8 +656,8 @@ static void check_mm(struct mm_struct *mm)
>  		long x = atomic_long_read(&mm->rss_stat.count[i]);
>  
>  		if (unlikely(x))
> -			printk(KERN_ALERT "BUG: Bad rss-counter state "
> -					  "mm:%p idx:%d val:%ld\n", mm, i, x);
> +			pr_alert("BUG: Bad rss-counter state mm:%p type:%s val:%ld\n",
> +				 mm, resident_page_types[i], x);
>  	}
>  
>  	if (mm_pgtables_bytes(mm))
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
