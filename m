Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40B291392E0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 14:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbgAMN6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 08:58:37 -0500
Received: from mga06.intel.com ([134.134.136.31]:7007 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728880AbgAMN4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 08:56:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2020 05:56:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,429,1571727600"; 
   d="scan'208";a="218671192"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 13 Jan 2020 05:56:29 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 575204BE; Mon, 13 Jan 2020 15:56:24 +0200 (EET)
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
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/36] platform/x86: intel_scu_ipc: Sleeping is fine when polling
Date:   Mon, 13 Jan 2020 16:55:54 +0300
Message-Id: <20200113135623.56286-8-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200113135623.56286-1-mika.westerberg@linux.intel.com>
References: <20200113135623.56286-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason why the driver would need to block other threads from
running the CPU while it is waiting for the SCU IPC to complete its
work. For this reason switch the driver to use usleep_range() instead
with a bit more relaxed polling loop.

Also add constant for the timeout and use the same value for both
polling and interrupt modes.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel_scu_ipc.c | 29 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index 43eaf9400c67..8db0644900a3 100644
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -79,6 +79,9 @@ static struct intel_scu_ipc_dev  ipcdev; /* Only one for now */
 #define IPC_WRITE_BUFFER	0x80
 #define IPC_READ_BUFFER		0x90
 
+/* Timeout in jiffies */
+#define IPC_TIMEOUT		(3 * HZ)
+
 static DEFINE_MUTEX(ipclock); /* lock used to prevent multiple call to SCU */
 
 /*
@@ -132,24 +135,20 @@ static inline u32 ipc_data_readl(struct intel_scu_ipc_dev *scu, u32 offset)
 /* Wait till scu status is busy */
 static inline int busy_loop(struct intel_scu_ipc_dev *scu)
 {
-	u32 status = ipc_read_status(scu);
-	u32 loop_count = 100000;
+	unsigned long end = jiffies + msecs_to_jiffies(IPC_TIMEOUT);
 
-	/* break if scu doesn't reset busy bit after huge retry */
-	while ((status & IPC_STATUS_BUSY) && --loop_count) {
-		udelay(1); /* scu processing time is in few u secods */
-		status = ipc_read_status(scu);
-	}
+	do {
+		u32 status;
 
-	if (status & IPC_STATUS_BUSY) {
-		dev_err(scu->dev, "IPC timed out");
-		return -ETIMEDOUT;
-	}
+		status = ipc_read_status(scu);
+		if (!(status & IPC_STATUS_BUSY))
+			return (status & IPC_STATUS_ERR) ? -EIO : 0;
 
-	if (status & IPC_STATUS_ERR)
-		return -EIO;
+		usleep_range(50, 100);
+	} while (time_before(jiffies, end));
 
-	return 0;
+	dev_err(scu->dev, "IPC timed out");
+	return -ETIMEDOUT;
 }
 
 /* Wait till ipc ioc interrupt is received or timeout in 3 HZ */
@@ -157,7 +156,7 @@ static inline int ipc_wait_for_interrupt(struct intel_scu_ipc_dev *scu)
 {
 	int status;
 
-	if (!wait_for_completion_timeout(&scu->cmd_complete, 3 * HZ)) {
+	if (!wait_for_completion_timeout(&scu->cmd_complete, IPC_TIMEOUT)) {
 		dev_err(scu->dev, "IPC timed out\n");
 		return -ETIMEDOUT;
 	}
-- 
2.24.1

