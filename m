Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7734DD0382
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 00:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfJHWnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 18:43:22 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40127 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfJHWnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 18:43:22 -0400
Received: by mail-pf1-f196.google.com with SMTP id x127so267680pfb.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 15:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=e68usEf58iDVSKP+d4E8UDoTBexUzFRigoqA3Uk2Lnc=;
        b=MYlKP5L6Ce3tV0Nijtiol3+NLXgq3qn6u8FBXEMy8shu/R8WDIKASDwB3r8/B16jxi
         xW01rEWr6NGhETYPaNRLalk1R7COgDb0P6dVDOh8iSR29AbGM15yyqpi5+ApKYgkyfG0
         35k3QaOLvQY8gujRTNUPO/nUte8QCYfBvAIIABeeZFA4a7efMTZeErhPyPzxnXNKUfdu
         LDOIxjKMI4tTTPnSQalS34Mazo4zYL6NI7/zjETPJgcxZWbg/b0rU+Bs2+R18lG+aycA
         9kfLta6SovtmY7FWE2A7HA8B+n3NZs2iomuYGv5hAA7Q81AZzy+vx2uTgY5K8UnZwW7o
         4ooQ==
X-Gm-Message-State: APjAAAXmXj7Y2FTd3YOcTJagKNxsuujYX9unLUFzpXc3Ideu+F4RZ+SC
        1Cb4o7aF+zcIE79ebt7BGQ1Zlw==
X-Google-Smtp-Source: APXvYqwc1aa/sybWMsR2BA3Lo7SgcBDomYDrZUUUUNmLKw/60SgO1cBLaz315acEcnSKKpGBZtIIoQ==
X-Received: by 2002:a65:420d:: with SMTP id c13mr823092pgq.420.1570574600295;
        Tue, 08 Oct 2019 15:43:20 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id t21sm205140pgi.87.2019.10.08.15.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 15:43:19 -0700 (PDT)
Date:   Tue, 08 Oct 2019 15:43:19 -0700 (PDT)
X-Google-Original-Date: Tue, 08 Oct 2019 15:41:34 PDT (-0700)
Subject:     Re: [PATCH v4 05/10] mm: Return faster for non-fatal signals in user mode faults
In-Reply-To: <20190923042523.10027-6-peterx@redhat.com>
CC:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, david@redhat.com,
        hughd@google.com, gokhale2@llnl.gov, jglisse@redhat.com,
        xemul@virtuozzo.com, hannes@cmpxchg.org, peterx@redhat.com,
        cracauer@cons.org, mcfadden8@llnl.gov, shli@fb.com,
        aarcange@redhat.com, mike.kravetz@oracle.com,
        dplotnikov@virtuozzo.com, rppt@linux.vnet.ibm.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        mgorman@suse.de, kirill@shutemov.name, dgilbert@redhat.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     peterx@redhat.com
Message-ID: <mhng-2f8b3ac1-9d2a-4c81-9417-62cff5f4190f@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Sep 2019 21:25:18 PDT (-0700), peterx@redhat.com wrote:
> The idea comes from the upstream discussion between Linus and Andrea:
>
>   https://lore.kernel.org/lkml/20171102193644.GB22686@redhat.com/
>
> A summary to the issue: there was a special path in handle_userfault()
> in the past that we'll return a VM_FAULT_NOPAGE when we detected
> non-fatal signals when waiting for userfault handling.  We did that by
> reacquiring the mmap_sem before returning.  However that brings a risk
> in that the vmas might have changed when we retake the mmap_sem and
> even we could be holding an invalid vma structure.
>
> This patch is a preparation of removing that special path by allowing
> the page fault to return even faster if we were interrupted by a
> non-fatal signal during a user-mode page fault handling routine.
>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Suggested-by: Andrea Arcangeli <aarcange@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  arch/alpha/mm/fault.c        |  3 ++-
>  arch/arc/mm/fault.c          |  5 +++++
>  arch/arm/mm/fault.c          |  9 +++++----
>  arch/arm64/mm/fault.c        |  9 +++++----
>  arch/hexagon/mm/vm_fault.c   |  3 ++-
>  arch/ia64/mm/fault.c         |  3 ++-
>  arch/m68k/mm/fault.c         |  5 +++--
>  arch/microblaze/mm/fault.c   |  3 ++-
>  arch/mips/mm/fault.c         |  3 ++-
>  arch/nds32/mm/fault.c        |  9 +++++----
>  arch/nios2/mm/fault.c        |  3 ++-
>  arch/openrisc/mm/fault.c     |  3 ++-
>  arch/parisc/mm/fault.c       |  3 ++-
>  arch/powerpc/mm/fault.c      |  2 ++
>  arch/riscv/mm/fault.c        |  5 +++--
>  arch/s390/mm/fault.c         |  4 ++--
>  arch/sh/mm/fault.c           |  4 ++++
>  arch/sparc/mm/fault_32.c     |  2 +-
>  arch/sparc/mm/fault_64.c     |  3 ++-
>  arch/um/kernel/trap.c        |  4 +++-
>  arch/unicore32/mm/fault.c    |  5 +++--
>  arch/x86/mm/fault.c          |  2 ++
>  arch/xtensa/mm/fault.c       |  3 ++-
>  include/linux/sched/signal.h | 12 ++++++++++++
>  24 files changed, 75 insertions(+), 32 deletions(-)
>
> diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
> index de4cc6936391..ab1d4212d658 100644
> --- a/arch/alpha/mm/fault.c
> +++ b/arch/alpha/mm/fault.c
> @@ -150,7 +150,8 @@ do_page_fault(unsigned long address, unsigned long mmcsr,
>  	   the fault.  */
>  	fault = handle_mm_fault(vma, address, flags);
>
> -	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
> +	if ((fault & VM_FAULT_RETRY) &&
> +	    fault_should_check_signal(user_mode(regs)))
>  		return;
>
>  	if (unlikely(fault & VM_FAULT_ERROR)) {
> diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
> index 61919e4e4eec..27adf4e608e4 100644
> --- a/arch/arc/mm/fault.c
> +++ b/arch/arc/mm/fault.c
> @@ -142,6 +142,11 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
>  				goto no_context;
>  			return;
>  		}
> +
> +		/* Allow user to handle non-fatal signals first */
> +		if (signal_pending(current) && user_mode(regs))
> +			return;
> +
>  		/*
>  		 * retry state machine
>  		 */
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index 2ae28ffec622..f00fb4eafe54 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -291,14 +291,15 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>
>  	fault = __do_page_fault(mm, addr, fsr, flags, tsk);
>
> -	/* If we need to retry but a fatal signal is pending, handle the
> +	/* If we need to retry but a signal is pending, try to handle the
>  	 * signal first. We do not need to release the mmap_sem because
>  	 * it would already be released in __lock_page_or_retry in
>  	 * mm/filemap.c. */
> -	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current)) {
> -		if (!user_mode(regs))
> +	if (unlikely(fault & VM_FAULT_RETRY && signal_pending(current))) {
> +		if (fatal_signal_pending(current) && !user_mode(regs))
>  			goto no_context;
> -		return 0;
> +		if (user_mode(regs))
> +			return 0;
>  	}
>
>  	/*
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 613e7434c208..0d3fe0ea6a70 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -479,15 +479,16 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
>
>  	if (fault & VM_FAULT_RETRY) {
>  		/*
> -		 * If we need to retry but a fatal signal is pending,
> +		 * If we need to retry but a signal is pending, try to
>  		 * handle the signal first. We do not need to release
>  		 * the mmap_sem because it would already be released
>  		 * in __lock_page_or_retry in mm/filemap.c.
>  		 */
> -		if (fatal_signal_pending(current)) {
> -			if (!user_mode(regs))
> +		if (signal_pending(current)) {
> +			if (fatal_signal_pending(current) && !user_mode(regs))
>  				goto no_context;
> -			return 0;
> +			if (user_mode(regs))
> +				return 0;
>  		}
>
>  		/*
> diff --git a/arch/hexagon/mm/vm_fault.c b/arch/hexagon/mm/vm_fault.c
> index 223787e01bdd..88a2e5635bfb 100644
> --- a/arch/hexagon/mm/vm_fault.c
> +++ b/arch/hexagon/mm/vm_fault.c
> @@ -91,7 +91,8 @@ void do_page_fault(unsigned long address, long cause, struct pt_regs *regs)
>
>  	fault = handle_mm_fault(vma, address, flags);
>
> -	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
> +	if ((fault & VM_FAULT_RETRY) &&
> +	    fault_should_check_signal(user_mode(regs)))
>  		return;
>
>  	/* The most common case -- we are done. */
> diff --git a/arch/ia64/mm/fault.c b/arch/ia64/mm/fault.c
> index d039b846f671..8d47acf50fda 100644
> --- a/arch/ia64/mm/fault.c
> +++ b/arch/ia64/mm/fault.c
> @@ -141,7 +141,8 @@ ia64_do_page_fault (unsigned long address, unsigned long isr, struct pt_regs *re
>  	 */
>  	fault = handle_mm_fault(vma, address, flags);
>
> -	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
> +	if ((fault & VM_FAULT_RETRY) &&
> +	    fault_should_check_signal(user_mode(regs)))
>  		return;
>
>  	if (unlikely(fault & VM_FAULT_ERROR)) {
> diff --git a/arch/m68k/mm/fault.c b/arch/m68k/mm/fault.c
> index 8e734309ace9..103f93ba8139 100644
> --- a/arch/m68k/mm/fault.c
> +++ b/arch/m68k/mm/fault.c
> @@ -138,8 +138,9 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
>  	fault = handle_mm_fault(vma, address, flags);
>  	pr_debug("handle_mm_fault returns %x\n", fault);
>
> -	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
> -		return 0;
> +	if ((fault & VM_FAULT_RETRY) &&
> +	    fault_should_check_signal(user_mode(regs)))
> +		return;
>
>  	if (unlikely(fault & VM_FAULT_ERROR)) {
>  		if (fault & VM_FAULT_OOM)
> diff --git a/arch/microblaze/mm/fault.c b/arch/microblaze/mm/fault.c
> index 45c9f66c1dbc..8b0615eab4b6 100644
> --- a/arch/microblaze/mm/fault.c
> +++ b/arch/microblaze/mm/fault.c
> @@ -217,7 +217,8 @@ void do_page_fault(struct pt_regs *regs, unsigned long address,
>  	 */
>  	fault = handle_mm_fault(vma, address, flags);
>
> -	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
> +	if ((fault & VM_FAULT_RETRY) &&
> +	    fault_should_check_signal(user_mode(regs)))
>  		return;
>
>  	if (unlikely(fault & VM_FAULT_ERROR)) {
> diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
> index 6660b77ff8f3..48aac20a1ded 100644
> --- a/arch/mips/mm/fault.c
> +++ b/arch/mips/mm/fault.c
> @@ -154,7 +154,8 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
>  	 */
>  	fault = handle_mm_fault(vma, address, flags);
>
> -	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
> +	if ((fault & VM_FAULT_RETRY) &&
> +	    fault_should_check_signal(user_mode(regs)))
>  		return;
>
>  	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
> diff --git a/arch/nds32/mm/fault.c b/arch/nds32/mm/fault.c
> index a40de112a23a..baa44f9d0b4a 100644
> --- a/arch/nds32/mm/fault.c
> +++ b/arch/nds32/mm/fault.c
> @@ -206,14 +206,15 @@ void do_page_fault(unsigned long entry, unsigned long addr,
>  	fault = handle_mm_fault(vma, addr, flags);
>
>  	/*
> -	 * If we need to retry but a fatal signal is pending, handle the
> +	 * If we need to retry but a signal is pending, try to handle the
>  	 * signal first. We do not need to release the mmap_sem because it
>  	 * would already be released in __lock_page_or_retry in mm/filemap.c.
>  	 */
> -	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current)) {
> -		if (!user_mode(regs))
> +	if ((fault & VM_FAULT_RETRY) && signal_pending(current)) {
> +		if (fatal_signal_pending(current) && !user_mode(regs))
>  			goto no_context;
> -		return;
> +		if (user_mode(regs))
> +			return;
>  	}
>
>  	if (unlikely(fault & VM_FAULT_ERROR)) {
> diff --git a/arch/nios2/mm/fault.c b/arch/nios2/mm/fault.c
> index a401b45cae47..f9f178484184 100644
> --- a/arch/nios2/mm/fault.c
> +++ b/arch/nios2/mm/fault.c
> @@ -133,7 +133,8 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long cause,
>  	 */
>  	fault = handle_mm_fault(vma, address, flags);
>
> -	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
> +	if ((fault & VM_FAULT_RETRY) &&
> +	    fault_should_check_signal(user_mode(regs)))
>  		return;
>
>  	if (unlikely(fault & VM_FAULT_ERROR)) {
> diff --git a/arch/openrisc/mm/fault.c b/arch/openrisc/mm/fault.c
> index fd1592a56238..8ba3696dd10c 100644
> --- a/arch/openrisc/mm/fault.c
> +++ b/arch/openrisc/mm/fault.c
> @@ -161,7 +161,8 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
>
>  	fault = handle_mm_fault(vma, address, flags);
>
> -	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
> +	if ((fault & VM_FAULT_RETRY) &&
> +	    fault_should_check_signal(user_mode(regs)))
>  		return;
>
>  	if (unlikely(fault & VM_FAULT_ERROR)) {
> diff --git a/arch/parisc/mm/fault.c b/arch/parisc/mm/fault.c
> index 355e3e13fa72..163dcb080c7b 100644
> --- a/arch/parisc/mm/fault.c
> +++ b/arch/parisc/mm/fault.c
> @@ -304,7 +304,8 @@ void do_page_fault(struct pt_regs *regs, unsigned long code,
>
>  	fault = handle_mm_fault(vma, address, flags);
>
> -	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
> +	if ((fault & VM_FAULT_RETRY) &&
> +	    fault_should_check_signal(user_mode(regs)))
>  		return;
>
>  	if (unlikely(fault & VM_FAULT_ERROR)) {
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 408ee769c470..d321a6c5fe62 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -596,6 +596,8 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
>  			 */
>  			flags &= ~FAULT_FLAG_ALLOW_RETRY;
>  			flags |= FAULT_FLAG_TRIED;
> +			if (is_user && signal_pending(current))
> +				return 0;
>  			if (!fatal_signal_pending(current))
>  				goto retry;
>  		}
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index deeb820bd855..ea8f301de65b 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -111,11 +111,12 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
>  	fault = handle_mm_fault(vma, addr, flags);
>
>  	/*
> -	 * If we need to retry but a fatal signal is pending, handle the
> +	 * If we need to retry but a signal is pending, try to handle the
>  	 * signal first. We do not need to release the mmap_sem because it
>  	 * would already be released in __lock_page_or_retry in mm/filemap.c.
>  	 */
> -	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(tsk))
> +	if ((fault & VM_FAULT_RETRY) &&
> +	    fault_should_check_signal(user_mode(regs)))
>  		return;
>
>  	if (unlikely(fault & VM_FAULT_ERROR)) {

Acked-by: Palmer Dabbelt <palmer@sifive.com> # RISC-V parts

I'm assuming this is going in through some other tree.

> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> index 74a77b2bca75..3ad77501deef 100644
> --- a/arch/s390/mm/fault.c
> +++ b/arch/s390/mm/fault.c
> @@ -480,8 +480,8 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
>  	 * the fault.
>  	 */
>  	fault = handle_mm_fault(vma, address, flags);
> -	/* No reason to continue if interrupted by SIGKILL. */
> -	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current)) {
> +	if ((fault & VM_FAULT_RETRY) &&
> +	    fault_should_check_signal(user_mode(regs))) {
>  		fault = VM_FAULT_SIGNAL;
>  		if (flags & FAULT_FLAG_RETRY_NOWAIT)
>  			goto out_up;
> diff --git a/arch/sh/mm/fault.c b/arch/sh/mm/fault.c
> index becf0be267bb..f620282a37fd 100644
> --- a/arch/sh/mm/fault.c
> +++ b/arch/sh/mm/fault.c
> @@ -489,6 +489,10 @@ asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
>  			 * have already released it in __lock_page_or_retry
>  			 * in mm/filemap.c.
>  			 */
> +
> +			if (user_mode(regs) && signal_pending(tsk))
> +				return;
> +
>  			goto retry;
>  		}
>  	}
> diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
> index 0863f6fdd2c5..9af0c3ad50d6 100644
> --- a/arch/sparc/mm/fault_32.c
> +++ b/arch/sparc/mm/fault_32.c
> @@ -237,7 +237,7 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
>  	 */
>  	fault = handle_mm_fault(vma, address, flags);
>
> -	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
> +	if ((fault & VM_FAULT_RETRY) && fault_should_check_signal(from_user))
>  		return;
>
>  	if (unlikely(fault & VM_FAULT_ERROR)) {
> diff --git a/arch/sparc/mm/fault_64.c b/arch/sparc/mm/fault_64.c
> index a1cba3eef79e..566f05f9040b 100644
> --- a/arch/sparc/mm/fault_64.c
> +++ b/arch/sparc/mm/fault_64.c
> @@ -421,7 +421,8 @@ asmlinkage void __kprobes do_sparc64_fault(struct pt_regs *regs)
>
>  	fault = handle_mm_fault(vma, address, flags);
>
> -	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
> +	if ((fault & VM_FAULT_RETRY) &&
> +	    fault_should_check_signal(flags & FAULT_FLAG_USER))
>  		goto exit_exception;
>
>  	if (unlikely(fault & VM_FAULT_ERROR)) {
> diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
> index bc2756782d64..3c72111f27e9 100644
> --- a/arch/um/kernel/trap.c
> +++ b/arch/um/kernel/trap.c
> @@ -76,7 +76,9 @@ int handle_page_fault(unsigned long address, unsigned long ip,
>
>  		fault = handle_mm_fault(vma, address, flags);
>
> -		if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
> +
> +		if ((fault & VM_FAULT_RETRY) &&
> +		    fault_should_check_signal(is_user))
>  			goto out_nosemaphore;
>
>  		if (unlikely(fault & VM_FAULT_ERROR)) {
> diff --git a/arch/unicore32/mm/fault.c b/arch/unicore32/mm/fault.c
> index 60453c892c51..04c193439c97 100644
> --- a/arch/unicore32/mm/fault.c
> +++ b/arch/unicore32/mm/fault.c
> @@ -246,11 +246,12 @@ static int do_pf(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>
>  	fault = __do_pf(mm, addr, fsr, flags, tsk);
>
> -	/* If we need to retry but a fatal signal is pending, handle the
> +	/* If we need to retry but a signal is pending, try to handle the
>  	 * signal first. We do not need to release the mmap_sem because
>  	 * it would already be released in __lock_page_or_retry in
>  	 * mm/filemap.c. */
> -	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
> +	if ((fault & VM_FAULT_RETRY) &&
> +	    fault_should_check_signal(user_mode(regs)))
>  		return 0;
>
>  	if (!(fault & VM_FAULT_ERROR) && (flags & FAULT_FLAG_ALLOW_RETRY)) {
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 994c860ac2d8..f7836472961e 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1451,6 +1451,8 @@ void do_user_addr_fault(struct pt_regs *regs,
>  		if (flags & FAULT_FLAG_ALLOW_RETRY) {
>  			flags &= ~FAULT_FLAG_ALLOW_RETRY;
>  			flags |= FAULT_FLAG_TRIED;
> +			if ((flags & FAULT_FLAG_USER) && signal_pending(tsk))
> +				return;
>  			if (!fatal_signal_pending(tsk))
>  				goto retry;
>  		}
> diff --git a/arch/xtensa/mm/fault.c b/arch/xtensa/mm/fault.c
> index d2b082908538..094606676c36 100644
> --- a/arch/xtensa/mm/fault.c
> +++ b/arch/xtensa/mm/fault.c
> @@ -110,7 +110,8 @@ void do_page_fault(struct pt_regs *regs)
>  	 */
>  	fault = handle_mm_fault(vma, address, flags);
>
> -	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
> +	if ((fault & VM_FAULT_RETRY) &&
> +	    fault_should_check_signal(user_mode(regs)))
>  		return;
>
>  	if (unlikely(fault & VM_FAULT_ERROR)) {
> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index efd8ce7675ed..ccce63f2822d 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -377,6 +377,18 @@ static inline int signal_pending_state(long state, struct task_struct *p)
>  	return (state & TASK_INTERRUPTIBLE) || __fatal_signal_pending(p);
>  }
>
> +/*
> + * This should only be used in fault handlers to decide whether we
> + * should stop the current fault routine to handle the signals
> + * instead.  It should normally be used when a signal interrupted a
> + * page fault which can lead to a VM_FAULT_RETRY.
> + */
> +static inline bool fault_should_check_signal(bool is_user)
> +{
> +	return (fatal_signal_pending(current) ||
> +		(is_user && signal_pending(current)));
> +}
> +
>  /*
>   * Reevaluate whether the task has signals pending delivery.
>   * Wake the task if so.
