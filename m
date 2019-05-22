Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7121926E48
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 21:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732383AbfEVTsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 15:48:10 -0400
Received: from mga01.intel.com ([192.55.52.88]:47986 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387951AbfEVTsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:48:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 May 2019 12:48:06 -0700
X-ExtLoop1: 1
Received: from cjpowell-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.154.39])
  by fmsmga008.fm.intel.com with ESMTP; 22 May 2019 12:48:04 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH v2 13/15] soundwire: Intel: add log for number of PCM and PDM PDIs
Date:   Wed, 22 May 2019 14:47:29 -0500
Message-Id: <20190522194732.25704-14-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522194732.25704-1-pierre-louis.bossart@linux.intel.com>
References: <20190522194732.25704-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This information will be reflected in debugfs but it's easier to see
as a dmesg log.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 4ac141730b13..92be6ad84e8d 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -263,6 +263,9 @@ static void intel_pdi_init(struct sdw_intel *sdw,
 	config->pcm_out = (pcm_cap & SDW_SHIM_PCMSCAP_OSS) >>
 					SDW_REG_SHIFT(SDW_SHIM_PCMSCAP_OSS);
 
+	dev_dbg(sdw->cdns.dev, "PCM cap bd:%d in:%d out:%d\n",
+		config->pcm_bd, config->pcm_in, config->pcm_out);
+
 	/* PDM Stream Capability */
 	pdm_cap = intel_readw(shim, SDW_SHIM_PDMSCAP(link_id));
 
@@ -272,6 +275,9 @@ static void intel_pdi_init(struct sdw_intel *sdw,
 					SDW_REG_SHIFT(SDW_SHIM_PDMSCAP_ISS);
 	config->pdm_out = (pdm_cap & SDW_SHIM_PDMSCAP_OSS) >>
 					SDW_REG_SHIFT(SDW_SHIM_PDMSCAP_OSS);
+
+	dev_dbg(sdw->cdns.dev, "PDM cap bd:%d in:%d out:%d\n",
+		config->pdm_bd, config->pdm_in, config->pdm_out);
 }
 
 static int
-- 
2.20.1

