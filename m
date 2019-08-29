Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16C5BA1233
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 09:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfH2HAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 03:00:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48144 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfH2HAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 03:00:49 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5C35388319;
        Thu, 29 Aug 2019 07:00:49 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-166.ams2.redhat.com [10.36.117.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 810801001B05;
        Thu, 29 Aug 2019 07:00:47 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH v3 04/11] mm/memory_hotplug: Drop local variables in shrink_zone_span()
Date:   Thu, 29 Aug 2019 09:00:12 +0200
Message-Id: <20190829070019.12714-5-david@redhat.com>
In-Reply-To: <20190829070019.12714-1-david@redhat.com>
References: <20190829070019.12714-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 29 Aug 2019 07:00:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Especially, when checking for "all holes" we can avoid rechecking already
processed pieces (that we are removing) - use the updated zone data
instead (possibly already zero).

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: David Hildenbrand <david@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 0a21f6f99753..d3c34bbeb36d 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -374,14 +374,11 @@ static unsigned long find_biggest_section_pfn(int nid, struct zone *zone,
 static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
 			     unsigned long end_pfn)
 {
-	unsigned long zone_start_pfn = zone->zone_start_pfn;
-	unsigned long z = zone_end_pfn(zone); /* zone_end_pfn namespace clash */
-	unsigned long zone_end_pfn = z;
 	unsigned long pfn;
 	int nid = zone_to_nid(zone);
 
 	zone_span_writelock(zone);
-	if (zone_start_pfn == start_pfn) {
+	if (zone->zone_start_pfn == start_pfn) {
 		/*
 		 * If the section is smallest section in the zone, it need
 		 * shrink zone->zone_start_pfn and zone->zone_spanned_pages.
@@ -389,22 +386,29 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
 		 * for shrinking zone.
 		 */
 		pfn = find_smallest_section_pfn(nid, zone, end_pfn,
-						zone_end_pfn);
+						zone_end_pfn(zone));
 		if (pfn) {
+			zone->spanned_pages = zone_end_pfn(zone) - pfn;
 			zone->zone_start_pfn = pfn;
-			zone->spanned_pages = zone_end_pfn - pfn;
+		} else {
+			zone->zone_start_pfn = 0;
+			zone->spanned_pages = 0;
 		}
-	} else if (zone_end_pfn == end_pfn) {
+	} else if (zone_end_pfn(zone) == end_pfn) {
 		/*
 		 * If the section is biggest section in the zone, it need
 		 * shrink zone->spanned_pages.
 		 * In this case, we find second biggest valid mem_section for
 		 * shrinking zone.
 		 */
-		pfn = find_biggest_section_pfn(nid, zone, zone_start_pfn,
+		pfn = find_biggest_section_pfn(nid, zone, zone->zone_start_pfn,
 					       start_pfn);
 		if (pfn)
-			zone->spanned_pages = pfn - zone_start_pfn + 1;
+			zone->spanned_pages = pfn - zone->zone_start_pfn + 1;
+		else {
+			zone->zone_start_pfn = 0;
+			zone->spanned_pages = 0;
+		}
 	}
 
 	/*
@@ -413,8 +417,8 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
 	 * change the zone. But perhaps, the zone has only hole data. Thus
 	 * it check the zone has only hole or not.
 	 */
-	pfn = zone_start_pfn;
-	for (; pfn < zone_end_pfn; pfn += PAGES_PER_SUBSECTION) {
+	for (pfn = zone->zone_start_pfn;
+	     pfn < zone_end_pfn(zone); pfn += PAGES_PER_SUBSECTION) {
 		if (unlikely(!pfn_valid(pfn)))
 			continue;
 
-- 
2.21.0

