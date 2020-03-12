Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAE9182B41
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 09:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgCLIel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 04:34:41 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36713 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgCLIel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 04:34:41 -0400
Received: by mail-pl1-f194.google.com with SMTP id g12so2383252plo.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 01:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o8tWeCypuK1QOsKNJkPWjnl6zp71Q9i3fpD2i8Bk47I=;
        b=kDMvA2exUIdT1c6vkox/9tshpEUaxfe3peeGwW7N3j+NMe16liNfQTD5oL8HlYFePF
         fzgSMWlcsMGtkzxAaHHGs3bT7k1uvXaS6W69RUIvuuBSeDOWfWwPckHvclvaedExsmUB
         GWhXUjbK+qA6KG4n0sQ+S3jSTMF4Wi1KmU926yp6f0E1PzTfnjk5tSzoIuPXApsHTCWn
         oH0JB3DMFc99MinbXtpjMken/HnHg6SN8VX3UHCKnvP8qllUGoW+BdogB4XwEgWtsCLw
         zFKgGyuX776BjcJNU3GDxj0vwBdZ5rzwyGeB/tMtVLVEJebgGBi0tWggi8NrAWdeeR/q
         4lKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o8tWeCypuK1QOsKNJkPWjnl6zp71Q9i3fpD2i8Bk47I=;
        b=sPAGdTr/AcFvrJ8uLzgF6Pr9kxoGMuw1D84VPO08k61VIiaq1Og+CTTcuyr7c+72td
         GWHCXZkDoYxv6kNHrsH6Gt8N980sHnXmLcVebwk2T34NTvp7EbZGx+7Ksu7L+HIHnTmq
         5cqA/ulIpBrxoLeyrpfxtTBvQ0aNV4XiG3FMZTT0xGfs7dEVdVS1q6SpxBTPeKZ1iJCI
         zmRiB8JOe+048KC2Uy7HrZZs4FWbr45WmHf83EVl0nULA8JIL7oOetzP2l3aA3rdejD8
         z2ezjBpUGU8i3sOQ4AYQCw9B1vYGR9oV7CfM5SM0CPmBx1gnLG8MNTCKyD7ZkROyMiR5
         YNnw==
X-Gm-Message-State: ANhLgQ3Y1a8EqQ197rdsv69Jij2wgJi7bu41VlE4uPAAc+7dGm/34Jpu
        bpT79vMhKJzALdCta3XLnoslVw==
X-Google-Smtp-Source: ADFU+vvspHbr8K5oFPO6UNLDH5awu771Qxb0TRck99UbEb+J2KJblpIGzDwr0ExCYH8hcE0po0F1lA==
X-Received: by 2002:a17:90b:1904:: with SMTP id mp4mr3126972pjb.110.1584002080097;
        Thu, 12 Mar 2020 01:34:40 -0700 (PDT)
Received: from starnight.local ([150.116.255.181])
        by smtp.googlemail.com with ESMTPSA id s13sm8163947pjp.1.2020.03.12.01.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 01:34:39 -0700 (PDT)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux@endlessm.com,
        Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH] Revert "x86/reboot, efi: Use EFI reboot for Acer TravelMate X514-51T"
Date:   Thu, 12 Mar 2020 16:33:42 +0800
Message-Id: <20200312083341.9365-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 0082517fa4bce073e7cf542633439f26538a14cc.

According to Acer's information, this reboot issue is fixed since 1.08
and newer BIOS. So, we can revert the quirk.

Fixes: 0082517fa4bc ("x86/reboot, efi: Use EFI reboot for Acer TravelMate X514-51T")
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
 arch/x86/kernel/reboot.c | 21 ---------------------
 include/linux/efi.h      |  7 +------
 2 files changed, 1 insertion(+), 27 deletions(-)

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 0cc7c0b106bb..92177ccd47f3 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -81,19 +81,6 @@ static int __init set_bios_reboot(const struct dmi_system_id *d)
 	return 0;
 }
 
-/*
- * Some machines don't handle the default ACPI reboot method and
- * require the EFI reboot method:
- */
-static int __init set_efi_reboot(const struct dmi_system_id *d)
-{
-	if (reboot_type != BOOT_EFI && !efi_runtime_disabled()) {
-		reboot_type = BOOT_EFI;
-		pr_info("%s series board detected. Selecting EFI-method for reboot.\n", d->ident);
-	}
-	return 0;
-}
-
 void __noreturn machine_real_restart(unsigned int type)
 {
 	local_irq_disable();
@@ -179,14 +166,6 @@ static const struct dmi_system_id reboot_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "AOA110"),
 		},
 	},
-	{	/* Handle reboot issue on Acer TravelMate X514-51T */
-		.callback = set_efi_reboot,
-		.ident = "Acer TravelMate X514-51T",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate X514-51T"),
-		},
-	},
 
 	/* Apple */
 	{	/* Handle problems with rebooting on Apple MacBook5 */
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 7efd7072cca5..8375bbc6e739 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1529,12 +1529,7 @@ efi_status_t efi_parse_options(char const *cmdline);
 efi_status_t efi_setup_gop(struct screen_info *si, efi_guid_t *proto,
 			   unsigned long size);
 
-#ifdef CONFIG_EFI
-extern bool efi_runtime_disabled(void);
-#else
-static inline bool efi_runtime_disabled(void) { return true; }
-#endif
-
+bool efi_runtime_disabled(void);
 extern void efi_call_virt_check_flags(unsigned long flags, const char *call);
 extern unsigned long efi_call_virt_save_flags(void);
 
-- 
2.25.1

