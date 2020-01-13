Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A798139B3E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 22:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbgAMVKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 16:10:33 -0500
Received: from mga04.intel.com ([192.55.52.120]:4309 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbgAMVKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 16:10:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2020 13:10:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,430,1571727600"; 
   d="scan'208";a="213114390"
Received: from pboliset-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.251.152.72])
  by orsmga007.jf.intel.com with ESMTP; 13 Jan 2020 13:10:29 -0800
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
Subject: [PATCH 1/2] soundwire: cadence: update kernel-doc parameter descriptions
Date:   Mon, 13 Jan 2020 15:10:24 -0600
Message-Id: <20200113211025.27973-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200113211025.27973-1-pierre-louis.bossart@linux.intel.com>
References: <20200113211025.27973-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make W=1 reports inconsistencies with parameter descriptions, fix

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index fed21e2b2277..377628de380d 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -814,6 +814,7 @@ EXPORT_SYMBOL(sdw_cdns_exit_reset);
 /**
  * sdw_cdns_enable_interrupt() - Enable SDW interrupts and update config
  * @cdns: Cadence instance
+ * @state: True if we are trying to enable interrupt.
  */
 int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns, bool state)
 {
@@ -1224,8 +1225,10 @@ EXPORT_SYMBOL(cdns_set_sdw_stream);
  * cdns_find_pdi() - Find a free PDI
  *
  * @cdns: Cadence instance
+ * @offset: Starting offset
  * @num: Number of PDIs
  * @pdi: PDI instances
+ * @dai_id: DAI id
  *
  * Find a PDI for a given PDI array. The PDI num and dai_id are
  * expected to match, return NULL otherwise.
@@ -1277,6 +1280,7 @@ EXPORT_SYMBOL(sdw_cdns_config_stream);
  * @stream: Stream to be allocated
  * @ch: Channel count
  * @dir: Data direction
+ * @dai_id: DAI id
  */
 struct sdw_cdns_pdi *sdw_cdns_alloc_pdi(struct sdw_cdns *cdns,
 					struct sdw_cdns_streams *stream,
-- 
2.20.1

