Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8CD9172AE3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 23:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbgB0WKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 17:10:13 -0500
Received: from mga17.intel.com ([192.55.52.151]:6165 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbgB0WKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 17:10:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 14:10:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,493,1574150400"; 
   d="scan'208";a="317932348"
Received: from azeira-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.251.147.250])
  by orsmga001.jf.intel.com with ESMTP; 27 Feb 2020 14:10:01 -0800
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
Subject: [PATCH v2] soundwire: bus: provide correct return value on error
Date:   Thu, 27 Feb 2020 16:09:49 -0600
Message-Id: <20200227220949.4013-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bard Liao <yung-chuan.liao@linux.intel.com>

It seems to be a typo. It makes more sense to return the return value
of sdw_update() instead of the value we want to update.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---

v2: address Vinod's comment and use single return

 drivers/soundwire/bus.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index ccaa590df61e..488c3c9e4947 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1056,13 +1056,10 @@ static int sdw_initialize_slave(struct sdw_slave *slave)
 	val |= SDW_DP0_INT_PORT_READY | SDW_DP0_INT_BRA_FAILURE;
 
 	ret = sdw_update(slave, SDW_DP0_INTMASK, val, val);
-	if (ret < 0) {
+	if (ret < 0)
 		dev_err(slave->bus->dev,
 			"SDW_DP0_INTMASK read failed:%d\n", ret);
-		return val;
-	}
-
-	return 0;
+	return ret;
 }
 
 static int sdw_handle_dp0_interrupt(struct sdw_slave *slave, u8 *slave_status)
-- 
2.20.1

