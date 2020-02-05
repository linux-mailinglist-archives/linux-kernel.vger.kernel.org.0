Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCD01528D4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 11:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgBEKHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 05:07:10 -0500
Received: from mga06.intel.com ([134.134.136.31]:30679 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727068AbgBEKHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 05:07:10 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 02:07:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,405,1574150400"; 
   d="scan'208";a="279328278"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Feb 2020 02:07:06 -0800
Date:   Wed, 5 Feb 2020 18:07:23 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH v6 09/10] mm/memory_hotplug: Drop local variables in
 shrink_zone_span()
Message-ID: <20200205100723.GD24162@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20191006085646.5768-1-david@redhat.com>
 <20191006085646.5768-10-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191006085646.5768-10-david@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 06, 2019 at 10:56:45AM +0200, David Hildenbrand wrote:
>Get rid of the unnecessary local variables.
>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: Oscar Salvador <osalvador@suse.de>
>Cc: David Hildenbrand <david@redhat.com>
>Cc: Michal Hocko <mhocko@suse.com>
>Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
>Cc: Dan Williams <dan.j.williams@intel.com>
>Cc: Wei Yang <richardw.yang@linux.intel.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>

Looks reasonable.

Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>

>---
> mm/memory_hotplug.c | 15 ++++++---------
> 1 file changed, 6 insertions(+), 9 deletions(-)
>
>diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>index 8dafa1ba8d9f..843481bd507d 100644
>--- a/mm/memory_hotplug.c
>+++ b/mm/memory_hotplug.c
>@@ -374,14 +374,11 @@ static unsigned long find_biggest_section_pfn(int nid, struct zone *zone,
> static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
> 			     unsigned long end_pfn)
> {
>-	unsigned long zone_start_pfn = zone->zone_start_pfn;
>-	unsigned long z = zone_end_pfn(zone); /* zone_end_pfn namespace clash */
>-	unsigned long zone_end_pfn = z;
> 	unsigned long pfn;
> 	int nid = zone_to_nid(zone);
> 
> 	zone_span_writelock(zone);
>-	if (zone_start_pfn == start_pfn) {
>+	if (zone->zone_start_pfn == start_pfn) {
> 		/*
> 		 * If the section is smallest section in the zone, it need
> 		 * shrink zone->zone_start_pfn and zone->zone_spanned_pages.
>@@ -389,25 +386,25 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
> 		 * for shrinking zone.
> 		 */
> 		pfn = find_smallest_section_pfn(nid, zone, end_pfn,
>-						zone_end_pfn);
>+						zone_end_pfn(zone));
> 		if (pfn) {
>+			zone->spanned_pages = zone_end_pfn(zone) - pfn;
> 			zone->zone_start_pfn = pfn;
>-			zone->spanned_pages = zone_end_pfn - pfn;
> 		} else {
> 			zone->zone_start_pfn = 0;
> 			zone->spanned_pages = 0;
> 		}
>-	} else if (zone_end_pfn == end_pfn) {
>+	} else if (zone_end_pfn(zone) == end_pfn) {
> 		/*
> 		 * If the section is biggest section in the zone, it need
> 		 * shrink zone->spanned_pages.
> 		 * In this case, we find second biggest valid mem_section for
> 		 * shrinking zone.
> 		 */
>-		pfn = find_biggest_section_pfn(nid, zone, zone_start_pfn,
>+		pfn = find_biggest_section_pfn(nid, zone, zone->zone_start_pfn,
> 					       start_pfn);
> 		if (pfn)
>-			zone->spanned_pages = pfn - zone_start_pfn + 1;
>+			zone->spanned_pages = pfn - zone->zone_start_pfn + 1;
> 		else {
> 			zone->zone_start_pfn = 0;
> 			zone->spanned_pages = 0;
>-- 
>2.21.0

-- 
Wei Yang
Help you, Help me
