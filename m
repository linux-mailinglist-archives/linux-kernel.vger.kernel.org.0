Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8976FE36
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 18:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfD3Q4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 12:56:30 -0400
Received: from mga02.intel.com ([134.134.136.20]:16164 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfD3Q43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 12:56:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Apr 2019 09:56:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,414,1549958400"; 
   d="scan'208";a="169352293"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 30 Apr 2019 09:56:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A9B8E11F; Tue, 30 Apr 2019 19:56:26 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Evan Green <evgreen@chromium.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] mfd: intel-lpss: Add Intel Comet Lake PCI IDs
Date:   Tue, 30 Apr 2019 19:56:26 +0300
Message-Id: <20190430165626.31639-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel Comet Lake has the same LPSS than Intel Cannon Lake.
Add the new IDs to the list of supported devices.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
- update i2c info
 drivers/mfd/intel-lpss-pci.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index a67f67c90ec4..417569482481 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -129,6 +129,19 @@ static const struct intel_lpss_platform_info cnl_i2c_info = {
 };
 
 static const struct pci_device_id intel_lpss_pci_ids[] = {
+	/* CML */
+	{ PCI_VDEVICE(INTEL, 0x02a8), (kernel_ulong_t)&spt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x02a9), (kernel_ulong_t)&spt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x02aa), (kernel_ulong_t)&spt_info },
+	{ PCI_VDEVICE(INTEL, 0x02ab), (kernel_ulong_t)&spt_info },
+	{ PCI_VDEVICE(INTEL, 0x02c5), (kernel_ulong_t)&cnl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x02c6), (kernel_ulong_t)&cnl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x02c7), (kernel_ulong_t)&spt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x02e8), (kernel_ulong_t)&cnl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x02e9), (kernel_ulong_t)&cnl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x02ea), (kernel_ulong_t)&cnl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x02eb), (kernel_ulong_t)&cnl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x02fb), (kernel_ulong_t)&spt_info },
 	/* BXT A-Step */
 	{ PCI_VDEVICE(INTEL, 0x0aac), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x0aae), (kernel_ulong_t)&bxt_i2c_info },
-- 
2.20.1

