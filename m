Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F234E1155DF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2019 17:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfLFQ4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Dec 2019 11:56:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:51084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbfLFQ4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 11:56:13 -0500
Received: from e123331-lin.cambridge.arm.com (fw-tnat-cam5.arm.com [217.140.106.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBF9F2467A;
        Fri,  6 Dec 2019 16:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575651372;
        bh=0ld8kOcqM2caAQmvxEjgIeog81bSQ16/K/Tq37PU/jo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gglp4JVZGh2D5cfyD7bbOIs6Mep/zrT2e6HnT8sFKc6Lo1vi2JKSUbmU8itEVUQj/
         7Qvi9sxY2y4crf4paa9+7rLhQWosVXveVmD7ASuHOtMnHLR7ulsdffk9DCfAZYNWtZ
         tU4IrG7+tXSnJIDQjB80UzeMWSckYGtsX1dA+2n4=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: [PATCH 6/6] efi/earlycon: Remap entire framebuffer after page initialization
Date:   Fri,  6 Dec 2019 16:55:42 +0000
Message-Id: <20191206165542.31469-7-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191206165542.31469-1-ardb@kernel.org>
References: <20191206165542.31469-1-ardb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

When commit 69c1f396f25b

  "efi/x86: Convert x86 EFI earlyprintk into generic earlycon implementation"

moved the x86 specific EFI earlyprintk implementation to a shared location,
it also tweaked the behaviour. In particular, it dropped a trick with full
framebuffer remapping after page initialization, leading to two regressions:
1) very slow scrolling after page initialization,
2) kernel hang when the 'keep_bootcon' command line argument is passed.

Putting the tweak back fixes #2 and mitigates #1, i.e., it limits the slow
behavior to the early boot stages, presumably due to eliminating heavy
map()/unmap() operations per each pixel line on the screen.

Fixes: 69c1f396f25b ("efi/x86: Convert x86 EFI earlyprintk into generic earlycon implementation")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
[ardb: ensure efifb is unmapped again unless keep_bootcon is in effect]
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/earlycon.c | 40 +++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/firmware/efi/earlycon.c b/drivers/firmware/efi/earlycon.c
index c9a0efca17b0..0bc4fe741415 100644
--- a/drivers/firmware/efi/earlycon.c
+++ b/drivers/firmware/efi/earlycon.c
@@ -13,18 +13,57 @@
 
 #include <asm/early_ioremap.h>
 
+static const struct console *earlycon_console __initdata;
 static const struct font_desc *font;
 static u32 efi_x, efi_y;
 static u64 fb_base;
 static pgprot_t fb_prot;
+static void *efi_fb;
+
+/*
+ * efi earlycon needs to use early_memremap() to map the framebuffer.
+ * But early_memremap() is not usable for 'earlycon=efifb keep_bootcon',
+ * memremap() should be used instead. memremap() will be available after
+ * paging_init() which is earlier than initcall callbacks. Thus adding this
+ * early initcall function early_efi_map_fb() to map the whole efi framebuffer.
+ */
+static int __init efi_earlycon_remap_fb(void)
+{
+	/* bail if there is no bootconsole or it has been disabled already */
+	if (!earlycon_console || !(earlycon_console->flags & CON_ENABLED))
+		return 0;
+
+	if (pgprot_val(fb_prot) == pgprot_val(PAGE_KERNEL))
+		efi_fb = memremap(fb_base, screen_info.lfb_size, MEMREMAP_WB);
+	else
+		efi_fb = memremap(fb_base, screen_info.lfb_size, MEMREMAP_WC);
+
+	return efi_fb ? 0 : -ENOMEM;
+}
+early_initcall(efi_earlycon_remap_fb);
+
+static int __init efi_earlycon_unmap_fb(void)
+{
+	/* unmap the bootconsole fb unless keep_bootcon has left it enabled */
+	if (efi_fb && !(earlycon_console->flags & CON_ENABLED))
+		memunmap(efi_fb);
+	return 0;
+}
+late_initcall(efi_earlycon_unmap_fb);
 
 static __ref void *efi_earlycon_map(unsigned long start, unsigned long len)
 {
+	if (efi_fb)
+		return efi_fb + start;
+
 	return early_memremap_prot(fb_base + start, len, pgprot_val(fb_prot));
 }
 
 static __ref void efi_earlycon_unmap(void *addr, unsigned long len)
 {
+	if (efi_fb)
+		return;
+
 	early_memunmap(addr, len);
 }
 
@@ -201,6 +240,7 @@ static int __init efi_earlycon_setup(struct earlycon_device *device,
 		efi_earlycon_scroll_up();
 
 	device->con->write = efi_earlycon_write;
+	earlycon_console = device->con;
 	return 0;
 }
 EARLYCON_DECLARE(efifb, efi_earlycon_setup);
-- 
2.17.1

