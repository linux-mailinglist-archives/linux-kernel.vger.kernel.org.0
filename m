Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3364371FA9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 20:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391586AbfGWSwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 14:52:55 -0400
Received: from thoth.sbs.de ([192.35.17.2]:51911 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbfGWSwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 14:52:54 -0400
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id x6NIqN15021719
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Jul 2019 20:52:23 +0200
Received: from [139.25.68.37] (md1q0hnc.ad001.siemens.net [139.25.68.37] (may be forged))
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id x6NIqLK4011734;
        Tue, 23 Jul 2019 20:52:21 +0200
Subject: Re: [PATCH] x86: Optimize load_mm_cr4 to load_mm_cr4_irqsoff
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org
References: <0fbbcb64-5f26-4ffb-1bb9-4f5f48426893@siemens.com>
Message-ID: <fe93bc72-74a0-ab39-9d42-9401609594ac@siemens.com>
Date:   Tue, 23 Jul 2019 20:52:21 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <0fbbcb64-5f26-4ffb-1bb9-4f5f48426893@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.06.19 09:32, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> We only call load_mm_cr4 with interrupts disabled:
>  - switch_mm_irqs_off
>  - refresh_pce (on_each_cpu callback)
> 
> Thus, we can avoid disabling interrupts again in cr4_set/clear_bits.
> 
> Instead, provide cr4_set/clear_bits_irqsoffs and call those helpers from
> load_mm_cr4_irqsoff. The renaming in combination with the checks
> in __cr4_set shall ensure that any changes in the boundary conditions of
> the invocations will be detected.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> Found while porting Xenomai with its virtualized interrupt
> infrastructure to a newer kernel.
> 
>  arch/x86/events/core.c             |  2 +-
>  arch/x86/include/asm/mmu_context.h |  8 ++++----
>  arch/x86/include/asm/tlbflush.h    | 30 +++++++++++++++++++++++-------
>  arch/x86/mm/tlb.c                  |  2 +-
>  4 files changed, 29 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index f315425d8468..78a3fba28c62 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2161,7 +2161,7 @@ static int x86_pmu_event_init(struct perf_event *event)
>  
>  static void refresh_pce(void *ignored)
>  {
> -	load_mm_cr4(this_cpu_read(cpu_tlbstate.loaded_mm));
> +	load_mm_cr4_irqsoff(this_cpu_read(cpu_tlbstate.loaded_mm));
>  }
>  
>  static void x86_pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
> diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
> index 9024236693d2..16ae821483c8 100644
> --- a/arch/x86/include/asm/mmu_context.h
> +++ b/arch/x86/include/asm/mmu_context.h
> @@ -28,16 +28,16 @@ static inline void paravirt_activate_mm(struct mm_struct *prev,
>  
>  DECLARE_STATIC_KEY_FALSE(rdpmc_always_available_key);
>  
> -static inline void load_mm_cr4(struct mm_struct *mm)
> +static inline void load_mm_cr4_irqsoff(struct mm_struct *mm)
>  {
>  	if (static_branch_unlikely(&rdpmc_always_available_key) ||
>  	    atomic_read(&mm->context.perf_rdpmc_allowed))
> -		cr4_set_bits(X86_CR4_PCE);
> +		cr4_set_bits_irqsoff(X86_CR4_PCE);
>  	else
> -		cr4_clear_bits(X86_CR4_PCE);
> +		cr4_clear_bits_irqsoff(X86_CR4_PCE);
>  }
>  #else
> -static inline void load_mm_cr4(struct mm_struct *mm) {}
> +static inline void load_mm_cr4_irqsoff(struct mm_struct *mm) {}
>  #endif
>  
>  #ifdef CONFIG_MODIFY_LDT_SYSCALL
> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
> index dee375831962..6f66d841262d 100644
> --- a/arch/x86/include/asm/tlbflush.h
> +++ b/arch/x86/include/asm/tlbflush.h
> @@ -290,26 +290,42 @@ static inline void __cr4_set(unsigned long cr4)
>  }
>  
>  /* Set in this cpu's CR4. */
> -static inline void cr4_set_bits(unsigned long mask)
> +static inline void cr4_set_bits_irqsoff(unsigned long mask)
>  {
> -	unsigned long cr4, flags;
> +	unsigned long cr4;
>  
> -	local_irq_save(flags);
>  	cr4 = this_cpu_read(cpu_tlbstate.cr4);
>  	if ((cr4 | mask) != cr4)
>  		__cr4_set(cr4 | mask);
> -	local_irq_restore(flags);
>  }
>  
>  /* Clear in this cpu's CR4. */
> -static inline void cr4_clear_bits(unsigned long mask)
> +static inline void cr4_clear_bits_irqsoff(unsigned long mask)
>  {
> -	unsigned long cr4, flags;
> +	unsigned long cr4;
>  
> -	local_irq_save(flags);
>  	cr4 = this_cpu_read(cpu_tlbstate.cr4);
>  	if ((cr4 & ~mask) != cr4)
>  		__cr4_set(cr4 & ~mask);
> +}
> +
> +/* Set in this cpu's CR4. */
> +static inline void cr4_set_bits(unsigned long mask)
> +{
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	cr4_set_bits_irqsoff(mask);
> +	local_irq_restore(flags);
> +}
> +
> +/* Clear in this cpu's CR4. */
> +static inline void cr4_clear_bits(unsigned long mask)
> +{
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	cr4_clear_bits_irqsoff(mask);
>  	local_irq_restore(flags);
>  }
>  
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 91f6db92554c..8fc1eaa55b6e 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -440,7 +440,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
>  	this_cpu_write(cpu_tlbstate.loaded_mm_asid, new_asid);
>  
>  	if (next != real_prev) {
> -		load_mm_cr4(next);
> +		load_mm_cr4_irqsoff(next);
>  		switch_ldt(real_prev, next);
>  	}
>  }
> 

Ping. I think the only remark of Dave was answered.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
