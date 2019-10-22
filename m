Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB4DE0E88
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 01:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389685AbfJVXaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 19:30:16 -0400
Received: from mga12.intel.com ([192.55.52.136]:25621 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731847AbfJVXaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 19:30:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2019 16:30:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,218,1569308400"; 
   d="scan'208";a="200952756"
Received: from srajamoh-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.20.203])
  by orsmga003.jf.intel.com with ESMTP; 22 Oct 2019 16:30:13 -0700
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
Subject: [PATCH] soundwire: intel: fix PDI/stream mapping for Bulk
Date:   Tue, 22 Oct 2019 18:29:48 -0500
Message-Id: <20191022232948.17156-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous formula is incorrect for PDI0/1, the mapping is not
linear but has a discontinuity between PDI1 and PDI2.

This change has no effect on PCM PDIs (same mapping).

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index b403ccc832b6..c984261fcc33 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -480,7 +480,10 @@ intel_pdi_shim_configure(struct sdw_intel *sdw, struct sdw_cdns_pdi *pdi)
 	unsigned int link_id = sdw->instance;
 	int pdi_conf = 0;
 
-	pdi->intel_alh_id = (link_id * 16) + pdi->num + 5;
+	/* the Bulk and PCM streams are not contiguous */
+	pdi->intel_alh_id = (link_id * 16) + pdi->num + 3;
+	if (pdi->num >= 2)
+		pdi->intel_alh_id += 2;
 
 	/*
 	 * Program stream parameters to stream SHIM register
@@ -509,7 +512,10 @@ intel_pdi_alh_configure(struct sdw_intel *sdw, struct sdw_cdns_pdi *pdi)
 	unsigned int link_id = sdw->instance;
 	unsigned int conf;
 
-	pdi->intel_alh_id = (link_id * 16) + pdi->num + 5;
+	/* the Bulk and PCM streams are not contiguous */
+	pdi->intel_alh_id = (link_id * 16) + pdi->num + 3;
+	if (pdi->num >= 2)
+		pdi->intel_alh_id += 2;
 
 	/* Program Stream config ALH register */
 	conf = intel_readl(alh, SDW_ALH_STRMZCFG(pdi->intel_alh_id));
-- 
2.20.1

