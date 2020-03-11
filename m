Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEF7182108
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 19:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730989AbgCKSmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 14:42:05 -0400
Received: from mga18.intel.com ([134.134.136.126]:27194 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730978AbgCKSmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 14:42:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 11:42:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,541,1574150400"; 
   d="scan'208";a="441776304"
Received: from fjan-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.251.25.157])
  by fmsmga005.fm.intel.com with ESMTP; 11 Mar 2020 11:42:00 -0700
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
Subject: [PATCH 11/16] soundwire: cadence: reorder MCP_CONFIG settings
Date:   Wed, 11 Mar 2020 13:41:23 -0500
Message-Id: <20200311184128.4212-12-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200311184128.4212-1-pierre-louis.bossart@linux.intel.com>
References: <20200311184128.4212-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow hardware programming flows and add placeholder comment for
multi-master mode.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 4a7e7329ff0d..dd8c9b051037 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -1097,21 +1097,23 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
 	/* Configure mcp config */
 	val = cdns_readl(cdns, CDNS_MCP_CONFIG);
 
-	/* Set Max cmd retry to 15 */
-	val |= CDNS_MCP_CONFIG_MCMD_RETRY;
-
-	/* Set frame delay between PREQ and ping frame to 15 frames */
-	val |= 0xF << SDW_REG_SHIFT(CDNS_MCP_CONFIG_MPREQ_DELAY);
-
-	/* Disable auto bus release */
-	val &= ~CDNS_MCP_CONFIG_BUS_REL;
-
-	/* Disable sniffer mode */
-	val &= ~CDNS_MCP_CONFIG_SNIFFER;
-
 	/* Set cmd mode for Tx and Rx cmds */
 	val &= ~CDNS_MCP_CONFIG_CMD;
 
+	/* Disable sniffer mode */
+	val &= ~CDNS_MCP_CONFIG_SNIFFER;
+
+	/* Disable auto bus release */
+	val &= ~CDNS_MCP_CONFIG_BUS_REL;
+
+	/* Multi-master support to be added here */
+
+	/* Set frame delay between PREQ and ping frame to 15 frames */
+	val |= 0xF << SDW_REG_SHIFT(CDNS_MCP_CONFIG_MPREQ_DELAY);
+
+	/* Set Max cmd retry to 15 */
+	val |= CDNS_MCP_CONFIG_MCMD_RETRY;
+
 	cdns_writel(cdns, CDNS_MCP_CONFIG, val);
 
 	/* commit changes */
-- 
2.20.1

