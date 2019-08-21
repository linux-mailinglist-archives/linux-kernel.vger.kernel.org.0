Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52ABC98525
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 22:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730417AbfHUUFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 16:05:38 -0400
Received: from mga09.intel.com ([134.134.136.24]:53248 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730378AbfHUUFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 16:05:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 13:05:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="196069752"
Received: from smasango-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.252.139.100])
  by fmsmga001.fm.intel.com with ESMTP; 21 Aug 2019 13:05:33 -0700
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
Subject: [RFC PATCH 03/11] soundwire: intel: remove playback/capture stream_name
Date:   Wed, 21 Aug 2019 15:05:13 -0500
Message-Id: <20190821200521.17283-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821200521.17283-1-pierre-louis.bossart@linux.intel.com>
References: <20190821200521.17283-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bard Liao <yung-chuan.liao@linux.intel.com>

We will create dai widget in SOF.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index d5563cfc6549..883289a04c82 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -922,14 +922,6 @@ static int intel_create_dai(struct sdw_cdns *cdns,
 			return -ENOMEM;
 
 		if (type == INTEL_PDI_BD || type == INTEL_PDI_OUT) {
-			dais[i].playback.stream_name =
-				kasprintf(GFP_KERNEL, "SDW%d Tx%d",
-					  cdns->instance, i);
-			if (!dais[i].playback.stream_name) {
-				kfree(dais[i].name);
-				return -ENOMEM;
-			}
-
 			dais[i].playback.channels_min = 1;
 			dais[i].playback.channels_max = max_ch;
 			dais[i].playback.rates = SNDRV_PCM_RATE_48000;
@@ -937,15 +929,6 @@ static int intel_create_dai(struct sdw_cdns *cdns,
 		}
 
 		if (type == INTEL_PDI_BD || type == INTEL_PDI_IN) {
-			dais[i].capture.stream_name =
-				kasprintf(GFP_KERNEL, "SDW%d Rx%d",
-					  cdns->instance, i);
-			if (!dais[i].capture.stream_name) {
-				kfree(dais[i].name);
-				kfree(dais[i].playback.stream_name);
-				return -ENOMEM;
-			}
-
 			dais[i].capture.channels_min = 1;
 			dais[i].capture.channels_max = max_ch;
 			dais[i].capture.rates = SNDRV_PCM_RATE_48000;
-- 
2.20.1

