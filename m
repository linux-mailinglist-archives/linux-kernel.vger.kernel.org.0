Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD7CB95249
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 02:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbfHTASI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 20:18:08 -0400
Received: from ozlabs.org ([203.11.71.1]:39811 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728351AbfHTASI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 20:18:08 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46CBG53TVsz9s4Y;
        Tue, 20 Aug 2019 10:18:05 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v1 08/10] powerpc/mm: move __ioremap_at() and __iounmap_at() into ioremap.c
In-Reply-To: <84bab66e7afc4b35e2bd460a87b5911c1b0830d2.1565726867.git.christophe.leroy@c-s.fr>
References: <6bc35eca507359075528bc0e55938bc1ce8ee485.1565726867.git.christophe.leroy@c-s.fr> <84bab66e7afc4b35e2bd460a87b5911c1b0830d2.1565726867.git.christophe.leroy@c-s.fr>
Date:   Tue, 20 Aug 2019 10:18:00 +1000
Message-ID: <87tvac666f.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> diff --git a/arch/powerpc/mm/ioremap.c b/arch/powerpc/mm/ioremap.c
> index 57d742509cec..889ee656cf64 100644
> --- a/arch/powerpc/mm/ioremap.c
> +++ b/arch/powerpc/mm/ioremap.c
> @@ -103,3 +103,46 @@ void iounmap(volatile void __iomem *token)
>  	vunmap(addr);
>  }
>  EXPORT_SYMBOL(iounmap);
> +
> +#ifdef CONFIG_PPC64
> +/**
> + * __ioremap_at - Low level function to establish the page tables
> + *                for an IO mapping
> + */
> +void __iomem *__ioremap_at(phys_addr_t pa, void *ea, unsigned long size, pgprot_t prot)
> +{
> +	/* We don't support the 4K PFN hack with ioremap */
> +	if (pgprot_val(prot) & H_PAGE_4K_PFN)
> +		return NULL;
> +
> +	if ((ea + size) >= (void *)IOREMAP_END) {
> +		pr_warn("Outside the supported range\n");
> +		return NULL;
> +	}
> +
> +	WARN_ON(pa & ~PAGE_MASK);
> +	WARN_ON(((unsigned long)ea) & ~PAGE_MASK);
> +	WARN_ON(size & ~PAGE_MASK);
> +
> +	if (ioremap_range((unsigned long)ea, pa, size, prot, NUMA_NO_NODE))

This doesn't build.

Adding ...

extern int ioremap_range(unsigned long ea, phys_addr_t pa, unsigned long size, pgprot_t prot, int nid);

... above, until the next patch, fixes it.

cheers
