Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 373E918D469
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 17:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbgCTQaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 12:30:12 -0400
Received: from mga05.intel.com ([192.55.52.43]:35562 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727163AbgCTQaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 12:30:11 -0400
IronPort-SDR: 9nCnvpTWPI0mZdzQwDE83vyr1n95kXjq9l1x0wBXc7l5zHA9SfDWzcABRyRye+xQPWGdcfkHLP
 XPH1OJo9aHLg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2020 09:30:10 -0700
IronPort-SDR: 6bn7FFdVrLHJSMqkvB+QYysCZhQCP4T0EM+s/wzOq5LaGg6kRWWemKKPKJXJ/u3PWOPgh9/AF8
 lnAS982dP7WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,285,1580803200"; 
   d="scan'208";a="248930955"
Received: from manallet-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.255.34.12])
  by orsmga006.jf.intel.com with ESMTP; 20 Mar 2020 09:30:06 -0700
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
Subject: [PATCH 3/5] soundwire: master: use device node pointer from master device
Date:   Fri, 20 Mar 2020 11:29:45 -0500
Message-Id: <20200320162947.17663-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200320162947.17663-1-pierre-louis.bossart@linux.intel.com>
References: <20200320162947.17663-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

device_node pointer is required for scanning slave devices, update
it from the master device.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/master.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soundwire/master.c b/drivers/soundwire/master.c
index fbfa1c35137d..817ad434d4af 100644
--- a/drivers/soundwire/master.c
+++ b/drivers/soundwire/master.c
@@ -51,6 +51,7 @@ struct sdw_master_device
 	init_completion(&md->probe_complete);
 
 	md->dev.parent = parent;
+	md->dev.of_node = parent->of_node;
 	md->dev.fwnode = fwnode;
 	md->dev.bus = &sdw_bus_type;
 	md->dev.type = &sdw_master_type;
-- 
2.20.1

