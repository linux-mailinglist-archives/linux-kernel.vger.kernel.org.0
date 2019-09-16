Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 563C6B40D5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 21:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730194AbfIPTKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 15:10:12 -0400
Received: from mga02.intel.com ([134.134.136.20]:45447 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390794AbfIPTKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 15:10:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 12:10:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,513,1559545200"; 
   d="scan'208";a="191161749"
Received: from jvhicko1-mobl2.amr.corp.intel.com (HELO localhost.localdomain) ([10.254.104.227])
  by orsmga006.jf.intel.com with ESMTP; 16 Sep 2019 12:10:03 -0700
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
Subject: [PATCH v2 4/5] soundwire: intel/cadence: add flag for interrupt enable
Date:   Mon, 16 Sep 2019 14:09:50 -0500
Message-Id: <20190916190952.32388-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190916190952.32388-1-pierre-louis.bossart@linux.intel.com>
References: <20190916190952.32388-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for future PM support and fix error handling by disabling
interrupts as needed.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 18 ++++++++++++------
 drivers/soundwire/cadence_master.h |  2 +-
 drivers/soundwire/intel.c          | 12 +++++++-----
 3 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 5f900cf2acb9..a71df99ca18f 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -819,14 +819,17 @@ EXPORT_SYMBOL(sdw_cdns_exit_reset);
  * sdw_cdns_enable_interrupt() - Enable SDW interrupts and update config
  * @cdns: Cadence instance
  */
-int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns)
+int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns, bool state)
 {
-	u32 mask;
+	u32 slave_intmask0 = 0;
+	u32 slave_intmask1 = 0;
+	u32 mask = 0;
+
+	if (!state)
+		goto update_masks;
 
-	cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK0,
-		    CDNS_MCP_SLAVE_INTMASK0_MASK);
-	cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK1,
-		    CDNS_MCP_SLAVE_INTMASK1_MASK);
+	slave_intmask0 = CDNS_MCP_SLAVE_INTMASK0_MASK;
+	slave_intmask1 = CDNS_MCP_SLAVE_INTMASK1_MASK;
 
 	/* enable detection of all slave state changes */
 	mask = CDNS_MCP_INT_SLAVE_MASK;
@@ -849,6 +852,9 @@ int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns)
 	if (interrupt_mask) /* parameter override */
 		mask = interrupt_mask;
 
+update_masks:
+	cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK0, slave_intmask0);
+	cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK1, slave_intmask1);
 	cdns_writel(cdns, CDNS_MCP_INTMASK, mask);
 
 	/* commit changes */
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index 1a67728c5000..302351808098 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -162,7 +162,7 @@ int sdw_cdns_init(struct sdw_cdns *cdns);
 int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
 		      struct sdw_cdns_stream_config config);
 int sdw_cdns_exit_reset(struct sdw_cdns *cdns);
-int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns);
+int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns, bool state);
 
 #ifdef CONFIG_DEBUG_FS
 void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct dentry *root);
diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index cdb3243e8823..08530c136c5f 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1036,7 +1036,7 @@ static int intel_probe(struct platform_device *pdev)
 	ret = sdw_add_bus_master(&sdw->cdns.bus);
 	if (ret) {
 		dev_err(&pdev->dev, "sdw_add_bus_master fail: %d\n", ret);
-		goto err_master_reg;
+		return ret;
 	}
 
 	if (sdw->cdns.bus.prop.hw_disabled) {
@@ -1067,7 +1067,7 @@ static int intel_probe(struct platform_device *pdev)
 		goto err_init;
 	}
 
-	ret = sdw_cdns_enable_interrupt(&sdw->cdns);
+	ret = sdw_cdns_enable_interrupt(&sdw->cdns, true);
 	if (ret < 0) {
 		dev_err(sdw->cdns.dev, "cannot enable interrupts\n");
 		goto err_init;
@@ -1076,7 +1076,7 @@ static int intel_probe(struct platform_device *pdev)
 	ret = sdw_cdns_exit_reset(&sdw->cdns);
 	if (ret < 0) {
 		dev_err(sdw->cdns.dev, "unable to exit bus reset sequence\n");
-		goto err_init;
+		goto err_interrupt;
 	}
 
 	/* Register DAIs */
@@ -1084,18 +1084,19 @@ static int intel_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(sdw->cdns.dev, "DAI registration failed: %d\n", ret);
 		snd_soc_unregister_component(sdw->cdns.dev);
-		goto err_dai;
+		goto err_interrupt;
 	}
 
 	intel_debugfs_init(sdw);
 
 	return 0;
 
+err_interrupt:
+	sdw_cdns_enable_interrupt(&sdw->cdns, false);
 err_dai:
 	free_irq(sdw->res->irq, sdw);
 err_init:
 	sdw_delete_bus_master(&sdw->cdns.bus);
-err_master_reg:
 	return ret;
 }
 
@@ -1107,6 +1108,7 @@ static int intel_remove(struct platform_device *pdev)
 
 	if (!sdw->cdns.bus.prop.hw_disabled) {
 		intel_debugfs_exit(sdw);
+		sdw_cdns_enable_interrupt(&sdw->cdns, false);
 		free_irq(sdw->res->irq, sdw);
 		snd_soc_unregister_component(sdw->cdns.dev);
 	}
-- 
2.20.1

