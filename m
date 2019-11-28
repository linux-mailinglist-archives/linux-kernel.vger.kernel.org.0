Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 904F910C9E1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 14:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfK1Nwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 08:52:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:54850 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726496AbfK1Nwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 08:52:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E6A75AF22;
        Thu, 28 Nov 2019 13:52:39 +0000 (UTC)
Date:   Thu, 28 Nov 2019 14:52:36 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v1] mm/memory_hotplug: don't check the nid in
 find_(smallest|biggest)_section_pfn
Message-ID: <20191128135231.GA10554@linux>
References: <20191127174158.28226-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127174158.28226-1-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 06:41:58PM +0100, David Hildenbrand wrote:
> Now that we always check against a zone, we can stop checking against
> the nid, it is implicitly covered by the zone.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Maybe the check was in place to play against the "assumption" that a zone can
span multiple nodes.
Hotplug code was full of those hardcoded assumtions (like working with holes and whatnot).

Anyway, this looks the right thing to do, and thanks for the previous
fixes/cleanups.

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/memory_hotplug.c | 23 ++++++++---------------
>  1 file changed, 8 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 46b2e056a43f..602f753c662c 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -344,17 +344,14 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
>  }
>  
>  /* find the smallest valid pfn in the range [start_pfn, end_pfn) */
> -static unsigned long find_smallest_section_pfn(int nid, struct zone *zone,
> -				     unsigned long start_pfn,
> -				     unsigned long end_pfn)
> +static unsigned long find_smallest_section_pfn(struct zone *zone,
> +					       unsigned long start_pfn,
> +					       unsigned long end_pfn)
>  {
>  	for (; start_pfn < end_pfn; start_pfn += PAGES_PER_SUBSECTION) {
>  		if (unlikely(!pfn_to_online_page(start_pfn)))
>  			continue;
>  
> -		if (unlikely(pfn_to_nid(start_pfn) != nid))
> -			continue;
> -
>  		if (zone != page_zone(pfn_to_page(start_pfn)))
>  			continue;
>  
> @@ -365,9 +362,9 @@ static unsigned long find_smallest_section_pfn(int nid, struct zone *zone,
>  }
>  
>  /* find the biggest valid pfn in the range [start_pfn, end_pfn). */
> -static unsigned long find_biggest_section_pfn(int nid, struct zone *zone,
> -				    unsigned long start_pfn,
> -				    unsigned long end_pfn)
> +static unsigned long find_biggest_section_pfn(struct zone *zone,
> +					      unsigned long start_pfn,
> +					      unsigned long end_pfn)
>  {
>  	unsigned long pfn;
>  
> @@ -377,9 +374,6 @@ static unsigned long find_biggest_section_pfn(int nid, struct zone *zone,
>  		if (unlikely(!pfn_to_online_page(pfn)))
>  			continue;
>  
> -		if (unlikely(pfn_to_nid(pfn) != nid))
> -			continue;
> -
>  		if (zone != page_zone(pfn_to_page(pfn)))
>  			continue;
>  
> @@ -393,7 +387,6 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
>  			     unsigned long end_pfn)
>  {
>  	unsigned long pfn;
> -	int nid = zone_to_nid(zone);
>  
>  	zone_span_writelock(zone);
>  	if (zone->zone_start_pfn == start_pfn) {
> @@ -403,7 +396,7 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
>  		 * In this case, we find second smallest valid mem_section
>  		 * for shrinking zone.
>  		 */
> -		pfn = find_smallest_section_pfn(nid, zone, end_pfn,
> +		pfn = find_smallest_section_pfn(zone, end_pfn,
>  						zone_end_pfn(zone));
>  		if (pfn) {
>  			zone->spanned_pages = zone_end_pfn(zone) - pfn;
> @@ -419,7 +412,7 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
>  		 * In this case, we find second biggest valid mem_section for
>  		 * shrinking zone.
>  		 */
> -		pfn = find_biggest_section_pfn(nid, zone, zone->zone_start_pfn,
> +		pfn = find_biggest_section_pfn(zone, zone->zone_start_pfn,
>  					       start_pfn);
>  		if (pfn)
>  			zone->spanned_pages = pfn - zone->zone_start_pfn + 1;
> -- 
> 2.21.0
> 

-- 
Oscar Salvador
SUSE L3
