Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73D5A1612E1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 14:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbgBQNO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 08:14:58 -0500
Received: from mga17.intel.com ([192.55.52.151]:16058 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728821AbgBQNOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:14:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Feb 2020 05:14:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,452,1574150400"; 
   d="scan'208";a="268408500"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 17 Feb 2020 05:14:51 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id C35204C7; Mon, 17 Feb 2020 15:14:46 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 07/19] platform/x86: intel_scu_ipcutil: Convert to use new SCU IPC API
Date:   Mon, 17 Feb 2020 16:14:34 +0300
Message-Id: <20200217131446.32818-8-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200217131446.32818-1-mika.westerberg@linux.intel.com>
References: <20200217131446.32818-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the IPC util to use the new SCU IPC API where the SCU IPC
instance is passed to the functions.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel_scu_ipcutil.c | 43 +++++++++++++++++++++---
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel_scu_ipcutil.c b/drivers/platform/x86/intel_scu_ipcutil.c
index 8afe6fa06d7b..b7c10c15a3d6 100644
--- a/drivers/platform/x86/intel_scu_ipcutil.c
+++ b/drivers/platform/x86/intel_scu_ipcutil.c
@@ -22,6 +22,9 @@
 
 static int major;
 
+struct intel_scu_ipc_dev *scu;
+static DEFINE_MUTEX(scu_lock);
+
 /* IOCTL commands */
 #define	INTE_SCU_IPC_REGISTER_READ	0
 #define INTE_SCU_IPC_REGISTER_WRITE	1
@@ -52,12 +55,12 @@ static int scu_reg_access(u32 cmd, struct scu_ipc_data  *data)
 
 	switch (cmd) {
 	case INTE_SCU_IPC_REGISTER_READ:
-		return intel_scu_ipc_readv(data->addr, data->data, count);
+		return intel_scu_ipc_dev_readv(scu, data->addr, data->data, count);
 	case INTE_SCU_IPC_REGISTER_WRITE:
-		return intel_scu_ipc_writev(data->addr, data->data, count);
+		return intel_scu_ipc_dev_writev(scu, data->addr, data->data, count);
 	case INTE_SCU_IPC_REGISTER_UPDATE:
-		return intel_scu_ipc_update_register(data->addr[0],
-						    data->data[0], data->mask);
+		return intel_scu_ipc_dev_update(scu, data->addr[0], data->data[0],
+						data->mask);
 	default:
 		return -ENOTTY;
 	}
@@ -91,8 +94,40 @@ static long scu_ipc_ioctl(struct file *fp, unsigned int cmd,
 	return 0;
 }
 
+static int scu_ipc_open(struct inode *inode, struct file *file)
+{
+	int ret = 0;
+
+	/* Only single open at the time */
+	mutex_lock(&scu_lock);
+	if (scu) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	scu = intel_scu_ipc_dev_get();
+	if (!scu)
+		ret = -ENODEV;
+
+unlock:
+	mutex_unlock(&scu_lock);
+	return ret;
+}
+
+static int scu_ipc_release(struct inode *inode, struct file *file)
+{
+	mutex_lock(&scu_lock);
+	intel_scu_ipc_dev_put(scu);
+	scu = NULL;
+	mutex_unlock(&scu_lock);
+
+	return 0;
+}
+
 static const struct file_operations scu_ipc_fops = {
 	.unlocked_ioctl = scu_ipc_ioctl,
+	.open = scu_ipc_open,
+	.release = scu_ipc_release,
 };
 
 static int __init ipc_module_init(void)
-- 
2.25.0

