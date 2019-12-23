Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50B5A12971A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Dec 2019 15:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfLWOS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Dec 2019 09:18:57 -0500
Received: from mga04.intel.com ([192.55.52.120]:8564 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727072AbfLWOR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 09:17:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Dec 2019 06:17:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,347,1571727600"; 
   d="scan'208";a="299688898"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 23 Dec 2019 06:17:25 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 434BAF1C; Mon, 23 Dec 2019 16:17:18 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>, x86@kernel.org
Cc:     Zha Qipeng <qipeng.zha@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 24/37] platform/x86: intel_scu_ipc: Add function to remove SCU IPC
Date:   Mon, 23 Dec 2019 17:17:03 +0300
Message-Id: <20191223141716.13727-25-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191223141716.13727-1-mika.westerberg@linux.intel.com>
References: <20191223141716.13727-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers such as intel_pmc_ipc.c can be unloaded as well so in order to
support those in this driver add a new function that can be called to
remove the SCU IPC if the driver is unloaded.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 arch/x86/include/asm/intel_scu_ipc.h |  1 +
 drivers/platform/x86/intel_scu_ipc.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/x86/include/asm/intel_scu_ipc.h b/arch/x86/include/asm/intel_scu_ipc.h
index 9895b60386c5..250127eb1e38 100644
--- a/arch/x86/include/asm/intel_scu_ipc.h
+++ b/arch/x86/include/asm/intel_scu_ipc.h
@@ -32,6 +32,7 @@ struct intel_scu_ipc_pdata {
 
 struct intel_scu_ipc_dev *
 intel_scu_ipc_probe(struct device *dev, const struct intel_scu_ipc_pdata *pdata);
+void intel_scu_ipc_remove(struct intel_scu_ipc_dev *scu);
 
 struct intel_scu_ipc_dev *intel_scu_ipc_dev_get(void);
 void intel_scu_ipc_dev_put(struct intel_scu_ipc_dev *scu);
diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index cc29f504adcf..9fa0ea95198b 100644
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -566,3 +566,21 @@ intel_scu_ipc_probe(struct device *dev, const struct intel_scu_ipc_pdata *pdata)
 	return scu;
 }
 EXPORT_SYMBOL_GPL(intel_scu_ipc_probe);
+
+/**
+ * intel_scu_ipc_remove() - Remove SCU IPC
+ * @scu: SCU IPC handle
+ *
+ * This unregisters the SCU IPC device and releases the interrupt.
+ */
+void intel_scu_ipc_remove(struct intel_scu_ipc_dev *scu)
+{
+	mutex_lock(&ipclock);
+	if (!WARN_ON(!scu->dev)) {
+		if (scu->irq > 0)
+			devm_free_irq(scu->dev, scu->irq, scu);
+		scu->dev = NULL;
+	}
+	mutex_unlock(&ipclock);
+}
+EXPORT_SYMBOL_GPL(intel_scu_ipc_remove);
-- 
2.24.0

