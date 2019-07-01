Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6FE0387F5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 12:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbfFGKau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 06:30:50 -0400
Received: from foss.arm.com ([217.140.110.172]:37474 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726939AbfFGKat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 06:30:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CF51344;
        Fri,  7 Jun 2019 03:30:49 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7760D3F246;
        Fri,  7 Jun 2019 03:32:28 -0700 (PDT)
Date:   Fri, 7 Jun 2019 11:30:46 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH V3 1/2] arm64/mm: Consolidate page fault information
 capture
Message-ID: <20190607103045.GB15753@lakrids.cambridge.arm.com>
References: <1559898786-28530-1-git-send-email-anshuman.khandual@arm.com>
 <1559898786-28530-2-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559898786-28530-2-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 02:43:05PM +0530, Anshuman Khandual wrote:
> This consolidates page fault information capture and move them bit earlier.
> While here it also adds an wrapper is_write_abort(). It also saves some
> cycles by replacing multiple user_mode() calls into a single one earlier
> during the fault.
> 
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Andrey Konovalov <andreyknvl@google.com>
> ---
>  arch/arm64/mm/fault.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)

As I mentioned previously, I doubt that this has any measureable impact
on performance, and other than commenting the caveats w.r.t. cache
maintenance, I'm not sure this makes things any clearer.

However, AFAICT it is correct, so I'll leave that to Catalin:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> 
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 7c1c8f4..95cac4a 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -435,6 +435,15 @@ static bool is_el0_instruction_abort(unsigned int esr)
>  	return ESR_ELx_EC(esr) == ESR_ELx_EC_IABT_LOW;
>  }
>  
> +/*
> + * Note: not valid for EL1 DC IVAC, but we never use that such that it
> + * should fault. EL0 cannot issue DC IVAC (undef).
> + */
> +static bool is_write_abort(unsigned int esr)
> +{
> +	return (esr & ESR_ELx_WNR) && !(esr & ESR_ELx_CM);
> +}
> +
>  static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
>  				   struct pt_regs *regs)
>  {
> @@ -443,6 +452,9 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
>  	vm_fault_t fault, major = 0;
>  	unsigned long vm_flags = VM_READ | VM_WRITE;
>  	unsigned int mm_flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
> +	bool is_user = user_mode(regs);
> +	bool is_el0_exec = is_el0_instruction_abort(esr);
> +	bool is_write = is_write_abort(esr);
>  
>  	if (notify_page_fault(regs, esr))
>  		return 0;
> @@ -454,13 +466,13 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
>  	if (faulthandler_disabled() || !mm)
>  		goto no_context;
>  
> -	if (user_mode(regs))
> +	if (is_user)
>  		mm_flags |= FAULT_FLAG_USER;
>  
> -	if (is_el0_instruction_abort(esr)) {
> +	if (is_el0_exec) {
>  		vm_flags = VM_EXEC;
>  		mm_flags |= FAULT_FLAG_INSTRUCTION;
> -	} else if ((esr & ESR_ELx_WNR) && !(esr & ESR_ELx_CM)) {
> +	} else if (is_write) {
>  		vm_flags = VM_WRITE;
>  		mm_flags |= FAULT_FLAG_WRITE;
>  	}
> @@ -488,7 +500,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
>  	 * we can bug out early if this is from code which shouldn't.
>  	 */
>  	if (!down_read_trylock(&mm->mmap_sem)) {
> -		if (!user_mode(regs) && !search_exception_tables(regs->pc))
> +		if (!is_user && !search_exception_tables(regs->pc))
>  			goto no_context;
>  retry:
>  		down_read(&mm->mmap_sem);
> @@ -499,7 +511,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
>  		 */
>  		might_sleep();
>  #ifdef CONFIG_DEBUG_VM
> -		if (!user_mode(regs) && !search_exception_tables(regs->pc)) {
> +		if (!is_user && !search_exception_tables(regs->pc)) {
>  			up_read(&mm->mmap_sem);
>  			goto no_context;
>  		}
> @@ -517,7 +529,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
>  		 * in __lock_page_or_retry in mm/filemap.c.
>  		 */
>  		if (fatal_signal_pending(current)) {
> -			if (!user_mode(regs))
> +			if (!is_user)
>  				goto no_context;
>  			return 0;
>  		}
> @@ -562,7 +574,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
>  	 * If we are in kernel mode at this point, we have no context to
>  	 * handle this fault with.
>  	 */
> -	if (!user_mode(regs))
> +	if (!is_user)
>  		goto no_context;
>  
>  	if (fault & VM_FAULT_OOM) {
> -- 
> 2.7.4
> 
