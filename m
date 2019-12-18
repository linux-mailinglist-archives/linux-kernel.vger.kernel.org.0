Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A346D1253AB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 21:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbfLRUkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 15:40:46 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34627 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727732AbfLRUkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:40:18 -0500
Received: by mail-qt1-f196.google.com with SMTP id 5so3068408qtz.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 12:40:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qJEYKRpdvOZyP9yUq3qQQyurrO0vRRGI/xgoq8mO4Fo=;
        b=ijsN4WZ9sVFl9IbjDk1hZEUUwy+rjDGjG+eG1WO0EXjoyAuOliax2H5S2GBOtY4z4e
         oYpiVYJ1M/aHCfL24SmustjIdi7R+d+3IZ7cI4CvPC+Pzo8nx75HRmxTyrq1YX8RLjCQ
         PoQqgtqb1Cq4Sd/eDWgHk72PGjnGECXWZgb5QJNU0/eRlylqkx8L3MVNZzxtcRFDoyuZ
         5t+PZIJUASFRLKzxOuF75SFMBGb8ROjs9+RBBQJcFngQ2CytX8C5FoYD+n3HYUMOgctO
         jBkzlCitrA8qEr2Bs13kE5VcmcrT9Jvo4p8zvFU7dKygAwmUtEFD3OBDXZsHrWy75Nuu
         71ew==
X-Gm-Message-State: APjAAAW4RnM2aQIvrTdm64b1kXXohJNd6ocBP7E+Ysfq1XZ54U2UoSIV
        VatOq1rKIK9gYGdWIxrembE=
X-Google-Smtp-Source: APXvYqyK/njr9tZKbcw1O6rUQcrgICPrWxDEUAroRavC5z7X+KWN/b8cGRAL9bNyggM6rTUPi0Y3bw==
X-Received: by 2002:ac8:2a06:: with SMTP id k6mr4058455qtk.145.1576701617485;
        Wed, 18 Dec 2019 12:40:17 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t7sm993347qkm.136.2019.12.18.12.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 12:40:16 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 17/24] arch/setup: Drop dummy_con initialization
Date:   Wed, 18 Dec 2019 15:39:55 -0500
Message-Id: <20191218204002.30512-18-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218204002.30512-1-nivedita@alum.mit.edu>
References: <20191218204002.30512-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

con_init in tty/vt.c will now set conswitchp to dummy_con if it's unset.
Drop it from arch setup code.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/powerpc/kernel/setup-common.c    | 3 ---
 arch/powerpc/platforms/cell/setup.c   | 3 ---
 arch/powerpc/platforms/maple/setup.c  | 3 ---
 arch/powerpc/platforms/pasemi/setup.c | 4 ----
 arch/powerpc/platforms/ps3/setup.c    | 4 ----
 5 files changed, 17 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 488f1eecc0de..7f8c890360fe 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -949,9 +949,6 @@ void __init setup_arch(char **cmdline_p)
 
 	early_memtest(min_low_pfn << PAGE_SHIFT, max_low_pfn << PAGE_SHIFT);
 
-	if (IS_ENABLED(CONFIG_DUMMY_CONSOLE))
-		conswitchp = &dummy_con;
-
 	if (ppc_md.setup_arch)
 		ppc_md.setup_arch();
 
diff --git a/arch/powerpc/platforms/cell/setup.c b/arch/powerpc/platforms/cell/setup.c
index 9680d766f20e..855eedb8d7d7 100644
--- a/arch/powerpc/platforms/cell/setup.c
+++ b/arch/powerpc/platforms/cell/setup.c
@@ -240,9 +240,6 @@ static void __init cell_setup_arch(void)
 	init_pci_config_tokens();
 
 	cbe_pervasive_init();
-#ifdef CONFIG_DUMMY_CONSOLE
-	conswitchp = &dummy_con;
-#endif
 
 	mmio_nvram_init();
 }
diff --git a/arch/powerpc/platforms/maple/setup.c b/arch/powerpc/platforms/maple/setup.c
index 9cd6f3e1000b..47f73103ef74 100644
--- a/arch/powerpc/platforms/maple/setup.c
+++ b/arch/powerpc/platforms/maple/setup.c
@@ -183,9 +183,6 @@ static void __init maple_setup_arch(void)
 	/* Lookup PCI hosts */
        	maple_pci_init();
 
-#ifdef CONFIG_DUMMY_CONSOLE
-	conswitchp = &dummy_con;
-#endif
 	maple_use_rtas_reboot_and_halt_if_present();
 
 	printk(KERN_DEBUG "Using native/NAP idle loop\n");
diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index 05a52f10c2f0..b612474f8f8e 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -147,10 +147,6 @@ static void __init pas_setup_arch(void)
 	/* Lookup PCI hosts */
 	pas_pci_init();
 
-#ifdef CONFIG_DUMMY_CONSOLE
-	conswitchp = &dummy_con;
-#endif
-
 	/* Remap SDC register for doing reset */
 	/* XXXOJN This should maybe come out of the device tree */
 	reset_reg = ioremap(0xfc101100, 4);
diff --git a/arch/powerpc/platforms/ps3/setup.c b/arch/powerpc/platforms/ps3/setup.c
index 8108b9b9b9ea..b29368931c56 100644
--- a/arch/powerpc/platforms/ps3/setup.c
+++ b/arch/powerpc/platforms/ps3/setup.c
@@ -200,10 +200,6 @@ static void __init ps3_setup_arch(void)
 	smp_init_ps3();
 #endif
 
-#ifdef CONFIG_DUMMY_CONSOLE
-	conswitchp = &dummy_con;
-#endif
-
 	prealloc_ps3fb_videomemory();
 	prealloc_ps3flash_bounce_buffer();
 
-- 
2.24.1

