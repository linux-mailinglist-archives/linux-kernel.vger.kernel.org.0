Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAD87D4C88
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2019 05:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbfJLDqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 23:46:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44336 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728159AbfJLDqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 23:46:34 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 989CA307D989;
        Sat, 12 Oct 2019 03:46:33 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-71.pek2.redhat.com [10.72.12.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6BAF019C6A;
        Sat, 12 Oct 2019 03:46:27 +0000 (UTC)
From:   Kairui Song <kasong@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Matthew Garrett <matthewgarrett@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        x86@kernel.org, linux-efi@vger.kernel.org,
        Kairui Song <kasong@redhat.com>
Subject: [PATCH v3] x86, efi: never relocate kernel below lowest acceptable address
Date:   Sat, 12 Oct 2019 11:44:21 +0800
Message-Id: <20191012034421.25027-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Sat, 12 Oct 2019 03:46:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, kernel fails to boot on some HyperV VMs when using EFI.
And it's a potential issue on all platforms.

It's caused a broken kernel relocation on EFI systems, when below three
conditions are met:

1. Kernel image is not loaded to the default address (LOAD_PHYSICAL_ADDR)
   by the loader.
2. There isn't enough room to contain the kernel, starting from the
   default load address (eg. something else occupied part the region).
3. In the memmap provided by EFI firmware, there is a memory region
   starts below LOAD_PHYSICAL_ADDR, and suitable for containing the
   kernel.

Efi stub will perform a kernel relocation when condition 1 is met. But
due to condition 2, efi stub can't relocate kernel to the preferred
address, so it fallback to query and alloc from EFI firmware for lowest
usable memory region.

It's incorrect to use the lowest memory address. In later stage, kernel
will assume LOAD_PHYSICAL_ADDR as the minimal acceptable relocate address,
but efi stub will end up relocating kernel below it.

The later kernel decompressing code will forcefully correct the wrong
kernel load location, but it is not aware of the EFI's memory map, and
could over write critical memory, crashing the system.

To fix it, just don't let efi stub relocate the kernel to any address
lower than lowest acceptable address.

Signed-off-by: Kairui Song <kasong@redhat.com>
Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

---
Update from V2:
 - Update part of the commit message.

Update from V1:
 - Redo the commit message.

 arch/x86/boot/compressed/eboot.c               |  8 +++++---
 drivers/firmware/efi/libstub/arm32-stub.c      |  2 +-
 drivers/firmware/efi/libstub/arm64-stub.c      |  2 +-
 drivers/firmware/efi/libstub/efi-stub-helper.c | 12 ++++++++----
 include/linux/efi.h                            |  5 +++--
 5 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index d6662fdef300..e89e84b66527 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -13,6 +13,7 @@
 #include <asm/e820/types.h>
 #include <asm/setup.h>
 #include <asm/desc.h>
+#include <asm/boot.h>
 
 #include "../string.h"
 #include "eboot.h"
@@ -413,7 +414,7 @@ struct boot_params *make_boot_params(struct efi_config *c)
 	}
 
 	status = efi_low_alloc(sys_table, 0x4000, 1,
-			       (unsigned long *)&boot_params);
+			       (unsigned long *)&boot_params, 0);
 	if (status != EFI_SUCCESS) {
 		efi_printk(sys_table, "Failed to allocate lowmem for boot params\n");
 		return NULL;
@@ -798,7 +799,7 @@ efi_main(struct efi_config *c, struct boot_params *boot_params)
 
 	gdt->size = 0x800;
 	status = efi_low_alloc(sys_table, gdt->size, 8,
-			   (unsigned long *)&gdt->address);
+			       (unsigned long *)&gdt->address, 0);
 	if (status != EFI_SUCCESS) {
 		efi_printk(sys_table, "Failed to allocate memory for 'gdt'\n");
 		goto fail;
@@ -813,7 +814,8 @@ efi_main(struct efi_config *c, struct boot_params *boot_params)
 		status = efi_relocate_kernel(sys_table, &bzimage_addr,
 					     hdr->init_size, hdr->init_size,
 					     hdr->pref_address,
-					     hdr->kernel_alignment);
+					     hdr->kernel_alignment,
+					     LOAD_PHYSICAL_ADDR);
 		if (status != EFI_SUCCESS) {
 			efi_printk(sys_table, "efi_relocate_kernel() failed!\n");
 			goto fail;
diff --git a/drivers/firmware/efi/libstub/arm32-stub.c b/drivers/firmware/efi/libstub/arm32-stub.c
index e8f7aefb6813..bf6f954d6afe 100644
--- a/drivers/firmware/efi/libstub/arm32-stub.c
+++ b/drivers/firmware/efi/libstub/arm32-stub.c
@@ -220,7 +220,7 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table,
 	*image_size = image->image_size;
 	status = efi_relocate_kernel(sys_table, image_addr, *image_size,
 				     *image_size,
-				     dram_base + MAX_UNCOMP_KERNEL_SIZE, 0);
+				     dram_base + MAX_UNCOMP_KERNEL_SIZE, 0, 0);
 	if (status != EFI_SUCCESS) {
 		pr_efi_err(sys_table, "Failed to relocate kernel.\n");
 		efi_free(sys_table, *reserve_size, *reserve_addr);
diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index 1550d244e996..3d2e517e10f4 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -140,7 +140,7 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table_arg,
 	if (status != EFI_SUCCESS) {
 		*reserve_size = kernel_memsize + TEXT_OFFSET;
 		status = efi_low_alloc(sys_table_arg, *reserve_size,
-				       MIN_KIMG_ALIGN, reserve_addr);
+				       MIN_KIMG_ALIGN, reserve_addr, 0);
 
 		if (status != EFI_SUCCESS) {
 			pr_efi_err(sys_table_arg, "Failed to relocate kernel\n");
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 3caae7f2cf56..00b00a2562aa 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -260,11 +260,11 @@ efi_status_t efi_high_alloc(efi_system_table_t *sys_table_arg,
 }
 
 /*
- * Allocate at the lowest possible address.
+ * Allocate at the lowest possible address that is not below 'min'.
  */
 efi_status_t efi_low_alloc(efi_system_table_t *sys_table_arg,
 			   unsigned long size, unsigned long align,
-			   unsigned long *addr)
+			   unsigned long *addr, unsigned long min)
 {
 	unsigned long map_size, desc_size, buff_size;
 	efi_memory_desc_t *map;
@@ -311,6 +311,9 @@ efi_status_t efi_low_alloc(efi_system_table_t *sys_table_arg,
 		start = desc->phys_addr;
 		end = start + desc->num_pages * EFI_PAGE_SIZE;
 
+		if (start < min)
+			start = min;
+
 		/*
 		 * Don't allocate at 0x0. It will confuse code that
 		 * checks pointers against NULL. Skip the first 8
@@ -698,7 +701,8 @@ efi_status_t efi_relocate_kernel(efi_system_table_t *sys_table_arg,
 				 unsigned long image_size,
 				 unsigned long alloc_size,
 				 unsigned long preferred_addr,
-				 unsigned long alignment)
+				 unsigned long alignment,
+				 unsigned long min_addr)
 {
 	unsigned long cur_image_addr;
 	unsigned long new_addr = 0;
@@ -732,7 +736,7 @@ efi_status_t efi_relocate_kernel(efi_system_table_t *sys_table_arg,
 	 */
 	if (status != EFI_SUCCESS) {
 		status = efi_low_alloc(sys_table_arg, alloc_size, alignment,
-				       &new_addr);
+				       &new_addr, min_addr);
 	}
 	if (status != EFI_SUCCESS) {
 		pr_efi_err(sys_table_arg, "Failed to allocate usable memory for kernel.\n");
diff --git a/include/linux/efi.h b/include/linux/efi.h
index bd3837022307..a5144cc44e54 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1581,7 +1581,7 @@ efi_status_t efi_get_memory_map(efi_system_table_t *sys_table_arg,
 
 efi_status_t efi_low_alloc(efi_system_table_t *sys_table_arg,
 			   unsigned long size, unsigned long align,
-			   unsigned long *addr);
+			   unsigned long *addr, unsigned long min);
 
 efi_status_t efi_high_alloc(efi_system_table_t *sys_table_arg,
 			    unsigned long size, unsigned long align,
@@ -1592,7 +1592,8 @@ efi_status_t efi_relocate_kernel(efi_system_table_t *sys_table_arg,
 				 unsigned long image_size,
 				 unsigned long alloc_size,
 				 unsigned long preferred_addr,
-				 unsigned long alignment);
+				 unsigned long alignment,
+				 unsigned long min_addr);
 
 efi_status_t handle_cmdline_files(efi_system_table_t *sys_table_arg,
 				  efi_loaded_image_t *image,
-- 
2.21.0

