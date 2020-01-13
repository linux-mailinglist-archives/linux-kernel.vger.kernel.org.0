Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3EC3139784
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 18:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgAMRXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 12:23:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:42924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728946AbgAMRXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 12:23:37 -0500
Received: from dogfood.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97FA1206DA;
        Mon, 13 Jan 2020 17:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578936216;
        bh=yqJTpElEIc8QobaR9Uk2pT2ef9Mek7Pwo/n6rRWT4jA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qmq1FoVI08ZLfnqiF3oSV422/cURLUqT2913jMeAoQo3ad60QBEOvWhmXU3xhBQ0v
         MQMGlvqlPIlEgVnFRLFIbuETXK/zM+sdWj22swh/5CeEinkF245zHzirgsIYlAXvwj
         uxlS0Z5vGnh7G1O3fumS8AgU2ulP30KVPdFWOtr4=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Young <dyoung@redhat.com>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH 13/13] efi: Fix handling of multiple efi_fake_mem= entries
Date:   Mon, 13 Jan 2020 18:22:45 +0100
Message-Id: <20200113172245.27925-14-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200113172245.27925-1-ardb@kernel.org>
References: <20200113172245.27925-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

Dave noticed that when specifying multiple efi_fake_mem= entries only
the last entry was successfully being reflected in the efi memory map.
This is due to the fact that the efi_memmap_insert() is being called
multiple times, but on successive invocations the insertion should be
applied to the last new memmap rather than the original map at
efi_fake_memmap() entry.

Rework efi_fake_memmap() to install the new memory map after each
efi_fake_mem= entry is parsed.

This also fixes an issue in efi_fake_memmap() that caused it to litter
emtpy entries into the end of the efi memory map. An empty entry causes
efi_memmap_insert() to attempt more memmap splits / copies than
efi_memmap_split_count() accounted for when sizing the new map. When
that happens efi_memmap_insert() may overrun its allocation, and if you
are lucky will spill over to an unmapped page leading to crash
signature like the following rather than silent corruption:

    BUG: unable to handle page fault for address: ffffffffff281000
    [..]
    RIP: 0010:efi_memmap_insert+0x11d/0x191
    [..]
    Call Trace:
     ? bgrt_init+0xbe/0xbe
     ? efi_arch_mem_reserve+0x1cb/0x228
     ? acpi_parse_bgrt+0xa/0xd
     ? acpi_table_parse+0x86/0xb8
     ? acpi_boot_init+0x494/0x4e3
     ? acpi_parse_x2apic+0x87/0x87
     ? setup_acpi_sci+0xa2/0xa2
     ? setup_arch+0x8db/0x9e1
     ? start_kernel+0x6a/0x547
     ? secondary_startup_64+0xb6/0xc0

Commit af1648984828 "x86/efi: Update e820 with reserved EFI boot
services data to fix kexec breakage" introduced more occurrences where
efi_memmap_insert() is invoked after an efi_fake_mem= configuration has
been parsed. Previously the side effects of vestigial empty entries were
benign, but with commit af1648984828 that follow-on efi_memmap_insert()
invocation triggers efi_memmap_insert() overruns.

Link: https://lore.kernel.org/r/20191231014630.GA24942@dhcp-128-65.nay.redhat.com
Reported-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/fake_mem.c | 31 ++++++++++++++++---------------
 drivers/firmware/efi/memmap.c   |  2 +-
 include/linux/efi.h             |  2 ++
 3 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/firmware/efi/fake_mem.c b/drivers/firmware/efi/fake_mem.c
index a8d20568d532..6e0f34a38171 100644
--- a/drivers/firmware/efi/fake_mem.c
+++ b/drivers/firmware/efi/fake_mem.c
@@ -34,25 +34,16 @@ static int __init cmp_fake_mem(const void *x1, const void *x2)
 	return 0;
 }
 
-void __init efi_fake_memmap(void)
+static void __init efi_fake_range(struct efi_mem_range *efi_range)
 {
 	struct efi_memory_map_data data = { 0 };
 	int new_nr_map = efi.memmap.nr_map;
 	efi_memory_desc_t *md;
 	void *new_memmap;
-	int i;
-
-	if (!efi_enabled(EFI_MEMMAP) || !nr_fake_mem)
-		return;
 
 	/* count up the number of EFI memory descriptor */
-	for (i = 0; i < nr_fake_mem; i++) {
-		for_each_efi_memory_desc(md) {
-			struct range *r = &efi_fake_mems[i].range;
-
-			new_nr_map += efi_memmap_split_count(md, r);
-		}
-	}
+	for_each_efi_memory_desc(md)
+		new_nr_map += efi_memmap_split_count(md, &efi_range->range);
 
 	/* allocate memory for new EFI memmap */
 	if (efi_memmap_alloc(new_nr_map, &data) != 0)
@@ -61,17 +52,27 @@ void __init efi_fake_memmap(void)
 	/* create new EFI memmap */
 	new_memmap = early_memremap(data.phys_map, data.size);
 	if (!new_memmap) {
-		memblock_free(data.phys_map, data.size);
+		__efi_memmap_free(data.phys_map, data.size, data.flags);
 		return;
 	}
 
-	for (i = 0; i < nr_fake_mem; i++)
-		efi_memmap_insert(&efi.memmap, new_memmap, &efi_fake_mems[i]);
+	efi_memmap_insert(&efi.memmap, new_memmap, efi_range);
 
 	/* swap into new EFI memmap */
 	early_memunmap(new_memmap, data.size);
 
 	efi_memmap_install(&data);
+}
+
+void __init efi_fake_memmap(void)
+{
+	int i;
+
+	if (!efi_enabled(EFI_MEMMAP) || !nr_fake_mem)
+		return;
+
+	for (i = 0; i < nr_fake_mem; i++)
+		efi_fake_range(&efi_fake_mems[i]);
 
 	/* print new EFI memmap */
 	efi_print_memmap();
diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
index 501672166502..2ff1883dc788 100644
--- a/drivers/firmware/efi/memmap.c
+++ b/drivers/firmware/efi/memmap.c
@@ -29,7 +29,7 @@ static phys_addr_t __init __efi_memmap_alloc_late(unsigned long size)
 	return PFN_PHYS(page_to_pfn(p));
 }
 
-static void __init __efi_memmap_free(u64 phys, unsigned long size, unsigned long flags)
+void __init __efi_memmap_free(u64 phys, unsigned long size, unsigned long flags)
 {
 	if (flags & EFI_MEMMAP_MEMBLOCK) {
 		if (slab_is_available())
diff --git a/include/linux/efi.h b/include/linux/efi.h
index adbe421835c1..7efd7072cca5 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -976,6 +976,8 @@ extern void __iomem *efi_lookup_mapped_addr(u64 phys_addr);
 
 extern int __init efi_memmap_alloc(unsigned int num_entries,
 				   struct efi_memory_map_data *data);
+extern void __efi_memmap_free(u64 phys, unsigned long size,
+			      unsigned long flags);
 extern int __init efi_memmap_init_early(struct efi_memory_map_data *data);
 extern int __init efi_memmap_init_late(phys_addr_t addr, unsigned long size);
 extern void __init efi_memmap_unmap(void);
-- 
2.20.1

