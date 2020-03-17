Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0F1C188A65
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 17:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgCQQes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 12:34:48 -0400
Received: from mga06.intel.com ([134.134.136.31]:47605 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726924AbgCQQer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 12:34:47 -0400
IronPort-SDR: zpESST9LheqCZHtruq1nhKpOr/8F10hngymCesxzbSDmd09hyGpIDVxEEPw4Vxa/Imt5nwoak5
 4tj0+Rdb7aeg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 09:34:47 -0700
IronPort-SDR: rYLJdD8Lfn0sRTjyE23iMPSlkpLUdMlt2AMfxyFk826PXDnCR79DMoGweMOmlVOuGl2FpzUoLW
 bH5pwYQD3byg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,565,1574150400"; 
   d="scan'208";a="244533314"
Received: from aavila-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.255.36.39])
  by orsmga003.jf.intel.com with ESMTP; 17 Mar 2020 09:34:44 -0700
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
Subject: [PATCH v2 16/17] soundwire: cadence: multi-link support
Date:   Tue, 17 Mar 2020 11:33:28 -0500
Message-Id: <20200317163329.25501-17-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317163329.25501-1-pierre-louis.bossart@linux.intel.com>
References: <20200317163329.25501-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable multi-link (aka multi-master configuration). In this
configuration, updates and commands with the 'ssp_sync' tag will be
deferred and controlled by the gsync hardware signal.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 55cf219cc908..eedc4cefdab0 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -843,7 +843,13 @@ int sdw_cdns_exit_reset(struct sdw_cdns *cdns)
 		     CDNS_MCP_CONTROL_HW_RST);
 
 	/* commit changes */
-	return cdns_config_update(cdns);
+	cdns_updatel(cdns, CDNS_MCP_CONFIG_UPDATE,
+		     CDNS_MCP_CONFIG_UPDATE_BIT,
+		     CDNS_MCP_CONFIG_UPDATE_BIT);
+
+	/* don't wait here */
+	return 0;
+
 }
 EXPORT_SYMBOL(sdw_cdns_exit_reset);
 
@@ -1104,7 +1110,9 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
 	/* Disable auto bus release */
 	val &= ~CDNS_MCP_CONFIG_BUS_REL;
 
-	/* Multi-master support to be added here */
+	if (cdns->bus.multi_link)
+		/* Set Multi-master mode to take gsync into account */
+		val |= CDNS_MCP_CONFIG_MMASTER;
 
 	/* leave frame delay to hardware default of 0x1F */
 
-- 
2.20.1

