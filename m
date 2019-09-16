Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92A18B435D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 23:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbfIPVnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 17:43:07 -0400
Received: from mga02.intel.com ([134.134.136.20]:54985 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729469AbfIPVnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 17:43:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 14:43:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,514,1559545200"; 
   d="scan'208";a="198479895"
Received: from dgitin-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.142.45])
  by orsmga002.jf.intel.com with ESMTP; 16 Sep 2019 14:43:02 -0700
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
Subject: [RFC PATCH 03/12] soundwire: intel: update stream callbacks for hwparams/free stream operations
Date:   Mon, 16 Sep 2019 16:42:42 -0500
Message-Id: <20190916214251.13130-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190916214251.13130-1-pierre-louis.bossart@linux.intel.com>
References: <20190916214251.13130-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rander Wang <rander.wang@linux.intel.com>

Rename 'config_stream' as 'params_stream' to be closer to ALSA/ASoC
concepts.

Add a 'free_stream' callback in case any resources allocated in the
'params_stream' stage need to be released.

Define structures for callbacks, mainly to allow for extensions as
needed.

Add the link_id and alh_stream_id parameters which are needed to align
with firmware IPC needs.

Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c           | 39 +++++++++++++++++++++++-----
 drivers/soundwire/intel_init.c      |  2 +-
 include/linux/soundwire/sdw_intel.h | 40 +++++++++++++++++++++++------
 3 files changed, 66 insertions(+), 15 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index c3dba6cf7730..bd87caa127b6 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -521,20 +521,46 @@ intel_pdi_alh_configure(struct sdw_intel *sdw, struct sdw_cdns_pdi *pdi)
 	intel_writel(alh, SDW_ALH_STRMZCFG(pdi->intel_alh_id), conf);
 }
 
-static int intel_config_stream(struct sdw_intel *sdw,
+static int intel_params_stream(struct sdw_intel *sdw,
 			       struct snd_pcm_substream *substream,
 			       struct snd_soc_dai *dai,
-			       struct snd_pcm_hw_params *hw_params, int link_id)
+			       struct snd_pcm_hw_params *hw_params,
+			       int link_id, int alh_stream_id)
 {
 	struct sdw_intel_link_res *res = sdw->link_res;
+	struct sdw_intel_stream_params_data params_data;
 
-	if (res->ops && res->ops->config_stream && res->arg)
-		return res->ops->config_stream(res->arg,
-				substream, dai, hw_params, link_id);
+	params_data.substream = substream;
+	params_data.dai = dai;
+	params_data.hw_params = hw_params;
+	params_data.link_id = link_id;
+	params_data.alh_stream_id = alh_stream_id;
 
+	if (res->ops && res->ops->params_stream && res->dev)
+		return res->ops->params_stream(res->dev,
+					       &params_data);
 	return -EIO;
 }
 
+static int intel_free_stream(struct sdw_intel *sdw,
+			     struct snd_pcm_substream *substream,
+			     struct snd_soc_dai *dai,
+			     int link_id)
+{
+	struct sdw_intel_link_res *res = sdw->link_res;
+	struct sdw_intel_stream_free_data free_data;
+
+	free_data.substream = substream;
+	free_data.dai = dai;
+	free_data.link_id = link_id;
+
+	if (res->ops && res->ops->free_stream && res->dev)
+		return res->ops->free_stream(res->dev,
+					     &free_data);
+
+	return 0;
+}
+
 /*
  * bank switch routines
  */
@@ -646,7 +672,8 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 
 
 	/* Inform DSP about PDI stream number */
-	ret = intel_config_stream(sdw, substream, dai, params,
+	ret = intel_params_stream(sdw, substream, dai, params,
+				  sdw->instance,
 				  pdi->intel_alh_id);
 	if (ret)
 		goto error;
diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index 47124fc13a4a..295637429e99 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -194,7 +194,7 @@ static struct sdw_intel_ctx
 		link->alh = res->mmio_base + SDW_ALH_BASE;
 		link->irq = res->irq;
 		link->ops = res->ops;
-		link->arg = res->arg;
+		link->dev = res->dev;
 
 		/* let the SoundWire master driver to its probe */
 		md->driver->probe(md, link);
diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index 0ce3e4023074..87e63f34d93c 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -4,15 +4,39 @@
 #ifndef __SDW_INTEL_H
 #define __SDW_INTEL_H
 
+/**
+ * struct sdw_intel_stream_params_data: configuration passed during
+ * the @params_stream callback, e.g. for interaction with DSP
+ * firmware.
+ */
+struct sdw_intel_stream_params_data {
+	struct snd_pcm_substream *substream;
+	struct snd_soc_dai *dai;
+	struct snd_pcm_hw_params *hw_params;
+	int link_id;
+	int alh_stream_id;
+};
+
+/**
+ * struct sdw_intel_stream_free_data: configuration passed during
+ * the @free_stream callback, e.g. for interaction with DSP
+ * firmware.
+ */
+struct sdw_intel_stream_free_data {
+	struct snd_pcm_substream *substream;
+	struct snd_soc_dai *dai;
+	int link_id;
+};
+
 /**
  * struct sdw_intel_ops: Intel audio driver callback ops
  *
- * @config_stream: configure the stream with the hw_params
- * the first argument containing the context is mandatory
  */
 struct sdw_intel_ops {
-	int (*config_stream)(void *arg, void *substream,
-			     void *dai, void *hw_params, int stream_num);
+	int (*params_stream)(struct device *dev,
+			     struct sdw_intel_stream_params_data *params_data);
+	int (*free_stream)(struct device *dev,
+			   struct sdw_intel_stream_free_data *free_data);
 };
 
 /**
@@ -41,7 +65,7 @@ struct sdw_intel_acpi_info {
  * @handle: ACPI parent handle
  * @parent: parent device
  * @ops: callback ops
- * @arg: callback arg
+ * @dev: device implementing hwparams and free callbacks
  * @link_mask: bit-wise mask listing links selected by the DSP driver
  */
 struct sdw_intel_res {
@@ -51,7 +75,7 @@ struct sdw_intel_res {
 	acpi_handle handle;
 	struct device *parent;
 	const struct sdw_intel_ops *ops;
-	void *arg;
+	struct device *dev;
 	u32 link_mask;
 };
 
@@ -65,7 +89,7 @@ struct sdw_intel_res {
  * @alh: ALH (Audio Link Hub) pointer
  * @irq: Interrupt line
  * @ops: Shim callback ops
- * @arg: Shim callback ops argument
+ * @dev: Device implementing the callbacks for params/free
  */
 struct sdw_intel_link_res {
 	struct sdw_master_device *md;
@@ -75,7 +99,7 @@ struct sdw_intel_link_res {
 	void __iomem *alh;
 	int irq;
 	const struct sdw_intel_ops *ops;
-	void *arg;
+	struct device *dev;
 };
 
 /**
-- 
2.20.1

