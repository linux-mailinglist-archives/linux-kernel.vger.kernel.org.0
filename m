Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFF5F1E95
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 20:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732310AbfKFTWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 14:22:43 -0500
Received: from mga02.intel.com ([134.134.136.20]:50594 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732263AbfKFTWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 14:22:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 11:22:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400"; 
   d="scan'208";a="403835112"
Received: from vidhipat-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.254.33.70])
  by fmsmga006.fm.intel.com with ESMTP; 06 Nov 2019 11:22:39 -0800
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
Subject: [PATCH v2 08/19] soundwire: intel: reset pm_runtime status during system resume
Date:   Wed,  6 Nov 2019 13:22:12 -0600
Message-Id: <20191106192223.6003-9-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191106192223.6003-1-pierre-louis.bossart@linux.intel.com>
References: <20191106192223.6003-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The system resume does the entire bus re-initialization and brings it
to full-power. If the device was pm_runtime suspended, there is no
need to run the pm_runtime resume sequence after the system runtime.

Follow the documentation from runtime_pm.rst, and conditionally
disable, set_active and re-enable the device on system resume.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c     | 30 ++++++++++++++++++++++++++++++
 include/linux/soundwire/sdw.h |  1 +
 2 files changed, 31 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 650581348732..c3cd7d2d5a34 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1298,6 +1298,7 @@ static int intel_master_remove(struct sdw_master_device *md)
 
 static int intel_suspend(struct device *dev)
 {
+	struct sdw_master_device *md = to_sdw_master_device(dev);
 	struct sdw_cdns *cdns = dev_get_drvdata(dev);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
 	int ret;
@@ -1308,6 +1309,20 @@ static int intel_suspend(struct device *dev)
 		return 0;
 	}
 
+	if (pm_runtime_status_suspended(dev)) {
+		dev_dbg(dev,
+			"%s: pm_runtime status: suspended\n",
+			__func__);
+
+		/*
+		 * keep track of the state for the system resume, where
+		 * we will need to reset the pm_runtime status to active
+		 */
+		md->pm_runtime_suspended = true;
+
+		return 0;
+	}
+
 	ret = sdw_cdns_enable_interrupt(cdns, false);
 	if (ret < 0) {
 		dev_err(dev, "cannot disable interrupts on suspend\n");
@@ -1356,6 +1371,7 @@ static int intel_suspend_runtime(struct device *dev)
 
 static int intel_resume(struct device *dev)
 {
+	struct sdw_master_device *md = to_sdw_master_device(dev);
 	struct sdw_cdns *cdns = dev_get_drvdata(dev);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
 	int ret;
@@ -1366,6 +1382,20 @@ static int intel_resume(struct device *dev)
 		return 0;
 	}
 
+	if (md->pm_runtime_suspended) {
+		dev_dbg(dev,
+			"%s: pm_runtime status was suspended, forcing active\n",
+			__func__);
+
+		/* follow required sequence from runtime_pm.rst */
+		pm_runtime_disable(dev);
+		pm_runtime_set_active(dev);
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_enable(dev);
+
+		md->pm_runtime_suspended = false;
+	}
+
 	ret = intel_init(sdw);
 	if (ret) {
 		dev_err(dev, "%s failed: %d", __func__, ret);
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 17ec786d3a15..c06c515abad9 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -583,6 +583,7 @@ struct sdw_master_device {
 	struct device dev;
 	int link_id;
 	struct sdw_md_driver *driver;
+	bool pm_runtime_suspended;
 	void *pdata; /* core does not touch */
 };
 
-- 
2.20.1

