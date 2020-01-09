Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B10BE1351E9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 04:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgAIDZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 22:25:02 -0500
Received: from foss.arm.com ([217.140.110.172]:53120 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727524AbgAIDZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 22:25:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4613431B;
        Wed,  8 Jan 2020 19:25:01 -0800 (PST)
Received: from [10.162.40.138] (p8cg001049571a15.blr.arm.com [10.162.40.138])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE4BE3F534;
        Wed,  8 Jan 2020 19:24:56 -0800 (PST)
Subject: Re: [PATCH 1/1] arm/arm64: add support for folded p4d page tables
To:     Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
References: <20191230082734.28954-1-rppt@kernel.org>
 <20191230082734.28954-2-rppt@kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <7f18fc35-3380-564b-b660-0c003d7d3107@arm.com>
Date:   Thu, 9 Jan 2020 08:56:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191230082734.28954-2-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/30/2019 01:57 PM, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Implement primitives necessary for the 4th level folding, add walks of p4d
> level where appropriate, replace 5level-fixup.h with pgtable-nop4d.h and
> remove __ARCH_USE_5LEVEL_HACK.
> 
> Since arm and arm64 share kvm memory management bits, make the conversion
> for both variants at once to avoid breaking the builds in the middle.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/arm/include/asm/kvm_mmu.h          |   5 +-
>  arch/arm/include/asm/pgtable.h          |   1 -
>  arch/arm/include/asm/stage2_pgtable.h   |  15 +-
>  arch/arm/lib/uaccess_with_memcpy.c      |   9 +-
>  arch/arm/mach-sa1100/assabet.c          |   2 +-
>  arch/arm/mm/dump.c                      |  29 +++-
>  arch/arm/mm/fault-armv.c                |   7 +-
>  arch/arm/mm/fault.c                     |  28 +++-
>  arch/arm/mm/idmap.c                     |   3 +-
>  arch/arm/mm/init.c                      |   2 +-
>  arch/arm/mm/ioremap.c                   |  12 +-
>  arch/arm/mm/mm.h                        |   2 +-
>  arch/arm/mm/mmu.c                       |  35 +++-
>  arch/arm/mm/pgd.c                       |  40 ++++-
>  arch/arm64/include/asm/kvm_mmu.h        |  10 +-
>  arch/arm64/include/asm/pgalloc.h        |  10 +-
>  arch/arm64/include/asm/pgtable-types.h  |   5 +-
>  arch/arm64/include/asm/pgtable.h        |  37 +++--
>  arch/arm64/include/asm/stage2_pgtable.h |  48 ++++--
>  arch/arm64/kernel/hibernate.c           |  46 +++++-
>  arch/arm64/mm/dump.c                    |  29 +++-
>  arch/arm64/mm/fault.c                   |   9 +-
>  arch/arm64/mm/hugetlbpage.c             |  15 +-
>  arch/arm64/mm/kasan_init.c              |  41 ++++-
>  arch/arm64/mm/mmu.c                     |  52 ++++--
>  arch/arm64/mm/pageattr.c                |   7 +-
>  virt/kvm/arm/mmu.c                      | 209 ++++++++++++++++++++----
>  27 files changed, 565 insertions(+), 143 deletions(-)
> 

^^^^^^

> diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> index f87a32484ea8..fd6220508711 100644
> --- a/arch/arm64/mm/kasan_init.c
> +++ b/arch/arm64/mm/kasan_init.c
> @@ -84,17 +84,32 @@ static pmd_t *__init kasan_pmd_offset(pud_t *pudp, unsigned long addr, int node,
>  	return early ? pmd_offset_kimg(pudp, addr) : pmd_offset(pudp, addr);
>  }
>  
> -static pud_t *__init kasan_pud_offset(pgd_t *pgdp, unsigned long addr, int node,
> +static pud_t *__init kasan_pud_offset(p4d_t *p4dp, unsigned long addr, int node,
>  				      bool early)
>  {
> -	if (pgd_none(READ_ONCE(*pgdp))) {
> +	if (p4d_none(READ_ONCE(*p4dp))) {
>  		phys_addr_t pud_phys = early ?
>  				__pa_symbol(kasan_early_shadow_pud)
>  					: kasan_alloc_zeroed_page(node);
> -		__pgd_populate(pgdp, pud_phys, PMD_TYPE_TABLE);
> +		__p4d_populate(p4dp, pud_phys, PMD_TYPE_TABLE);
> +	}
> +
> +	return early ? pud_offset_kimg(p4dp, addr) : pud_offset(p4dp, addr);
> +}
> +
> +static p4d_t *__init kasan_p4d_offset(pgd_t *pgdp, unsigned long addr, int node,
> +				      bool early)
> +{
> +#ifndef __PAGETABLE_P4D_FOLDED
> +	if (pgd_none(READ_ONCE(*pgdp))) {
> +		phys_addr_t p4d_phys = early ?
> +				__pa_symbol(kasan_early_shadow_p4d)
> +					: kasan_alloc_zeroed_page(node);
> +		__pgd_populate(pgdp, p4d_phys, PMD_TYPE_TABLE);

We dont have __pgd_populate() definition any more. AFAICS __PAGETABLE_P4D_FOLDED
is always defined because pgtable-nop4d.h gets pulled in for all configurations
via pgtable-nopud.h and pgtable-nopmd.h headers.

>  	}
> +#endif
>  
> -	return early ? pud_offset_kimg(pgdp, addr) : pud_offset(pgdp, addr);
> +	return early ? p4d_offset_kimg(pgdp, addr) : p4d_offset(pgdp, addr);
>  }
>  
>  static void __init kasan_pte_populate(pmd_t *pmdp, unsigned long addr,
> @@ -126,11 +141,11 @@ static void __init kasan_pmd_populate(pud_t *pudp, unsigned long addr,
>  	} while (pmdp++, addr = next, addr != end && pmd_none(READ_ONCE(*pmdp)));
>  }
>  
> -static void __init kasan_pud_populate(pgd_t *pgdp, unsigned long addr,
> +static void __init kasan_pud_populate(p4d_t *p4dp, unsigned long addr,
>  				      unsigned long end, int node, bool early)
>  {
>  	unsigned long next;
> -	pud_t *pudp = kasan_pud_offset(pgdp, addr, node, early);
> +	pud_t *pudp = kasan_pud_offset(p4dp, addr, node, early);
>  
>  	do {
>  		next = pud_addr_end(addr, end);
> @@ -138,6 +153,18 @@ static void __init kasan_pud_populate(pgd_t *pgdp, unsigned long addr,
>  	} while (pudp++, addr = next, addr != end && pud_none(READ_ONCE(*pudp)));
>  }
>  
> +static void __init kasan_p4d_populate(pgd_t *pgdp, unsigned long addr,
> +				      unsigned long end, int node, bool early)
> +{
> +	unsigned long next;
> +	p4d_t *p4dp = kasan_p4d_offset(pgdp, addr, node, early);
> +
> +	do {
> +		next = p4d_addr_end(addr, end);
> +		kasan_pmd_populate(p4dp, addr, next, node, early);

s/kasan_pmd_populate()/kasan_pud_populate()
