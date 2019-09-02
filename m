Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC1EA579A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 15:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbfIBNW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 09:22:28 -0400
Received: from foss.arm.com ([217.140.110.172]:54458 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729783AbfIBNW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:22:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C385337;
        Mon,  2 Sep 2019 06:22:27 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5D5A3F71A;
        Mon,  2 Sep 2019 06:22:25 -0700 (PDT)
Date:   Mon, 2 Sep 2019 14:22:21 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Daniel Axtens <dja@axtens.net>
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        aryabinin@virtuozzo.com, glider@google.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, dvyukov@google.com,
        christophe.leroy@c-s.fr, linuxppc-dev@lists.ozlabs.org,
        gor@linux.ibm.com
Subject: Re: [PATCH v6 1/5] kasan: support backing vmalloc space with real
 shadow memory
Message-ID: <20190902132220.GA9922@lakrids.cambridge.arm.com>
References: <20190902112028.23773-1-dja@axtens.net>
 <20190902112028.23773-2-dja@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902112028.23773-2-dja@axtens.net>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2019 at 09:20:24PM +1000, Daniel Axtens wrote:
> Hook into vmalloc and vmap, and dynamically allocate real shadow
> memory to back the mappings.
> 
> Most mappings in vmalloc space are small, requiring less than a full
> page of shadow space. Allocating a full shadow page per mapping would
> therefore be wasteful. Furthermore, to ensure that different mappings
> use different shadow pages, mappings would have to be aligned to
> KASAN_SHADOW_SCALE_SIZE * PAGE_SIZE.
> 
> Instead, share backing space across multiple mappings. Allocate a
> backing page when a mapping in vmalloc space uses a particular page of
> the shadow region. This page can be shared by other vmalloc mappings
> later on.
> 
> We hook in to the vmap infrastructure to lazily clean up unused shadow
> memory.
> 
> To avoid the difficulties around swapping mappings around, this code
> expects that the part of the shadow region that covers the vmalloc
> space will not be covered by the early shadow page, but will be left
> unmapped. This will require changes in arch-specific code.
> 
> This allows KASAN with VMAP_STACK, and may be helpful for architectures
> that do not have a separate module space (e.g. powerpc64, which I am
> currently working on). It also allows relaxing the module alignment
> back to PAGE_SIZE.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=202009
> Acked-by: Vasily Gorbik <gor@linux.ibm.com>
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> [Mark: rework shadow allocation]
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> 
> --
> 
> v2: let kasan_unpoison_shadow deal with ranges that do not use a
>     full shadow byte.
> 
> v3: relax module alignment
>     rename to kasan_populate_vmalloc which is a much better name
>     deal with concurrency correctly
> 
> v4: Mark's rework
>     Poision pages on vfree
>     Handle allocation failures
> 
> v5: Per Christophe Leroy, split out test and dynamically free pages.
> 
> v6: Guard freeing page properly. Drop WARN_ON_ONCE(pte_none(*ptep)),
>      on reflection it's unnecessary debugging cruft with too high a
>      false positive rate.
> ---

[...]

> +static int kasan_depopulate_vmalloc_pte(pte_t *ptep, unsigned long addr,
> +					void *unused)
> +{
> +	unsigned long page;
> +
> +	page = (unsigned long)__va(pte_pfn(*ptep) << PAGE_SHIFT);
> +
> +	spin_lock(&init_mm.page_table_lock);
> +
> +	if (likely(!pte_none(*ptep))) {
> +		pte_clear(&init_mm, addr, ptep);
> +		free_page(page);
> +	}
> +	spin_unlock(&init_mm.page_table_lock);
> +
> +	return 0;
> +}

There needs to be TLB maintenance after unmapping the page, but I don't
see that happening below.

We need that to ensure that errant accesses don't hit the page we're
freeing and that new mappings at the same VA don't cause a TLB conflict
or TLB amalgamation issue.

> +/*
> + * Release the backing for the vmalloc region [start, end), which
> + * lies within the free region [free_region_start, free_region_end).
> + *
> + * This can be run lazily, long after the region was freed. It runs
> + * under vmap_area_lock, so it's not safe to interact with the vmalloc/vmap
> + * infrastructure.
> + */

IIUC we aim to only free non-shared shadow by aligning the start
upwards, and aligning the end downwards. I think it would be worth
mentioning that explicitly in the comment since otherwise it's not
obvious how we handle races between alloc/free.

Thanks,
Mark.

> +void kasan_release_vmalloc(unsigned long start, unsigned long end,
> +			   unsigned long free_region_start,
> +			   unsigned long free_region_end)
> +{
> +	void *shadow_start, *shadow_end;
> +	unsigned long region_start, region_end;
> +
> +	/* we start with shadow entirely covered by this region */
> +	region_start = ALIGN(start, PAGE_SIZE * KASAN_SHADOW_SCALE_SIZE);
> +	region_end = ALIGN_DOWN(end, PAGE_SIZE * KASAN_SHADOW_SCALE_SIZE);
> +
> +	/*
> +	 * We don't want to extend the region we release to the entire free
> +	 * region, as the free region might cover huge chunks of vmalloc space
> +	 * where we never allocated anything. We just want to see if we can
> +	 * extend the [start, end) range: if start or end fall part way through
> +	 * a shadow page, we want to check if we can free that entire page.
> +	 */
> +
> +	free_region_start = ALIGN(free_region_start,
> +				  PAGE_SIZE * KASAN_SHADOW_SCALE_SIZE);
> +
> +	if (start != region_start &&
> +	    free_region_start < region_start)
> +		region_start -= PAGE_SIZE * KASAN_SHADOW_SCALE_SIZE;
> +
> +	free_region_end = ALIGN_DOWN(free_region_end,
> +				     PAGE_SIZE * KASAN_SHADOW_SCALE_SIZE);
> +
> +	if (end != region_end &&
> +	    free_region_end > region_end)
> +		region_end += PAGE_SIZE * KASAN_SHADOW_SCALE_SIZE;
> +
> +	shadow_start = kasan_mem_to_shadow((void *)region_start);
> +	shadow_end = kasan_mem_to_shadow((void *)region_end);
> +
> +	if (shadow_end > shadow_start)
> +		apply_to_page_range(&init_mm, (unsigned long)shadow_start,
> +				    (unsigned long)(shadow_end - shadow_start),
> +				    kasan_depopulate_vmalloc_pte, NULL);
> +}
