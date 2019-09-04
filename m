Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57DE8A7E2F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 10:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbfIDIpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 04:45:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:53354 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726358AbfIDIpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 04:45:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6C855AF55;
        Wed,  4 Sep 2019 08:45:09 +0000 (UTC)
Date:   Wed, 4 Sep 2019 10:45:08 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Tim Murray <timmurray@google.com>,
        carmenjackson@google.com, mayankgupta@google.com,
        dancol@google.com, rostedt@goodmis.org, minchan@kernel.org,
        akpm@linux-foundation.org, kernel-team@android.com,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jerome Glisse <jglisse@redhat.com>, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2] mm: emit tracepoint when RSS changes by threshold
Message-ID: <20190904084508.GL3838@dhcp22.suse.cz>
References: <20190903200905.198642-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903200905.198642-1-joel@joelfernandes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 03-09-19 16:09:05, Joel Fernandes (Google) wrote:
> Useful to track how RSS is changing per TGID to detect spikes in RSS and
> memory hogs. Several Android teams have been using this patch in various
> kernel trees for half a year now. Many reported to me it is really
> useful so I'm posting it upstream.
> 
> Initial patch developed by Tim Murray. Changes I made from original patch:
> o Prevent any additional space consumed by mm_struct.
> o Keep overhead low by checking if tracing is enabled.
> o Add some noise reduction and lower overhead by emitting only on
>   threshold changes.

Does this have any pre-requisite? I do not see trace_rss_stat_enabled in
the Linus tree (nor in linux-next). Besides that why do we need batching
in the first place. Does this have a measurable overhead? How does it
differ from any other tracepoints that we have in other hotpaths (e.g.
page allocator doesn't do any checks).

Other than that this looks reasonable to me.

> Co-developed-by: Tim Murray <timmurray@google.com>
> Signed-off-by: Tim Murray <timmurray@google.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> ---
> 
> v1->v2: Added more commit message.
> 
> Cc: carmenjackson@google.com
> Cc: mayankgupta@google.com
> Cc: dancol@google.com
> Cc: rostedt@goodmis.org
> Cc: minchan@kernel.org
> Cc: akpm@linux-foundation.org
> Cc: kernel-team@android.com
> 
>  include/linux/mm.h          | 14 +++++++++++---
>  include/trace/events/kmem.h | 21 +++++++++++++++++++++
>  mm/memory.c                 | 20 ++++++++++++++++++++
>  3 files changed, 52 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 0334ca97c584..823aaf759bdb 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1671,19 +1671,27 @@ static inline unsigned long get_mm_counter(struct mm_struct *mm, int member)
>  	return (unsigned long)val;
>  }
>  
> +void mm_trace_rss_stat(int member, long count, long value);
> +
>  static inline void add_mm_counter(struct mm_struct *mm, int member, long value)
>  {
> -	atomic_long_add(value, &mm->rss_stat.count[member]);
> +	long count = atomic_long_add_return(value, &mm->rss_stat.count[member]);
> +
> +	mm_trace_rss_stat(member, count, value);
>  }
>  
>  static inline void inc_mm_counter(struct mm_struct *mm, int member)
>  {
> -	atomic_long_inc(&mm->rss_stat.count[member]);
> +	long count = atomic_long_inc_return(&mm->rss_stat.count[member]);
> +
> +	mm_trace_rss_stat(member, count, 1);
>  }
>  
>  static inline void dec_mm_counter(struct mm_struct *mm, int member)
>  {
> -	atomic_long_dec(&mm->rss_stat.count[member]);
> +	long count = atomic_long_dec_return(&mm->rss_stat.count[member]);
> +
> +	mm_trace_rss_stat(member, count, -1);
>  }
>  
>  /* Optimized variant when page is already known not to be PageAnon */
> diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
> index eb57e3037deb..8b88e04fafbf 100644
> --- a/include/trace/events/kmem.h
> +++ b/include/trace/events/kmem.h
> @@ -315,6 +315,27 @@ TRACE_EVENT(mm_page_alloc_extfrag,
>  		__entry->change_ownership)
>  );
>  
> +TRACE_EVENT(rss_stat,
> +
> +	TP_PROTO(int member,
> +		long count),
> +
> +	TP_ARGS(member, count),
> +
> +	TP_STRUCT__entry(
> +		__field(int, member)
> +		__field(long, size)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->member = member;
> +		__entry->size = (count << PAGE_SHIFT);
> +	),
> +
> +	TP_printk("member=%d size=%ldB",
> +		__entry->member,
> +		__entry->size)
> +	);
>  #endif /* _TRACE_KMEM_H */
>  
>  /* This part must be outside protection */
> diff --git a/mm/memory.c b/mm/memory.c
> index e2bb51b6242e..9d81322c24a3 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -72,6 +72,8 @@
>  #include <linux/oom.h>
>  #include <linux/numa.h>
>  
> +#include <trace/events/kmem.h>
> +
>  #include <asm/io.h>
>  #include <asm/mmu_context.h>
>  #include <asm/pgalloc.h>
> @@ -140,6 +142,24 @@ static int __init init_zero_pfn(void)
>  }
>  core_initcall(init_zero_pfn);
>  
> +/*
> + * This threshold is the boundary in the value space, that the counter has to
> + * advance before we trace it. Should be a power of 2. It is to reduce unwanted
> + * trace overhead. The counter is in units of number of pages.
> + */
> +#define TRACE_MM_COUNTER_THRESHOLD 128
> +
> +void mm_trace_rss_stat(int member, long count, long value)
> +{
> +	long thresh_mask = ~(TRACE_MM_COUNTER_THRESHOLD - 1);
> +
> +	if (!trace_rss_stat_enabled())
> +		return;
> +
> +	/* Threshold roll-over, trace it */
> +	if ((count & thresh_mask) != ((count - value) & thresh_mask))
> +		trace_rss_stat(member, count);
> +}
>  
>  #if defined(SPLIT_RSS_COUNTING)
>  
> -- 
> 2.23.0.187.g17f5b7556c-goog

-- 
Michal Hocko
SUSE Labs
