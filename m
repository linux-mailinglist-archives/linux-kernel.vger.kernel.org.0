Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A496FCCFB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 19:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfKNSRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 13:17:37 -0500
Received: from mga03.intel.com ([134.134.136.65]:36355 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727128AbfKNSRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:17:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2019 10:17:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,304,1569308400"; 
   d="scan'208";a="195123385"
Received: from chiahuil-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.255.228.77])
  by orsmga007.jf.intel.com with ESMTP; 14 Nov 2019 10:17:32 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH v3 03/22] soundwire: bus: add PM/no-PM versions of read/write functions
Date:   Thu, 14 Nov 2019 12:16:43 -0600
Message-Id: <20191114181702.22254-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191114181702.22254-1-pierre-louis.bossart@linux.intel.com>
References: <20191114181702.22254-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for pm_runtime with the appropriate error checks for
sdw_write/read functions, e.g. when pm_runtime is not supported.

Also expose internal functions without pm_runtime support, which are
required to perform any sort of suspend/resume operation, as well as
any enumeration tasks.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/bus.c | 68 +++++++++++++++++++++++++++++++----------
 1 file changed, 52 insertions(+), 16 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index d99acbc614c6..a397d0a772b3 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -317,6 +317,46 @@ int sdw_fill_msg(struct sdw_msg *msg, struct sdw_slave *slave,
 	return 0;
 }
 
+/*
+ * Read/Write IO functions.
+ * no_pm versions can only be called by the bus, e.g. while enumerating or
+ * handling suspend-resume sequences.
+ * all clients need to use the pm versions
+ */
+
+static int
+sdw_nread_no_pm(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
+{
+	struct sdw_msg msg;
+	int ret;
+
+	ret = sdw_fill_msg(&msg, slave, addr, count,
+			   slave->dev_num, SDW_MSG_FLAG_READ, val);
+	if (ret < 0)
+		return ret;
+
+	return sdw_transfer(slave->bus, &msg);
+}
+
+static int
+sdw_nwrite_no_pm(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
+{
+	struct sdw_msg msg;
+	int ret;
+
+	ret = sdw_fill_msg(&msg, slave, addr, count,
+			   slave->dev_num, SDW_MSG_FLAG_WRITE, val);
+	if (ret < 0)
+		return ret;
+
+	return sdw_transfer(slave->bus, &msg);
+}
+
+int sdw_write_no_pm(struct sdw_slave *slave, u32 addr, u8 value)
+{
+	return sdw_nwrite_no_pm(slave, addr, 1, &value);
+}
+
 /**
  * sdw_nread() - Read "n" contiguous SDW Slave registers
  * @slave: SDW Slave
@@ -326,19 +366,17 @@ int sdw_fill_msg(struct sdw_msg *msg, struct sdw_slave *slave,
  */
 int sdw_nread(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
 {
-	struct sdw_msg msg;
 	int ret;
 
-	ret = sdw_fill_msg(&msg, slave, addr, count,
-			   slave->dev_num, SDW_MSG_FLAG_READ, val);
-	if (ret < 0)
-		return ret;
-
 	ret = pm_runtime_get_sync(slave->bus->dev);
-	if (ret < 0)
+	if (ret < 0 && ret != -EACCES) {
+		pm_runtime_put_noidle(slave->bus->dev);
 		return ret;
+	}
+
+	ret = sdw_nread_no_pm(slave, addr, count, val);
 
-	ret = sdw_transfer(slave->bus, &msg);
+	pm_runtime_mark_last_busy(slave->bus->dev);
 	pm_runtime_put(slave->bus->dev);
 
 	return ret;
@@ -354,19 +392,17 @@ EXPORT_SYMBOL(sdw_nread);
  */
 int sdw_nwrite(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
 {
-	struct sdw_msg msg;
 	int ret;
 
-	ret = sdw_fill_msg(&msg, slave, addr, count,
-			   slave->dev_num, SDW_MSG_FLAG_WRITE, val);
-	if (ret < 0)
-		return ret;
-
 	ret = pm_runtime_get_sync(slave->bus->dev);
-	if (ret < 0)
+	if (ret < 0 && ret != -EACCES) {
+		pm_runtime_put_noidle(slave->bus->dev);
 		return ret;
+	}
+
+	ret = sdw_nwrite_no_pm(slave, addr, count, val);
 
-	ret = sdw_transfer(slave->bus, &msg);
+	pm_runtime_mark_last_busy(slave->bus->dev);
 	pm_runtime_put(slave->bus->dev);
 
 	return ret;
-- 
2.20.1

