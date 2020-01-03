Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E403F12F778
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 12:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgACLkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jan 2020 06:40:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:40248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727824AbgACLkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 06:40:39 -0500
Received: from localhost.localdomain (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0802722314;
        Fri,  3 Jan 2020 11:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578051638;
        bh=30LNcCXGrHbjed7nFrjq4dhg8qri5X+a1jEAPmmUuXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MFyCZ4tAexrywQvB989HwzlZlynIG0kaQPjSIm2W+U4XQHnfALOo+lY6BSFoVukce
         PojaAFcBXrODj+PX/Islw+JP74BCppTc1vN1W4URFRqEULOjE2yQ9zFni2ZvrkKfFU
         Cau/GbfAD9b+YmlZEYVlBs/vt8xO6bFI76OdPXO8=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Matthew Garrett <mjg59@google.com>
Subject: [PATCH 11/20] efi/x86: drop two near identical versions of efi_runtime_init()
Date:   Fri,  3 Jan 2020 12:39:44 +0100
Message-Id: <20200103113953.9571-12-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200103113953.9571-1-ardb@kernel.org>
References: <20200103113953.9571-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The routines efi_runtime_init32() and efi_runtime_init64() are
almost indistinguishable, and the only relevant difference is
the offset in the runtime struct from where to obtain the physical
address of the SetVirtualAddressMap() routine.

However, this address is only used once, when installing the virtual
address map that the OS will use to invoke EFI runtime services, and
at the time of the call, we will necessarily be running with a 1:1
mapping, and so there is no need to do the map/unmap dance here to
retrieve the address. In fact, in the preceding changes to these users,
we stopped using the address recorded here entirely.

So let's just get rid of all this code since it no longer serves a
purpose. While at it, tweak the logic so that we handle unsupported
and disable EFI runtime services in the same way, and unmap the EFI
memory map in both cases.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/efi/efi.c | 95 ++-----------------------------------
 include/linux/efi.h         | 19 --------
 2 files changed, 5 insertions(+), 109 deletions(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index e4d3afac7be3..67cb0fd18777 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -429,87 +429,6 @@ static int __init efi_systab_init(void *phys)
 	return 0;
 }
 
-static int __init efi_runtime_init32(void)
-{
-	efi_runtime_services_32_t *runtime;
-
-	runtime = early_memremap((unsigned long)efi.systab->runtime,
-			sizeof(efi_runtime_services_32_t));
-	if (!runtime) {
-		pr_err("Could not map the runtime service table!\n");
-		return -ENOMEM;
-	}
-
-	/*
-	 * We will only need *early* access to the SetVirtualAddressMap
-	 * EFI runtime service. All other runtime services will be called
-	 * via the virtual mapping.
-	 */
-	efi_phys.set_virtual_address_map =
-			(efi_set_virtual_address_map_t *)
-			(unsigned long)runtime->set_virtual_address_map;
-	early_memunmap(runtime, sizeof(efi_runtime_services_32_t));
-
-	return 0;
-}
-
-static int __init efi_runtime_init64(void)
-{
-	efi_runtime_services_64_t *runtime;
-
-	runtime = early_memremap((unsigned long)efi.systab->runtime,
-			sizeof(efi_runtime_services_64_t));
-	if (!runtime) {
-		pr_err("Could not map the runtime service table!\n");
-		return -ENOMEM;
-	}
-
-	/*
-	 * We will only need *early* access to the SetVirtualAddressMap
-	 * EFI runtime service. All other runtime services will be called
-	 * via the virtual mapping.
-	 */
-	efi_phys.set_virtual_address_map =
-			(efi_set_virtual_address_map_t *)
-			(unsigned long)runtime->set_virtual_address_map;
-	early_memunmap(runtime, sizeof(efi_runtime_services_64_t));
-
-	return 0;
-}
-
-static int __init efi_runtime_init(void)
-{
-	int rv;
-
-	/*
-	 * Check out the runtime services table. We need to map
-	 * the runtime services table so that we can grab the physical
-	 * address of several of the EFI runtime functions, needed to
-	 * set the firmware into virtual mode.
-	 *
-	 * When EFI_PARAVIRT is in force then we could not map runtime
-	 * service memory region because we do not have direct access to it.
-	 * However, runtime services are available through proxy functions
-	 * (e.g. in case of Xen dom0 EFI implementation they call special
-	 * hypercall which executes relevant EFI functions) and that is why
-	 * they are always enabled.
-	 */
-
-	if (!efi_enabled(EFI_PARAVIRT)) {
-		if (efi_enabled(EFI_64BIT))
-			rv = efi_runtime_init64();
-		else
-			rv = efi_runtime_init32();
-
-		if (rv)
-			return rv;
-	}
-
-	set_bit(EFI_RUNTIME_SERVICES, &efi.flags);
-
-	return 0;
-}
-
 void __init efi_init(void)
 {
 	efi_char16_t *c16;
@@ -567,13 +486,13 @@ void __init efi_init(void)
 
 	if (!efi_runtime_supported())
 		pr_info("No EFI runtime due to 32/64-bit mismatch with kernel\n");
-	else {
-		if (efi_runtime_disabled() || efi_runtime_init()) {
-			efi_memmap_unmap();
-			return;
-		}
+
+	if (!efi_runtime_supported() || efi_runtime_disabled()) {
+		efi_memmap_unmap();
+		return;
 	}
 
+	set_bit(EFI_RUNTIME_SERVICES, &efi.flags);
 	efi_clean_memmap();
 
 	if (efi_enabled(EFI_DBG))
@@ -934,8 +853,6 @@ static void __init kexec_enter_virtual_mode(void)
 
 	efi_native_runtime_setup();
 
-	efi.set_virtual_address_map = NULL;
-
 	if (efi_enabled(EFI_OLD_MEMMAP) && (__supported_pte_mask & _PAGE_NX))
 		runtime_code_page_mkexec();
 #endif
@@ -1040,8 +957,6 @@ static void __init __efi_enter_virtual_mode(void)
 	else
 		efi_thunk_runtime_setup();
 
-	efi.set_virtual_address_map = NULL;
-
 	/*
 	 * Apply more restrictive page table mapping attributes now that
 	 * SVAM() has been called and the firmware has performed all
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 952c1659dfd9..ee68ea6f85ff 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -539,24 +539,6 @@ typedef struct {
 	u32 query_variable_info;
 } efi_runtime_services_32_t;
 
-typedef struct {
-	efi_table_hdr_t hdr;
-	u64 get_time;
-	u64 set_time;
-	u64 get_wakeup_time;
-	u64 set_wakeup_time;
-	u64 set_virtual_address_map;
-	u64 convert_pointer;
-	u64 get_variable;
-	u64 get_next_variable;
-	u64 set_variable;
-	u64 get_next_high_mono_count;
-	u64 reset_system;
-	u64 update_capsule;
-	u64 query_capsule_caps;
-	u64 query_variable_info;
-} efi_runtime_services_64_t;
-
 typedef efi_status_t efi_get_time_t (efi_time_t *tm, efi_time_cap_t *tc);
 typedef efi_status_t efi_set_time_t (efi_time_t *tm);
 typedef efi_status_t efi_get_wakeup_time_t (efi_bool_t *enabled, efi_bool_t *pending,
@@ -946,7 +928,6 @@ extern struct efi {
 	efi_query_capsule_caps_t *query_capsule_caps;
 	efi_get_next_high_mono_count_t *get_next_high_mono_count;
 	efi_reset_system_t *reset_system;
-	efi_set_virtual_address_map_t *set_virtual_address_map;
 	struct efi_memory_map memmap;
 	unsigned long flags;
 } efi;
-- 
2.20.1

