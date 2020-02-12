Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07E8515A7D4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 12:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgBLL1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 06:27:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23386 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726351AbgBLL1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 06:27:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581506818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sOBpuSxMPuJUbkuLPHqFKoJm4N6xAPNq3p7qQaPewdE=;
        b=OMbat9aQ4/P8y8ZUjk8B/H8130y1qCewJXuCQ5eYiAhiTuwwZHxo2IJG7uw5QHSYznPJ2s
        Wnj2T41/XrnmapVwhmC/e9zAHjTqvkllqA8TljYW2x90OJ2NMpxmoKWbhgXJwNRtl1Xj88
        AAqA+9ItwCv8fwb0sB31xa0LYIMvkI0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-xuJ5a9kFN6SbgiyplfDCAQ-1; Wed, 12 Feb 2020 06:26:55 -0500
X-MC-Unique: xuJ5a9kFN6SbgiyplfDCAQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10F768017CC;
        Wed, 12 Feb 2020 11:26:54 +0000 (UTC)
Received: from localhost (ovpn-12-47.pek2.redhat.com [10.72.12.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A5F39006B;
        Wed, 12 Feb 2020 11:26:49 +0000 (UTC)
Date:   Wed, 12 Feb 2020 19:26:41 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, dan.j.williams@intel.com,
        richardw.yang@linux.intel.com
Subject: Re: [PATCH 3/7] mm/sparse.c: only use subsection map in VMEMMAP case
Message-ID: <20200212112641.GJ26758@MiWiFi-R3L-srv>
References: <20200209104826.3385-1-bhe@redhat.com>
 <20200209104826.3385-4-bhe@redhat.com>
 <be1625c4-6875-cfba-9894-f9c148cfe4e7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be1625c4-6875-cfba-9894-f9c148cfe4e7@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/20 at 03:43pm, David Hildenbrand wrote:
> On 09.02.20 11:48, Baoquan He wrote:
> > Currently, subsection map is used when SPARSEMEM is enabled, including
> > VMEMMAP case and !VMEMMAP case. However, subsection hotplug is not
> > supported at all in SPARSEMEM|!VMEMMAP case, subsection map is unnecessary
> > and misleading. Let's adjust code to only allow subsection map being
> > used in SPARSEMEM|VMEMMAP case.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  include/linux/mmzone.h |   2 +
> >  mm/sparse.c            | 231 ++++++++++++++++++++++-------------------
> >  2 files changed, 124 insertions(+), 109 deletions(-)
> > 
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index 462f6873905a..fc0de3a9a51e 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -1185,7 +1185,9 @@ static inline unsigned long section_nr_to_pfn(unsigned long sec)
> >  #define SUBSECTION_ALIGN_DOWN(pfn) ((pfn) & PAGE_SUBSECTION_MASK)
> >  
> >  struct mem_section_usage {
> > +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> >  	DECLARE_BITMAP(subsection_map, SUBSECTIONS_PER_SECTION);
> > +#endif
> >  	/* See declaration of similar field in struct zone */
> >  	unsigned long pageblock_flags[0];
> >  };
> > diff --git a/mm/sparse.c b/mm/sparse.c
> > index 696f6b9f706e..cf55d272d0a9 100644
> > --- a/mm/sparse.c
> > +++ b/mm/sparse.c
> > @@ -209,41 +209,6 @@ static inline unsigned long first_present_section_nr(void)
> >  	return next_present_section_nr(-1);
> >  }
> >  
> > -static void subsection_mask_set(unsigned long *map, unsigned long pfn,
> > -		unsigned long nr_pages)
> > -{
> > -	int idx = subsection_map_index(pfn);
> > -	int end = subsection_map_index(pfn + nr_pages - 1);
> > -
> > -	bitmap_set(map, idx, end - idx + 1);
> > -}
> > -
> > -void __init subsection_map_init(unsigned long pfn, unsigned long nr_pages)
> > -{
> > -	int end_sec = pfn_to_section_nr(pfn + nr_pages - 1);
> > -	unsigned long nr, start_sec = pfn_to_section_nr(pfn);
> > -
> > -	if (!nr_pages)
> > -		return;
> > -
> > -	for (nr = start_sec; nr <= end_sec; nr++) {
> > -		struct mem_section *ms;
> > -		unsigned long pfns;
> > -
> > -		pfns = min(nr_pages, PAGES_PER_SECTION
> > -				- (pfn & ~PAGE_SECTION_MASK));
> > -		ms = __nr_to_section(nr);
> > -		subsection_mask_set(ms->usage->subsection_map, pfn, pfns);
> > -
> > -		pr_debug("%s: sec: %lu pfns: %lu set(%d, %d)\n", __func__, nr,
> > -				pfns, subsection_map_index(pfn),
> > -				subsection_map_index(pfn + pfns - 1));
> > -
> > -		pfn += pfns;
> > -		nr_pages -= pfns;
> > -	}
> > -}
> > -
> >  /* Record a memory area against a node. */
> >  void __init memory_present(int nid, unsigned long start, unsigned long end)
> >  {
> > @@ -432,12 +397,134 @@ static unsigned long __init section_map_size(void)
> >  	return ALIGN(sizeof(struct page) * PAGES_PER_SECTION, PMD_SIZE);
> >  }
> >  
> > +static void subsection_mask_set(unsigned long *map, unsigned long pfn,
> > +		unsigned long nr_pages)
> > +{
> > +	int idx = subsection_map_index(pfn);
> > +	int end = subsection_map_index(pfn + nr_pages - 1);
> > +
> > +	bitmap_set(map, idx, end - idx + 1);
> > +}
> > +
> > +void __init subsection_map_init(unsigned long pfn, unsigned long nr_pages)
> > +{
> > +	int end_sec = pfn_to_section_nr(pfn + nr_pages - 1);
> > +	unsigned long nr, start_sec = pfn_to_section_nr(pfn);
> > +
> > +	if (!nr_pages)
> > +		return;
> > +
> > +	for (nr = start_sec; nr <= end_sec; nr++) {
> > +		struct mem_section *ms;
> > +		unsigned long pfns;
> > +
> > +		pfns = min(nr_pages, PAGES_PER_SECTION
> > +				- (pfn & ~PAGE_SECTION_MASK));
> > +		ms = __nr_to_section(nr);
> > +		subsection_mask_set(ms->usage->subsection_map, pfn, pfns);
> > +
> > +		pr_debug("%s: sec: %lu pfns: %lu set(%d, %d)\n", __func__, nr,
> > +				pfns, subsection_map_index(pfn),
> > +				subsection_map_index(pfn + pfns - 1));
> > +
> > +		pfn += pfns;
> > +		nr_pages -= pfns;
> > +	}
> > +}
> > +
> > +/**
> > + * clear_subsection_map - Clear subsection map of one memory region
> > + *
> > + * @pfn - start pfn of the memory range
> > + * @nr_pages - number of pfns to add in the region
> > + *
> > + * This is only intended for hotplug, and clear the related subsection
> > + * map inside one section.
> > + *
> > + * Return:
> > + * * -EINVAL	- Section already deactived.
> > + * * 0		- Subsection map is emptied.
> > + * * 1		- Subsection map is not empty.
> > + */
> > +static int clear_subsection_map(unsigned long pfn, unsigned long nr_pages)
> > +{
> > +	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
> > +	DECLARE_BITMAP(tmp, SUBSECTIONS_PER_SECTION) = { 0 };
> > +	struct mem_section *ms = __pfn_to_section(pfn);
> > +	unsigned long *subsection_map = ms->usage
> > +		? &ms->usage->subsection_map[0] : NULL;
> > +
> > +	subsection_mask_set(map, pfn, nr_pages);
> > +	if (subsection_map)
> > +		bitmap_and(tmp, map, subsection_map, SUBSECTIONS_PER_SECTION);
> > +
> > +	if (WARN(!subsection_map || !bitmap_equal(tmp, map, SUBSECTIONS_PER_SECTION),
> > +				"section already deactivated (%#lx + %ld)\n",
> > +				pfn, nr_pages))
> > +		return -EINVAL;
> > +
> > +	bitmap_xor(subsection_map, map, subsection_map, SUBSECTIONS_PER_SECTION);
> > +
> > +	if (bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION))
> > +		return 0;
> > +
> > +	return 1;
> > +}
> > +
> > +/**
> > + * fill_subsection_map - fill subsection map of a memory region
> > + * @pfn - start pfn of the memory range
> > + * @nr_pages - number of pfns to add in the region
> > + *
> > + * This clears the related subsection map inside one section, and only
> > + * intended for hotplug.
> > + *
> > + * Return:
> > + * * 0		- On success.
> > + * * -EINVAL	- Invalid memory region.
> > + * * -EEXIST	- Subsection map has been set.
> > + */
> > +static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
> > +{
> > +	struct mem_section *ms = __pfn_to_section(pfn);
> > +	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
> > +	unsigned long *subsection_map;
> > +	int rc = 0;
> > +
> > +	subsection_mask_set(map, pfn, nr_pages);
> > +
> > +	subsection_map = &ms->usage->subsection_map[0];
> > +
> > +	if (bitmap_empty(map, SUBSECTIONS_PER_SECTION))
> > +		rc = -EINVAL;
> > +	else if (bitmap_intersects(map, subsection_map, SUBSECTIONS_PER_SECTION))
> > +		rc = -EEXIST;
> > +	else
> > +		bitmap_or(subsection_map, map, subsection_map,
> > +				SUBSECTIONS_PER_SECTION);
> > +
> > +	return rc;
> > +}
> > +
> >  #else
> >  static unsigned long __init section_map_size(void)
> >  {
> >  	return PAGE_ALIGN(sizeof(struct page) * PAGES_PER_SECTION);
> >  }
> >  
> > +void __init subsection_map_init(unsigned long pfn, unsigned long nr_pages)
> > +{
> > +}
> > +
> > +static int clear_subsection_map(unsigned long pfn, unsigned long nr_pages)
> > +{
> > +	return 0;
> > +}
> > +static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
> > +{
> > +	return 0;
> > +}
> > +
> >  struct page __init *__populate_section_memmap(unsigned long pfn,
> >  		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
> >  {
> > @@ -726,45 +813,6 @@ static void free_map_bootmem(struct page *memmap)
> >  }
> >  #endif /* CONFIG_SPARSEMEM_VMEMMAP */
> >  
> > -/**
> > - * clear_subsection_map - Clear subsection map of one memory region
> > - *
> > - * @pfn - start pfn of the memory range
> > - * @nr_pages - number of pfns to add in the region
> > - *
> > - * This is only intended for hotplug, and clear the related subsection
> > - * map inside one section.
> > - *
> > - * Return:
> > - * * -EINVAL	- Section already deactived.
> > - * * 0		- Subsection map is emptied.
> > - * * 1		- Subsection map is not empty.
> > - */
> > -static int clear_subsection_map(unsigned long pfn, unsigned long nr_pages)
> > -{
> > -	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
> > -	DECLARE_BITMAP(tmp, SUBSECTIONS_PER_SECTION) = { 0 };
> > -	struct mem_section *ms = __pfn_to_section(pfn);
> > -	unsigned long *subsection_map = ms->usage
> > -		? &ms->usage->subsection_map[0] : NULL;
> > -
> > -	subsection_mask_set(map, pfn, nr_pages);
> > -	if (subsection_map)
> > -		bitmap_and(tmp, map, subsection_map, SUBSECTIONS_PER_SECTION);
> > -
> > -	if (WARN(!subsection_map || !bitmap_equal(tmp, map, SUBSECTIONS_PER_SECTION),
> > -				"section already deactivated (%#lx + %ld)\n",
> > -				pfn, nr_pages))
> > -		return -EINVAL;
> > -
> > -	bitmap_xor(subsection_map, map, subsection_map, SUBSECTIONS_PER_SECTION);
> > -
> > -	if (bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION))
> > -		return 0;
> > -
> > -	return 1;
> > -}
> > -
> >  static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> >  		struct vmem_altmap *altmap)
> >  {
> > @@ -818,41 +866,6 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> >  		depopulate_section_memmap(pfn, nr_pages, altmap);
> >  }
> >  
> > -/**
> > - * fill_subsection_map - fill subsection map of a memory region
> > - * @pfn - start pfn of the memory range
> > - * @nr_pages - number of pfns to add in the region
> > - *
> > - * This clears the related subsection map inside one section, and only
> > - * intended for hotplug.
> > - *
> > - * Return:
> > - * * 0		- On success.
> > - * * -EINVAL	- Invalid memory region.
> > - * * -EEXIST	- Subsection map has been set.
> > - */
> > -static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
> > -{
> > -	struct mem_section *ms = __pfn_to_section(pfn);
> > -	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
> > -	unsigned long *subsection_map;
> > -	int rc = 0;
> > -
> > -	subsection_mask_set(map, pfn, nr_pages);
> > -
> > -	subsection_map = &ms->usage->subsection_map[0];
> > -
> > -	if (bitmap_empty(map, SUBSECTIONS_PER_SECTION))
> > -		rc = -EINVAL;
> > -	else if (bitmap_intersects(map, subsection_map, SUBSECTIONS_PER_SECTION))
> > -		rc = -EEXIST;
> > -	else
> > -		bitmap_or(subsection_map, map, subsection_map,
> > -				SUBSECTIONS_PER_SECTION);
> > -
> > -	return rc;
> > -}
> > -
> >  static struct page * __meminit section_activate(int nid, unsigned long pfn,
> >  		unsigned long nr_pages, struct vmem_altmap *altmap)
> >  {
> > 
> 
> I'd prefer adding more ifdefs to avoid heavy code movement. Would make
> it much easier to review :)

OK, I did it in the first place. Later I think putting all subsectin
related handling into one place makes code look better. Now I understand
it may make patch format messy. I will adjust the place to make
reviewing easier. Thanks for your great suggestion.

