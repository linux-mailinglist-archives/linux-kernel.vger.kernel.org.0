Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6428D59B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 16:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbfHNOIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 10:08:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:57790 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726551AbfHNOIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 10:08:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8A6B0ADCC;
        Wed, 14 Aug 2019 14:08:05 +0000 (UTC)
Date:   Wed, 14 Aug 2019 16:08:05 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Arun KS <arunks@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v1 2/4] mm/memory_hotplug: Handle unaligned start and
 nr_pages in online_pages_blocks()
Message-ID: <20190814140805.GA17933@dhcp22.suse.cz>
References: <20190809125701.3316-1-david@redhat.com>
 <20190809125701.3316-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809125701.3316-3-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 09-08-19 14:56:59, David Hildenbrand wrote:
> Take care of nr_pages not being a power of two and start not being
> properly aligned. Essentially, what walk_system_ram_range() could provide
> to us. get_order() will round-up in case it's not a power of two.
> 
> This should only apply to memory blocks that contain strange memory
> resources (especially with holes), not to ordinary DIMMs.

I would really like to see an example of such setup before making the
code hard to read. Because I am not really sure something like that
exists at all.

> Fixes: a9cd410a3d29 ("mm/page_alloc.c: memory hotplug: free pages as higher order")
> Cc: Arun KS <arunks@codeaurora.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/memory_hotplug.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 3706a137d880..2abd938c8c45 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -640,6 +640,10 @@ static int online_pages_blocks(unsigned long start, unsigned long nr_pages)
>  	while (start < end) {
>  		order = min(MAX_ORDER - 1,
>  			get_order(PFN_PHYS(end) - PFN_PHYS(start)));
> +		/* make sure the PFN is aligned and we don't exceed the range */
> +		while (!IS_ALIGNED(start, 1ul << order) ||
> +		       (1ul << order) > end - start)
> +			order--;
>  		(*online_page_callback)(pfn_to_page(start), order);
>  
>  		onlined_pages += (1UL << order);
> -- 
> 2.21.0

-- 
Michal Hocko
SUSE Labs
