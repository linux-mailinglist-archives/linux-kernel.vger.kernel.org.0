Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC5C28C3C1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 23:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfHMVc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 17:32:59 -0400
Received: from mga06.intel.com ([134.134.136.31]:18158 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727154AbfHMVcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 17:32:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2019 14:32:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,382,1559545200"; 
   d="scan'208";a="177922928"
Received: from ccalgarr-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.252.205.92])
  by fmsmga007.fm.intel.com with ESMTP; 13 Aug 2019 14:32:53 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH 6/6] soundwire: intel: add pm_runtime support
Date:   Tue, 13 Aug 2019 16:32:26 -0500
Message-Id: <20190813213227.5163-7-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190813213227.5163-1-pierre-louis.bossart@linux.intel.com>
References: <20190813213227.5163-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic hooks in DAI .startup and .shutdown callbacks. The SoundWire
IP should be powered between those two calls.

By default the platform_device is in SUSPENDED mode, it is required to
call pm_runtime_set_active() before _enable()

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index fd2d0a9ccb00..c95222f18c75 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -716,6 +716,23 @@ static void intel_port_cleanup(struct sdw_cdns_dma_data *dma)
 	}
 }
 
+static int intel_startup(struct snd_pcm_substream *substream,
+			 struct snd_soc_dai *dai)
+{
+	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
+	int ret;
+
+	ret = pm_runtime_get_sync(cdns->dev);
+	if (ret < 0) {
+		dev_err_ratelimited(cdns->dev,
+				    "pm_runtime_get_sync failed in %s, ret %d\n",
+				    __func__, ret);
+		pm_runtime_put_noidle(cdns->dev);
+	}
+
+	return ret;
+}
+
 static int intel_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_pcm_hw_params *params,
 			   struct snd_soc_dai *dai)
@@ -838,6 +855,8 @@ static void intel_shutdown(struct snd_pcm_substream *substream,
 			   struct snd_soc_dai *dai)
 {
 	struct sdw_cdns_dma_data *dma;
+	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
+	int ret;
 
 	dma = snd_soc_dai_get_dma_data(dai, substream);
 	if (!dma)
@@ -845,6 +864,13 @@ static void intel_shutdown(struct snd_pcm_substream *substream,
 
 	snd_soc_dai_set_dma_data(dai, substream, NULL);
 	kfree(dma);
+
+	pm_runtime_mark_last_busy(cdns->dev);
+	ret = pm_runtime_put_autosuspend(cdns->dev);
+	if (ret < 0)
+		dev_err_ratelimited(cdns->dev,
+				    "pm_runtime_put_autosuspend failed in %s:, ret %d\n",
+				    __func__, ret);
 }
 
 static int intel_pcm_set_sdw_stream(struct snd_soc_dai *dai,
@@ -860,6 +886,7 @@ static int intel_pdm_set_sdw_stream(struct snd_soc_dai *dai,
 }
 
 static const struct snd_soc_dai_ops intel_pcm_dai_ops = {
+	.startup = intel_startup,
 	.hw_params = intel_hw_params,
 	.hw_free = intel_hw_free,
 	.shutdown = intel_shutdown,
@@ -1141,6 +1168,15 @@ static int intel_probe(struct platform_device *pdev)
 
 	intel_debugfs_init(sdw);
 
+	/* Enable PM */
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 3000);
+	pm_runtime_use_autosuspend(&pdev->dev);
+
+	pm_runtime_mark_last_busy(&pdev->dev);
+
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
 	return 0;
 
 err_dai:
@@ -1158,6 +1194,7 @@ static int intel_remove(struct platform_device *pdev)
 	sdw = platform_get_drvdata(pdev);
 
 	if (!sdw->cdns.bus.prop.hw_disabled) {
+		pm_runtime_disable(&pdev->dev);
 		intel_debugfs_exit(sdw);
 		free_irq(sdw->res->irq, sdw);
 		snd_soc_unregister_component(sdw->cdns.dev);
@@ -1237,6 +1274,7 @@ static int intel_resume(struct device *dev)
 
 static const struct dev_pm_ops intel_pm = {
 	SET_SYSTEM_SLEEP_PM_OPS(intel_suspend, intel_resume)
+	SET_RUNTIME_PM_OPS(intel_suspend, intel_resume, NULL)
 };
 
 static struct platform_driver sdw_intel_drv = {
-- 
2.20.1

