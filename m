Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E413A1887A9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 15:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgCQOjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 10:39:05 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:47741 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726498AbgCQOjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 10:39:04 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48hbQY2Pzdz9txJr;
        Tue, 17 Mar 2020 15:39:01 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=NGasMkjV; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id jy1vh3gr2NYn; Tue, 17 Mar 2020 15:39:01 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48hbQY1B2Lz9txJP;
        Tue, 17 Mar 2020 15:39:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1584455941; bh=3aB3sKo4axTmyvq66pIQTh9FsqX/8+Pv5FpPFzBfBtE=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=NGasMkjVrfGKMNcqn7ZWm4o8AloBrVIUTxZ+xl/7ZrrIMIHTwfhml5pVfzHvW41NT
         jT920tTUmPvzOA3iNZ7VmxiDhhtrt/hdAoAtAU/nBAfmCj6kmMebRt/W1EFKfDmWOE
         +CUxGE2C+bGZkeT4TiJ6wfbqxWuBnRczQWcHTLaY=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8C2FF8B7BA;
        Tue, 17 Mar 2020 15:39:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id QqoWzBYd6i2c; Tue, 17 Mar 2020 15:39:02 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DB4CF8B7B7;
        Tue, 17 Mar 2020 15:39:00 +0100 (CET)
Subject: Re: [PATCH v1 16/46] powerpc/mm: Allocate static page tables for
 fixmap
From:   Christophe Leroy <christophe.leroy@c-s.fr>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <cover.1584360343.git.christophe.leroy@c-s.fr>
 <d4bd46fe0103f8a8cb7e5affb2a7fcc3185be24e.1584360344.git.christophe.leroy@c-s.fr>
Message-ID: <b9c92137-f757-1e6a-bca9-5c522e1083c5@c-s.fr>
Date:   Tue, 17 Mar 2020 15:38:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <d4bd46fe0103f8a8cb7e5affb2a7fcc3185be24e.1584360344.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 16/03/2020 à 13:36, Christophe Leroy a écrit :
> Allocate static page tables for the fixmap area. This allows
> setting mappings through page tables before memblock is ready.
> That's needed to use early_ioremap() early and to use standard
> page mappings with fixmap.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>   arch/powerpc/include/asm/fixmap.h |  4 ++++
>   arch/powerpc/kernel/setup_32.c    |  2 +-
>   arch/powerpc/mm/pgtable_32.c      | 16 ++++++++++++++++
>   3 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/fixmap.h b/arch/powerpc/include/asm/fixmap.h
> index 2ef155a3c821..ccbe2e83c950 100644
> --- a/arch/powerpc/include/asm/fixmap.h
> +++ b/arch/powerpc/include/asm/fixmap.h
> @@ -86,6 +86,10 @@ enum fixed_addresses {
>   #define __FIXADDR_SIZE	(__end_of_fixed_addresses << PAGE_SHIFT)
>   #define FIXADDR_START		(FIXADDR_TOP - __FIXADDR_SIZE)
>   
> +#define FIXMAP_ALIGNED_SIZE	(ALIGN(FIXADDR_TOP, PGDIR_SIZE) - \
> +				 ALIGN_DOWN(FIXADDR_START, PGDIR_SIZE))
> +#define FIXMAP_PTE_SIZE	(FIXMAP_ALIGNED_SIZE / PGDIR_SIZE * PTE_TABLE_SIZE)
> +
>   #define FIXMAP_PAGE_NOCACHE PAGE_KERNEL_NCG
>   #define FIXMAP_PAGE_IO	PAGE_KERNEL_NCG
>   
> diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
> index 5b49b26eb154..3f1e1c0b328a 100644
> --- a/arch/powerpc/kernel/setup_32.c
> +++ b/arch/powerpc/kernel/setup_32.c
> @@ -81,7 +81,7 @@ notrace void __init machine_init(u64 dt_ptr)
>   	/* Configure static keys first, now that we're relocated. */
>   	setup_feature_keys();
>   
> -	early_ioremap_setup();
> +	early_ioremap_init();
>   
>   	/* Enable early debugging if any specified (see udbg.h) */
>   	udbg_early_init();
> diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
> index f62de06e3d07..9934659cb871 100644
> --- a/arch/powerpc/mm/pgtable_32.c
> +++ b/arch/powerpc/mm/pgtable_32.c
> @@ -29,11 +29,27 @@
>   #include <asm/fixmap.h>
>   #include <asm/setup.h>
>   #include <asm/sections.h>
> +#include <asm/early_ioremap.h>
>   
>   #include <mm/mmu_decl.h>
>   
>   extern char etext[], _stext[], _sinittext[], _einittext[];
>   
> +static u8 early_fixmap_pagetable[FIXMAP_PTE_SIZE] __page_aligned_data;

Sparse reports this as a variable size array. This is definitely not. 
Gcc properly sees it is an 8k table (2 pages).

Christophe


> +
> +notrace void __init early_ioremap_init(void)
> +{
> +	unsigned long addr = ALIGN_DOWN(FIXADDR_START, PGDIR_SIZE);
> +	pte_t *ptep = (pte_t *)early_fixmap_pagetable;
> +	pmd_t *pmdp = pmd_ptr_k(addr);
> +
> +	for (; (s32)(FIXADDR_TOP - addr) > 0;
> +	     addr += PGDIR_SIZE, ptep += PTRS_PER_PTE, pmdp++)
> +		pmd_populate_kernel(&init_mm, pmdp, ptep);
> +
> +	early_ioremap_setup();
> +}
> +
>   static void __init *early_alloc_pgtable(unsigned long size)
>   {
>   	void *ptr = memblock_alloc(size, size);
> 

Christophe
