Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 171EB75E2A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 07:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbfGZFJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 01:09:59 -0400
Received: from foss.arm.com ([217.140.110.172]:37910 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfGZFJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 01:09:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E00C337;
        Thu, 25 Jul 2019 22:09:57 -0700 (PDT)
Received: from [10.163.1.197] (unknown [10.163.1.197])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 818A13F694;
        Thu, 25 Jul 2019 22:11:55 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [RFC] mm/pgtable/debug: Add test validating architecture page
 table helpers
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     linux-mm@kvack.org, Mark Rutland <mark.rutland@arm.com>,
        x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mark Brown <Mark.Brown@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <Steven.Price@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <1564037723-26676-1-git-send-email-anshuman.khandual@arm.com>
 <1564037723-26676-2-git-send-email-anshuman.khandual@arm.com>
 <20190725215427.GL1330@shell.armlinux.org.uk>
Message-ID: <1f64ba59-af68-7daa-44bf-6ac1f8f796a8@arm.com>
Date:   Fri, 26 Jul 2019 10:40:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190725215427.GL1330@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/26/2019 03:24 AM, Russell King - ARM Linux admin wrote:
> On Thu, Jul 25, 2019 at 12:25:23PM +0530, Anshuman Khandual wrote:
>> This adds a test module which will validate architecture page table helpers
>> and accessors regarding compliance with generic MM semantics expectations.
>> This will help various architectures in validating changes to the existing
>> page table helpers or addition of new ones.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Mark Brown <Mark.Brown@arm.com>
>> Cc: Steven Price <Steven.Price@arm.com>
>> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Sri Krishna chowdary <schowdary@nvidia.com>
>> Cc: Dave Hansen <dave.hansen@intel.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: x86@kernel.org
>> Cc: linux-kernel@vger.kernel.org
>>
>> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  lib/Kconfig.debug       |  14 +++
>>  lib/Makefile            |   1 +
>>  lib/test_arch_pgtable.c | 290 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 305 insertions(+)
>>  create mode 100644 lib/test_arch_pgtable.c
>>
>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>> index 5960e29..a27fe8d 100644
>> --- a/lib/Kconfig.debug
>> +++ b/lib/Kconfig.debug
>> @@ -1719,6 +1719,20 @@ config TEST_SORT
>>  
>>  	  If unsure, say N.
>>  
>> +config TEST_ARCH_PGTABLE
>> +	tristate "Test arch page table helpers for semantics compliance"
>> +	depends on MMUpte/pmd/pud/p4d/pgd 
>> +	depends on DEBUG_KERNEL || m
>> +	help
>> +	  This options provides a kernel module which can be used to test
>> +	  architecture page table helper functions on various platform in
>> +	  verifing if they comply with expected generic MM semantics. This
>> +	  will help architectures code in making sure that any changes or
>> +	  new additions of these helpers will still conform to generic MM
>> +	  expeted semantics.
>> +
>> +	  If unsure, say N.
>> +
>>  config KPROBES_SANITY_TEST
>>  	bool "Kprobes sanity tests"
>>  	depends on DEBUG_KERNEL
>> diff --git a/lib/Makefile b/lib/Makefile
>> index 095601c..0806d61 100644
>> --- a/lib/Makefile
>> +++ b/lib/Makefile
>> @@ -76,6 +76,7 @@ obj-$(CONFIG_TEST_VMALLOC) += test_vmalloc.o
>>  obj-$(CONFIG_TEST_OVERFLOW) += test_overflow.o
>>  obj-$(CONFIG_TEST_RHASHTABLE) += test_rhashtable.o
>>  obj-$(CONFIG_TEST_SORT) += test_sort.o
>> +obj-$(CONFIG_TEST_ARCH_PGTABLE) += test_arch_pgtable.o
>>  obj-$(CONFIG_TEST_USER_COPY) += test_user_copy.o
>>  obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_keys.o
>>  obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_key_base.o
>> diff --git a/lib/test_arch_pgtable.c b/lib/test_arch_pgtable.c
>> new file mode 100644
>> index 0000000..1396664
>> --- /dev/null
>> +++ b/lib/test_arch_pgtable.c
>> @@ -0,0 +1,290 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * This kernel module validates architecture page table helpers &
>> + * accessors and helps in verifying their continued compliance with
>> + * generic MM semantics.
>> + *
>> + * Copyright (C) 2019 ARM Ltd.
>> + *
>> + * Author: Anshuman Khandual <anshuman.khandual@arm.com>
>> + */
>> +#define pr_fmt(fmt) "test_arch_pgtable: %s " fmt, __func__
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/hugetlb.h>
>> +#include <linux/mm.h>
>> +#include <linux/mman.h>
>> +#include <linux/mm_types.h>
>> +#include <linux/module.h>
>> +#include <linux/printk.h>
>> +#include <linux/swap.h>
>> +#include <linux/swapops.h>
>> +#include <linux/pfn_t.h>
>> +#include <linux/gfp.h>
>> +#include <asm/pgalloc.h>
>> +#include <asm/pgtable.h>
>> +
>> +/*
>> + * Basic operations
>> + *
>> + * mkold(entry)			= An old and not an young entry
>> + * mkyoung(entry)		= An young and not an old entry
>> + * mkdirty(entry)		= A dirty and not a clean entry
>> + * mkclean(entry)		= A clean and not a dirty entry
>> + * mkwrite(entry)		= An write and not an write protected entry
>> + * wrprotect(entry)		= An write protected and not an write entry
>> + * pxx_bad(entry)		= A mapped and non-table entry
>> + * pxx_same(entry1, entry2)	= Both entries hold the exact same value
>> + */
>> +#define VMA_TEST_FLAGS (VM_READ|VM_WRITE|VM_EXEC)
>> +
>> +static struct vm_area_struct vma;
>> +static struct mm_struct mm;
>> +static struct page *page;
>> +static pgprot_t prot;
>> +static unsigned long pfn, addr;
>> +
>> +static void pte_basic_tests(void)
>> +{
>> +	pte_t pte;
>> +
>> +	pte = mk_pte(page, prot);
>> +	WARN_ON(!pte_same(pte, pte));
>> +	WARN_ON(!pte_young(pte_mkyoung(pte)));
>> +	WARN_ON(!pte_dirty(pte_mkdirty(pte)));
>> +	WARN_ON(!pte_write(pte_mkwrite(pte)));
>> +	WARN_ON(pte_young(pte_mkold(pte)));
>> +	WARN_ON(pte_dirty(pte_mkclean(pte)));
>> +	WARN_ON(pte_write(pte_wrprotect(pte)));
>> +}
>> +
>> +#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE
>> +static void pmd_basic_tests(void)
>> +{
>> +	pmd_t pmd;
>> +
>> +	pmd = mk_pmd(page, prot);
> 
> mk_pmd() is provided on 32-bit ARM LPAE, which also sets
> HAVE_ARCH_TRANSPARENT_HUGEPAGE, so this should be fine.

Okay.

> 
>> +	WARN_ON(!pmd_same(pmd, pmd));
>> +	WARN_ON(!pmd_young(pmd_mkyoung(pmd)));
>> +	WARN_ON(!pmd_dirty(pmd_mkdirty(pmd)));
>> +	WARN_ON(!pmd_write(pmd_mkwrite(pmd)));
>> +	WARN_ON(pmd_young(pmd_mkold(pmd)));
>> +	WARN_ON(pmd_dirty(pmd_mkclean(pmd)));
>> +	WARN_ON(pmd_write(pmd_wrprotect(pmd)));
>> +	/*
>> +	 * A huge page does not point to next level page table
>> +	 * entry. Hence this must qualify as pmd_bad().
>> +	 */
>> +	WARN_ON(!pmd_bad(pmd_mkhuge(pmd)));
>> +}
>> +#else
>> +static void pmd_basic_tests(void) { }
>> +#endif
>> +
>> +#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
>> +static void pud_basic_tests(void)
>> +{
>> +	pud_t pud;
>> +
>> +	pud = pfn_pud(pfn, prot);
>> +	WARN_ON(!pud_same(pud, pud));
>> +	WARN_ON(!pud_young(pud_mkyoung(pud)));
>> +	WARN_ON(!pud_write(pud_mkwrite(pud)));
>> +	WARN_ON(pud_write(pud_wrprotect(pud)));
>> +	WARN_ON(pud_young(pud_mkold(pud)));
>> +
>> +#if !defined(__PAGETABLE_PMD_FOLDED) && !defined(__ARCH_HAS_4LEVEL_HACK)
>> +	/*
>> +	 * A huge page does not point to next level page table
>> +	 * entry. Hence this must qualify as pud_bad().
>> +	 */
>> +	WARN_ON(!pud_bad(pud_mkhuge(pud)));
>> +#endif
>> +}
>> +#else
>> +static void pud_basic_tests(void) { }
>> +#endif
>> +
>> +static void p4d_basic_tests(void)
>> +{
>> +	pte_t pte;
>> +	p4d_t p4d;
>> +
>> +	pte = mk_pte(page, prot);
>> +	p4d = (p4d_t) { (pte_val(pte)) };
>> +	WARN_ON(!p4d_same(p4d, p4d));
> 
> If the intention is to test p4d_same(), is this really a sufficient test?

p4d_same() just tests if two p4d entries have the same value. Hence any non-zero
value in there should be able to achieve that. Besides p4d does not have much
common helpers (as it gets often folded) to operate on an entry in order to create
other real world values. But if you have suggestions to make this better I am happy
to incorporate.

> 
>> +}
>> +
>> +static void pgd_basic_tests(void)
>> +{
>> +	pte_t pte;
>> +	pgd_t pgd;
>> +
>> +	pte = mk_pte(page, prot);
>> +	pgd = (pgd_t) { (pte_val(pte)) };
>> +	WARN_ON(!pgd_same(pgd, pgd));
> 
> If the intention is to test pgd_same(), is this really a sufficient test?

Same as above.

> 
>> +}
>> +
>> +#if !defined(__PAGETABLE_PMD_FOLDED) && !defined(__ARCH_HAS_4LEVEL_HACK)
>> +static void pud_clear_tests(void)
>> +{
>> +	pud_t pud;
>> +
>> +	pud_clear(&pud);
>> +	WARN_ON(!pud_none(pud));
>> +}
>> +
>> +static void pud_populate_tests(void)
>> +{
>> +	pmd_t pmd;
>> +	pud_t pud;
>> +
>> +	/*
>> +	 * This entry points to next level page table page.
>> +	 * Hence this must not qualify as pud_bad().
>> +	 */
>> +	pmd_clear(&pmd);
> 
> 32-bit ARM sets __PAGETABLE_PMD_FOLDED so this is not a concern.

Okay.

> 
>> +	pud_clear(&pud);
>> +	pud_populate(&mm, &pud, &pmd);
>> +	WARN_ON(pud_bad(pud));
>> +}
>> +#else
>> +static void pud_clear_tests(void) { }
>> +static void pud_populate_tests(void) { }
>> +#endif
>> +
>> +#if !defined(__PAGETABLE_PUD_FOLDED) && !defined(__ARCH_HAS_5LEVEL_HACK)
>> +static void p4d_clear_tests(void)
>> +{
>> +	p4d_t p4d;
>> +
>> +	p4d_clear(&p4d);
>> +	WARN_ON(!p4d_none(p4d));
>> +}
>> +
>> +static void p4d_populate_tests(void)
>> +{
>> +	pud_t pud;
>> +	p4d_t p4d;
>> +
>> +	/*
>> +	 * This entry points to next level page table page.
>> +	 * Hence this must not qualify as p4d_bad().
>> +	 */
>> +	pud_clear(&pud);
>> +	p4d_clear(&p4d);
>> +	p4d_populate(&mm, &p4d, &pud);
>> +	WARN_ON(p4d_bad(p4d));
>> +}
>> +#else
>> +static void p4d_clear_tests(void) { }
>> +static void p4d_populate_tests(void) { }
>> +#endif
>> +
>> +#ifndef __PAGETABLE_P4D_FOLDED
>> +static void pgd_clear_tests(void)
>> +{
>> +	pgd_t pgd;
>> +
>> +	pgd_clear(&pgd);
>> +	WARN_ON(!pgd_none(pgd));
>> +}
>> +
>> +static void pgd_populate_tests(void)
>> +{
>> +	pgd_t p4d;
>> +	pgd_t pgd;
>> +
>> +	/*
>> +	 * This entry points to next level page table page.
>> +	 * Hence this must not qualify as pgd_bad().
>> +	 */
>> +	p4d_clear(&p4d);
>> +	pgd_clear(&pgd);
>> +	pgd_populate(&mm, &pgd, &p4d);
>> +	WARN_ON(pgd_bad(pgd));
>> +}
>> +#else
>> +static void pgd_clear_tests(void) { }
>> +static void pgd_populate_tests(void) { }
>> +#endif
>> +
>> +static void pxx_clear_tests(void)
>> +{
>> +	pte_t pte;
>> +	pmd_t pmd;
>> +
>> +	pte_clear(NULL, 0, &pte);
>> +	WARN_ON(!pte_none(pte));
>> +
>> +	pmd_clear(&pmd);
> 
> This really isn't going to be happy on 32-bit non-LPAE ARM.  Here, a
> PMD is a 32-bit entry which is expected to be _within_ a proper PGD,
> where a PGD is 16K in size, consisting of pairs of PMDs.
> 
> So, pmd_clear() expects to always be called for an _even_ PMD of the
> pair, and will write to the even and following odd PMD.  Hence, the
> above will scribble over the stack of this function.

A pmd_clear() clears two consecutive 32 bit pmd_t entries not a single
one. So the stack needs to have two entries for such cases. I could see
only a single definition for pmd_none() on arm, hence pmd_none() should
be called on both the 32 bit entries cleared with pmd_clear() earlier ?

Though this could be accommodate with relevant non-LPAE ARM specific
config option but should we do that ? All the config wrappers in the test
right now are generic MM identifiable and nothing platform specific. The
primary idea is to test platform page table helpers as seen from generic
MM. Any suggestions how to incorporate this while still keeping the test
clear from platform specific details like these ?

> 
>> +	WARN_ON(!pmd_none(pmd));
>> +
>> +	pud_clear_tests();
>> +	p4d_clear_tests();
>> +	pgd_clear_tests();
>> +}
>> +
>> +static void pxx_populate_tests(void)
>> +{
>> +	pmd_t pmd;
>> +
>> +	/*
>> +	 * This entry points to next level page table page.
>> +	 * Hence this must not qualify as pmd_bad().
>> +	 */
>> +	memset(page, 0, sizeof(*page));
>> +	pmd_clear(&pmd);
> 
> This really isn't going to be happy on 32-bit non-LPAE ARM.  Here, a
> PMD is a 32-bit entry which is expected to be _within_ a proper PGD,
> where a PGD is 16K in size, consisting of pairs of PMDs.
> 
> So, pmd_clear() expects to always be called for an _even_ PMD of the
> pair, and will write to the even and following odd PMD.  Hence, the
> above will scribble over the stack of this function.

Same as above.

> 
>> +	pmd_populate(&mm, &pmd, page);
> 
> This too has the same expectations on 32-bit non-LPAE ARM.

Right this loads up both pmdp[0] and pmdp[1]. The issue is equivalent to
the one detailed above.
