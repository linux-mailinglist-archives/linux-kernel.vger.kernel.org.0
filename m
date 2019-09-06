Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAD4ABC1A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 17:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391195AbfIFPSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 11:18:42 -0400
Received: from foss.arm.com ([217.140.110.172]:58064 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390233AbfIFPSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:18:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A95341576;
        Fri,  6 Sep 2019 08:18:41 -0700 (PDT)
Received: from [10.1.196.105] (unknown [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B82E3F59C;
        Fri,  6 Sep 2019 08:18:38 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
Subject: Re: [PATCH v3 07/17] arm64, hibernate: move page handling function to
 new trans_pgd.c
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
References: <20190821183204.23576-1-pasha.tatashin@soleen.com>
 <20190821183204.23576-8-pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        vladimir.murzin@arm.com, matthias.bgg@gmail.com,
        bhsharma@redhat.com, linux-mm@kvack.org, mark.rutland@arm.com
Message-ID: <f1db863a-de57-2d1a-6bec-6020b2130964@arm.com>
Date:   Fri, 6 Sep 2019 16:18:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190821183204.23576-8-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 21/08/2019 19:31, Pavel Tatashin wrote:
> Now, that we abstracted the required functions move them to a new home.
> Later, we will generalize these function in order to be useful outside
> of hibernation.

> diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
> new file mode 100644
> index 000000000000..00b62d8640c2
> --- /dev/null
> +++ b/arch/arm64/mm/trans_pgd.c
> @@ -0,0 +1,211 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright (c) 2019, Microsoft Corporation.
> + * Pavel Tatashin <patatash@linux.microsoft.com>

Hmmm, while line-count isn't a useful metric: this file contains 41% of the code that was
in hibernate.c, but has stripped the substantial copyright-pedigree that the hibernate
code had built up over the years.
(counting lines identified by 'cloc' as code, not comments or blank)

If you are copying or moving a non trivial quantity of code, you need to preserve the
copyright. Something like 'Derived from the arm64 hibernate support which has:'....


> + */
> +
> +/*
> + * Transitional tables are used during system transferring from one world to
> + * another: such as during hibernate restore, and kexec reboots. During these
> + * phases one cannot rely on page table not being overwritten.

I think you need to mention that hibernate and kexec are rewriting memory, and may
overwrite the live page tables, therefore ...


> + *
> + */
> +
> +#include <asm/trans_pgd.h>
> +#include <asm/pgalloc.h>
> +#include <asm/pgtable.h>
> +#include <linux/suspend.h>

#include <linux/bug.h>
#include <linux/mm.h>
#include <linux/mmzone.h>


> +static void _copy_pte(pte_t *dst_ptep, pte_t *src_ptep, unsigned long addr)
> +{
> +	pte_t pte = READ_ONCE(*src_ptep);
> +

> +	if (pte_valid(pte)) {

> +		/*
> +		 * Resume will overwrite areas that may be marked
> +		 * read only (code, rodata). Clear the RDONLY bit from
> +		 * the temporary mappings we use during restore.
> +		 */
> +		set_pte(dst_ptep, pte_mkwrite(pte));

> +	} else if (debug_pagealloc_enabled() && !pte_none(pte)) {

> +		/*
> +		 * debug_pagealloc will removed the PTE_VALID bit if
> +		 * the page isn't in use by the resume kernel. It may have
> +		 * been in use by the original kernel, in which case we need
> +		 * to put it back in our copy to do the restore.
> +		 *
> +		 * Before marking this entry valid, check the pfn should
> +		 * be mapped.
> +		 */

> +		BUG_ON(!pfn_valid(pte_pfn(pte)));


Thanks,

James
