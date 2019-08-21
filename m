Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1889852C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 22:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730536AbfHUUFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 16:05:51 -0400
Received: from mga09.intel.com ([134.134.136.24]:53248 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730500AbfHUUFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 16:05:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 13:05:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="196069796"
Received: from smasango-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.252.139.100])
  by fmsmga001.fm.intel.com with ESMTP; 21 Aug 2019 13:05:46 -0700
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
Subject: [RFC PATCH 10/11] soundwire: intel: do sdw stream setup in setup function
Date:   Wed, 21 Aug 2019 15:05:20 -0500
Message-Id: <20190821200521.17283-11-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821200521.17283-1-pierre-louis.bossart@linux.intel.com>
References: <20190821200521.17283-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rander Wang <rander.wang@linux.intel.com>

The sdw stream is allocated and stored in dai to share
the sdw runtime information.

Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c | 57 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index f3764f67919e..336203303480 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -670,6 +670,58 @@ static int intel_post_bank_switch(struct sdw_bus *bus)
  * DAI routines
  */
 
+static int sdw_stream_setup(struct snd_pcm_substream *substream,
+			    struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct sdw_stream_runtime *sdw_stream = NULL;
+	char *name;
+	int i, ret;
+
+	name = kzalloc(32, GFP_KERNEL);
+	if (!name)
+		return -ENOMEM;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		snprintf(name, 32, "%s-Playback", dai->name);
+	else
+		snprintf(name, 32, "%s-Capture", dai->name);
+
+	sdw_stream = sdw_alloc_stream(name);
+	if (!sdw_stream) {
+		dev_err(dai->dev, "alloc stream failed for DAI %s", dai->name);
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	/* Set stream pointer on CPU DAI */
+	ret = snd_soc_dai_set_sdw_stream(dai, sdw_stream, substream->stream);
+	if (ret < 0) {
+		dev_err(dai->dev, "failed to set stream pointer on cpu dai %s",
+			dai->name);
+		goto release_stream;
+	}
+
+	/* Set stream pointer on all CODEC DAIs */
+	for (i = 0; i < rtd->num_codecs; i++) {
+		ret = snd_soc_dai_set_sdw_stream(rtd->codec_dais[i], sdw_stream,
+						 substream->stream);
+		if (ret < 0) {
+			dev_err(dai->dev, "failed to set stream pointer on codec dai %s",
+				rtd->codec_dais[i]->name);
+			goto release_stream;
+		}
+	}
+
+	return 0;
+
+release_stream:
+	sdw_release_stream(sdw_stream);
+error:
+	kfree(name);
+	return ret;
+}
+
 static int intel_startup(struct snd_pcm_substream *substream,
 			 struct snd_soc_dai *dai)
 {
@@ -682,9 +734,11 @@ static int intel_startup(struct snd_pcm_substream *substream,
 				    "pm_runtime_get_sync failed in %s, ret %d\n",
 				    __func__, ret);
 		pm_runtime_put_noidle(cdns->dev);
+
+		return ret;
 	}
 
-	return ret;
+	return sdw_stream_setup(substream, dai);
 }
 
 static int intel_hw_params(struct snd_pcm_substream *substream,
@@ -885,6 +939,7 @@ static const struct snd_soc_dai_ops intel_pcm_dai_ops = {
 };
 
 static const struct snd_soc_dai_ops intel_pdm_dai_ops = {
+	.startup = intel_startup,
 	.hw_params = intel_hw_params,
 	.prepare = intel_prepare,
 	.trigger = intel_trigger,
-- 
2.20.1

