Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8035828E4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 02:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731495AbfHFA4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 20:56:00 -0400
Received: from mga07.intel.com ([134.134.136.100]:35804 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731476AbfHFAzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 20:55:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 17:55:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; 
   d="scan'208";a="198153249"
Received: from sahluwal-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.252.202.215])
  by fmsmga004.fm.intel.com with ESMTP; 05 Aug 2019 17:55:53 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, Blauciak@vger.kernel.org,
        Slawomir <slawomir.blauciak@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH 17/17] soundwire: intel: move shutdown() callback and don't export symbol
Date:   Mon,  5 Aug 2019 19:55:22 -0500
Message-Id: <20190806005522.22642-18-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806005522.22642-1-pierre-louis.bossart@linux.intel.com>
References: <20190806005522.22642-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All DAI callbacks are in intel.c except for shutdown. Move and remove
export symbol

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 14 --------------
 drivers/soundwire/cadence_master.h |  2 --
 drivers/soundwire/intel.c          | 17 +++++++++++++++--
 3 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 4ab3174cbb04..c5891c8a824e 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -1316,19 +1316,5 @@ int sdw_cdns_alloc_stream(struct sdw_cdns *cdns,
 }
 EXPORT_SYMBOL(sdw_cdns_alloc_stream);
 
-void sdw_cdns_shutdown(struct snd_pcm_substream *substream,
-		       struct snd_soc_dai *dai)
-{
-	struct sdw_cdns_dma_data *dma;
-
-	dma = snd_soc_dai_get_dma_data(dai, substream);
-	if (!dma)
-		return;
-
-	snd_soc_dai_set_dma_data(dai, substream, NULL);
-	kfree(dma);
-}
-EXPORT_SYMBOL(sdw_cdns_shutdown);
-
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_DESCRIPTION("Cadence Soundwire Library");
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index c0bf6ff00a44..d1022125f182 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -174,8 +174,6 @@ int sdw_cdns_alloc_stream(struct sdw_cdns *cdns,
 void sdw_cdns_config_stream(struct sdw_cdns *cdns, struct sdw_cdns_port *port,
 			    u32 ch, u32 dir, struct sdw_cdns_pdi *pdi);
 
-void sdw_cdns_shutdown(struct snd_pcm_substream *substream,
-		       struct snd_soc_dai *dai);
 int sdw_cdns_pcm_set_stream(struct snd_soc_dai *dai,
 			    void *stream, int direction);
 int sdw_cdns_pdm_set_stream(struct snd_soc_dai *dai,
diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index e702187c0609..fe5f21edccfc 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -764,6 +764,19 @@ intel_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
 	return ret;
 }
 
+static void intel_shutdown(struct snd_pcm_substream *substream,
+			   struct snd_soc_dai *dai)
+{
+	struct sdw_cdns_dma_data *dma;
+
+	dma = snd_soc_dai_get_dma_data(dai, substream);
+	if (!dma)
+		return;
+
+	snd_soc_dai_set_dma_data(dai, substream, NULL);
+	kfree(dma);
+}
+
 static int intel_pcm_set_sdw_stream(struct snd_soc_dai *dai,
 				    void *stream, int direction)
 {
@@ -779,14 +792,14 @@ static int intel_pdm_set_sdw_stream(struct snd_soc_dai *dai,
 static const struct snd_soc_dai_ops intel_pcm_dai_ops = {
 	.hw_params = intel_hw_params,
 	.hw_free = intel_hw_free,
-	.shutdown = sdw_cdns_shutdown,
+	.shutdown = intel_shutdown,
 	.set_sdw_stream = intel_pcm_set_sdw_stream,
 };
 
 static const struct snd_soc_dai_ops intel_pdm_dai_ops = {
 	.hw_params = intel_hw_params,
 	.hw_free = intel_hw_free,
-	.shutdown = sdw_cdns_shutdown,
+	.shutdown = intel_shutdown,
 	.set_sdw_stream = intel_pdm_set_sdw_stream,
 };
 
-- 
2.20.1

