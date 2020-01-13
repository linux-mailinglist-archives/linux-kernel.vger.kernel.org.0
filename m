Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7284E139174
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 13:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgAMM5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 07:57:33 -0500
Received: from mga02.intel.com ([134.134.136.20]:24747 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbgAMM5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 07:57:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2020 04:57:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,429,1571727600"; 
   d="scan'208";a="273021691"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Jan 2020 04:57:30 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EEE1A1AD; Mon, 13 Jan 2020 14:57:29 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] mfd: intel-lpss: Add Intel Comet Lake PCH-V PCI IDs
Date:   Mon, 13 Jan 2020 14:57:29 +0200
Message-Id: <20200113125729.8576-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel Comet Lake PCH-V has the same LPSS than Intel Kaby Lake.
Add the new IDs to the list of supported devices.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel-lpss-pci.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index c40a6c7d0cf8..378024a3ba28 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -347,6 +347,16 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0xa36a), (kernel_ulong_t)&cnl_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0xa36b), (kernel_ulong_t)&cnl_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0xa37b), (kernel_ulong_t)&spt_info },
+	/* CML-V */
+	{ PCI_VDEVICE(INTEL, 0xa3a7), (kernel_ulong_t)&spt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0xa3a8), (kernel_ulong_t)&spt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0xa3a9), (kernel_ulong_t)&spt_info },
+	{ PCI_VDEVICE(INTEL, 0xa3aa), (kernel_ulong_t)&spt_info },
+	{ PCI_VDEVICE(INTEL, 0xa3e0), (kernel_ulong_t)&spt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xa3e1), (kernel_ulong_t)&spt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xa3e2), (kernel_ulong_t)&spt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xa3e3), (kernel_ulong_t)&spt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xa3e6), (kernel_ulong_t)&spt_uart_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, intel_lpss_pci_ids);
-- 
2.24.1

