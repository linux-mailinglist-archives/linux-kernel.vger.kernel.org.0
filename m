Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94A7A9CD11
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 12:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731293AbfHZKKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 06:10:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46888 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727376AbfHZKKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 06:10:38 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C66C73082B43;
        Mon, 26 Aug 2019 10:10:37 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-227.ams2.redhat.com [10.36.116.227])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 59E5D6060D;
        Mon, 26 Aug 2019 10:10:33 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH v2 3/6] mm/memory_hotplug: Process all zones when removing memory
Date:   Mon, 26 Aug 2019 12:10:09 +0200
Message-Id: <20190826101012.10575-4-david@redhat.com>
In-Reply-To: <20190826101012.10575-1-david@redhat.com>
References: <20190826101012.10575-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 26 Aug 2019 10:10:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is easier than I though to trigger a kernel bug by removing memory that
was never onlined. With CONFIG_DEBUG_VM the memmap is initialized with
garbage, resulting in the detection of a broken zone when removing memory.
Without CONFIG_DEBUG_VM it is less likely - but we could still have
garbage in the memmap.

:/# [   23.912993] BUG: unable to handle page fault for address: 000000000000353d
[   23.914219] #PF: supervisor write access in kernel mode
[   23.915199] #PF: error_code(0x0002) - not-present page
[   23.916160] PGD 0 P4D 0
[   23.916627] Oops: 0002 [#1] SMP PTI
[   23.917256] CPU: 1 PID: 7 Comm: kworker/u8:0 Not tainted 5.3.0-rc5-next-20190820+ #317
[   23.918900] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.4
[   23.921194] Workqueue: kacpi_hotplug acpi_hotplug_work_fn
[   23.922249] RIP: 0010:clear_zone_contiguous+0x5/0x10
[   23.923173] Code: 48 89 c6 48 89 c3 e8 2a fe ff ff 48 85 c0 75 cf 5b 5d c3 c6 85 fd 05 00 00 01 5b 5d c3 0f 1f 840
[   23.926876] RSP: 0018:ffffad2400043c98 EFLAGS: 00010246
[   23.927928] RAX: 0000000000000000 RBX: 0000000200000000 RCX: 0000000000000000
[   23.929458] RDX: 0000000000200000 RSI: 0000000000140000 RDI: 0000000000002f40
[   23.930899] RBP: 0000000140000000 R08: 0000000000000000 R09: 0000000000000001
[   23.932362] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000140000
[   23.933603] R13: 0000000000140000 R14: 0000000000002f40 R15: ffff9e3e7aff3680
[   23.934913] FS:  0000000000000000(0000) GS:ffff9e3e7bb00000(0000) knlGS:0000000000000000
[   23.936294] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   23.937481] CR2: 000000000000353d CR3: 0000000058610000 CR4: 00000000000006e0
[   23.938687] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   23.939889] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   23.941168] Call Trace:
[   23.941580]  __remove_pages+0x4b/0x640
[   23.942303]  ? mark_held_locks+0x49/0x70
[   23.943149]  arch_remove_memory+0x63/0x8d
[   23.943921]  try_remove_memory+0xdb/0x130
[   23.944766]  ? walk_memory_blocks+0x7f/0x9e
[   23.945616]  __remove_memory+0xa/0x11
[   23.946274]  acpi_memory_device_remove+0x70/0x100
[   23.947308]  acpi_bus_trim+0x55/0x90
[   23.947914]  acpi_device_hotplug+0x227/0x3a0
[   23.948714]  acpi_hotplug_work_fn+0x1a/0x30
[   23.949433]  process_one_work+0x221/0x550
[   23.950190]  worker_thread+0x50/0x3b0
[   23.950993]  kthread+0x105/0x140
[   23.951644]  ? process_one_work+0x550/0x550
[   23.952508]  ? kthread_park+0x80/0x80
[   23.953367]  ret_from_fork+0x3a/0x50
[   23.954025] Modules linked in:
[   23.954613] CR2: 000000000000353d
[   23.955248] ---[ end trace 93d982b1fb3e1a69 ]---

But the problem is more extreme: When removing memory we could have
- Single memory blocks that fall into no zone (never onlined)
- Single memory blocks that fall into multiple zones (offlined+re-onlined)
- Multiple memory blocks that fall into different zones
Right now, the zones don't get updated properly in these cases.

So let's simply process all zones for now until we can properly handle
this via the reverse of move_pfn_range_to_zone() (which would then be
called something like remove_pfn_range_from_zone()), for example, when
offlining memory or before removing ZONE_DEVICE memory.

To speed things up, only mark applicable zones non-contiguous (and
therefore reduce the zones to recompute) and skip non-intersecting zones
when trying to resize. shrink_zone_span() and shrink_pgdat_span() seem
to be able to cope just fine with pfn ranges they don't actually
contain (but still intersect with).

Don't check for zone_intersects() when triggering set_zone_contiguous()
- we might have resized the zone and the check might no longer hold. For
now, we have to try to recompute any zone (which will be skipped in case
the zone is already contiguous).

Note1: Detecting which memory is still part of a zone is not easy before
removing memory as the detection relies almost completely on pfn_valid()
right now. pfn_online() cannot be used as ZONE_DEVICE memory is never
online. pfn_present() cannot be used as all memory is present once it was
added (but not onlined). We need to rethink/refactor this properly.

Note2: We are safe to call zone_intersects() without locking (as already
done by onlining code in default_zone_for_pfn()), as we are protected by
the memory hotplug lock - just like zone->contiguous.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 71779b7b14df..27f0457b7512 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -505,22 +505,28 @@ static void __remove_zone(struct zone *zone, unsigned long start_pfn,
 	struct pglist_data *pgdat = zone->zone_pgdat;
 	unsigned long flags;
 
+	if (!zone_intersects(zone, start_pfn, nr_pages))
+		return;
+
 	pgdat_resize_lock(zone->zone_pgdat, &flags);
 	shrink_zone_span(zone, start_pfn, start_pfn + nr_pages);
 	shrink_pgdat_span(pgdat, start_pfn, start_pfn + nr_pages);
 	pgdat_resize_unlock(zone->zone_pgdat, &flags);
 }
 
-static void __remove_section(struct zone *zone, unsigned long pfn,
-		unsigned long nr_pages, unsigned long map_offset,
-		struct vmem_altmap *altmap)
+static void __remove_section(unsigned long pfn, unsigned long nr_pages,
+			     unsigned long map_offset,
+			     struct vmem_altmap *altmap)
 {
 	struct mem_section *ms = __nr_to_section(pfn_to_section_nr(pfn));
+	struct zone *zone;
 
 	if (WARN_ON_ONCE(!valid_section(ms)))
 		return;
 
-	__remove_zone(zone, pfn, nr_pages);
+	/* TODO: move zone handling out of memory removal path */
+	for_each_zone(zone)
+		__remove_zone(zone, pfn, nr_pages);
 	sparse_remove_section(ms, pfn, nr_pages, map_offset, altmap);
 }
 
@@ -547,7 +553,10 @@ void __remove_pages(struct zone *zone, unsigned long pfn,
 
 	map_offset = vmem_altmap_offset(altmap);
 
-	clear_zone_contiguous(zone);
+	/* TODO: move zone handling out of memory removal path */
+	for_each_zone(zone)
+		if (zone_intersects(zone, pfn, nr_pages))
+			clear_zone_contiguous(zone);
 
 	start_sec = pfn_to_section_nr(pfn);
 	end_sec = pfn_to_section_nr(pfn + nr_pages - 1);
@@ -557,13 +566,15 @@ void __remove_pages(struct zone *zone, unsigned long pfn,
 		cond_resched();
 		pfns = min(nr_pages, PAGES_PER_SECTION
 				- (pfn & ~PAGE_SECTION_MASK));
-		__remove_section(zone, pfn, pfns, map_offset, altmap);
+		__remove_section(pfn, pfns, map_offset, altmap);
 		pfn += pfns;
 		nr_pages -= pfns;
 		map_offset = 0;
 	}
 
-	set_zone_contiguous(zone);
+	/* TODO: move zone handling out of memory removal path */
+	for_each_zone(zone)
+		set_zone_contiguous(zone);
 }
 
 int set_online_page_callback(online_page_callback_t callback)
-- 
2.21.0

