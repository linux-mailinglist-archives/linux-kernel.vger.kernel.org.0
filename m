Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D94A98DD06
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 20:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbfHNSci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 14:32:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:50678 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726522AbfHNSci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:32:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 512CEAF5B;
        Wed, 14 Aug 2019 18:32:37 +0000 (UTC)
Date:   Wed, 14 Aug 2019 20:32:35 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Arun KS <arunks@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 4/5] mm/memory_hotplug: Make sure the pfn is aligned
 to the order when onlining
Message-ID: <20190814183235.GJ17933@dhcp22.suse.cz>
References: <20190814154109.3448-1-david@redhat.com>
 <20190814154109.3448-5-david@redhat.com>
 <b47ebf69-77eb-4a77-0fbc-631175aca979@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b47ebf69-77eb-4a77-0fbc-631175aca979@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14-08-19 18:09:16, David Hildenbrand wrote:
> On 14.08.19 17:41, David Hildenbrand wrote:
> > Commit a9cd410a3d29 ("mm/page_alloc.c: memory hotplug: free pages as higher
> > order") assumed that any PFN we get via memory resources is aligned to
> > to MAX_ORDER - 1, I am not convinced that is always true. Let's play safe,
> > check the alignment and fallback to single pages.
> > 
> > Cc: Arun KS <arunks@codeaurora.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Oscar Salvador <osalvador@suse.de>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
> >  mm/memory_hotplug.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index 63b1775f7cf8..f245fb50ba7f 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -646,6 +646,9 @@ static int online_pages_range(unsigned long start_pfn, unsigned long nr_pages,
> >  	 */
> >  	for (pfn = start_pfn; pfn < end_pfn; pfn += 1ul << order) {
> >  		order = min(MAX_ORDER - 1, get_order(PFN_PHYS(end_pfn - pfn)));
> > +		/* __free_pages_core() wants pfns to be aligned to the order */
> > +		if (unlikely(!IS_ALIGNED(pfn, 1ul << order)))
> > +			order = 0;
> >  		(*online_page_callback)(pfn_to_page(pfn), order);
> >  	}
> >  
> > 
> 
> @Michal, if you insist, we can drop this patch. "break first and fix
> later" is not part of my DNA :)

I do not insist but have already expressed that I am not a fan of this
change. Also I think that "break first" is quite an over statement here.

-- 
Michal Hocko
SUSE Labs
