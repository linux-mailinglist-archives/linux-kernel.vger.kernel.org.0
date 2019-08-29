Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3698A211A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 18:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbfH2Qj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 12:39:59 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38759 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbfH2Qj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 12:39:59 -0400
Received: by mail-io1-f68.google.com with SMTP id p12so8226174iog.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 09:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=stW1VQFI4STCMyU5y9D+1BszGenZwn0BGuJ2r0x8vwc=;
        b=VIO7mvKBwITVrPFsG28nd/d++zZrMREPcXMi6b+Np8bsRZlXf9SmBNLJKstZKhUTVM
         OBRotQwyUglToxI2SQXDPr9/M9WnPB3K8HDPXZHovyyxWTBqSum0E25xXz5WO0lpgD7P
         8FoWRcaS3OUixeQPaqn8ICUkNdwzITbtfoxvr6PW7k+y7t5oB411W0xxWZ4JYeQKtU2Q
         nJTNDE7eGQHQq+iexujJT4Me2yiEUANzdNORlkNEAZc6BOcppNn3+rJNIqA4lVZMluDQ
         7pUysDXJAAknnHpp+GCr7sdoyweCdkusrRzzEn7LCka7BkCVLc859Ja2d6SeIw9U7pDw
         Gb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=stW1VQFI4STCMyU5y9D+1BszGenZwn0BGuJ2r0x8vwc=;
        b=M8gWTOk+MoSf0NZeax5U3EkHFC8DKOuasZNWqcNojkJruHUS76g6WYqIfNZCqhhGgU
         ntlkOrdS0+1fqXMZFmzggghKLbdqVZXwc9D+0TaaVxrTjGlWwsb/HgPc1wffGRT1QKXB
         Qr4vlDy2OIPNt6yiHGGA2t0BBKvLNOxDD0c5KgSZsWp7lZwe1eKvXThJewKAZQR+rsnm
         DpxROr9R12RqG9iVUIYsb0hWU8FpwXkIFWlQac5zPQCZemrVjqdiTf2lexnVlJxBhnOT
         XvueOvYcMT/lSlAvpC7VCY1x6bURw8nvd/c+YEumSAhos6S/XwicBY+4WqbWL3+Y0WPQ
         kIAA==
X-Gm-Message-State: APjAAAVHqTbyc7eF2ocvsUonz5iuHhBeo5xZ3epPqqF0JsgpmXci0aLZ
        On02WIBgVt5gd1j3CIpxKA03kkwORWDr5qPt1m0=
X-Google-Smtp-Source: APXvYqyrGUu/Ys992gbXkcb0FiQaHwS4clbXFYgeo+v9dQrrDxqHUeIC3q4jqB3jT+uKYQOcH/cu8Va6ZWJP6WDY1bw=
X-Received: by 2002:a6b:fc02:: with SMTP id r2mr11607565ioh.15.1567096797779;
 Thu, 29 Aug 2019 09:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190829070019.12714-1-david@redhat.com> <20190829070019.12714-2-david@redhat.com>
In-Reply-To: <20190829070019.12714-2-david@redhat.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Thu, 29 Aug 2019 09:39:45 -0700
Message-ID: <CAKgT0UdKwYhF++=b=vN_Kw_SORtgJ3ehCAn8a9kp8tb79HknyQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] mm/memremap: Get rid of memmap_init_zone_device()
To:     David Hildenbrand <david@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Wei Yang <richard.weiyang@gmail.com>, Qian Cai <cai@lca.pw>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Dave Airlie <airlied@redhat.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Arun KS <arunks@codeaurora.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Logan Gunthorpe <logang@deltatee.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 12:00 AM David Hildenbrand <david@redhat.com> wrote:
>
> As far as I can see, the original split wanted to speed up a duplicate
> initialization. We now only initialize once - and we really should
> initialize under the lock, when resizing the zones.

What do you mean by duplicate initialization? Basically the issue was
that we can have systems with massive memory footprints and I was just
trying to get the initialization time under a minute. The compromise I
made was to split the initialization so that we only initialized the
pages in the altmap and defer the rest so that they can be initialized
in parallel.

What this patch does is serialize the initialization so it will likely
take 2 to 4 minutes or more to initialize memory on a system where I
had brought the init time under about 30 seconds.

> As soon as we drop the lock we might have memory unplug running, trying
> to shrink the zone again. In case the memmap was not properly initialized,
> the zone/node shrinking code might get false negatives when search for
> the new zone/node boundaries - bad. We suddenly could no longer span the
> memory we just added.

The issue as I see it is that we can have systems with multiple nodes
and each node can populate a fairly significant amount of data. By
pushing this all back under the hotplug lock you are serializing the
initialization for each node resulting in a 4x or 8x increase in
initialization time on some of these bigger systems.

> Also, once we want to fix set_zone_contiguous(zone) inside
> move_pfn_range_to_zone() to actually work with ZONE_DEVICE (instead of
> always immediately stopping and never setting zone->contiguous) we have
> to have the whole memmap initialized at that point. (not sure if we
> want that in the future, just a note)
>
> Let's just keep things simple and initialize the memmap when resizing
> the zones under the lock.
>
> If this is a real performance issue, we have to watch out for
> alternatives.

My concern is that this is going to become a performance issue, but I
don't have access to the hardware at the moment to test how much of
one. I'll have to check to see if I can get access to a system to test
this patch set.

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Oscar Salvador <osalvador@suse.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Cc: Qian Cai <cai@lca.pw>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Andrey Konovalov <andreyknvl@google.com>
> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Arun KS <arunks@codeaurora.org>
> Cc: Souptick Joarder <jrdr.linux@gmail.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Cc: Alexander Potapenko <glider@google.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/memory_hotplug.h |  2 +-
>  include/linux/mm.h             |  4 +---
>  mm/memory_hotplug.c            |  4 ++--
>  mm/memremap.c                  |  9 +-------
>  mm/page_alloc.c                | 42 ++++++++++++----------------------
>  5 files changed, 20 insertions(+), 41 deletions(-)
>
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index f46ea71b4ffd..235530cdface 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -344,7 +344,7 @@ extern int __add_memory(int nid, u64 start, u64 size);
>  extern int add_memory(int nid, u64 start, u64 size);
>  extern int add_memory_resource(int nid, struct resource *resource);
>  extern void move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
> -               unsigned long nr_pages, struct vmem_altmap *altmap);
> +               unsigned long nr_pages, struct dev_pagemap *pgmap);
>  extern bool is_memblock_offlined(struct memory_block *mem);
>  extern int sparse_add_section(int nid, unsigned long pfn,
>                 unsigned long nr_pages, struct vmem_altmap *altmap);
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ad6766a08f9b..2bd445c4d3b4 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -962,8 +962,6 @@ static inline bool is_zone_device_page(const struct page *page)
>  {
>         return page_zonenum(page) == ZONE_DEVICE;
>  }
> -extern void memmap_init_zone_device(struct zone *, unsigned long,
> -                                   unsigned long, struct dev_pagemap *);
>  #else
>  static inline bool is_zone_device_page(const struct page *page)
>  {
> @@ -2243,7 +2241,7 @@ static inline void zero_resv_unavail(void) {}
>
>  extern void set_dma_reserve(unsigned long new_dma_reserve);
>  extern void memmap_init_zone(unsigned long, int, unsigned long, unsigned long,
> -               enum memmap_context, struct vmem_altmap *);
> +               enum memmap_context, struct dev_pagemap *);
>  extern void setup_per_zone_wmarks(void);
>  extern int __meminit init_per_zone_wmark_min(void);
>  extern void mem_init(void);
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 49f7bf91c25a..35a395d195c6 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -719,7 +719,7 @@ static void __meminit resize_pgdat_range(struct pglist_data *pgdat, unsigned lon
>   * call, all affected pages are PG_reserved.
>   */
>  void __ref move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
> -               unsigned long nr_pages, struct vmem_altmap *altmap)
> +               unsigned long nr_pages, struct dev_pagemap *pgmap)
>  {
>         struct pglist_data *pgdat = zone->zone_pgdat;
>         int nid = pgdat->node_id;
> @@ -744,7 +744,7 @@ void __ref move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
>          * are reserved so nobody should be touching them so we should be safe
>          */
>         memmap_init_zone(nr_pages, nid, zone_idx(zone), start_pfn,
> -                       MEMMAP_HOTPLUG, altmap);
> +                        MEMMAP_HOTPLUG, pgmap);
>
>         set_zone_contiguous(zone);
>  }
> diff --git a/mm/memremap.c b/mm/memremap.c
> index f6c17339cd0d..9ee23374e6da 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -308,20 +308,13 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
>
>                 zone = &NODE_DATA(nid)->node_zones[ZONE_DEVICE];
>                 move_pfn_range_to_zone(zone, PHYS_PFN(res->start),
> -                               PHYS_PFN(resource_size(res)), restrictions.altmap);
> +                               PHYS_PFN(resource_size(res)), pgmap);
>         }
>
>         mem_hotplug_done();
>         if (error)
>                 goto err_add_memory;
>
> -       /*
> -        * Initialization of the pages has been deferred until now in order
> -        * to allow us to do the work while not holding the hotplug lock.
> -        */
> -       memmap_init_zone_device(&NODE_DATA(nid)->node_zones[ZONE_DEVICE],
> -                               PHYS_PFN(res->start),
> -                               PHYS_PFN(resource_size(res)), pgmap);
>         percpu_ref_get_many(pgmap->ref, pfn_end(pgmap) - pfn_first(pgmap));
>         return __va(res->start);
>

So if you are moving this all under the lock then this is going to
serialize initialization and it is going to be quite expensive on bit
systems. I was only ever able to get the init time down to something
like ~20s with the optimized function. Since that has been torn apart
and you are back to doing things with memmap_init_zone we are probably
looking at more like 25-30s for each node, and on a 4 node system we
are looking at 2 minutes or so which may lead to issues if people are
mounting this.

Instead of forcing this all to be done under the hotplug lock is there
some way we could do this under the zone span_seqlock instead to
achieve the same result?

> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c5d62f1c2851..44038665fe8e 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5845,7 +5845,7 @@ overlap_memmap_init(unsigned long zone, unsigned long *pfn)
>   */
>  void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>                 unsigned long start_pfn, enum memmap_context context,
> -               struct vmem_altmap *altmap)
> +               struct dev_pagemap *pgmap)
>  {
>         unsigned long pfn, end_pfn = start_pfn + size;
>         struct page *page;
> @@ -5853,24 +5853,6 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>         if (highest_memmap_pfn < end_pfn - 1)
>                 highest_memmap_pfn = end_pfn - 1;
>
> -#ifdef CONFIG_ZONE_DEVICE
> -       /*
> -        * Honor reservation requested by the driver for this ZONE_DEVICE
> -        * memory. We limit the total number of pages to initialize to just
> -        * those that might contain the memory mapping. We will defer the
> -        * ZONE_DEVICE page initialization until after we have released
> -        * the hotplug lock.
> -        */
> -       if (zone == ZONE_DEVICE) {
> -               if (!altmap)
> -                       return;
> -
> -               if (start_pfn == altmap->base_pfn)
> -                       start_pfn += altmap->reserve;
> -               end_pfn = altmap->base_pfn + vmem_altmap_offset(altmap);
> -       }
> -#endif
> -
>         for (pfn = start_pfn; pfn < end_pfn; pfn++) {
>                 /*
>                  * There can be holes in boot-time mem_map[]s handed to this
> @@ -5892,6 +5874,20 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>                 if (context == MEMMAP_HOTPLUG)
>                         __SetPageReserved(page);
>
> +#ifdef CONFIG_ZONE_DEVICE
> +               if (zone == ZONE_DEVICE) {
> +                       WARN_ON_ONCE(!pgmap);
> +                       /*
> +                        * ZONE_DEVICE pages union ->lru with a ->pgmap back
> +                        * pointer and zone_device_data. It is a bug if a
> +                        * ZONE_DEVICE page is ever freed or placed on a driver
> +                        * private list.
> +                        */
> +                       page->pgmap = pgmap;
> +                       page->zone_device_data = NULL;
> +               }
> +#endif
> +

So I am not sure this is right. Part of the reason for the split is
that the pages that were a part of the altmap had an LRU setup, not
the pgmap/zone_device_data setup. This is changing that.

Also, I am more a fan of just testing pgmap and if it is present then
assign page->pgmap and reset zone_device_data. Then you can avoid the
test for zone on every iteration and the WARN_ON_ONCE check, or at
least you could move it outside the loop so we don't incur the cost
with each page. Are there situations where you would have pgmap but
not a ZONE_DEVICE page?

>                 /*
>                  * Mark the block movable so that blocks are reserved for
>                  * movable at startup. This will force kernel allocations
> @@ -5951,14 +5947,6 @@ void __ref memmap_init_zone_device(struct zone *zone,
>                  */
>                 __SetPageReserved(page);
>
> -               /*
> -                * ZONE_DEVICE pages union ->lru with a ->pgmap back pointer
> -                * and zone_device_data.  It is a bug if a ZONE_DEVICE page is
> -                * ever freed or placed on a driver-private list.
> -                */
> -               page->pgmap = pgmap;
> -               page->zone_device_data = NULL;
> -
>                 /*
>                  * Mark the block movable so that blocks are reserved for
>                  * movable at startup. This will force kernel allocations

Shouldn't you be removing this function instead of just gutting it?
I'm kind of surprised you aren't getting warnings about unused code
since you also pulled the declaration for it from the header.
