Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C736144133
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 17:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbgAUQBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 11:01:21 -0500
Received: from mga06.intel.com ([134.134.136.31]:53110 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729121AbgAUQBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 11:01:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 08:01:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,346,1574150400"; 
   d="scan'208";a="227374462"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 21 Jan 2020 08:01:15 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id DC9F63CF; Tue, 21 Jan 2020 18:01:14 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Brown <broonie@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 04/38] platform/x86: intel_scu_ipc: Remove Lincroft support
Date:   Tue, 21 Jan 2020 19:00:40 +0300
Message-Id: <20200121160114.60007-5-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200121160114.60007-1-mika.westerberg@linux.intel.com>
References: <20200121160114.60007-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moorestown support was removed years ago with by the commit 1a8359e411eb
("x86/mid: Remove Intel Moorestown"). Lincroft is the CPU side chip of
Moorestown and not supported anymore so remove the code from the driver.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel_scu_ipc.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index a8be5bcb9832..6c44fe5e55b5 100644
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -58,7 +58,6 @@
 #define IPC_RWBUF_SIZE    20		/* IPC Read buffer Size */
 #define IPC_IOC	          0x100		/* IPC command register IOC bit */
 
-#define PCI_DEVICE_ID_LINCROFT		0x082a
 #define PCI_DEVICE_ID_PENWELL		0x080e
 #define PCI_DEVICE_ID_CLOVERVIEW	0x08ea
 #define PCI_DEVICE_ID_TANGIER		0x11a0
@@ -70,12 +69,6 @@ struct intel_scu_ipc_pdata_t {
 	u8 irq_mode;
 };
 
-static const struct intel_scu_ipc_pdata_t intel_scu_ipc_lincroft_pdata = {
-	.i2c_base = 0xff12b000,
-	.i2c_len = 0x10,
-	.irq_mode = 0,
-};
-
 /* Penwell and Cloverview */
 static const struct intel_scu_ipc_pdata_t intel_scu_ipc_penwell_pdata = {
 	.i2c_base = 0xff12b000,
@@ -677,7 +670,6 @@ static int ipc_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 #define SCU_DEVICE(id, pdata)	{PCI_VDEVICE(INTEL, id), (kernel_ulong_t)&pdata}
 
 static const struct pci_device_id pci_ids[] = {
-	SCU_DEVICE(PCI_DEVICE_ID_LINCROFT,	intel_scu_ipc_lincroft_pdata),
 	SCU_DEVICE(PCI_DEVICE_ID_PENWELL,	intel_scu_ipc_penwell_pdata),
 	SCU_DEVICE(PCI_DEVICE_ID_CLOVERVIEW,	intel_scu_ipc_penwell_pdata),
 	SCU_DEVICE(PCI_DEVICE_ID_TANGIER,	intel_scu_ipc_tangier_pdata),
-- 
2.24.1

