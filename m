Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C116144170
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 17:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729951AbgAUQDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 11:03:06 -0500
Received: from mga12.intel.com ([192.55.52.136]:22455 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729137AbgAUQBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 11:01:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 08:01:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,346,1574150400"; 
   d="scan'208";a="215582450"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 21 Jan 2020 08:01:15 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id D3A9834C; Tue, 21 Jan 2020 18:01:14 +0200 (EET)
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
Subject: [PATCH v4 03/38] platform/x86: intel_scu_ipc: Add constants for register offsets
Date:   Tue, 21 Jan 2020 19:00:39 +0300
Message-Id: <20200121160114.60007-4-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200121160114.60007-1-mika.westerberg@linux.intel.com>
References: <20200121160114.60007-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes the code more readable. These are taken from intel_pmc_ipc.c
which implements the same thing.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel_scu_ipc.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index cdab916fbf92..a8be5bcb9832 100644
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -99,11 +99,15 @@ struct intel_scu_ipc_dev {
 
 static struct intel_scu_ipc_dev  ipcdev; /* Only one for now */
 
+#define IPC_STATUS		0x04
+#define IPC_STATUS_ERR		BIT(1)
+#define IPC_STATUS_BUSY		BIT(0)
+
 /*
- * IPC Read Buffer (Read Only):
- * 16 byte buffer for receiving data from SCU, if IPC command
- * processing results in response data
+ * IPC Write/Read Buffers:
+ * 16 byte buffer for sending and receiving data to and from SCU.
  */
+#define IPC_WRITE_BUFFER	0x80
 #define IPC_READ_BUFFER		0x90
 
 #define IPC_I2C_CNTRL_ADDR	0
@@ -135,7 +139,7 @@ static inline void ipc_command(struct intel_scu_ipc_dev *scu, u32 cmd)
  */
 static inline void ipc_data_writel(struct intel_scu_ipc_dev *scu, u32 data, u32 offset)
 {
-	writel(data, scu->ipc_base + 0x80 + offset);
+	writel(data, scu->ipc_base + IPC_WRITE_BUFFER + offset);
 }
 
 /*
@@ -147,7 +151,7 @@ static inline void ipc_data_writel(struct intel_scu_ipc_dev *scu, u32 data, u32
  */
 static inline u8 ipc_read_status(struct intel_scu_ipc_dev *scu)
 {
-	return __raw_readl(scu->ipc_base + 0x04);
+	return __raw_readl(scu->ipc_base + IPC_STATUS);
 }
 
 /* Read ipc byte data */
@@ -169,17 +173,17 @@ static inline int busy_loop(struct intel_scu_ipc_dev *scu)
 	u32 loop_count = 100000;
 
 	/* break if scu doesn't reset busy bit after huge retry */
-	while ((status & BIT(0)) && --loop_count) {
+	while ((status & IPC_STATUS_BUSY) && --loop_count) {
 		udelay(1); /* scu processing time is in few u secods */
 		status = ipc_read_status(scu);
 	}
 
-	if (status & BIT(0)) {
+	if (status & IPC_STATUS_BUSY) {
 		dev_err(scu->dev, "IPC timed out");
 		return -ETIMEDOUT;
 	}
 
-	if (status & BIT(1))
+	if (status & IPC_STATUS_ERR)
 		return -EIO;
 
 	return 0;
@@ -196,7 +200,7 @@ static inline int ipc_wait_for_interrupt(struct intel_scu_ipc_dev *scu)
 	}
 
 	status = ipc_read_status(scu);
-	if (status & BIT(1))
+	if (status & IPC_STATUS_ERR)
 		return -EIO;
 
 	return 0;
-- 
2.24.1

