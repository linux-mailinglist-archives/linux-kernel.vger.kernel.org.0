Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF2817CCF3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Mar 2020 09:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgCGImq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Mar 2020 03:42:46 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57663 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726193AbgCGImp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 03:42:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583570564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=UraJ83HV2pn1X1NXn9FVFonewL2jW9cZzbayED9iRfE=;
        b=OTdyJeZxd2W3qGlS0iDvlJWyvyEGREpDoWgq503bd1bnW9ekcAJje/sm03rcMqNPtnefxn
        3p7C5bNoQErTx6KqFSM/JO/dIxvfK/L79INxWDMMT/gVoWZVw16auIK2fVPrw9gH3Rrjc7
        lwytW+E/x5O2V75a94vRpXDWIJ/6Tk8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-lQgXJX1vNaCwwzLzbAGmqw-1; Sat, 07 Mar 2020 03:42:42 -0500
X-MC-Unique: lQgXJX1vNaCwwzLzbAGmqw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D88B13EA;
        Sat,  7 Mar 2020 08:42:41 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-29.pek2.redhat.com [10.72.12.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 143B95D9CA;
        Sat,  7 Mar 2020 08:42:37 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@suse.com,
        david@redhat.com, richardw.yang@linux.intel.com,
        dan.j.williams@intel.com, osalvador@suse.de, rppt@linux.ibm.com,
        bhe@redhat.com
Subject: [PATCH v3 1/7] mm/hotplug: fix hot remove failure in SPARSEMEM|!VMEMMAP case
Date:   Sat,  7 Mar 2020 16:42:23 +0800
Message-Id: <20200307084229.28251-2-bhe@redhat.com>
In-Reply-To: <20200307084229.28251-1-bhe@redhat.com>
References: <20200307084229.28251-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In section_deactivate(), pfn_to_page() doesn't work any more after
ms->section_mem_map is resetting to NULL in SPARSEMEM|!VMEMMAP case.
It caused hot remove failure:

kernel BUG at mm/page_alloc.c:4806!
invalid opcode: 0000 [#1] SMP PTI
CPU: 3 PID: 8 Comm: kworker/u16:0 Tainted: G        W         5.5.0-next-20200205+ #340
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
Workqueue: kacpi_hotplug acpi_hotplug_work_fn
RIP: 0010:free_pages+0x85/0xa0
Call Trace:
 __remove_pages+0x99/0xc0
 arch_remove_memory+0x23/0x4d
 try_remove_memory+0xc8/0x130
 ? walk_memory_blocks+0x72/0xa0
 __remove_memory+0xa/0x11
 acpi_memory_device_remove+0x72/0x100
 acpi_bus_trim+0x55/0x90
 acpi_device_hotplug+0x2eb/0x3d0
 acpi_hotplug_work_fn+0x1a/0x30
 process_one_work+0x1a7/0x370
 worker_thread+0x30/0x380
 ? flush_rcu_work+0x30/0x30
 kthread+0x112/0x130
 ? kthread_create_on_node+0x60/0x60
 ret_from_fork+0x35/0x40

Let's move the ->section_mem_map resetting after depopulate_section_memmap()
to fix it.

Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: stable@vger.kernel.org
---
 mm/sparse.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 42c18a38ffaa..1b50c15677d7 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -734,6 +734,7 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 	struct mem_section *ms = __pfn_to_section(pfn);
 	bool section_is_early = early_section(ms);
 	struct page *memmap = NULL;
+	bool empty = false;
 	unsigned long *subsection_map = ms->usage
 		? &ms->usage->subsection_map[0] : NULL;
 
@@ -764,7 +765,8 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 	 * For 2/ and 3/ the SPARSEMEM_VMEMMAP={y,n} cases are unified
 	 */
 	bitmap_xor(subsection_map, map, subsection_map, SUBSECTIONS_PER_SECTION);
-	if (bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION)) {
+	empty = bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION);
+	if (empty) {
 		unsigned long section_nr = pfn_to_section_nr(pfn);
 
 		/*
@@ -779,13 +781,15 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 			ms->usage = NULL;
 		}
 		memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
-		ms->section_mem_map = (unsigned long)NULL;
 	}
 
 	if (section_is_early && memmap)
 		free_map_bootmem(memmap);
 	else
 		depopulate_section_memmap(pfn, nr_pages, altmap);
+
+	if (empty)
+		ms->section_mem_map = (unsigned long)NULL;
 }
 
 static struct page * __meminit section_activate(int nid, unsigned long pfn,
-- 
2.17.2

