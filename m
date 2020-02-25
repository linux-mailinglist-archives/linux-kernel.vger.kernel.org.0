Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F25B516EBF6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 18:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731284AbgBYRBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 12:01:17 -0500
Received: from mga18.intel.com ([134.134.136.126]:25248 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728200AbgBYRBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 12:01:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2020 09:00:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,484,1574150400"; 
   d="scan'208";a="317139651"
Received: from sorin-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.254.45.43])
  by orsmga001.jf.intel.com with ESMTP; 25 Feb 2020 09:00:56 -0800
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
Subject: [PATCH 1/3] soundwire: cadence: remove useless prototypes
Date:   Tue, 25 Feb 2020 11:00:39 -0600
Message-Id: <20200225170041.23644-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225170041.23644-1-pierre-louis.bossart@linux.intel.com>
References: <20200225170041.23644-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These prototypes are no longer used, remove.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index 001457cbe5ad..2de1b2493ffc 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -148,20 +148,12 @@ int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns, bool state);
 void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct dentry *root);
 #endif
 
-int sdw_cdns_get_stream(struct sdw_cdns *cdns,
-			struct sdw_cdns_streams *stream,
-			u32 ch, u32 dir);
 struct sdw_cdns_pdi *sdw_cdns_alloc_pdi(struct sdw_cdns *cdns,
 					struct sdw_cdns_streams *stream,
 					u32 ch, u32 dir, int dai_id);
 void sdw_cdns_config_stream(struct sdw_cdns *cdns,
 			    u32 ch, u32 dir, struct sdw_cdns_pdi *pdi);
 
-int sdw_cdns_pcm_set_stream(struct snd_soc_dai *dai,
-			    void *stream, int direction);
-int sdw_cdns_pdm_set_stream(struct snd_soc_dai *dai,
-			    void *stream, int direction);
-
 enum sdw_command_response
 cdns_reset_page_addr(struct sdw_bus *bus, unsigned int dev_num);
 
-- 
2.20.1

