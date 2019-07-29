Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A72778A24
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 13:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387575AbfG2LIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 07:08:10 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:15122 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387457AbfG2LIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 07:08:10 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45xxkC44QKz9v9MV;
        Mon, 29 Jul 2019 13:08:03 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=arONxYLf; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ESTVg6lnoUGW; Mon, 29 Jul 2019 13:08:03 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45xxkC2ztgz9v9Lx;
        Mon, 29 Jul 2019 13:08:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1564398483; bh=5INwHw7XbuC/K2OjMZ4KYRax0cv2G+pbjXkMo1syWiI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=arONxYLfYazH1Zuv1sjYhl+98rYh7/IMm8wcB9t915KfBP0mg7p23qtwKyOzwnotp
         W40nOf8zFdXdk+whAYptqqCcrHrHC6a8ulMz3YYeOFBKwQhFMNHEzDbTqPDV1UtWXJ
         Wm699DyCi1utuj1uMB5IRkKVDDV3wBaTlHP6sh5E=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 449968B7CB;
        Mon, 29 Jul 2019 13:08:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id vS0yC_BC0m1Z; Mon, 29 Jul 2019 13:08:08 +0200 (CEST)
Received: from [172.25.230.101] (po15451.idsi0.si.c-s.fr [172.25.230.101])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 13A6E8B7B3;
        Mon, 29 Jul 2019 13:08:08 +0200 (CEST)
Subject: Re: [RFC PATCH 05/10] powerpc/fsl_booke/32: introduce
 reloc_kernel_entry() helper
To:     Jason Yan <yanaijie@huawei.com>, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, diana.craciun@nxp.com,
        benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
        keescook@chromium.org, kernel-hardening@lists.openwall.com
Cc:     linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
        yebin10@huawei.com, thunder.leizhen@huawei.com,
        jingxiangfeng@huawei.com, fanchengyang@huawei.com
References: <20190717080621.40424-1-yanaijie@huawei.com>
 <20190717080621.40424-6-yanaijie@huawei.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <e4ccd015-a9c4-b0a6-e3ca-d37a04e29ec6@c-s.fr>
Date:   Mon, 29 Jul 2019 13:08:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190717080621.40424-6-yanaijie@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 17/07/2019 à 10:06, Jason Yan a écrit :
> Add a new helper reloc_kernel_entry() to jump back to the start of the
> new kernel. After we put the new kernel in a randomized place we can use
> this new helper to enter the kernel and begin to relocate again.
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> Cc: Diana Craciun <diana.craciun@nxp.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Kees Cook <keescook@chromium.org>
> ---
>   arch/powerpc/kernel/head_fsl_booke.S | 16 ++++++++++++++++
>   arch/powerpc/mm/mmu_decl.h           |  1 +
>   2 files changed, 17 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
> index a57d44638031..ce40f96dae20 100644
> --- a/arch/powerpc/kernel/head_fsl_booke.S
> +++ b/arch/powerpc/kernel/head_fsl_booke.S
> @@ -1144,6 +1144,22 @@ _GLOBAL(create_tlb_entry)
>   	sync
>   	blr
>   
> +/*
> + * Return to the start of the relocated kernel and run again
> + * r3 - virtual address of fdt
> + * r4 - entry of the kernel
> + */
> +_GLOBAL(reloc_kernel_entry)
> +	mfmsr	r7
> +	li	r8,(MSR_IS | MSR_DS)
> +	andc	r7,r7,r8

Instead of the li/andc, what about the following:

rlwinm r7, r7, 0, ~(MSR_IS | MSR_DS)

> +
> +	mtspr	SPRN_SRR0,r4
> +	mtspr	SPRN_SRR1,r7
> +	isync
> +	sync
> +	rfi

Are the isync/sync really necessary ? AFAIK, rfi is context synchronising.

> +
>   /*
>    * Create a tlb entry with the same effective and physical address as
>    * the tlb entry used by the current running code. But set the TS to 1.
> diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
> index d7737cf97cee..dae8e9177574 100644
> --- a/arch/powerpc/mm/mmu_decl.h
> +++ b/arch/powerpc/mm/mmu_decl.h
> @@ -143,6 +143,7 @@ extern void adjust_total_lowmem(void);
>   extern int switch_to_as1(void);
>   extern void restore_to_as0(int esel, int offset, void *dt_ptr, int bootcpu);
>   extern void create_tlb_entry(phys_addr_t phys, unsigned long virt, int entry);
> +extern void reloc_kernel_entry(void *fdt, int addr);

No new 'extern' please, see 
https://openpower.xyz/job/snowpatch/job/snowpatch-linux-checkpatch/8125//artifact/linux/checkpatch.log


>   #endif
>   extern void loadcam_entry(unsigned int index);
>   extern void loadcam_multi(int first_idx, int num, int tmp_idx);
> 

Christophe
