Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00BED15FC34
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 02:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgBOBrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 20:47:55 -0500
Received: from mga14.intel.com ([192.55.52.115]:23828 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727951AbgBOBru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 20:47:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 17:47:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,442,1574150400"; 
   d="scan'208";a="434975929"
Received: from gosalsar-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.252.136.64])
  by fmsmga006.fm.intel.com with ESMTP; 14 Feb 2020 17:47:48 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH v3 1/5] soundwire: intel: rename res field as link_res
Date:   Fri, 14 Feb 2020 19:47:36 -0600
Message-Id: <20200215014740.27580-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200215014740.27580-1-pierre-louis.bossart@linux.intel.com>
References: <20200215014740.27580-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are too many fields called 'res' so add prefix to make it easier
to track what the structures are.

Pure rename, no functionality change

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 06ef3a3ac080..78b2ebf0119c 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -103,7 +103,7 @@ enum intel_pdi_type {
 struct sdw_intel {
 	struct sdw_cdns cdns;
 	int instance;
-	struct sdw_intel_link_res *res;
+	struct sdw_intel_link_res *link_res;
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs;
 #endif
@@ -193,8 +193,8 @@ static ssize_t intel_sprintf(void __iomem *mem, bool l,
 static int intel_reg_show(struct seq_file *s_file, void *data)
 {
 	struct sdw_intel *sdw = s_file->private;
-	void __iomem *s = sdw->res->shim;
-	void __iomem *a = sdw->res->alh;
+	void __iomem *s = sdw->link_res->shim;
+	void __iomem *a = sdw->link_res->alh;
 	char *buf;
 	ssize_t ret;
 	int i, j;
@@ -289,7 +289,7 @@ static void intel_debugfs_exit(struct sdw_intel *sdw) {}
 static int intel_link_power_up(struct sdw_intel *sdw)
 {
 	unsigned int link_id = sdw->instance;
-	void __iomem *shim = sdw->res->shim;
+	void __iomem *shim = sdw->link_res->shim;
 	int spa_mask, cpa_mask;
 	int link_control, ret;
 
@@ -309,7 +309,7 @@ static int intel_link_power_up(struct sdw_intel *sdw)
 
 static int intel_shim_init(struct sdw_intel *sdw)
 {
-	void __iomem *shim = sdw->res->shim;
+	void __iomem *shim = sdw->link_res->shim;
 	unsigned int link_id = sdw->instance;
 	int sync_reg, ret;
 	u16 ioctl = 0, act = 0;
@@ -370,7 +370,7 @@ static int intel_shim_init(struct sdw_intel *sdw)
 static void intel_pdi_init(struct sdw_intel *sdw,
 			   struct sdw_cdns_stream_config *config)
 {
-	void __iomem *shim = sdw->res->shim;
+	void __iomem *shim = sdw->link_res->shim;
 	unsigned int link_id = sdw->instance;
 	int pcm_cap, pdm_cap;
 
@@ -404,7 +404,7 @@ static void intel_pdi_init(struct sdw_intel *sdw,
 static int
 intel_pdi_get_ch_cap(struct sdw_intel *sdw, unsigned int pdi_num, bool pcm)
 {
-	void __iomem *shim = sdw->res->shim;
+	void __iomem *shim = sdw->link_res->shim;
 	unsigned int link_id = sdw->instance;
 	int count;
 
@@ -476,7 +476,7 @@ static int intel_pdi_ch_update(struct sdw_intel *sdw)
 static void
 intel_pdi_shim_configure(struct sdw_intel *sdw, struct sdw_cdns_pdi *pdi)
 {
-	void __iomem *shim = sdw->res->shim;
+	void __iomem *shim = sdw->link_res->shim;
 	unsigned int link_id = sdw->instance;
 	int pdi_conf = 0;
 
@@ -508,7 +508,7 @@ intel_pdi_shim_configure(struct sdw_intel *sdw, struct sdw_cdns_pdi *pdi)
 static void
 intel_pdi_alh_configure(struct sdw_intel *sdw, struct sdw_cdns_pdi *pdi)
 {
-	void __iomem *alh = sdw->res->alh;
+	void __iomem *alh = sdw->link_res->alh;
 	unsigned int link_id = sdw->instance;
 	unsigned int conf;
 
@@ -535,7 +535,7 @@ static int intel_params_stream(struct sdw_intel *sdw,
 			       struct snd_pcm_hw_params *hw_params,
 			       int link_id, int alh_stream_id)
 {
-	struct sdw_intel_link_res *res = sdw->res;
+	struct sdw_intel_link_res *res = sdw->link_res;
 	struct sdw_intel_stream_params_data params_data;
 
 	params_data.substream = substream;
@@ -558,7 +558,7 @@ static int intel_pre_bank_switch(struct sdw_bus *bus)
 {
 	struct sdw_cdns *cdns = bus_to_cdns(bus);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
-	void __iomem *shim = sdw->res->shim;
+	void __iomem *shim = sdw->link_res->shim;
 	int sync_reg;
 
 	/* Write to register only for multi-link */
@@ -577,7 +577,7 @@ static int intel_post_bank_switch(struct sdw_bus *bus)
 {
 	struct sdw_cdns *cdns = bus_to_cdns(bus);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
-	void __iomem *shim = sdw->res->shim;
+	void __iomem *shim = sdw->link_res->shim;
 	int sync_reg, ret;
 
 	/* Write to register only for multi-link */
@@ -937,9 +937,9 @@ static int intel_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	sdw->instance = pdev->id;
-	sdw->res = dev_get_platdata(&pdev->dev);
+	sdw->link_res = dev_get_platdata(&pdev->dev);
 	sdw->cdns.dev = &pdev->dev;
-	sdw->cdns.registers = sdw->res->registers;
+	sdw->cdns.registers = sdw->link_res->registers;
 	sdw->cdns.instance = sdw->instance;
 	sdw->cdns.msg_count = 0;
 	sdw->cdns.bus.dev = &pdev->dev;
@@ -979,11 +979,12 @@ static int intel_probe(struct platform_device *pdev)
 	intel_pdi_ch_update(sdw);
 
 	/* Acquire IRQ */
-	ret = request_threaded_irq(sdw->res->irq, sdw_cdns_irq, sdw_cdns_thread,
+	ret = request_threaded_irq(sdw->link_res->irq,
+				   sdw_cdns_irq, sdw_cdns_thread,
 				   IRQF_SHARED, KBUILD_MODNAME, &sdw->cdns);
 	if (ret < 0) {
 		dev_err(sdw->cdns.dev, "unable to grab IRQ %d, disabling device\n",
-			sdw->res->irq);
+			sdw->link_res->irq);
 		goto err_init;
 	}
 
@@ -1013,7 +1014,7 @@ static int intel_probe(struct platform_device *pdev)
 
 err_interrupt:
 	sdw_cdns_enable_interrupt(&sdw->cdns, false);
-	free_irq(sdw->res->irq, sdw);
+	free_irq(sdw->link_res->irq, sdw);
 err_init:
 	sdw_delete_bus_master(&sdw->cdns.bus);
 	return ret;
@@ -1028,7 +1029,7 @@ static int intel_remove(struct platform_device *pdev)
 	if (!sdw->cdns.bus.prop.hw_disabled) {
 		intel_debugfs_exit(sdw);
 		sdw_cdns_enable_interrupt(&sdw->cdns, false);
-		free_irq(sdw->res->irq, sdw);
+		free_irq(sdw->link_res->irq, sdw);
 		snd_soc_unregister_component(sdw->cdns.dev);
 	}
 	sdw_delete_bus_master(&sdw->cdns.bus);
-- 
2.20.1

