Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 758A67DC88
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 15:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731294AbfHAN2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 09:28:44 -0400
Received: from mga03.intel.com ([134.134.136.65]:57204 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728578AbfHAN2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 09:28:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2019 06:28:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,334,1559545200"; 
   d="scan'208";a="256646724"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 01 Aug 2019 06:28:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D249EFF; Thu,  1 Aug 2019 16:28:41 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] mfd: intel-lpss: Add Intel Tiger Lake PCI IDs
Date:   Thu,  1 Aug 2019 16:28:41 +0300
Message-Id: <20190801132841.71645-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel Tiger Lake has the same LPSS than Intel Broxton.
Add the new IDs to the list of supported devices.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel-lpss-pci.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index e3a04929aaa3..9355db29d2f9 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -258,6 +258,29 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x9dea), (kernel_ulong_t)&cnl_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x9deb), (kernel_ulong_t)&cnl_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x9dfb), (kernel_ulong_t)&spt_info },
+	/* TGL-LP */
+	{ PCI_VDEVICE(INTEL, 0xa0a8), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0xa0a9), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0xa0aa), (kernel_ulong_t)&spt_info },
+	{ PCI_VDEVICE(INTEL, 0xa0ab), (kernel_ulong_t)&spt_info },
+	{ PCI_VDEVICE(INTEL, 0xa0c5), (kernel_ulong_t)&spt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xa0c6), (kernel_ulong_t)&spt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xa0c7), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0xa0d8), (kernel_ulong_t)&spt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xa0d9), (kernel_ulong_t)&spt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xa0da), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0xa0db), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0xa0dc), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0xa0dd), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0xa0de), (kernel_ulong_t)&spt_info },
+	{ PCI_VDEVICE(INTEL, 0xa0df), (kernel_ulong_t)&spt_info },
+	{ PCI_VDEVICE(INTEL, 0xa0e8), (kernel_ulong_t)&spt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xa0e9), (kernel_ulong_t)&spt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xa0ea), (kernel_ulong_t)&spt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xa0eb), (kernel_ulong_t)&spt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xa0fb), (kernel_ulong_t)&spt_info },
+	{ PCI_VDEVICE(INTEL, 0xa0fd), (kernel_ulong_t)&spt_info },
+	{ PCI_VDEVICE(INTEL, 0xa0fe), (kernel_ulong_t)&spt_info },
 	/* SPT-H */
 	{ PCI_VDEVICE(INTEL, 0xa127), (kernel_ulong_t)&spt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0xa128), (kernel_ulong_t)&spt_uart_info },
-- 
2.20.1

