Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4E6D17715D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 09:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgCCIi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 03:38:29 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45214 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725879AbgCCIi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 03:38:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583224707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GjQ3059ixcduAKYIisq1sdw/ONPw46srdTH5A+0meRY=;
        b=MLgENILJWaHusk+EwrFam1QGN8aiXsQ7L8vAYCqrRBOfDzFk6Lp2qHgiIcNlHPnQfXtehN
        RiTs9f5O4/qcZ7cSNEhIKYyG9IMcW38/Jkl77wrRIoQDBaZSYu/BPYlwqTcj1f1dED8TtQ
        fARVh0rVPwm/ledns7pOI3o/SmbqySc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-W8fQa0E5Nw--9tO7xoev2w-1; Tue, 03 Mar 2020 03:38:26 -0500
X-MC-Unique: W8fQa0E5Nw--9tO7xoev2w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C692318B5FA1;
        Tue,  3 Mar 2020 08:38:24 +0000 (UTC)
Received: from localhost (ovpn-12-29.pek2.redhat.com [10.72.12.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B32A60BF3;
        Tue,  3 Mar 2020 08:38:21 +0000 (UTC)
Date:   Tue, 3 Mar 2020 16:38:18 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, richardw.yang@linux.intel.com,
        osalvador@suse.de, dan.j.williams@intel.com, mhocko@suse.com,
        rppt@linux.ibm.com, robin.murphy@arm.com
Subject: Re: [PATCH v2 3/7] mm/sparse.c: introduce a new function
 clear_subsection_map()
Message-ID: <20200303083818.GB4433@MiWiFi-R3L-srv>
References: <20200220043316.19668-1-bhe@redhat.com>
 <20200220043316.19668-4-bhe@redhat.com>
 <dc5ab1b1-65e2-e20f-66aa-b71d739a5b6d@redhat.com>
 <20200301052028.GN24216@MiWiFi-R3L-srv>
 <1346f0c2-7b1f-6feb-5e9b-2854fd0022ba@redhat.com>
 <20200303082204.GA4433@MiWiFi-R3L-srv>
 <53bba557-149c-54b5-c8d7-27f7b6a55eb0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53bba557-149c-54b5-c8d7-27f7b6a55eb0@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/20 at 09:33am, David Hildenbrand wrote:
> On 03.03.20 09:22, Baoquan He wrote:
> > On 03/02/20 at 04:43pm, David Hildenbrand wrote:
> >> On 01.03.20 06:20, Baoquan He wrote:
> >>> On 02/28/20 at 03:36pm, David Hildenbrand wrote:
> >>>> On 20.02.20 05:33, Baoquan He wrote:
> >>>>> Wrap the codes which clear subsection map of one memory region from
> >>>>> section_deactivate() into clear_subsection_map().
> >>>>>
> >>>>> Signed-off-by: Baoquan He <bhe@redhat.com>
> >>>>> ---
> >>>>>  mm/sparse.c | 46 ++++++++++++++++++++++++++++++++++++++--------
> >>>>>  1 file changed, 38 insertions(+), 8 deletions(-)
> >>>>>
> >>>>> diff --git a/mm/sparse.c b/mm/sparse.c
> >>>>> index 977b47acd38d..df857ee9330c 100644
> >>>>> --- a/mm/sparse.c
> >>>>> +++ b/mm/sparse.c
> >>>>> @@ -726,14 +726,25 @@ static void free_map_bootmem(struct page *memmap)
> >>>>>  }
> >>>>>  #endif /* CONFIG_SPARSEMEM_VMEMMAP */
> >>>>>  
> >>>>> -static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> >>>>> -		struct vmem_altmap *altmap)
> >>>>> +/**
> >>>>> + * clear_subsection_map - Clear subsection map of one memory region
> >>>>> + *
> >>>>> + * @pfn - start pfn of the memory range
> >>>>> + * @nr_pages - number of pfns to add in the region
> >>>>> + *
> >>>>> + * This is only intended for hotplug, and clear the related subsection
> >>>>> + * map inside one section.
> >>>>> + *
> >>>>> + * Return:
> >>>>> + * * -EINVAL	- Section already deactived.
> >>>>> + * * 0		- Subsection map is emptied.
> >>>>> + * * 1		- Subsection map is not empty.
> >>>>> + */
> >>>>
> >>>> Less verbose please (in my preference: none and simplify return handling)
> >>>>
> >>>>> +static int clear_subsection_map(unsigned long pfn, unsigned long nr_pages)
> >>>>>  {
> >>>>>  	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
> >>>>>  	DECLARE_BITMAP(tmp, SUBSECTIONS_PER_SECTION) = { 0 };
> >>>>>  	struct mem_section *ms = __pfn_to_section(pfn);
> >>>>> -	bool section_is_early = early_section(ms);
> >>>>> -	struct page *memmap = NULL;
> >>>>>  	unsigned long *subsection_map = ms->usage
> >>>>>  		? &ms->usage->subsection_map[0] : NULL;
> >>>>>  
> >>>>> @@ -744,8 +755,28 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> >>>>>  	if (WARN(!subsection_map || !bitmap_equal(tmp, map, SUBSECTIONS_PER_SECTION),
> >>>>>  				"section already deactivated (%#lx + %ld)\n",
> >>>>>  				pfn, nr_pages))
> >>>>> -		return;
> >>>>> +		return -EINVAL;
> >>>>> +
> >>>>> +	bitmap_xor(subsection_map, map, subsection_map, SUBSECTIONS_PER_SECTION);
> >>>>>  
> >>>>> +	if (bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION))
> >>>>> +		return 0;
> >>>>> +
> >>>>
> >>>> Can we please just have a
> >>>>
> >>>> subsection_map_empty() instead and handle that in the caller?
> >>>> (you can then always return true in the !VMEMMAP variant)
> >>>
> >>> I don't follow. Could you be more specific? or pseudo code please?
> >>>
> >>> The old code has to handle below case in which subsection_map has been
> >>> cleared. And I introduce clear_subsection_map() to encapsulate all
> >>> subsection map realted code so that !VMEMMAP won't have to see it any
> >>> more.
> >>>
> >>
> >> Something like this on top would be easier to understand IMHO
> >>
> >>
> >> diff --git a/mm/sparse.c b/mm/sparse.c
> >> index dc79b00ddaaa..be5c80e9cfee 100644
> >> --- a/mm/sparse.c
> >> +++ b/mm/sparse.c
> >> @@ -726,20 +726,6 @@ static void free_map_bootmem(struct page *memmap)
> >>  }
> >>  #endif /* CONFIG_SPARSEMEM_VMEMMAP */
> >>  
> >> -/**
> >> - * clear_subsection_map - Clear subsection map of one memory region
> >> - *
> >> - * @pfn - start pfn of the memory range
> >> - * @nr_pages - number of pfns to add in the region
> >> - *
> >> - * This is only intended for hotplug, and clear the related subsection
> >> - * map inside one section.
> >> - *
> >> - * Return:
> >> - * * -EINVAL	- Section already deactived.
> >> - * * 0		- Subsection map is emptied.
> >> - * * 1		- Subsection map is not empty.
> >> - */
> >>  static int clear_subsection_map(unsigned long pfn, unsigned long nr_pages)
> >>  {
> >>  	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
> >> @@ -758,11 +744,12 @@ static int clear_subsection_map(unsigned long pfn, unsigned long nr_pages)
> >>  		return -EINVAL;
> >>  
> >>  	bitmap_xor(subsection_map, map, subsection_map, SUBSECTIONS_PER_SECTION);
> >> +	return 0;
> >> +}
> >>  
> >> -	if (bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION))
> >> -		return 0;
> >> -
> >> -	return 1;
> >> +static bool is_subsection_map_empty(unsigned long pfn, unsigned long nr_pages)
> >> +{
> >> +	return bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION);
> >>  }
> >>  
> >>  static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> >> @@ -771,11 +758,8 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> >>  	struct mem_section *ms = __pfn_to_section(pfn);
> >>  	bool section_is_early = early_section(ms);
> >>  	struct page *memmap = NULL;
> >> -	int rc;
> >> -
> >>  
> >> -	rc = clear_subsection_map(pfn, nr_pages);
> >> -	if (IS_ERR_VALUE((unsigned long)rc))
> >> +	if (unlikely(clear_subsection_map(pfn, nr_pages)))
> >>  		return;
> >>  	/*
> >>  	 * There are 3 cases to handle across two configurations
> >> @@ -794,7 +778,7 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> >>  	 *
> >>  	 * For 2/ and 3/ the SPARSEMEM_VMEMMAP={y,n} cases are unified
> >>  	 */
> >> -	if (!rc) {
> >> +	if (is_subsection_map_empty(pfn, nr_pages)) {
> >>  		unsigned long section_nr = pfn_to_section_nr(pfn);
> > 
> > Tried this way, it's not good in this patch. Since ms->usage might be
> > freed in this place.
> > 
> >                 if (!PageReserved(virt_to_page(ms->usage))) {
> >                         kfree(ms->usage);
> >                         ms->usage = NULL;
> >                 }
> 
> So your patch #1 is already broken. Just cache the result in patch #1.
> 
> bool empty;

Right, good catch. Will take this way. Thanks.

> 
> ...
> empty = bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION);
> ...
> if (empty) {
> 	...
> }

