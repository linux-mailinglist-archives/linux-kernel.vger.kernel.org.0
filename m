Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67B6315181B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 10:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgBDJq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 04:46:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:40210 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbgBDJq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 04:46:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BC651ABF4;
        Tue,  4 Feb 2020 09:46:55 +0000 (UTC)
Date:   Tue, 4 Feb 2020 10:46:53 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH v6 10/10] mm/memory_hotplug: Cleanup __remove_pages()
Message-ID: <20200204094652.GE6494@linux>
References: <20191006085646.5768-1-david@redhat.com>
 <20191006085646.5768-11-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191006085646.5768-11-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 06, 2019 at 10:56:46AM +0200, David Hildenbrand wrote:
> Let's drop the basically unused section stuff and simplify.
> 
> Also, let's use a shorter variant to calculate the number of pages to
> the next section boundary.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Wei Yang <richardw.yang@linux.intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

I have to confess that it took me while to wrap around my head
with the new min() change, but looks ok:

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/memory_hotplug.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 843481bd507d..2275240cfa10 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -490,25 +490,20 @@ static void __remove_section(unsigned long pfn, unsigned long nr_pages,
>  void __remove_pages(unsigned long pfn, unsigned long nr_pages,
>  		    struct vmem_altmap *altmap)
>  {
> +	const unsigned long end_pfn = pfn + nr_pages;
> +	unsigned long cur_nr_pages;
>  	unsigned long map_offset = 0;
> -	unsigned long nr, start_sec, end_sec;
>  
>  	map_offset = vmem_altmap_offset(altmap);
>  
>  	if (check_pfn_span(pfn, nr_pages, "remove"))
>  		return;
>  
> -	start_sec = pfn_to_section_nr(pfn);
> -	end_sec = pfn_to_section_nr(pfn + nr_pages - 1);
> -	for (nr = start_sec; nr <= end_sec; nr++) {
> -		unsigned long pfns;
> -
> +	for (; pfn < end_pfn; pfn += cur_nr_pages) {
>  		cond_resched();
> -		pfns = min(nr_pages, PAGES_PER_SECTION
> -				- (pfn & ~PAGE_SECTION_MASK));
> -		__remove_section(pfn, pfns, map_offset, altmap);
> -		pfn += pfns;
> -		nr_pages -= pfns;
> +		/* Select all remaining pages up to the next section boundary */
> +		cur_nr_pages = min(end_pfn - pfn, -(pfn | PAGE_SECTION_MASK));
> +		__remove_section(pfn, cur_nr_pages, map_offset, altmap);
>  		map_offset = 0;
>  	}
>  }
> -- 
> 2.21.0
> 
> 

-- 
Oscar Salvador
SUSE L3
