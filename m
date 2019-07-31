Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4572A7BB16
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 10:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfGaIDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 04:03:00 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:55848 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbfGaIC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 04:02:59 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45z5Wh6ggWzB09bK;
        Wed, 31 Jul 2019 10:02:56 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=YUDfNzOg; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ckumsCPzUguK; Wed, 31 Jul 2019 10:02:56 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45z5Wh5d4TzB09bJ;
        Wed, 31 Jul 2019 10:02:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1564560176; bh=urMfCkzEN/XPPc7SqG4losLKhjWS1AUFXYonBDS8tIc=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=YUDfNzOgYerwaUTgkGYUQWXkAUNWw6NartKTZNY/ZpSPpUCRbyki4Yn8kXHFw5kpb
         U1ld57JoZzua+Kl4joibhHo5INE/QdMNLosHCpYu9bsIO1DTiuDY3R224SSeKnDQdD
         f2pUO8OHY0np8g/4EWSo6NVw5yEW4TXDF7xhWZX0=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 752CE8B82A;
        Wed, 31 Jul 2019 10:02:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id dwz4ruHw_B_A; Wed, 31 Jul 2019 10:02:57 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C340C8B752;
        Wed, 31 Jul 2019 10:02:56 +0200 (CEST)
Subject: Re: [PATCH] powerpc/kasan: fix early boot failure on PPC32
From:   Christophe Leroy <christophe.leroy@c-s.fr>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <da89670093651437f27d2975224712e0a130b055.1564552796.git.christophe.leroy@c-s.fr>
Message-ID: <2f29b91a-11cd-8385-74b6-d85e515012c3@c-s.fr>
Date:   Wed, 31 Jul 2019 10:02:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <da89670093651437f27d2975224712e0a130b055.1564552796.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 31/07/2019 à 08:01, Christophe Leroy a écrit :
> Due to commit 4a6d8cf90017 ("powerpc/mm: don't use pte_alloc_kernel()
> until slab is available on PPC32"), pte_alloc_kernel() cannot be used
> during early KASAN init.
> 
> Fix it by using memblock_alloc() instead.
> 
> Reported-by: Erhard F. <erhard_f@mailbox.org>
> Fixes: 2edb16efc899 ("powerpc/32: Add KASAN support")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Cc: stable@vger.kernel.org

> ---
>   arch/powerpc/mm/kasan/kasan_init_32.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/mm/kasan/kasan_init_32.c b/arch/powerpc/mm/kasan/kasan_init_32.c
> index 0d62be3cba47..74f4555a62ba 100644
> --- a/arch/powerpc/mm/kasan/kasan_init_32.c
> +++ b/arch/powerpc/mm/kasan/kasan_init_32.c
> @@ -21,7 +21,7 @@ static void kasan_populate_pte(pte_t *ptep, pgprot_t prot)
>   		__set_pte_at(&init_mm, va, ptep, pfn_pte(PHYS_PFN(pa), prot), 0);
>   }
>   
> -static int kasan_init_shadow_page_tables(unsigned long k_start, unsigned long k_end)
> +static int __ref kasan_init_shadow_page_tables(unsigned long k_start, unsigned long k_end)
>   {
>   	pmd_t *pmd;
>   	unsigned long k_cur, k_next;
> @@ -35,7 +35,10 @@ static int kasan_init_shadow_page_tables(unsigned long k_start, unsigned long k_
>   		if ((void *)pmd_page_vaddr(*pmd) != kasan_early_shadow_pte)
>   			continue;
>   
> -		new = pte_alloc_one_kernel(&init_mm);
> +		if (slab_is_available())
> +			new = pte_alloc_one_kernel(&init_mm);
> +		else
> +			new = memblock_alloc(PTE_FRAG_SIZE, PTE_FRAG_SIZE);
>   
>   		if (!new)
>   			return -ENOMEM;
> 
