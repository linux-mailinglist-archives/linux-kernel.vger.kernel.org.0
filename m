Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 084DC57AD3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 06:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfF0EsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 00:48:05 -0400
Received: from ozlabs.org ([203.11.71.1]:53313 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbfF0EsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 00:48:05 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Z6pW1Pl7z9sCJ;
        Thu, 27 Jun 2019 14:48:02 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
Subject: Re: [PATCH] powerpc/64s/radix: Define arch_ioremap_p4d_supported()
In-Reply-To: <1561555260-17335-1-git-send-email-anshuman.khandual@arm.com>
References: <1561555260-17335-1-git-send-email-anshuman.khandual@arm.com>
Date:   Thu, 27 Jun 2019 14:48:00 +1000
Message-ID: <87d0iztz0f.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anshuman Khandual <anshuman.khandual@arm.com> writes:
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

The easiest option is for this to be folded into your patch that creates
the requirement for arch_ioremap_p4d_supported().

Andrew might do that for you, or you could send a v2.

This looks fine from a powerpc POV:

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

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
> ---
> This has been just build tested and fixes the problem reported earlier.
>
>  arch/powerpc/mm/book3s64/radix_pgtable.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
> index 8904aa1..c81da88 100644
> --- a/arch/powerpc/mm/book3s64/radix_pgtable.c
> +++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
> @@ -1124,6 +1124,11 @@ void radix__ptep_modify_prot_commit(struct vm_area_struct *vma,
>  	set_pte_at(mm, addr, ptep, pte);
>  }
>  
> +int __init arch_ioremap_p4d_supported(void)
> +{
> +	return 0;
> +}
> +
>  int __init arch_ioremap_pud_supported(void)
>  {
>  	/* HPT does not cope with large pages in the vmalloc area */
> -- 
> 2.7.4
