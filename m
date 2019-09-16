Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48593B4368
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 23:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbfIPVoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 17:44:05 -0400
Received: from mga14.intel.com ([192.55.52.115]:58534 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730086AbfIPVoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 17:44:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 14:44:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,514,1559545200"; 
   d="scan'208";a="198480135"
Received: from dgitin-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.142.45])
  by orsmga002.jf.intel.com with ESMTP; 16 Sep 2019 14:44:01 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>,
        Janusz Jankowski <janusz.jankowski@linux.intel.com>
Subject: [RFC PATCH 10/12] ASoC: SOF: IPC: dai-intel: move ALH declarations in header file
Date:   Mon, 16 Sep 2019 16:42:49 -0500
Message-Id: <20190916214251.13130-11-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190916214251.13130-1-pierre-louis.bossart@linux.intel.com>
References: <20190916214251.13130-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ALH was inserted in the wrong place during integration, add after DMIC
to mirror the file used by SOF firmware.

No functional change, just text move in the same file to better track
changes, if any.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/sof/dai-intel.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/sound/sof/dai-intel.h b/include/sound/sof/dai-intel.h
index 5f1ef5565be6..04e48227f542 100644
--- a/include/sound/sof/dai-intel.h
+++ b/include/sound/sof/dai-intel.h
@@ -87,6 +87,15 @@ struct sof_ipc_dai_hda_params {
 	uint32_t link_dma_ch;
 } __packed;
 
+/* ALH Configuration Request - SOF_IPC_DAI_ALH_CONFIG */
+struct sof_ipc_dai_alh_params {
+	struct sof_ipc_hdr hdr;
+	uint32_t stream_id;
+
+	/* reserved for future use */
+	uint32_t reserved[15];
+} __packed;
+
 /* DMIC Configuration Request - SOF_IPC_DAI_DMIC_CONFIG */
 
 /* This struct is defined per 2ch PDM controller available in the platform.
@@ -179,13 +188,4 @@ struct sof_ipc_dai_dmic_params {
 	struct sof_ipc_dai_dmic_pdm_ctrl pdm[0];
 } __packed;
 
-/* ALH Configuration Request - SOF_IPC_DAI_ALH_CONFIG */
-struct sof_ipc_dai_alh_params {
-	struct sof_ipc_hdr hdr;
-	uint32_t stream_id;
-
-	/* reserved for future use */
-	uint32_t reserved[15];
-} __packed;
-
 #endif
-- 
2.20.1

