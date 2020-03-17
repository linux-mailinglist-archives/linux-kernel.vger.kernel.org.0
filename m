Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0C7A188A55
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 17:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgCQQeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 12:34:18 -0400
Received: from mga06.intel.com ([134.134.136.31]:47605 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbgCQQeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 12:34:16 -0400
IronPort-SDR: VdJ11Cm17KES/SL0OWwkum0cN2hqywgu2JV3pDEfhhLwcPPDeuTb4zwo72bxGX9q6XfNwvA7IR
 jYFHfjqg3YeA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 09:34:16 -0700
IronPort-SDR: 652AvrA3Fycv6sbd6mmjwONOmjWPar9r6RZx8S6BY1ZDsDs6KF0HEYZMCpYYZPbZ03FGCswarf
 81fiV9aLvJcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,565,1574150400"; 
   d="scan'208";a="244533142"
Received: from aavila-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.255.36.39])
  by orsmga003.jf.intel.com with ESMTP; 17 Mar 2020 09:34:14 -0700
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
Subject: [PATCH v2 04/17] soundwire: cadence: handle error cases with CONFIG_UPDATE
Date:   Tue, 17 Mar 2020 11:33:16 -0500
Message-Id: <20200317163329.25501-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317163329.25501-1-pierre-louis.bossart@linux.intel.com>
References: <20200317163329.25501-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

config_update() may time out or cannot be use in ClockStopMode

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 1bfdc1d4fcb1..d7f01d39767b 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -239,6 +239,11 @@ static int cdns_config_update(struct sdw_cdns *cdns)
 {
 	int ret;
 
+	if (sdw_cdns_is_clock_stop(cdns)) {
+		dev_err(cdns->dev, "Cannot program MCP_CONFIG_UPDATE in ClockStopMode\n");
+		return -EINVAL;
+	}
+
 	ret = cdns_clear_bit(cdns, CDNS_MCP_CONFIG_UPDATE,
 			     CDNS_MCP_CONFIG_UPDATE_BIT);
 	if (ret < 0)
-- 
2.20.1

