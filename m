Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 992C657AB2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 06:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfF0Ej0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 00:39:26 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:63453 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfF0Ej0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 00:39:26 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45Z6cW3zXvz9v0bT;
        Thu, 27 Jun 2019 06:39:23 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=ez22xSXe; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Pv5yZBePPNWY; Thu, 27 Jun 2019 06:39:23 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45Z6cW2gw5z9v0bS;
        Thu, 27 Jun 2019 06:39:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1561610363; bh=uSip90CjY6ipnPCboMIzCTf6R15j8iY2klqsFQRuFHo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ez22xSXenyJafd/cBfOrYvcLgLb3L9QoeannzXvtRfqULrpeEdFu+LempOs+0fZbS
         SN2CHGt29XHhtCvT4IUW/MwhSHlxG7dhGGSOLadHGbbbX6IuWOiO0g8hxJRKQfdbIk
         7xeaz24HM3SZHQ1Yv5C73jVUNwkMDZNCgg6T3oJY=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 278B98B780;
        Thu, 27 Jun 2019 06:39:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id paYZo5xhpiac; Thu, 27 Jun 2019 06:39:24 +0200 (CEST)
Received: from pc17473vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A027F8B77F;
        Thu, 27 Jun 2019 06:39:23 +0200 (CEST)
Subject: Re: [PATCH] powerpc/64s/radix: Define arch_ioremap_p4d_supported()
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org
References: <1561555260-17335-1-git-send-email-anshuman.khandual@arm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <f32fbb6c-0600-991a-6d1a-72670c27c8de@c-s.fr>
Date:   Thu, 27 Jun 2019 04:38:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1561555260-17335-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/26/2019 01:21 PM, Anshuman Khandual wrote:
> Recent core ioremap changes require HAVE_ARCH_HUGE_VMAP subscribing archs
> provide arch_ioremap_p4d_supported() failing which will result in a build
> failure like the following.
> 
> ld: lib/ioremap.o: in function `.ioremap_huge_init':
> ioremap.c:(.init.text+0x3c): undefined reference to
> `.arch_ioremap_p4d_supported'
> 
> This defines a stub implementation for arch_ioremap_p4d_supported() keeping
> it disabled for now to fix the build problem.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-next@vger.kernel.org
> 
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Add a Fixes: tag ? For instance:

Fixes: d909f9109c30 ("powerpc/64s/radix: Enable HAVE_ARCH_HUGE_VMAP")

Christophe

> ---
> This has been just build tested and fixes the problem reported earlier.
> 
>   arch/powerpc/mm/book3s64/radix_pgtable.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
> index 8904aa1..c81da88 100644
> --- a/arch/powerpc/mm/book3s64/radix_pgtable.c
> +++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
> @@ -1124,6 +1124,11 @@ void radix__ptep_modify_prot_commit(struct vm_area_struct *vma,
>   	set_pte_at(mm, addr, ptep, pte);
>   }
>   
> +int __init arch_ioremap_p4d_supported(void)
> +{
> +	return 0;
> +}
> +
>   int __init arch_ioremap_pud_supported(void)
>   {
>   	/* HPT does not cope with large pages in the vmalloc area */
> 
