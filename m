Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D451142F42
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 17:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgATQIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 11:08:17 -0500
Received: from mga09.intel.com ([134.134.136.24]:19096 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbgATQIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 11:08:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2020 08:08:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,342,1574150400"; 
   d="scan'208";a="374357088"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 20 Jan 2020 08:08:13 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id F0BA52CB; Mon, 20 Jan 2020 18:08:12 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 3/9] x86/quirks: Introduce hpet_dev_print_force_hpet_address() helper
Date:   Mon, 20 Jan 2020 18:07:55 +0200
Message-Id: <20200120160801.53089-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200120160801.53089-1-andriy.shevchenko@linux.intel.com>
References: <20200120160801.53089-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce hpet_dev_print_force_hpet_address() helper to unify printing
forced HPET address. No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/kernel/quirks.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/quirks.c b/arch/x86/kernel/quirks.c
index 5b96654aacc0..ce8fc9bec43b 100644
--- a/arch/x86/kernel/quirks.c
+++ b/arch/x86/kernel/quirks.c
@@ -68,6 +68,11 @@ static enum {
 	ATI_FORCE_HPET_RESUME,
 } force_hpet_resume_type;
 
+static void hpet_dev_print_force_hpet_address(struct device *dev)
+{
+	dev_printk(KERN_DEBUG, dev, "Force enabled HPET at 0x%lx\n", force_hpet_address);
+}
+
 static void __iomem *rcba_base;
 
 static void ich_force_hpet_resume(void)
@@ -125,8 +130,7 @@ static void ich_force_enable_hpet(struct pci_dev *dev)
 		/* HPET is enabled in HPTC. Just not reported by BIOS */
 		val = val & 0x3;
 		force_hpet_address = 0xFED00000 | (val << 12);
-		dev_printk(KERN_DEBUG, &dev->dev, "Force enabled HPET at "
-			"0x%lx\n", force_hpet_address);
+		hpet_dev_print_force_hpet_address(&dev->dev);
 		iounmap(rcba_base);
 		return;
 	}
@@ -149,8 +153,7 @@ static void ich_force_enable_hpet(struct pci_dev *dev)
 			"Failed to force enable HPET\n");
 	} else {
 		force_hpet_resume_type = ICH_FORCE_HPET_RESUME;
-		dev_printk(KERN_DEBUG, &dev->dev, "Force enabled HPET at "
-			"0x%lx\n", force_hpet_address);
+		hpet_dev_print_force_hpet_address(&dev->dev);
 	}
 }
 
@@ -223,8 +226,7 @@ static void old_ich_force_enable_hpet(struct pci_dev *dev)
 	if (val & 0x4) {
 		val &= 0x3;
 		force_hpet_address = 0xFED00000 | (val << 12);
-		dev_printk(KERN_DEBUG, &dev->dev, "HPET at 0x%lx\n",
-			force_hpet_address);
+		hpet_dev_print_force_hpet_address(&dev->dev);
 		return;
 	}
 
@@ -244,8 +246,7 @@ static void old_ich_force_enable_hpet(struct pci_dev *dev)
 		/* HPET is enabled in HPTC. Just not reported by BIOS */
 		val &= 0x3;
 		force_hpet_address = 0xFED00000 | (val << 12);
-		dev_printk(KERN_DEBUG, &dev->dev, "Force enabled HPET at "
-			"0x%lx\n", force_hpet_address);
+		hpet_dev_print_force_hpet_address(&dev->dev);
 		cached_dev = dev;
 		force_hpet_resume_type = OLD_ICH_FORCE_HPET_RESUME;
 		return;
@@ -316,8 +317,7 @@ static void vt8237_force_enable_hpet(struct pci_dev *dev)
 	 */
 	if (val & 0x80) {
 		force_hpet_address = (val & ~0x3ff);
-		dev_printk(KERN_DEBUG, &dev->dev, "HPET at 0x%lx\n",
-			force_hpet_address);
+		hpet_dev_print_force_hpet_address(&dev->dev);
 		return;
 	}
 
@@ -331,8 +331,7 @@ static void vt8237_force_enable_hpet(struct pci_dev *dev)
 	pci_read_config_dword(dev, 0x68, &val);
 	if (val & 0x80) {
 		force_hpet_address = (val & ~0x3ff);
-		dev_printk(KERN_DEBUG, &dev->dev, "Force enabled HPET at "
-			"0x%lx\n", force_hpet_address);
+		hpet_dev_print_force_hpet_address(&dev->dev);
 		cached_dev = dev;
 		force_hpet_resume_type = VT8237_FORCE_HPET_RESUME;
 		return;
@@ -412,8 +411,7 @@ static void ati_force_enable_hpet(struct pci_dev *dev)
 
 	force_hpet_address = val;
 	force_hpet_resume_type = ATI_FORCE_HPET_RESUME;
-	dev_printk(KERN_DEBUG, &dev->dev, "Force enabled HPET at 0x%lx\n",
-		   force_hpet_address);
+	hpet_dev_print_force_hpet_address(&dev->dev);
 	cached_dev = dev;
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP400_SMBUS,
@@ -444,8 +442,7 @@ static void nvidia_force_enable_hpet(struct pci_dev *dev)
 	pci_read_config_dword(dev, 0x44, &val);
 	force_hpet_address = val & 0xfffffffe;
 	force_hpet_resume_type = NVIDIA_FORCE_HPET_RESUME;
-	dev_printk(KERN_DEBUG, &dev->dev, "Force enabled HPET at 0x%lx\n",
-		force_hpet_address);
+	hpet_dev_print_force_hpet_address(&dev->dev);
 	cached_dev = dev;
 }
 
@@ -509,8 +506,7 @@ static void e6xx_force_enable_hpet(struct pci_dev *dev)
 
 	force_hpet_address = 0xFED00000;
 	force_hpet_resume_type = NONE_FORCE_HPET_RESUME;
-	dev_printk(KERN_DEBUG, &dev->dev, "Force enabled HPET at "
-		"0x%lx\n", force_hpet_address);
+	hpet_dev_print_force_hpet_address(&dev->dev);
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_E6XX_CU,
 			 e6xx_force_enable_hpet);
-- 
2.24.1

