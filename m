Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAE5142F43
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 17:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbgATQIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 11:08:18 -0500
Received: from mga17.intel.com ([192.55.52.151]:23180 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729080AbgATQIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 11:08:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2020 08:08:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,342,1574150400"; 
   d="scan'208";a="215269714"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 20 Jan 2020 08:08:13 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 020C929B; Mon, 20 Jan 2020 18:08:13 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 4/9] x86/quirks: Join string literals back
Date:   Mon, 20 Jan 2020 18:07:56 +0200
Message-Id: <20200120160801.53089-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200120160801.53089-1-andriy.shevchenko@linux.intel.com>
References: <20200120160801.53089-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to split string literals. Moreover, it would be simpler
to grep for an actual code line, when debugging, by using almost any
part of the string literal in question.

No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/kernel/quirks.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/quirks.c b/arch/x86/kernel/quirks.c
index ce8fc9bec43b..6c122f35508a 100644
--- a/arch/x86/kernel/quirks.c
+++ b/arch/x86/kernel/quirks.c
@@ -36,8 +36,7 @@ static void quirk_intel_irqbalance(struct pci_dev *dev)
 	pci_bus_read_config_word(dev->bus, PCI_DEVFN(8, 0), 0x4c, &word);
 
 	if (!(word & (1 << 13))) {
-		dev_info(&dev->dev, "Intel E7520/7320/7525 detected; "
-			"disabling irq balancing and affinity\n");
+		dev_info(&dev->dev, "Intel E7520/7320/7525 detected; disabling irq balancing and affinity\n");
 		noirqdebug_setup("");
 #ifdef CONFIG_PROC_FS
 		no_irq_affinity = 1;
@@ -110,16 +109,14 @@ static void ich_force_enable_hpet(struct pci_dev *dev)
 	pci_read_config_dword(dev, 0xF0, &rcba);
 	rcba &= 0xFFFFC000;
 	if (rcba == 0) {
-		dev_printk(KERN_DEBUG, &dev->dev, "RCBA disabled; "
-			"cannot force enable HPET\n");
+		dev_printk(KERN_DEBUG, &dev->dev, "RCBA disabled; cannot force enable HPET\n");
 		return;
 	}
 
 	/* use bits 31:14, 16 kB aligned */
 	rcba_base = ioremap_nocache(rcba, 0x4000);
 	if (rcba_base == NULL) {
-		dev_printk(KERN_DEBUG, &dev->dev, "ioremap failed; "
-			"cannot force enable HPET\n");
+		dev_printk(KERN_DEBUG, &dev->dev, "ioremap failed; cannot force enable HPET\n");
 		return;
 	}
 
@@ -149,8 +146,7 @@ static void ich_force_enable_hpet(struct pci_dev *dev)
 	if (err) {
 		force_hpet_address = 0;
 		iounmap(rcba_base);
-		dev_printk(KERN_DEBUG, &dev->dev,
-			"Failed to force enable HPET\n");
+		dev_printk(KERN_DEBUG, &dev->dev, "Failed to force enable HPET\n");
 	} else {
 		force_hpet_resume_type = ICH_FORCE_HPET_RESUME;
 		hpet_dev_print_force_hpet_address(&dev->dev);
@@ -182,8 +178,7 @@ static struct pci_dev *cached_dev;
 
 static void hpet_print_force_info(void)
 {
-	printk(KERN_INFO "HPET not enabled in BIOS. "
-	       "You might try hpet=force boot option\n");
+	printk(KERN_INFO "HPET not enabled in BIOS. You might try hpet=force boot option\n");
 }
 
 static void old_ich_force_hpet_resume(void)
-- 
2.24.1

