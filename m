Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8AA4702A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2019 15:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfFON0D convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 15 Jun 2019 09:26:03 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:6615 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbfFON0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 09:26:03 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45Qysg71slz9v0qB;
        Sat, 15 Jun 2019 15:25:59 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ypMTtY4H2cjl; Sat, 15 Jun 2019 15:25:59 +0200 (CEST)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45Qysg6612z9v0q9;
        Sat, 15 Jun 2019 15:25:59 +0200 (CEST)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id 9DA2B3FF; Sat, 15 Jun 2019 15:25:59 +0200 (CEST)
Received: from 37.170.137.36 ([37.170.137.36]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Sat, 15 Jun 2019 15:25:59 +0200
Date:   Sat, 15 Jun 2019 15:25:59 +0200
Message-ID: <20190615152559.Horde.0lTFIZALxZ-RI75z94G3jA8@messagerie.si.c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        j.neuschaefer@gmx.net, Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/mm/32s: only use MMU to mark initmem NX if
 STRICT_KERNEL_RWX
References: <cover.1550775950.git.christophe.leroy@c-s.fr>
 <1e412310cc18ea654fb2ce4c935654d8d1069f27.1550775950.git.christophe.leroy@c-s.fr>
 <8736kb9fry.fsf_-_@igel.home>
In-Reply-To: <8736kb9fry.fsf_-_@igel.home>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab <schwab@linux-m68k.org> a écrit :

> If STRICT_KERNEL_RWX is disabled, never use the MMU to mark initmen
> nonexecutable.

I dont understand, can you elaborate ?

This area is mapped with BATs so using change_page_attr() is pointless.

Christophe

>
> Also move a misplaced paren that makes the condition always true.
>
> Fixes: 63b2bc619565 ("powerpc/mm/32s: Use BATs for STRICT_KERNEL_RWX")
> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
> ---
>  arch/powerpc/mm/pgtable_32.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
> index d53188dee18f..3935dc263d65 100644
> --- a/arch/powerpc/mm/pgtable_32.c
> +++ b/arch/powerpc/mm/pgtable_32.c
> @@ -360,9 +360,11 @@ void mark_initmem_nx(void)
>  	unsigned long numpages = PFN_UP((unsigned long)_einittext) -
>  				 PFN_DOWN((unsigned long)_sinittext);
>
> -	if (v_block_mapped((unsigned long)_stext) + 1)
> +#ifdef CONFIG_STRICT_KERNEL_RWX
> +	if (v_block_mapped((unsigned long)_stext + 1))
>  		mmu_mark_initmem_nx();
>  	else
> +#endif
>  		change_page_attr(page, numpages, PAGE_KERNEL);
>  }
>
> --
> 2.22.0
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
> "And now for something completely different."


