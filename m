Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3518C3BC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 23:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfHMVct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 17:32:49 -0400
Received: from mga06.intel.com ([134.134.136.31]:18152 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbfHMVcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 17:32:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2019 14:32:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,382,1559545200"; 
   d="scan'208";a="177922897"
Received: from ccalgarr-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.252.205.92])
  by fmsmga007.fm.intel.com with ESMTP; 13 Aug 2019 14:32:44 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH 1/6] soundwire: fix startup sequence for Intel/Cadence
Date:   Tue, 13 Aug 2019 16:32:21 -0500
Message-Id: <20190813213227.5163-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190813213227.5163-1-pierre-louis.bossart@linux.intel.com>
References: <20190813213227.5163-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multiple changes squashed in single patch to avoid tick-tock effect.

1. Per the hardware documentation, all changes to MCP_CONFIG,
MCP_CONTROL, MCP_CMDCTRL and MCP_PHYCTRL need to be validated with a
self-clearing write to MCP_CONFIG_UPDATE. Add a helper and do the
update when the CONFIG is changed.

2. Move interrupt enable after interrupt handler registration

3. Add a new helper to start the hardware bus reset with maximum duration
to make sure the Slave(s) correctly detect the reset pattern and to
ensure electrical conflicts can be resolved.

4. flush command FIFOs

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 84 +++++++++++++++++++++---------
 drivers/soundwire/cadence_master.h |  1 +
 drivers/soundwire/intel.c          | 14 ++++-
 3 files changed, 73 insertions(+), 26 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 502ed4ec8f07..046622e4b264 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -231,6 +231,22 @@ static int cdns_clear_bit(struct sdw_cdns *cdns, int offset, u32 value)
 	return -EAGAIN;
 }
 
+/*
+ * all changes to the MCP_CONFIG, MCP_CONTROL, MCP_CMDCTRL and MCP_PHYCTRL
+ * need to be confirmed with a write to MCP_CONFIG_UPDATE
+ */
+static int cdns_update_config(struct sdw_cdns *cdns)
+{
+	int ret;
+
+	ret = cdns_clear_bit(cdns, CDNS_MCP_CONFIG_UPDATE,
+			     CDNS_MCP_CONFIG_UPDATE_BIT);
+	if (ret < 0)
+		dev_err(cdns->dev, "Config update timedout\n");
+
+	return ret;
+}
+
 /*
  * debugfs
  */
@@ -752,7 +768,42 @@ EXPORT_SYMBOL(sdw_cdns_thread);
 /*
  * init routines
  */
-static int _cdns_enable_interrupt(struct sdw_cdns *cdns)
+
+/**
+ * sdw_cdns_exit_reset() - Program reset parameters and start bus operations
+ * @cdns: Cadence instance
+ */
+int sdw_cdns_exit_reset(struct sdw_cdns *cdns)
+{
+	int ret;
+
+	/* program maximum length reset to be safe */
+	cdns_updatel(cdns, CDNS_MCP_CONTROL,
+		     CDNS_MCP_CONTROL_RST_DELAY,
+		     CDNS_MCP_CONTROL_RST_DELAY);
+
+	/* use hardware generated reset */
+	cdns_updatel(cdns, CDNS_MCP_CONTROL,
+		     CDNS_MCP_CONTROL_HW_RST,
+		     CDNS_MCP_CONTROL_HW_RST);
+
+	/* enable bus operations with clock and data */
+	cdns_updatel(cdns, CDNS_MCP_CONFIG,
+		     CDNS_MCP_CONFIG_OP,
+		     CDNS_MCP_CONFIG_OP_NORMAL);
+
+	/* commit changes */
+	ret = cdns_update_config(cdns);
+
+	return ret;
+}
+EXPORT_SYMBOL(sdw_cdns_exit_reset);
+
+/**
+ * sdw_cdns_enable_interrupt() - Enable SDW interrupts and update config
+ * @cdns: Cadence instance
+ */
+int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns)
 {
 	u32 mask;
 
@@ -784,24 +835,8 @@ static int _cdns_enable_interrupt(struct sdw_cdns *cdns)
 
 	cdns_writel(cdns, CDNS_MCP_INTMASK, mask);
 
-	return 0;
-}
-
-/**
- * sdw_cdns_enable_interrupt() - Enable SDW interrupts and update config
- * @cdns: Cadence instance
- */
-int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns)
-{
-	int ret;
-
-	_cdns_enable_interrupt(cdns);
-	ret = cdns_clear_bit(cdns, CDNS_MCP_CONFIG_UPDATE,
-			     CDNS_MCP_CONFIG_UPDATE_BIT);
-	if (ret < 0)
-		dev_err(cdns->dev, "Config update timedout\n");
-
-	return ret;
+	/* commit changes */
+	return cdns_update_config(cdns);
 }
 EXPORT_SYMBOL(sdw_cdns_enable_interrupt);
 
@@ -975,6 +1010,10 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
 	cdns_writel(cdns, CDNS_MCP_SSP_CTRL0, CDNS_DEFAULT_SSP_INTERVAL);
 	cdns_writel(cdns, CDNS_MCP_SSP_CTRL1, CDNS_DEFAULT_SSP_INTERVAL);
 
+	/* flush command FIFOs */
+	cdns_updatel(cdns, CDNS_MCP_CONTROL, CDNS_MCP_CONTROL_CMD_RST,
+		     CDNS_MCP_CONTROL_CMD_RST);
+
 	/* Set cmd accept mode */
 	cdns_updatel(cdns, CDNS_MCP_CONTROL, CDNS_MCP_CONTROL_CMD_ACCEPT,
 		     CDNS_MCP_CONTROL_CMD_ACCEPT);
@@ -997,13 +1036,10 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
 	/* Set cmd mode for Tx and Rx cmds */
 	val &= ~CDNS_MCP_CONFIG_CMD;
 
-	/* Set operation to normal */
-	val &= ~CDNS_MCP_CONFIG_OP;
-	val |= CDNS_MCP_CONFIG_OP_NORMAL;
-
 	cdns_writel(cdns, CDNS_MCP_CONFIG, val);
 
-	return 0;
+	/* commit changes */
+	return cdns_update_config(cdns);
 }
 EXPORT_SYMBOL(sdw_cdns_init);
 
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index 0b72b7094735..1a67728c5000 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -161,6 +161,7 @@ irqreturn_t sdw_cdns_thread(int irq, void *dev_id);
 int sdw_cdns_init(struct sdw_cdns *cdns);
 int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
 		      struct sdw_cdns_stream_config config);
+int sdw_cdns_exit_reset(struct sdw_cdns *cdns);
 int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns);
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 13c54eac0cc3..5f14c6acce80 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1043,8 +1043,6 @@ static int intel_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_init;
 
-	ret = sdw_cdns_enable_interrupt(&sdw->cdns);
-
 	/* Read the PDI config and initialize cadence PDI */
 	intel_pdi_init(sdw, &config);
 	ret = sdw_cdns_pdi_init(&sdw->cdns, config);
@@ -1062,6 +1060,18 @@ static int intel_probe(struct platform_device *pdev)
 		goto err_init;
 	}
 
+	ret = sdw_cdns_enable_interrupt(&sdw->cdns);
+	if (ret < 0) {
+		dev_err(sdw->cdns.dev, "cannot enable interrupts\n");
+		goto err_init;
+	}
+
+	ret = sdw_cdns_exit_reset(&sdw->cdns);
+	if (ret < 0) {
+		dev_err(sdw->cdns.dev, "unable to exit bus reset sequence\n");
+		goto err_init;
+	}
+
 	/* Register DAIs */
 	ret = intel_register_dai(sdw);
 	if (ret) {
-- 
2.20.1

