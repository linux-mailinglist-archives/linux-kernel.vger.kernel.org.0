Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF95E12F78B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 12:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgACLlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jan 2020 06:41:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:40418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727841AbgACLkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 06:40:43 -0500
Received: from localhost.localdomain (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 269892464B;
        Fri,  3 Jan 2020 11:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578051642;
        bh=Hc6UcQ9UpT/kVsHpfR+qryCfdpE3qLzn7SldrCucIX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ii790vAP0OPeIIlLjwcHHtH/Ks7PQ+Dtw3t1mC4olvTHfFIGuQk++kQWf5SDFCCfn
         iWmGrQWDHkC+CTqCo8p9hJPSPKZBZz8vigTRj8T3JQu2mfMBy1aC5Y2veux74cl9j1
         WGdwYSGVSxkfHU/1PMgBEPCF6kx7e+QknpY6Vahw=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Matthew Garrett <mjg59@google.com>
Subject: [PATCH 13/20] efi/x86: don't panic or BUG() on non-critical error conditions
Date:   Fri,  3 Jan 2020 12:39:46 +0100
Message-Id: <20200103113953.9571-14-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200103113953.9571-1-ardb@kernel.org>
References: <20200103113953.9571-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The logic in __efi_enter_virtual_mode() does a number of steps in
sequence, all of which may fail in one way or the other. In most
cases, we simply print an error and disable EFI runtime services
support, but in some cases, we BUG() or panic() and bring down the
system when encountering conditions that we could easily handle in
the same way.

While at it, replace a pointless page-to-virt-phys conversion with
one that goes straight from struct page to physical.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/efi/efi.c    | 28 ++++++++++++++--------------
 arch/x86/platform/efi/efi_64.c |  9 +++++----
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 53ed0b123641..4f539bfdc051 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -889,16 +889,14 @@ static void __init __efi_enter_virtual_mode(void)
 
 	if (efi_alloc_page_tables()) {
 		pr_err("Failed to allocate EFI page tables\n");
-		clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
-		return;
+		goto err;
 	}
 
 	efi_merge_regions();
 	new_memmap = efi_map_regions(&count, &pg_shift);
 	if (!new_memmap) {
 		pr_err("Error reallocating memory, EFI runtime non-functional!\n");
-		clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
-		return;
+		goto err;
 	}
 
 	pa = __pa(new_memmap);
@@ -912,8 +910,7 @@ static void __init __efi_enter_virtual_mode(void)
 
 	if (efi_memmap_init_late(pa, efi.memmap.desc_size * count)) {
 		pr_err("Failed to remap late EFI memory map\n");
-		clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
-		return;
+		goto err;
 	}
 
 	if (efi_enabled(EFI_DBG)) {
@@ -921,12 +918,11 @@ static void __init __efi_enter_virtual_mode(void)
 		efi_print_memmap();
 	}
 
-	BUG_ON(!efi.systab);
+	if (WARN_ON(!efi.systab))
+		goto err;
 
-	if (efi_setup_page_tables(pa, 1 << pg_shift)) {
-		clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
-		return;
-	}
+	if (efi_setup_page_tables(pa, 1 << pg_shift))
+		goto err;
 
 	efi_sync_low_kernel_mappings();
 
@@ -935,9 +931,9 @@ static void __init __efi_enter_virtual_mode(void)
 					     efi.memmap.desc_version,
 					     (efi_memory_desc_t *)pa);
 	if (status != EFI_SUCCESS) {
-		pr_alert("Unable to switch EFI into virtual mode (status=%lx)!\n",
-			 status);
-		panic("EFI call to SetVirtualAddressMap() failed!");
+		pr_err("Unable to switch EFI into virtual mode (status=%lx)!\n",
+		       status);
+		goto err;
 	}
 
 	efi_free_boot_services();
@@ -964,6 +960,10 @@ static void __init __efi_enter_virtual_mode(void)
 
 	/* clean DUMMY object */
 	efi_delete_dummy_variable();
+	return;
+
+err:
+	clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
 }
 
 void __init efi_enter_virtual_mode(void)
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 910e9ec03b09..c13fa2150976 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -384,11 +384,12 @@ int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages)
 		return 0;
 
 	page = alloc_page(GFP_KERNEL|__GFP_DMA32);
-	if (!page)
-		panic("Unable to allocate EFI runtime stack < 4GB\n");
+	if (!page) {
+		pr_err("Unable to allocate EFI runtime stack < 4GB\n");
+		return 1;
+	}
 
-	efi_scratch.phys_stack = virt_to_phys(page_address(page));
-	efi_scratch.phys_stack += PAGE_SIZE; /* stack grows down */
+	efi_scratch.phys_stack = page_to_phys(page + 1); /* stack grows down */
 
 	npages = (_etext - _text) >> PAGE_SHIFT;
 	text = __pa(_text);
-- 
2.20.1

