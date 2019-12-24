Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 509F412A2C0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Dec 2019 16:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfLXPLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Dec 2019 10:11:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:51222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727236AbfLXPLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 10:11:16 -0500
Received: from localhost.localdomain (aaubervilliers-681-1-7-6.w90-88.abo.wanadoo.fr [90.88.129.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B09472075E;
        Tue, 24 Dec 2019 15:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577200274;
        bh=GZcoBbklxYPexvBGAH7d2secV6CRr9Zlis2664kpEgc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sj6CUJ9gRsGrQL2793aMEuvpMFYdw7v8bU8xLjq0ocKcb3WpMnXQnc0t7mctv/NgY
         MHpiXohPCF/JNdbjhtmWOY4TM82jNaFgEHXm7hd+DZyArseir0XciaCQ2qEUry2xI6
         ofNKqThP2GaBKVUtoPvD5b1jd9TggvYns6fwJld0=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH 18/25] efi/libstub: drop sys_table_arg from printk routines
Date:   Tue, 24 Dec 2019 16:10:18 +0100
Message-Id: <20191224151025.32482-19-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224151025.32482-1-ardb@kernel.org>
References: <20191224151025.32482-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a first step towards getting rid of the need to pass around a function
parameter 'sys_table_arg' pointing to the EFI system table, remove the
references to it in the printing code, which is represents the majority
of the use cases.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/eboot.c              | 28 +++++++--------
 drivers/firmware/efi/libstub/arm-stub.c       | 28 +++++++--------
 drivers/firmware/efi/libstub/arm32-stub.c     | 14 ++++----
 drivers/firmware/efi/libstub/arm64-stub.c     | 12 +++----
 .../firmware/efi/libstub/efi-stub-helper.c    | 34 +++++++++----------
 drivers/firmware/efi/libstub/efistub.h        |  9 ++---
 drivers/firmware/efi/libstub/fdt.c            | 16 ++++-----
 drivers/firmware/efi/libstub/secureboot.c     |  4 +--
 drivers/firmware/efi/libstub/tpm.c            |  3 +-
 include/linux/efi.h                           |  2 +-
 10 files changed, 74 insertions(+), 76 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 2a7c6d58cc56..1e072d487833 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -57,7 +57,7 @@ preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
 	status = efi_call_early(allocate_pool, EFI_LOADER_DATA, size,
 				(void **)&rom);
 	if (status != EFI_SUCCESS) {
-		efi_printk(sys_table, "Failed to allocate memory for 'rom'\n");
+		efi_printk("Failed to allocate memory for 'rom'\n");
 		return status;
 	}
 
@@ -74,7 +74,7 @@ preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
 				&rom->vendor);
 
 	if (status != EFI_SUCCESS) {
-		efi_printk(sys_table, "Failed to read rom->vendor\n");
+		efi_printk("Failed to read rom->vendor\n");
 		goto free_struct;
 	}
 
@@ -83,7 +83,7 @@ preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
 				&rom->devid);
 
 	if (status != EFI_SUCCESS) {
-		efi_printk(sys_table, "Failed to read rom->devid\n");
+		efi_printk("Failed to read rom->devid\n");
 		goto free_struct;
 	}
 
@@ -132,7 +132,7 @@ static void setup_efi_pci(struct boot_params *params)
 					size, (void **)&pci_handle);
 
 		if (status != EFI_SUCCESS) {
-			efi_printk(sys_table, "Failed to allocate memory for 'pci_handle'\n");
+			efi_printk("Failed to allocate memory for 'pci_handle'\n");
 			return;
 		}
 
@@ -187,7 +187,7 @@ static void retrieve_apple_device_properties(struct boot_params *boot_params)
 		return;
 
 	if (efi_table_attr(apple_properties_protocol, version, p) != 0x10000) {
-		efi_printk(sys_table, "Unsupported properties proto version\n");
+		efi_printk("Unsupported properties proto version\n");
 		return;
 	}
 
@@ -200,7 +200,7 @@ static void retrieve_apple_device_properties(struct boot_params *boot_params)
 					size + sizeof(struct setup_data),
 					(void **)&new);
 		if (status != EFI_SUCCESS) {
-			efi_printk(sys_table, "Failed to allocate memory for 'properties'\n");
+			efi_printk("Failed to allocate memory for 'properties'\n");
 			return;
 		}
 
@@ -386,14 +386,14 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	status = efi_call_early(handle_protocol, handle,
 				&proto, (void *)&image);
 	if (status != EFI_SUCCESS) {
-		efi_printk(sys_table, "Failed to get handle for LOADED_IMAGE_PROTOCOL\n");
+		efi_printk("Failed to get handle for LOADED_IMAGE_PROTOCOL\n");
 		return status;
 	}
 
 	status = efi_low_alloc(sys_table, 0x4000, 1,
 			       (unsigned long *)&boot_params);
 	if (status != EFI_SUCCESS) {
-		efi_printk(sys_table, "Failed to allocate lowmem for boot params\n");
+		efi_printk("Failed to allocate lowmem for boot params\n");
 		return status;
 	}
 
@@ -441,7 +441,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 
 	if (status != EFI_SUCCESS &&
 	    hdr->xloadflags & XLF_CAN_BE_LOADED_ABOVE_4G) {
-		efi_printk(sys_table, "Trying to load files to higher address\n");
+		efi_printk("Trying to load files to higher address\n");
 		status = handle_cmdline_files(sys_table, image,
 				      (char *)(unsigned long)hdr->cmd_line_ptr,
 				      "initrd=", -1UL,
@@ -773,7 +773,7 @@ struct boot_params *efi_main(efi_handle_t handle,
 	status = efi_call_early(allocate_pool, EFI_LOADER_DATA,
 				sizeof(*gdt), (void **)&gdt);
 	if (status != EFI_SUCCESS) {
-		efi_printk(sys_table, "Failed to allocate memory for 'gdt' structure\n");
+		efi_printk("Failed to allocate memory for 'gdt' structure\n");
 		goto fail;
 	}
 
@@ -781,7 +781,7 @@ struct boot_params *efi_main(efi_handle_t handle,
 	status = efi_low_alloc(sys_table, gdt->size, 8,
 			   (unsigned long *)&gdt->address);
 	if (status != EFI_SUCCESS) {
-		efi_printk(sys_table, "Failed to allocate memory for 'gdt'\n");
+		efi_printk("Failed to allocate memory for 'gdt'\n");
 		goto fail;
 	}
 
@@ -797,7 +797,7 @@ struct boot_params *efi_main(efi_handle_t handle,
 					     hdr->kernel_alignment,
 					     LOAD_PHYSICAL_ADDR);
 		if (status != EFI_SUCCESS) {
-			efi_printk(sys_table, "efi_relocate_kernel() failed!\n");
+			efi_printk("efi_relocate_kernel() failed!\n");
 			goto fail;
 		}
 
@@ -807,7 +807,7 @@ struct boot_params *efi_main(efi_handle_t handle,
 
 	status = exit_boot(boot_params, handle);
 	if (status != EFI_SUCCESS) {
-		efi_printk(sys_table, "exit_boot() failed!\n");
+		efi_printk("exit_boot() failed!\n");
 		goto fail;
 	}
 
@@ -900,7 +900,7 @@ struct boot_params *efi_main(efi_handle_t handle,
 
 	return boot_params;
 fail:
-	efi_printk(sys_table, "efi_main() failed!\n");
+	efi_printk("efi_main() failed!\n");
 
 	for (;;)
 		asm("hlt");
diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
index b44b1bd4d480..2ed4bd457e66 100644
--- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/arm-stub.c
@@ -73,7 +73,7 @@ void install_memreserve_table(efi_system_table_t *sys_table_arg)
 	status = efi_call_early(allocate_pool, EFI_LOADER_DATA, sizeof(*rsv),
 				(void **)&rsv);
 	if (status != EFI_SUCCESS) {
-		pr_efi_err(sys_table_arg, "Failed to allocate memreserve entry!\n");
+		pr_efi_err("Failed to allocate memreserve entry!\n");
 		return;
 	}
 
@@ -85,7 +85,7 @@ void install_memreserve_table(efi_system_table_t *sys_table_arg)
 				&memreserve_table_guid,
 				rsv);
 	if (status != EFI_SUCCESS)
-		pr_efi_err(sys_table_arg, "Failed to install memreserve config table!\n");
+		pr_efi_err("Failed to install memreserve config table!\n");
 }
 
 
@@ -147,13 +147,13 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table_arg,
 	status = sys_table->boottime->handle_protocol(handle,
 					&loaded_image_proto, (void *)&image);
 	if (status != EFI_SUCCESS) {
-		pr_efi_err(sys_table, "Failed to get loaded image protocol\n");
+		pr_efi_err("Failed to get loaded image protocol\n");
 		goto fail;
 	}
 
 	dram_base = get_dram_base(sys_table);
 	if (dram_base == EFI_ERROR) {
-		pr_efi_err(sys_table, "Failed to find DRAM base\n");
+		pr_efi_err("Failed to find DRAM base\n");
 		goto fail;
 	}
 
@@ -164,7 +164,7 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table_arg,
 	 */
 	cmdline_ptr = efi_convert_cmdline(sys_table, image, &cmdline_size);
 	if (!cmdline_ptr) {
-		pr_efi_err(sys_table, "getting command line via LOADED_IMAGE_PROTOCOL\n");
+		pr_efi_err("getting command line via LOADED_IMAGE_PROTOCOL\n");
 		goto fail;
 	}
 
@@ -176,7 +176,7 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table_arg,
 	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE) && cmdline_size > 0)
 		efi_parse_options(cmdline_ptr);
 
-	pr_efi(sys_table, "Booting Linux Kernel...\n");
+	pr_efi("Booting Linux Kernel...\n");
 
 	si = setup_graphics(sys_table);
 
@@ -185,7 +185,7 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table_arg,
 				     &reserve_size,
 				     dram_base, image);
 	if (status != EFI_SUCCESS) {
-		pr_efi_err(sys_table, "Failed to relocate kernel\n");
+		pr_efi_err("Failed to relocate kernel\n");
 		goto fail_free_cmdline;
 	}
 
@@ -204,29 +204,29 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table_arg,
 	if (!IS_ENABLED(CONFIG_EFI_ARMSTUB_DTB_LOADER) ||
 	     secure_boot != efi_secureboot_mode_disabled) {
 		if (strstr(cmdline_ptr, "dtb="))
-			pr_efi(sys_table, "Ignoring DTB from command line.\n");
+			pr_efi("Ignoring DTB from command line.\n");
 	} else {
 		status = handle_cmdline_files(sys_table, image, cmdline_ptr,
 					      "dtb=",
 					      ~0UL, &fdt_addr, &fdt_size);
 
 		if (status != EFI_SUCCESS) {
-			pr_efi_err(sys_table, "Failed to load device tree!\n");
+			pr_efi_err("Failed to load device tree!\n");
 			goto fail_free_image;
 		}
 	}
 
 	if (fdt_addr) {
-		pr_efi(sys_table, "Using DTB from command line\n");
+		pr_efi("Using DTB from command line\n");
 	} else {
 		/* Look for a device tree configuration table entry. */
 		fdt_addr = (uintptr_t)get_fdt(sys_table, &fdt_size);
 		if (fdt_addr)
-			pr_efi(sys_table, "Using DTB from configuration table\n");
+			pr_efi("Using DTB from configuration table\n");
 	}
 
 	if (!fdt_addr)
-		pr_efi(sys_table, "Generating empty DTB\n");
+		pr_efi("Generating empty DTB\n");
 
 	status = handle_cmdline_files(sys_table, image, cmdline_ptr, "initrd=",
 				      efi_get_max_initrd_addr(dram_base,
@@ -234,7 +234,7 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table_arg,
 				      (unsigned long *)&initrd_addr,
 				      (unsigned long *)&initrd_size);
 	if (status != EFI_SUCCESS)
-		pr_efi_err(sys_table, "Failed initrd from command line!\n");
+		pr_efi_err("Failed initrd from command line!\n");
 
 	efi_random_get_seed(sys_table);
 
@@ -275,7 +275,7 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table_arg,
 	if (status == EFI_SUCCESS)
 		return new_fdt_addr;
 
-	pr_efi_err(sys_table, "Failed to update FDT and exit boot services\n");
+	pr_efi_err("Failed to update FDT and exit boot services\n");
 
 	efi_free(sys_table, initrd_size, initrd_addr);
 	efi_free(sys_table, fdt_size, fdt_addr);
diff --git a/drivers/firmware/efi/libstub/arm32-stub.c b/drivers/firmware/efi/libstub/arm32-stub.c
index 4566640de650..7b5c717ddfac 100644
--- a/drivers/firmware/efi/libstub/arm32-stub.c
+++ b/drivers/firmware/efi/libstub/arm32-stub.c
@@ -18,7 +18,7 @@ efi_status_t check_platform_features(efi_system_table_t *sys_table_arg)
 	/* LPAE kernels need compatible hardware */
 	block = cpuid_feature_extract(CPUID_EXT_MMFR0, 0);
 	if (block < 5) {
-		pr_efi_err(sys_table_arg, "This LPAE kernel is not supported by your CPU\n");
+		pr_efi_err("This LPAE kernel is not supported by your CPU\n");
 		return EFI_UNSUPPORTED;
 	}
 	return EFI_SUCCESS;
@@ -121,8 +121,7 @@ static efi_status_t reserve_kernel_base(efi_system_table_t *sys_table_arg,
 	 */
 	status = efi_get_memory_map(sys_table_arg, &map);
 	if (status != EFI_SUCCESS) {
-		pr_efi_err(sys_table_arg,
-			   "reserve_kernel_base(): Unable to retrieve memory map.\n");
+		pr_efi_err("reserve_kernel_base(): Unable to retrieve memory map.\n");
 		return status;
 	}
 
@@ -164,8 +163,7 @@ static efi_status_t reserve_kernel_base(efi_system_table_t *sys_table_arg,
 						(end - start) / EFI_PAGE_SIZE,
 						&start);
 			if (status != EFI_SUCCESS) {
-				pr_efi_err(sys_table_arg,
-					"reserve_kernel_base(): alloc failed.\n");
+				pr_efi_err("reserve_kernel_base(): alloc failed.\n");
 				goto out;
 			}
 			break;
@@ -224,7 +222,7 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table,
 	status = reserve_kernel_base(sys_table, kernel_base, reserve_addr,
 				     reserve_size);
 	if (status != EFI_SUCCESS) {
-		pr_efi_err(sys_table, "Unable to allocate memory for uncompressed kernel.\n");
+		pr_efi_err("Unable to allocate memory for uncompressed kernel.\n");
 		return status;
 	}
 
@@ -237,7 +235,7 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table,
 				     *image_size,
 				     kernel_base + MAX_UNCOMP_KERNEL_SIZE, 0, 0);
 	if (status != EFI_SUCCESS) {
-		pr_efi_err(sys_table, "Failed to relocate kernel.\n");
+		pr_efi_err("Failed to relocate kernel.\n");
 		efi_free(sys_table, *reserve_size, *reserve_addr);
 		*reserve_size = 0;
 		return status;
@@ -249,7 +247,7 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table,
 	 * address at which the zImage is loaded.
 	 */
 	if (*image_addr + *image_size > dram_base + ZIMAGE_OFFSET_LIMIT) {
-		pr_efi_err(sys_table, "Failed to relocate kernel, no low memory available.\n");
+		pr_efi_err("Failed to relocate kernel, no low memory available.\n");
 		efi_free(sys_table, *reserve_size, *reserve_addr);
 		*reserve_size = 0;
 		efi_free(sys_table, *image_size, *image_addr);
diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index 1550d244e996..b09dda600c78 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -32,9 +32,9 @@ efi_status_t check_platform_features(efi_system_table_t *sys_table_arg)
 	tg = (read_cpuid(ID_AA64MMFR0_EL1) >> ID_AA64MMFR0_TGRAN_SHIFT) & 0xf;
 	if (tg != ID_AA64MMFR0_TGRAN_SUPPORTED) {
 		if (IS_ENABLED(CONFIG_ARM64_64K_PAGES))
-			pr_efi_err(sys_table_arg, "This 64 KB granular kernel is not supported by your CPU\n");
+			pr_efi_err("This 64 KB granular kernel is not supported by your CPU\n");
 		else
-			pr_efi_err(sys_table_arg, "This 16 KB granular kernel is not supported by your CPU\n");
+			pr_efi_err("This 16 KB granular kernel is not supported by your CPU\n");
 		return EFI_UNSUPPORTED;
 	}
 	return EFI_SUCCESS;
@@ -60,13 +60,13 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table_arg,
 						      sizeof(phys_seed),
 						      (u8 *)&phys_seed);
 			if (status == EFI_NOT_FOUND) {
-				pr_efi(sys_table_arg, "EFI_RNG_PROTOCOL unavailable, no randomness supplied\n");
+				pr_efi("EFI_RNG_PROTOCOL unavailable, no randomness supplied\n");
 			} else if (status != EFI_SUCCESS) {
-				pr_efi_err(sys_table_arg, "efi_get_random_bytes() failed\n");
+				pr_efi_err("efi_get_random_bytes() failed\n");
 				return status;
 			}
 		} else {
-			pr_efi(sys_table_arg, "KASLR disabled on kernel command line\n");
+			pr_efi("KASLR disabled on kernel command line\n");
 		}
 	}
 
@@ -143,7 +143,7 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table_arg,
 				       MIN_KIMG_ALIGN, reserve_addr);
 
 		if (status != EFI_SUCCESS) {
-			pr_efi_err(sys_table_arg, "Failed to relocate kernel\n");
+			pr_efi_err("Failed to relocate kernel\n");
 			*reserve_size = 0;
 			return status;
 		}
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index f74b514789d7..9f0d332954ab 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -58,7 +58,7 @@ struct file_info {
 	u64 size;
 };
 
-void efi_printk(efi_system_table_t *sys_table_arg, char *str)
+void efi_printk(char *str)
 {
 	char *s8;
 
@@ -68,10 +68,10 @@ void efi_printk(efi_system_table_t *sys_table_arg, char *str)
 		ch[0] = *s8;
 		if (*s8 == '\n') {
 			efi_char16_t nl[2] = { '\r', 0 };
-			efi_char16_printk(sys_table_arg, nl);
+			efi_char16_printk(nl);
 		}
 
-		efi_char16_printk(sys_table_arg, ch);
+		efi_char16_printk(ch);
 	}
 }
 
@@ -372,9 +372,9 @@ static efi_status_t efi_file_size(efi_system_table_t *sys_table_arg, void *__fh,
 
 	status = fh->open(fh, &h, filename_16, EFI_FILE_MODE_READ, 0);
 	if (status != EFI_SUCCESS) {
-		efi_printk(sys_table_arg, "Failed to open file: ");
-		efi_char16_printk(sys_table_arg, filename_16);
-		efi_printk(sys_table_arg, "\n");
+		efi_printk("Failed to open file: ");
+		efi_char16_printk(filename_16);
+		efi_printk("\n");
 		return status;
 	}
 
@@ -383,7 +383,7 @@ static efi_status_t efi_file_size(efi_system_table_t *sys_table_arg, void *__fh,
 	info_sz = 0;
 	status = h->get_info(h, &info_guid, &info_sz, NULL);
 	if (status != EFI_BUFFER_TOO_SMALL) {
-		efi_printk(sys_table_arg, "Failed to get file info size\n");
+		efi_printk("Failed to get file info size\n");
 		return status;
 	}
 
@@ -391,7 +391,7 @@ static efi_status_t efi_file_size(efi_system_table_t *sys_table_arg, void *__fh,
 	status = efi_call_early(allocate_pool, EFI_LOADER_DATA,
 				info_sz, (void **)&info);
 	if (status != EFI_SUCCESS) {
-		efi_printk(sys_table_arg, "Failed to alloc mem for file info\n");
+		efi_printk("Failed to alloc mem for file info\n");
 		return status;
 	}
 
@@ -405,7 +405,7 @@ static efi_status_t efi_file_size(efi_system_table_t *sys_table_arg, void *__fh,
 	efi_call_early(free_pool, info);
 
 	if (status != EFI_SUCCESS)
-		efi_printk(sys_table_arg, "Failed to get initrd info\n");
+		efi_printk("Failed to get initrd info\n");
 
 	return status;
 }
@@ -434,13 +434,13 @@ static efi_status_t efi_open_volume(efi_system_table_t *sys_table_arg,
 	status = efi_call_early(handle_protocol, handle,
 				&fs_proto, (void **)&io);
 	if (status != EFI_SUCCESS) {
-		efi_printk(sys_table_arg, "Failed to handle fs_proto\n");
+		efi_printk("Failed to handle fs_proto\n");
 		return status;
 	}
 
 	status = io->open_volume(io, &fh);
 	if (status != EFI_SUCCESS)
-		efi_printk(sys_table_arg, "Failed to open volume\n");
+		efi_printk("Failed to open volume\n");
 	else
 		*__fh = fh;
 
@@ -569,7 +569,7 @@ efi_status_t handle_cmdline_files(efi_system_table_t *sys_table_arg,
 	status = efi_call_early(allocate_pool, EFI_LOADER_DATA,
 				nr_files * sizeof(*files), (void **)&files);
 	if (status != EFI_SUCCESS) {
-		pr_efi_err(sys_table_arg, "Failed to alloc mem for file handle list\n");
+		pr_efi_err("Failed to alloc mem for file handle list\n");
 		goto fail;
 	}
 
@@ -632,13 +632,13 @@ efi_status_t handle_cmdline_files(efi_system_table_t *sys_table_arg,
 		status = efi_high_alloc(sys_table_arg, file_size_total, 0x1000,
 				    &file_addr, max_addr);
 		if (status != EFI_SUCCESS) {
-			pr_efi_err(sys_table_arg, "Failed to alloc highmem for files\n");
+			pr_efi_err("Failed to alloc highmem for files\n");
 			goto close_handles;
 		}
 
 		/* We've run out of free low memory. */
 		if (file_addr > max_addr) {
-			pr_efi_err(sys_table_arg, "We've run out of free low memory\n");
+			pr_efi_err("We've run out of free low memory\n");
 			status = EFI_INVALID_PARAMETER;
 			goto free_file_total;
 		}
@@ -660,7 +660,7 @@ efi_status_t handle_cmdline_files(efi_system_table_t *sys_table_arg,
 						       &chunksize,
 						       (void *)addr);
 				if (status != EFI_SUCCESS) {
-					pr_efi_err(sys_table_arg, "Failed to read file\n");
+					pr_efi_err("Failed to read file\n");
 					goto free_file_total;
 				}
 				addr += chunksize;
@@ -746,7 +746,7 @@ efi_status_t efi_relocate_kernel(efi_system_table_t *sys_table_arg,
 					     alignment, &new_addr, min_addr);
 	}
 	if (status != EFI_SUCCESS) {
-		pr_efi_err(sys_table_arg, "Failed to allocate usable memory for kernel.\n");
+		pr_efi_err("Failed to allocate usable memory for kernel.\n");
 		return status;
 	}
 
@@ -956,7 +956,7 @@ void *get_efi_config_table(efi_system_table_t *sys_table, efi_guid_t guid)
 	return NULL;
 }
 
-void efi_char16_printk(efi_system_table_t *table, efi_char16_t *str)
+void efi_char16_printk(efi_char16_t *str)
 {
 	efi_call_proto(efi_simple_text_output_protocol,
 		       output_string,
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index e6775c16a97d..4a6acd28ce65 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -31,13 +31,14 @@ extern int __pure novamap(void);
 
 extern __pure efi_system_table_t  *efi_system_table(void);
 
-#define pr_efi(sys_table, msg)		do {				\
-	if (!is_quiet()) efi_printk(sys_table, "EFI stub: "msg);	\
+#define pr_efi(msg)		do {			\
+	if (!is_quiet()) efi_printk("EFI stub: "msg);	\
 } while (0)
 
-#define pr_efi_err(sys_table, msg) efi_printk(sys_table, "EFI stub: ERROR: "msg)
+#define pr_efi_err(msg) efi_printk("EFI stub: ERROR: "msg)
 
-void efi_char16_printk(efi_system_table_t *, efi_char16_t *);
+void efi_char16_printk(efi_char16_t *);
+void efi_char16_printk(efi_char16_t *);
 
 unsigned long get_dram_base(efi_system_table_t *sys_table_arg);
 
diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
index 0bf0190917e0..1bf7edfd81ec 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -40,7 +40,7 @@ static efi_status_t update_fdt(efi_system_table_t *sys_table, void *orig_fdt,
 	/* Do some checks on provided FDT, if it exists: */
 	if (orig_fdt) {
 		if (fdt_check_header(orig_fdt)) {
-			pr_efi_err(sys_table, "Device Tree header not valid!\n");
+			pr_efi_err("Device Tree header not valid!\n");
 			return EFI_LOAD_ERROR;
 		}
 		/*
@@ -48,7 +48,7 @@ static efi_status_t update_fdt(efi_system_table_t *sys_table, void *orig_fdt,
 		 * configuration table:
 		 */
 		if (orig_fdt_size && fdt_totalsize(orig_fdt) > orig_fdt_size) {
-			pr_efi_err(sys_table, "Truncated device tree! foo!\n");
+			pr_efi_err("Truncated device tree! foo!\n");
 			return EFI_LOAD_ERROR;
 		}
 	}
@@ -277,17 +277,17 @@ efi_status_t allocate_new_fdt_and_exit_boot(efi_system_table_t *sys_table,
 	 */
 	status = efi_get_memory_map(sys_table, &map);
 	if (status != EFI_SUCCESS) {
-		pr_efi_err(sys_table, "Unable to retrieve UEFI memory map.\n");
+		pr_efi_err("Unable to retrieve UEFI memory map.\n");
 		return status;
 	}
 
-	pr_efi(sys_table, "Exiting boot services and installing virtual address map...\n");
+	pr_efi("Exiting boot services and installing virtual address map...\n");
 
 	map.map = &memory_map;
 	status = efi_high_alloc(sys_table, MAX_FDT_SIZE, EFI_FDT_ALIGN,
 				new_fdt_addr, max_addr);
 	if (status != EFI_SUCCESS) {
-		pr_efi_err(sys_table, "Unable to allocate memory for new device tree.\n");
+		pr_efi_err("Unable to allocate memory for new device tree.\n");
 		goto fail;
 	}
 
@@ -304,7 +304,7 @@ efi_status_t allocate_new_fdt_and_exit_boot(efi_system_table_t *sys_table,
 			    initrd_addr, initrd_size);
 
 	if (status != EFI_SUCCESS) {
-		pr_efi_err(sys_table, "Unable to construct new device tree.\n");
+		pr_efi_err("Unable to construct new device tree.\n");
 		goto fail_free_new_fdt;
 	}
 
@@ -350,7 +350,7 @@ efi_status_t allocate_new_fdt_and_exit_boot(efi_system_table_t *sys_table,
 		return EFI_SUCCESS;
 	}
 
-	pr_efi_err(sys_table, "Exit boot services failed.\n");
+	pr_efi_err("Exit boot services failed.\n");
 
 fail_free_new_fdt:
 	efi_free(sys_table, MAX_FDT_SIZE, *new_fdt_addr);
@@ -371,7 +371,7 @@ void *get_fdt(efi_system_table_t *sys_table, unsigned long *fdt_size)
 		return NULL;
 
 	if (fdt_check_header(fdt) != 0) {
-		pr_efi_err(sys_table, "Invalid header detected on UEFI supplied FDT, ignoring ...\n");
+		pr_efi_err("Invalid header detected on UEFI supplied FDT, ignoring ...\n");
 		return NULL;
 	}
 	*fdt_size = fdt_totalsize(fdt);
diff --git a/drivers/firmware/efi/libstub/secureboot.c b/drivers/firmware/efi/libstub/secureboot.c
index edba5e7a3743..9071b57da8fe 100644
--- a/drivers/firmware/efi/libstub/secureboot.c
+++ b/drivers/firmware/efi/libstub/secureboot.c
@@ -72,10 +72,10 @@ enum efi_secureboot_mode efi_get_secureboot(efi_system_table_t *sys_table_arg)
 		return efi_secureboot_mode_disabled;
 
 secure_boot_enabled:
-	pr_efi(sys_table_arg, "UEFI Secure Boot is enabled.\n");
+	pr_efi("UEFI Secure Boot is enabled.\n");
 	return efi_secureboot_mode_enabled;
 
 out_efi_err:
-	pr_efi_err(sys_table_arg, "Could not determine UEFI Secure Boot status.\n");
+	pr_efi_err("Could not determine UEFI Secure Boot status.\n");
 	return efi_secureboot_mode_unknown;
 }
diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
index d270acd43de8..86658b005e85 100644
--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -131,8 +131,7 @@ void efi_retrieve_tpm2_eventlog(efi_system_table_t *sys_table_arg)
 				(void **) &log_tbl);
 
 	if (status != EFI_SUCCESS) {
-		efi_printk(sys_table_arg,
-			   "Unable to allocate memory for event log\n");
+		efi_printk("Unable to allocate memory for event log\n");
 		return;
 	}
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 14dd08ecf8a7..5b207db6ead0 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1493,7 +1493,7 @@ static inline int efi_runtime_map_copy(void *buf, size_t bufsz)
 
 /* prototypes shared between arch specific and generic stub code */
 
-void efi_printk(efi_system_table_t *sys_table_arg, char *str);
+void efi_printk(char *str);
 
 void efi_free(efi_system_table_t *sys_table_arg, unsigned long size,
 	      unsigned long addr);
-- 
2.20.1

