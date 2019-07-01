Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2C74509ED
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 13:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbfFXLkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 07:40:20 -0400
Received: from foss.arm.com ([217.140.110.172]:47854 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbfFXLkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 07:40:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89E602B;
        Mon, 24 Jun 2019 04:40:19 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8624A3F718;
        Mon, 24 Jun 2019 04:40:18 -0700 (PDT)
Date:   Mon, 24 Jun 2019 12:40:10 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     guoren@kernel.org
Cc:     julien.grall@arm.com, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] arm64: asid: Optimize cache_flush for SMT
Message-ID: <20190624114010.GA51882@lakrids.cambridge.arm.com>
References: <1561305869-18872-1-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561305869-18872-1-git-send-email-guoren@kernel.org>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm very confused by this patch. The title says arm64, yet the code is
under arch/csky/, and the code in question refers to HARTs, which IIUC
is RISC-V terminology.

On Mon, Jun 24, 2019 at 12:04:29AM +0800, guoren@kernel.org wrote:
> From: Guo Ren <ren_guo@c-sky.com>
> 
> The hardware threads of one core could share the same TLB for SMT+SMP
> system. Assume hardware threads number sequence like this:
> 
> | 0 1 2 3 | 4 5 6 7 | 8 9 a b | c d e f |
>    core1     core2     core3     core4

Given this is the Linux logical CPU ID rather than a physical CPU ID,
this assumption is not valid. For example, CPUs may be renumbered across
kexec.

Even if this were a physical CPU ID, this doesn't hold on arm64 (e.g.
due to big.LITTLE).

> Current algorithm seems is correct for SMT+SMP, but it'll give some
> duplicate local_tlb_flush. Because one hardware threads local_tlb_flush
> will also flush other hardware threads' TLB entry in one core TLB.

Does any architecture specification mandate that behaviour?

That isn't true for arm64, I have no idea whether RISC-V mandates that,
and as below it seems this is irrelevant on C-SKY.

> So we can use bitmap to reduce local_tlb_flush for SMT.
> 
> C-SKY cores don't support SMT and the patch is no benefit for C-SKY.

As above, this patch is very confusing -- if this doesn't benefit C-SKY,
why modify the C-SKY code?

Thanks,
Mark.

> 
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Julien Grall <julien.grall@arm.com>
> ---
>  arch/csky/include/asm/asid.h |  4 ++++
>  arch/csky/mm/asid.c          | 11 ++++++++++-
>  arch/csky/mm/context.c       |  2 +-
>  3 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/csky/include/asm/asid.h b/arch/csky/include/asm/asid.h
> index ac08b0f..f654492 100644
> --- a/arch/csky/include/asm/asid.h
> +++ b/arch/csky/include/asm/asid.h
> @@ -23,6 +23,9 @@ struct asid_info
>  	unsigned int		ctxt_shift;
>  	/* Callback to locally flush the context. */
>  	void			(*flush_cpu_ctxt_cb)(void);
> +	/* To reduce duplicate tlb_flush for SMT */
> +	unsigned int		harts_per_core;
> +	unsigned int		harts_per_core_mask;
>  };
>  
>  #define NUM_ASIDS(info)			(1UL << ((info)->bits))
> @@ -73,6 +76,7 @@ static inline void asid_check_context(struct asid_info *info,
>  
>  int asid_allocator_init(struct asid_info *info,
>  			u32 bits, unsigned int asid_per_ctxt,
> +			unsigned int harts_per_core,
>  			void (*flush_cpu_ctxt_cb)(void));
>  
>  #endif
> diff --git a/arch/csky/mm/asid.c b/arch/csky/mm/asid.c
> index b2e9147..50a983e 100644
> --- a/arch/csky/mm/asid.c
> +++ b/arch/csky/mm/asid.c
> @@ -148,8 +148,13 @@ void asid_new_context(struct asid_info *info, atomic64_t *pasid,
>  		atomic64_set(pasid, asid);
>  	}
>  
> -	if (cpumask_test_and_clear_cpu(cpu, &info->flush_pending))
> +	if (cpumask_test_cpu(cpu, &info->flush_pending)) {
> +		unsigned int i;
> +		unsigned int harts_base = cpu & info->harts_per_core_mask;
>  		info->flush_cpu_ctxt_cb();
> +		for (i = 0; i < info->harts_per_core; i++)
> +			cpumask_clear_cpu(harts_base + i, &info->flush_pending);
> +	}
>  
>  	atomic64_set(&active_asid(info, cpu), asid);
>  	cpumask_set_cpu(cpu, mm_cpumask(mm));
> @@ -162,15 +167,19 @@ void asid_new_context(struct asid_info *info, atomic64_t *pasid,
>   * @info: Pointer to the asid allocator structure
>   * @bits: Number of ASIDs available
>   * @asid_per_ctxt: Number of ASIDs to allocate per-context. ASIDs are
> + * @harts_per_core: Number hardware threads per core, must be 1, 2, 4, 8, 16 ...
>   * allocated contiguously for a given context. This value should be a power of
>   * 2.
>   */
>  int asid_allocator_init(struct asid_info *info,
>  			u32 bits, unsigned int asid_per_ctxt,
> +			unsigned int harts_per_core,
>  			void (*flush_cpu_ctxt_cb)(void))
>  {
>  	info->bits = bits;
>  	info->ctxt_shift = ilog2(asid_per_ctxt);
> +	info->harts_per_core = harts_per_core;
> +	info->harts_per_core_mask = ~((1 << ilog2(harts_per_core)) - 1);
>  	info->flush_cpu_ctxt_cb = flush_cpu_ctxt_cb;
>  	/*
>  	 * Expect allocation after rollover to fail if we don't have at least
> diff --git a/arch/csky/mm/context.c b/arch/csky/mm/context.c
> index 0d95bdd..b58523b 100644
> --- a/arch/csky/mm/context.c
> +++ b/arch/csky/mm/context.c
> @@ -30,7 +30,7 @@ static int asids_init(void)
>  {
>  	BUG_ON(((1 << CONFIG_CPU_ASID_BITS) - 1) <= num_possible_cpus());
>  
> -	if (asid_allocator_init(&asid_info, CONFIG_CPU_ASID_BITS, 1,
> +	if (asid_allocator_init(&asid_info, CONFIG_CPU_ASID_BITS, 1, 1,
>  				asid_flush_cpu_ctxt))
>  		panic("Unable to initialize ASID allocator for %lu ASIDs\n",
>  		      NUM_ASIDS(&asid_info));
> -- 
> 2.7.4
> 
