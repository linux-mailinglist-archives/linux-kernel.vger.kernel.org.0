Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 448BD195390
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 10:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgC0JHr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 27 Mar 2020 05:07:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56474 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726465AbgC0JHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 05:07:47 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02R92ttJ035927
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 05:07:46 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3017ju2ctv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 05:07:45 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Fri, 27 Mar 2020 09:07:40 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 27 Mar 2020 09:07:38 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02R97eo747972452
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Mar 2020 09:07:40 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70EF9AE053;
        Fri, 27 Mar 2020 09:07:40 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09616AE045;
        Fri, 27 Mar 2020 09:07:40 +0000 (GMT)
Received: from localhost (unknown [9.85.72.235])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 27 Mar 2020 09:07:39 +0000 (GMT)
Date:   Fri, 27 Mar 2020 14:37:37 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] powerpc/kprobes: Blacklist functions running with MMU
 disabled on PPC32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <3ada1af1b479c5a88bf9f3b8955bf5ba3f32f1ba.1582565849.git.christophe.leroy@c-s.fr>
In-Reply-To: <3ada1af1b479c5a88bf9f3b8955bf5ba3f32f1ba.1582565849.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
User-Agent: astroid/v0.15-13-gb675b421
 (https://github.com/astroidmail/astroid)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 20032709-0012-0000-0000-00000398FDBE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032709-0013-0000-0000-000021D5FF00
Message-Id: <1585299144.f9e0pmxsgv.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-27_02:2020-03-26,2020-03-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 mlxlogscore=999 bulkscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003270078
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy wrote:
> kprobe does not handle events happening in real mode, all
> functions running with MMU disabled have to be blacklisted.
> 
> As already done for PPC64, do it for PPC32.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
> v2:
> - Don't rename nonrecoverable as local, mark it noprobe instead.
> - Add missing linux/kprobes.h include in pq2.c
> ---
>  arch/powerpc/include/asm/ppc_asm.h           | 10 +++
>  arch/powerpc/kernel/cpu_setup_6xx.S          |  4 +-
>  arch/powerpc/kernel/entry_32.S               | 65 ++++++++------------
>  arch/powerpc/kernel/fpu.S                    |  1 +
>  arch/powerpc/kernel/idle_6xx.S               |  2 +-
>  arch/powerpc/kernel/idle_e500.S              |  2 +-
>  arch/powerpc/kernel/l2cr_6xx.S               |  2 +-
>  arch/powerpc/kernel/misc.S                   |  2 +
>  arch/powerpc/kernel/misc_32.S                |  4 +-
>  arch/powerpc/kernel/swsusp_32.S              |  6 +-
>  arch/powerpc/kernel/vector.S                 |  1 +
>  arch/powerpc/mm/book3s32/hash_low.S          | 38 ++++++------
>  arch/powerpc/mm/mem.c                        |  2 +
>  arch/powerpc/platforms/52xx/lite5200_sleep.S |  2 +
>  arch/powerpc/platforms/82xx/pq2.c            |  3 +
>  arch/powerpc/platforms/83xx/suspend-asm.S    |  1 +
>  arch/powerpc/platforms/powermac/cache.S      |  2 +
>  arch/powerpc/platforms/powermac/sleep.S      | 13 ++--
>  18 files changed, 86 insertions(+), 74 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
> index 6b03dff61a05..e8f34ba89497 100644
> --- a/arch/powerpc/include/asm/ppc_asm.h
> +++ b/arch/powerpc/include/asm/ppc_asm.h
> @@ -267,8 +267,18 @@ GLUE(.,name):
>  	.pushsection "_kprobe_blacklist","aw";		\
>  	PPC_LONG (entry) ;				\
>  	.popsection
> +#define _NOKPROBE_ENTRY(entry)				\
> +	_ASM_NOKPROBE_SYMBOL(entry)				\
> +	_ENTRY(entry)
> +#define _NOKPROBE_GLOBAL(entry)				\
> +	_ASM_NOKPROBE_SYMBOL(entry)				\
> +	_GLOBAL(entry)
>  #else
>  #define _ASM_NOKPROBE_SYMBOL(entry)
> +#define _NOKPROBE_ENTRY(entry)				\
> +	_ENTRY(entry)
> +#define _NOKPROBE_GLOBAL(entry)				\
> +	_GLOBAL(entry)
>  #endif

Michael hasn't preferred including NOKPROBE variants of those macros 
previously, since he would like to see some cleanups there:
https://patchwork.ozlabs.org/patch/696138/

> 
>  #define FUNC_START(name)	_GLOBAL(name)
> diff --git a/arch/powerpc/kernel/cpu_setup_6xx.S b/arch/powerpc/kernel/cpu_setup_6xx.S
> index f6517f67265a..1cb947268546 100644
> --- a/arch/powerpc/kernel/cpu_setup_6xx.S
> +++ b/arch/powerpc/kernel/cpu_setup_6xx.S
> @@ -276,7 +276,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_NO_DPM)
>   * in some 750 cpus where using a not yet initialized FPU register after
>   * power on reset may hang the CPU
>   */
> -_GLOBAL(__init_fpu_registers)
> +_NOKPROBE_GLOBAL(__init_fpu_registers)
>  	mfmsr	r10
>  	ori	r11,r10,MSR_FP
>  	mtmsr	r11
> @@ -381,7 +381,7 @@ _GLOBAL(__save_cpu_setup)
>   * restore CPU state as backed up by the previous
>   * function. This does not include cache setting
>   */
> -_GLOBAL(__restore_cpu_setup)
> +_NOKPROBE_GLOBAL(__restore_cpu_setup)
>  	/* Some CR fields are volatile, we back it up all */
>  	mfcr	r7
> 
> diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
> index 16af0d8d90a8..f788d586254d 100644
> --- a/arch/powerpc/kernel/entry_32.S
> +++ b/arch/powerpc/kernel/entry_32.S
> @@ -44,24 +44,21 @@
>  	.align	12
> 
>  #ifdef CONFIG_BOOKE
> -	.globl	mcheck_transfer_to_handler
> -mcheck_transfer_to_handler:
> +_NOKPROBE_ENTRY(mcheck_transfer_to_handler)
>  	mfspr	r0,SPRN_DSRR0
>  	stw	r0,_DSRR0(r11)
>  	mfspr	r0,SPRN_DSRR1
>  	stw	r0,_DSRR1(r11)
>  	/* fall through */
> 
> -	.globl	debug_transfer_to_handler
> -debug_transfer_to_handler:
> +_NOKPROBE_ENTRY(debug_transfer_to_handler)
>  	mfspr	r0,SPRN_CSRR0
>  	stw	r0,_CSRR0(r11)
>  	mfspr	r0,SPRN_CSRR1
>  	stw	r0,_CSRR1(r11)
>  	/* fall through */
> 
> -	.globl	crit_transfer_to_handler
> -crit_transfer_to_handler:
> +_NOKPROBE_ENTRY(crit_transfer_to_handler)
>  #ifdef CONFIG_PPC_BOOK3E_MMU
>  	mfspr	r0,SPRN_MAS0
>  	stw	r0,MAS0(r11)
> @@ -97,8 +94,7 @@ crit_transfer_to_handler:
>  #endif
> 
>  #ifdef CONFIG_40x
> -	.globl	crit_transfer_to_handler
> -crit_transfer_to_handler:
> +_NOKPROBE_ENTRY(crit_transfer_to_handler)
>  	lwz	r0,crit_r10@l(0)
>  	stw	r0,GPR10(r11)
>  	lwz	r0,crit_r11@l(0)
> @@ -124,13 +120,11 @@ crit_transfer_to_handler:
>   * Note that we rely on the caller having set cr0.eq iff the exception
>   * occurred in kernel mode (i.e. MSR:PR = 0).
>   */
> -	.globl	transfer_to_handler_full
> -transfer_to_handler_full:
> +_NOKPROBE_ENTRY(transfer_to_handler_full)
>  	SAVE_NVGPRS(r11)
>  	/* fall through */
> 
> -	.globl	transfer_to_handler
> -transfer_to_handler:
> +_NOKPROBE_ENTRY(transfer_to_handler)
>  	stw	r2,GPR2(r11)
>  	stw	r12,_NIP(r11)
>  	stw	r9,_MSR(r11)
> @@ -194,8 +188,7 @@ transfer_to_handler:
>  	bt-	31-TLF_NAPPING,4f
>  	bt-	31-TLF_SLEEPING,7f
>  #endif /* CONFIG_PPC_BOOK3S_32 || CONFIG_E500 */
> -	.globl transfer_to_handler_cont
> -transfer_to_handler_cont:
> +_NOKPROBE_ENTRY(transfer_to_handler_cont)
>  3:
>  	mflr	r9
>  	tovirt_novmstack r2, r2 	/* set r2 to current */
> @@ -297,6 +290,7 @@ reenable_mmu:
>   * On kernel stack overflow, load up an initial stack pointer
>   * and call StackOverflow(regs), which should not return.
>   */
> +_ASM_NOKPROBE_SYMBOL(stack_ovf)
>  stack_ovf:

The current convention is to add the NOKPROBE annotation at the _end_ of 
the associated function/symbol...

>  	/* sometimes we use a statically-allocated stack, which is OK. */
>  	lis	r12,_end@h
> @@ -460,6 +454,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRED_STWCX)
>  	lwz	r7,_NIP(r1)
>  	lwz	r2,GPR2(r1)
>  	lwz	r1,GPR1(r1)
> +syscall_exit_finish:
>  #if defined(CONFIG_PPC_8xx) && defined(CONFIG_PERF_EVENTS)
>  	mtspr	SPRN_NRI, r0
>  #endif
> @@ -467,6 +462,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRED_STWCX)
>  	mtspr	SPRN_SRR1,r8
>  	SYNC
>  	RFI
> +_ASM_NOKPROBE_SYMBOL(syscall_exit_finish)

... like so.

>  #ifdef CONFIG_44x
>  2:	li	r7,0
>  	iccci	r0,r0
> @@ -750,8 +746,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_SPE)
>  	addi	r1,r1,INT_FRAME_SIZE
>  	blr
> 
> -	.globl	fast_exception_return
> -fast_exception_return:
> +_NOKPROBE_ENTRY(fast_exception_return)
>  #if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
>  	andi.	r10,r9,MSR_RI		/* check for recoverable interrupt */
>  	beq	1f			/* if not, we've got problems */
> @@ -780,8 +775,8 @@ fast_exception_return:
> 
>  #if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
>  /* check if the exception happened in a restartable section */
> -1:	lis	r3,exc_exit_restart_end@ha
> -	addi	r3,r3,exc_exit_restart_end@l
> +1:	lis	r3,.Lexc_exit_restart_end@ha
> +	addi	r3,r3,.Lexc_exit_restart_end@l
>  	cmplw	r12,r3
>  #ifdef CONFIG_PPC_BOOK3S_601
>  	bge	2b
> @@ -1005,15 +1000,13 @@ END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRED_STWCX)
>  	LOAD_REG_IMMEDIATE(r10,MSR_KERNEL & ~MSR_RI)
>  	SYNC
>  	mtmsr	r10		/* clear the RI bit */
> -	.globl exc_exit_restart
> -exc_exit_restart:
> +_NOKPROBE_ENTRY(exc_exit_restart)
>  	lwz	r12,_NIP(r1)
>  	mtspr	SPRN_SRR0,r12
>  	mtspr	SPRN_SRR1,r9
>  	REST_4GPRS(9, r1)
>  	lwz	r1,GPR1(r1)
> -	.globl exc_exit_restart_end
> -exc_exit_restart_end:
> +.Lexc_exit_restart_end:
>  	SYNC
>  	RFI
> 
> @@ -1033,17 +1026,15 @@ exc_exit_restart_end:
>  	li	r10, 0
>  	stw	r10, 8(r1)
>  	REST_2GPRS(9, r1)
> -	.globl exc_exit_restart
> +_NOKPROBE_ENTRY(exc_exit_restart)
>  exc_exit_restart:
>  	lwz	r11,_NIP(r1)
>  	lwz	r12,_MSR(r1)
> -exc_exit_start:
>  	mtspr	SPRN_SRR0,r11
>  	mtspr	SPRN_SRR1,r12
>  	REST_2GPRS(11, r1)
>  	lwz	r1,GPR1(r1)
> -	.globl exc_exit_restart_end
> -exc_exit_restart_end:
> +.Lexc_exit_restart_end:

I think it would be good to break this into smaller patches to handle 
specific code paths, if possible. At the very least, it would be good to 
move changes to symbol visibility to a separate patch since this also 
changes the names printed in a backtrace.

- Naveen

