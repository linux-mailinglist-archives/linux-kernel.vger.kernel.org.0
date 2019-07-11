Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91EC264D18
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 21:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbfGJT7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 15:59:45 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38865 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfGJT7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 15:59:44 -0400
Received: by mail-pg1-f196.google.com with SMTP id z75so1737148pgz.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 12:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h0BX3mdDUgHm9iC9zApJq64h1iRY9VPLnwEaSxZ1oQ8=;
        b=R/qIHl8HdqvrmPbHzQg1HfwACUqyDWMzNPh7VzXZarBJD7FL6QHsDFUONqGPupB6Iv
         MZuOztgGv+4V6P7aeQ1eRgYeGba2YQsDmGQBmxSexwJibrv9f/gMrTOA4P+R+TdLcCP+
         Jkql/CVYFIrMb0Q9ngLiiRPq+Pa6ui2xTXP9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h0BX3mdDUgHm9iC9zApJq64h1iRY9VPLnwEaSxZ1oQ8=;
        b=n296hzkCJ/FLZq5dq89395eW0+5w08jZdhu0hAwCP6PjTDQmH0UOV7DdqRcJzdYTUB
         uTp2zWCKF1Hr+NxcFX52DvBWjmwpajAOwEM6avHblNiet7farMhs300Q7j7bqmnZil8s
         MKO/c14bTWYkoDByxVtKC3gHzmejn/OE9RTpeJq3YZnfQ1gwqjM69zV4wOlvrakwh3y9
         M8CTM8igKCMCMs89VuQYjfCd3/vSae1V0OAYDF3HBK6nLcXrbIyXwn0sG0ufinLP80cW
         YwOfGPfsXL/h7sUCpxZOvu+3h4y1vIHmQTE3kvt3IZoKYuCfvm/HOSMYB/BgJ+1X6HSr
         khuw==
X-Gm-Message-State: APjAAAUhA3BLnAfndKjtAZrceY1Mx3K2n/nWwMw0GaBGyMUrRXHZfW+z
        QA3o61GRZfw+yfiERwlqQuMLtQ==
X-Google-Smtp-Source: APXvYqzBxITAjeNmO/YfbFOXzo6LKnAEOJ6hWvh1q5IlLkbUfd4WbgXEjamhKiFHKVoDvijaMJpH7A==
X-Received: by 2002:a63:6d6:: with SMTP id 205mr25934pgg.262.1562788783843;
        Wed, 10 Jul 2019 12:59:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t9sm2937225pji.18.2019.07.10.12.59.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Jul 2019 12:59:42 -0700 (PDT)
Date:   Wed, 10 Jul 2019 12:59:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Xi Ruoyao <xry111@mengyan1223.wang>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jikos@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Bob Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] x86/asm: Move native_write_cr0/3() out of line
Message-ID: <201907101258.FE97AEC86@keescook>
References: <cb6d381ed7cd0bf732ae9d8f30c806b849b0f94b.camel@mengyan1223.wang>
 <alpine.DEB.2.21.1907101404570.1758@nanos.tec.linutronix.de>
 <nycvar.YFH.7.76.1907101425290.5899@cbobk.fhfr.pm>
 <768463eb26a2feb0fcc374fd7f9cc28b96976917.camel@mengyan1223.wang>
 <20190710134433.GN3402@hirez.programming.kicks-ass.net>
 <nycvar.YFH.7.76.1907101621050.5899@cbobk.fhfr.pm>
 <20190710142653.GJ3419@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1907101709340.1758@nanos.tec.linutronix.de>
 <a822cf447949582e2a11b7899f22b11da02f0ece.camel@mengyan1223.wang>
 <alpine.DEB.2.21.1907102140340.1758@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907102140340.1758@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 09:42:46PM +0200, Thomas Gleixner wrote:
> The pinning of sensitive CR0 and CR4 bits caused a boot crash when loading
> the kvm_intel module on a kernel compiled with CONFIG_PARAVIRT=n.
> 
> The reason is that the static key which controls the pinning is marked RO
> after init. The kvm_intel module contains a CR4 write which requires to
> update the static key entry list. That obviously does not work when the key
> is in a RO section.
> 
> With CONFIG_PARAVIRT enabled this does not happen because the CR4 write
> uses the paravirt indirection and the actual write function is built in.
> 
> As the key is intended to be immutable after init, move
> native_write_cr0/3() out of line.
> 
> While at it consolidate the update of the cr4 shadow variable and store the
> value right away when the pinning is initialized on a booting CPU. No point
> in reading it back 20 instructions later. This allows to confine the static
> key and the pinning variable to cpu/common and allows to mark them static.
> 
> Fixes: 8dbec27a242c ("x86/asm: Pin sensitive CR0 bits")
> Fixes: 873d50d58f67 ("x86/asm: Pin sensitive CR4 bits")
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Reported-by: Xi Ruoyao <xry111@mengyan1223.wang>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Xi Ruoyao <xry111@mengyan1223.wang>

Thank you for tracking this down and solving it!

Nit: should be "cr0/4()" in Subject and in paragraph 4.

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/x86/include/asm/processor.h     |    1 
>  arch/x86/include/asm/special_insns.h |   41 -------------------
>  arch/x86/kernel/cpu/common.c         |   72 +++++++++++++++++++++++++++--------
>  arch/x86/kernel/smpboot.c            |   14 ------
>  arch/x86/xen/smp_pv.c                |    1 
>  5 files changed, 61 insertions(+), 68 deletions(-)
> 
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -741,6 +741,7 @@ extern void load_direct_gdt(int);
>  extern void load_fixmap_gdt(int);
>  extern void load_percpu_segment(int);
>  extern void cpu_init(void);
> +extern void cr4_init(void);
>  
>  static inline unsigned long get_debugctlmsr(void)
>  {
> --- a/arch/x86/include/asm/special_insns.h
> +++ b/arch/x86/include/asm/special_insns.h
> @@ -18,9 +18,7 @@
>   */
>  extern unsigned long __force_order;
>  
> -/* Starts false and gets enabled once CPU feature detection is done. */
> -DECLARE_STATIC_KEY_FALSE(cr_pinning);
> -extern unsigned long cr4_pinned_bits;
> +void native_write_cr0(unsigned long val);
>  
>  static inline unsigned long native_read_cr0(void)
>  {
> @@ -29,24 +27,6 @@ static inline unsigned long native_read_
>  	return val;
>  }
>  
> -static inline void native_write_cr0(unsigned long val)
> -{
> -	unsigned long bits_missing = 0;
> -
> -set_register:
> -	asm volatile("mov %0,%%cr0": "+r" (val), "+m" (__force_order));
> -
> -	if (static_branch_likely(&cr_pinning)) {
> -		if (unlikely((val & X86_CR0_WP) != X86_CR0_WP)) {
> -			bits_missing = X86_CR0_WP;
> -			val |= bits_missing;
> -			goto set_register;
> -		}
> -		/* Warn after we've set the missing bits. */
> -		WARN_ONCE(bits_missing, "CR0 WP bit went missing!?\n");
> -	}
> -}
> -
>  static inline unsigned long native_read_cr2(void)
>  {
>  	unsigned long val;
> @@ -91,24 +71,7 @@ static inline unsigned long native_read_
>  	return val;
>  }
>  
> -static inline void native_write_cr4(unsigned long val)
> -{
> -	unsigned long bits_missing = 0;
> -
> -set_register:
> -	asm volatile("mov %0,%%cr4": "+r" (val), "+m" (cr4_pinned_bits));
> -
> -	if (static_branch_likely(&cr_pinning)) {
> -		if (unlikely((val & cr4_pinned_bits) != cr4_pinned_bits)) {
> -			bits_missing = ~val & cr4_pinned_bits;
> -			val |= bits_missing;
> -			goto set_register;
> -		}
> -		/* Warn after we've set the missing bits. */
> -		WARN_ONCE(bits_missing, "CR4 bits went missing: %lx!?\n",
> -			  bits_missing);
> -	}
> -}
> +void native_write_cr4(unsigned long val);
>  
>  #ifdef CONFIG_X86_64
>  static inline unsigned long native_read_cr8(void)
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -366,10 +366,62 @@ static __always_inline void setup_umip(s
>  	cr4_clear_bits(X86_CR4_UMIP);
>  }
>  
> -DEFINE_STATIC_KEY_FALSE_RO(cr_pinning);
> -EXPORT_SYMBOL(cr_pinning);
> -unsigned long cr4_pinned_bits __ro_after_init;
> -EXPORT_SYMBOL(cr4_pinned_bits);
> +static DEFINE_STATIC_KEY_FALSE_RO(cr_pinning);
> +static unsigned long cr4_pinned_bits __ro_after_init;
> +
> +void native_write_cr0(unsigned long val)
> +{
> +	unsigned long bits_missing = 0;
> +
> +set_register:
> +	asm volatile("mov %0,%%cr0": "+r" (val), "+m" (__force_order));
> +
> +	if (static_branch_likely(&cr_pinning)) {
> +		if (unlikely((val & X86_CR0_WP) != X86_CR0_WP)) {
> +			bits_missing = X86_CR0_WP;
> +			val |= bits_missing;
> +			goto set_register;
> +		}
> +		/* Warn after we've set the missing bits. */
> +		WARN_ONCE(bits_missing, "CR0 WP bit went missing!?\n");
> +	}
> +}
> +EXPORT_SYMBOL(native_write_cr0);
> +
> +void native_write_cr4(unsigned long val)
> +{
> +	unsigned long bits_missing = 0;
> +
> +set_register:
> +	asm volatile("mov %0,%%cr4": "+r" (val), "+m" (cr4_pinned_bits));
> +
> +	if (static_branch_likely(&cr_pinning)) {
> +		if (unlikely((val & cr4_pinned_bits) != cr4_pinned_bits)) {
> +			bits_missing = ~val & cr4_pinned_bits;
> +			val |= bits_missing;
> +			goto set_register;
> +		}
> +		/* Warn after we've set the missing bits. */
> +		WARN_ONCE(bits_missing, "CR4 bits went missing: %lx!?\n",
> +			  bits_missing);
> +	}
> +}
> +EXPORT_SYMBOL(native_write_cr4);
> +
> +void cr4_init(void)
> +{
> +	unsigned long cr4 = __read_cr4();
> +
> +	if (boot_cpu_has(X86_FEATURE_PCID))
> +		cr4 |= X86_CR4_PCIDE;
> +	if (static_branch_likely(&cr_pinning))
> +		cr4 |= cr4_pinned_bits;
> +
> +	__write_cr4(cr4);
> +
> +	/* Initialize cr4 shadow for this CPU. */
> +	this_cpu_write(cpu_tlbstate.cr4, cr4);
> +}
>  
>  /*
>   * Once CPU feature detection is finished (and boot params have been
> @@ -1723,12 +1775,6 @@ void cpu_init(void)
>  
>  	wait_for_master_cpu(cpu);
>  
> -	/*
> -	 * Initialize the CR4 shadow before doing anything that could
> -	 * try to read it.
> -	 */
> -	cr4_init_shadow();
> -
>  	if (cpu)
>  		load_ucode_ap();
>  
> @@ -1823,12 +1869,6 @@ void cpu_init(void)
>  
>  	wait_for_master_cpu(cpu);
>  
> -	/*
> -	 * Initialize the CR4 shadow before doing anything that could
> -	 * try to read it.
> -	 */
> -	cr4_init_shadow();
> -
>  	show_ucode_info_early();
>  
>  	pr_info("Initializing CPU#%d\n", cpu);
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -210,28 +210,16 @@ static int enable_start_cpu0;
>   */
>  static void notrace start_secondary(void *unused)
>  {
> -	unsigned long cr4 = __read_cr4();
> -
>  	/*
>  	 * Don't put *anything* except direct CPU state initialization
>  	 * before cpu_init(), SMP booting is too fragile that we want to
>  	 * limit the things done here to the most necessary things.
>  	 */
> -	if (boot_cpu_has(X86_FEATURE_PCID))
> -		cr4 |= X86_CR4_PCIDE;
> -	if (static_branch_likely(&cr_pinning))
> -		cr4 |= cr4_pinned_bits;
> -
> -	__write_cr4(cr4);
> +	cr4_init();
>  
>  #ifdef CONFIG_X86_32
>  	/* switch away from the initial page table */
>  	load_cr3(swapper_pg_dir);
> -	/*
> -	 * Initialize the CR4 shadow before doing anything that could
> -	 * try to read it.
> -	 */
> -	cr4_init_shadow();
>  	__flush_tlb_all();
>  #endif
>  	load_current_idt();
> --- a/arch/x86/xen/smp_pv.c
> +++ b/arch/x86/xen/smp_pv.c
> @@ -58,6 +58,7 @@ static void cpu_bringup(void)
>  {
>  	int cpu;
>  
> +	cr4_init();
>  	cpu_init();
>  	touch_softlockup_watchdog();
>  	preempt_disable();

-- 
Kees Cook
