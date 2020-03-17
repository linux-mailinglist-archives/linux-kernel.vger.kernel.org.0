Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C03B0187DF3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 11:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgCQKO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 06:14:56 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:46606 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbgCQKOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 06:14:55 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48hTYn1Q2Bz9txmY;
        Tue, 17 Mar 2020 11:14:53 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=uJs2Lp1s; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id HsW8z12_x4g8; Tue, 17 Mar 2020 11:14:53 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48hTYn0HH4z9txmV;
        Tue, 17 Mar 2020 11:14:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1584440093; bh=fONsrZN6lMxswRlJhDf2ydTRYrah+Hv1rbNo7C2XfiQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=uJs2Lp1sIjbA/dtw/io6ZwexpDe6PtFTr+CxAvXkHm1Q3oYBxnObrlidRCAv4p2g6
         mP06nOXgGZmMqdveJlDdBtdhbsHiOjRUSEy+Ra8+iltI7RIV2JX7+0qP9swGKxHPQz
         yVriu+XwMmXWUQkVXzMpEHf7lC8y++/k3+9Uw1vM=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2460C8B786;
        Tue, 17 Mar 2020 11:14:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 3E_j_0lDdxTE; Tue, 17 Mar 2020 11:14:54 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4F39D8B785;
        Tue, 17 Mar 2020 11:14:52 +0100 (CET)
Subject: Re: [PATCH 01/15] powerpc/watchpoint: Rename current DAWR macros
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, mpe@ellerman.id.au,
        mikey@neuling.org
Cc:     apopple@linux.ibm.com, paulus@samba.org, npiggin@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com, peterz@infradead.org,
        jolsa@kernel.org, oleg@redhat.com, fweisbec@gmail.com,
        mingo@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20200309085806.155823-1-ravi.bangoria@linux.ibm.com>
 <20200309085806.155823-2-ravi.bangoria@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <6ae1865c-fcf6-5bef-2d93-e75b03ed8b44@c-s.fr>
Date:   Tue, 17 Mar 2020 11:14:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200309085806.155823-2-ravi.bangoria@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 09/03/2020 à 09:57, Ravi Bangoria a écrit :
> Future Power architecture is introducing second DAWR. Rename current
> DAWR macros as:
>   s/SPRN_DAWR/SPRN_DAWR0/
>   s/SPRN_DAWRX/SPRN_DAWRX0/

I think you should tell that DAWR0 and DAWRX0 is the real name of the 
register as documented in (at least) power8 and power9 user manual.

Otherwise, we can't understand why you change the name of the register.

Christophe

> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>   arch/powerpc/include/asm/reg.h          |  4 ++--
>   arch/powerpc/kernel/dawr.c              |  4 ++--
>   arch/powerpc/kvm/book3s_hv.c            | 12 ++++++------
>   arch/powerpc/kvm/book3s_hv_rmhandlers.S | 18 +++++++++---------
>   arch/powerpc/xmon/xmon.c                |  2 +-
>   5 files changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> index da5cab038e25..156ee89fa9be 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -283,14 +283,14 @@
>   #define   CTRL_CT1	0x40000000	/* thread 1 */
>   #define   CTRL_TE	0x00c00000	/* thread enable */
>   #define   CTRL_RUNLATCH	0x1
> -#define SPRN_DAWR	0xB4
> +#define SPRN_DAWR0	0xB4
>   #define SPRN_RPR	0xBA	/* Relative Priority Register */
>   #define SPRN_CIABR	0xBB
>   #define   CIABR_PRIV		0x3
>   #define   CIABR_PRIV_USER	1
>   #define   CIABR_PRIV_SUPER	2
>   #define   CIABR_PRIV_HYPER	3
> -#define SPRN_DAWRX	0xBC
> +#define SPRN_DAWRX0	0xBC
>   #define   DAWRX_USER	__MASK(0)
>   #define   DAWRX_KERNEL	__MASK(1)
>   #define   DAWRX_HYP	__MASK(2)
> diff --git a/arch/powerpc/kernel/dawr.c b/arch/powerpc/kernel/dawr.c
> index cc14aa6c4a1b..e91b613bf137 100644
> --- a/arch/powerpc/kernel/dawr.c
> +++ b/arch/powerpc/kernel/dawr.c
> @@ -39,8 +39,8 @@ int set_dawr(struct arch_hw_breakpoint *brk)
>   	if (ppc_md.set_dawr)
>   		return ppc_md.set_dawr(dawr, dawrx);
>   
> -	mtspr(SPRN_DAWR, dawr);
> -	mtspr(SPRN_DAWRX, dawrx);
> +	mtspr(SPRN_DAWR0, dawr);
> +	mtspr(SPRN_DAWRX0, dawrx);
>   
>   	return 0;
>   }
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 33be4d93248a..498c57e1f5c9 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -3383,8 +3383,8 @@ static int kvmhv_load_hv_regs_and_go(struct kvm_vcpu *vcpu, u64 time_limit,
>   	int trap;
>   	unsigned long host_hfscr = mfspr(SPRN_HFSCR);
>   	unsigned long host_ciabr = mfspr(SPRN_CIABR);
> -	unsigned long host_dawr = mfspr(SPRN_DAWR);
> -	unsigned long host_dawrx = mfspr(SPRN_DAWRX);
> +	unsigned long host_dawr = mfspr(SPRN_DAWR0);
> +	unsigned long host_dawrx = mfspr(SPRN_DAWRX0);
>   	unsigned long host_psscr = mfspr(SPRN_PSSCR);
>   	unsigned long host_pidr = mfspr(SPRN_PID);
>   
> @@ -3413,8 +3413,8 @@ static int kvmhv_load_hv_regs_and_go(struct kvm_vcpu *vcpu, u64 time_limit,
>   	mtspr(SPRN_SPURR, vcpu->arch.spurr);
>   
>   	if (dawr_enabled()) {
> -		mtspr(SPRN_DAWR, vcpu->arch.dawr);
> -		mtspr(SPRN_DAWRX, vcpu->arch.dawrx);
> +		mtspr(SPRN_DAWR0, vcpu->arch.dawr);
> +		mtspr(SPRN_DAWRX0, vcpu->arch.dawrx);
>   	}
>   	mtspr(SPRN_CIABR, vcpu->arch.ciabr);
>   	mtspr(SPRN_IC, vcpu->arch.ic);
> @@ -3466,8 +3466,8 @@ static int kvmhv_load_hv_regs_and_go(struct kvm_vcpu *vcpu, u64 time_limit,
>   	      (local_paca->kvm_hstate.fake_suspend << PSSCR_FAKE_SUSPEND_LG));
>   	mtspr(SPRN_HFSCR, host_hfscr);
>   	mtspr(SPRN_CIABR, host_ciabr);
> -	mtspr(SPRN_DAWR, host_dawr);
> -	mtspr(SPRN_DAWRX, host_dawrx);
> +	mtspr(SPRN_DAWR0, host_dawr);
> +	mtspr(SPRN_DAWRX0, host_dawrx);
>   	mtspr(SPRN_PID, host_pidr);
>   
>   	/*
> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> index dbc2fecc37f0..f4b412b7cad8 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -707,8 +707,8 @@ BEGIN_FTR_SECTION
>   END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
>   BEGIN_FTR_SECTION
>   	mfspr	r5, SPRN_CIABR
> -	mfspr	r6, SPRN_DAWR
> -	mfspr	r7, SPRN_DAWRX
> +	mfspr	r6, SPRN_DAWR0
> +	mfspr	r7, SPRN_DAWRX0
>   	mfspr	r8, SPRN_IAMR
>   	std	r5, STACK_SLOT_CIABR(r1)
>   	std	r6, STACK_SLOT_DAWR(r1)
> @@ -803,8 +803,8 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
>   	beq	1f
>   	ld	r5, VCPU_DAWR(r4)
>   	ld	r6, VCPU_DAWRX(r4)
> -	mtspr	SPRN_DAWR, r5
> -	mtspr	SPRN_DAWRX, r6
> +	mtspr	SPRN_DAWR0, r5
> +	mtspr	SPRN_DAWRX0, r6
>   1:
>   	ld	r7, VCPU_CIABR(r4)
>   	ld	r8, VCPU_TAR(r4)
> @@ -1772,8 +1772,8 @@ BEGIN_FTR_SECTION
>   	 * If the DAWR doesn't work, it's ok to write these here as
>   	 * this value should always be zero
>   	*/
> -	mtspr	SPRN_DAWR, r6
> -	mtspr	SPRN_DAWRX, r7
> +	mtspr	SPRN_DAWR0, r6
> +	mtspr	SPRN_DAWRX0, r7
>   END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
>   BEGIN_FTR_SECTION
>   	ld	r5, STACK_SLOT_TID(r1)
> @@ -2583,8 +2583,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
>   	mfmsr	r6
>   	andi.	r6, r6, MSR_DR		/* in real mode? */
>   	bne	4f
> -	mtspr	SPRN_DAWR, r4
> -	mtspr	SPRN_DAWRX, r5
> +	mtspr	SPRN_DAWR0, r4
> +	mtspr	SPRN_DAWRX0, r5
>   4:	li	r3, 0
>   	blr
>   
> @@ -3340,7 +3340,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
>   	mtspr	SPRN_AMR, r0
>   	mtspr	SPRN_IAMR, r0
>   	mtspr	SPRN_CIABR, r0
> -	mtspr	SPRN_DAWRX, r0
> +	mtspr	SPRN_DAWRX0, r0
>   
>   BEGIN_MMU_FTR_SECTION
>   	b	4f
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index e8c84d265602..6c4a8f8c0bd8 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -1938,7 +1938,7 @@ static void dump_207_sprs(void)
>   	printf("hfscr  = %.16lx  dhdes = %.16lx rpr    = %.16lx\n",
>   		mfspr(SPRN_HFSCR), mfspr(SPRN_DHDES), mfspr(SPRN_RPR));
>   	printf("dawr   = %.16lx  dawrx = %.16lx ciabr  = %.16lx\n",
> -		mfspr(SPRN_DAWR), mfspr(SPRN_DAWRX), mfspr(SPRN_CIABR));
> +		mfspr(SPRN_DAWR0), mfspr(SPRN_DAWRX0), mfspr(SPRN_CIABR));
>   #endif
>   }
>   
> 
