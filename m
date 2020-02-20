Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74C5D165EFC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 14:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgBTNlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 08:41:25 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:39541 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728028AbgBTNlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 08:41:25 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48NbN22Wgxz9ty9V;
        Thu, 20 Feb 2020 14:41:22 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=ZOSkCGU1; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id z6e7fNr83C6z; Thu, 20 Feb 2020 14:41:22 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48NbN204fCz9ty9T;
        Thu, 20 Feb 2020 14:41:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1582206082; bh=PWM2VGeYn1puuYVao8kR+gKhli5A0TKj0zM2lK44Ojg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZOSkCGU1Srry32+pfJZCoylAC9Zgb2Mf5iLtUbdraslH6edil/Z5vijqc6OA025Lp
         nzx1saoBgW36o3ZnMfKImSy5boQBGQNGhtzNObDZuwZpOhe9hD2fI4xjldovLxkcUc
         wfpzmLymqHpUV8+R3Aq7l/TQuVrPKWFwqD4SGXa0=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 552588B86E;
        Thu, 20 Feb 2020 14:41:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id PVcQ5Y69vVqi; Thu, 20 Feb 2020 14:41:23 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 242678B86D;
        Thu, 20 Feb 2020 14:41:22 +0100 (CET)
Subject: Re: [PATCH v3 2/6] powerpc/fsl_booke/64: introduce
 reloc_kernel_entry() helper
To:     Jason Yan <yanaijie@huawei.com>, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, diana.craciun@nxp.com,
        benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
        keescook@chromium.org, kernel-hardening@lists.openwall.com,
        oss@buserror.net
Cc:     linux-kernel@vger.kernel.org, zhaohongjiang@huawei.com
References: <20200206025825.22934-1-yanaijie@huawei.com>
 <20200206025825.22934-3-yanaijie@huawei.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <da8c9b88-1d21-ed70-c6f1-343117b4075d@c-s.fr>
Date:   Thu, 20 Feb 2020 14:41:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200206025825.22934-3-yanaijie@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 06/02/2020 à 03:58, Jason Yan a écrit :
> Like the 32bit code, we introduce reloc_kernel_entry() helper to prepare
> for the KASLR 64bit version. And move the C declaration of this function
> out of CONFIG_PPC32 and use long instead of int for the parameter 'addr'.
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> Cc: Scott Wood <oss@buserror.net>
> Cc: Diana Craciun <diana.craciun@nxp.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Kees Cook <keescook@chromium.org>

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>


> ---
>   arch/powerpc/kernel/exceptions-64e.S | 13 +++++++++++++
>   arch/powerpc/mm/mmu_decl.h           |  3 ++-
>   2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
> index e4076e3c072d..1b9b174bee86 100644
> --- a/arch/powerpc/kernel/exceptions-64e.S
> +++ b/arch/powerpc/kernel/exceptions-64e.S
> @@ -1679,3 +1679,16 @@ _GLOBAL(setup_ehv_ivors)
>   _GLOBAL(setup_lrat_ivor)
>   	SET_IVOR(42, 0x340) /* LRAT Error */
>   	blr
> +
> +/*
> + * Return to the start of the relocated kernel and run again
> + * r3 - virtual address of fdt
> + * r4 - entry of the kernel
> + */
> +_GLOBAL(reloc_kernel_entry)
> +	mfmsr	r7
> +	rlwinm	r7, r7, 0, ~(MSR_IS | MSR_DS)
> +
> +	mtspr	SPRN_SRR0,r4
> +	mtspr	SPRN_SRR1,r7
> +	rfi
> diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
> index 8e99649c24fc..3e1c85c7d10b 100644
> --- a/arch/powerpc/mm/mmu_decl.h
> +++ b/arch/powerpc/mm/mmu_decl.h
> @@ -140,9 +140,10 @@ extern void adjust_total_lowmem(void);
>   extern int switch_to_as1(void);
>   extern void restore_to_as0(int esel, int offset, void *dt_ptr, int bootcpu);
>   void create_kaslr_tlb_entry(int entry, unsigned long virt, phys_addr_t phys);
> -void reloc_kernel_entry(void *fdt, int addr);
>   extern int is_second_reloc;
>   #endif
> +
> +void reloc_kernel_entry(void *fdt, long addr);
>   extern void loadcam_entry(unsigned int index);
>   extern void loadcam_multi(int first_idx, int num, int tmp_idx);
>   
> 
