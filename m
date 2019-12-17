Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACD1F123855
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 22:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbfLQVFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 16:05:04 -0500
Received: from mga04.intel.com ([192.55.52.120]:15620 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728168AbfLQVDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 16:03:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 13:03:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,326,1571727600"; 
   d="scan'208";a="240560963"
Received: from smcdonal-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.255.83.42])
  by fmsmga004.fm.intel.com with ESMTP; 17 Dec 2019 13:03:23 -0800
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
Subject: [PATCH v5 04/17] soundwire: bus_type: rename sdw_drv_ to sdw_slave_drv
Date:   Tue, 17 Dec 2019 15:03:01 -0600
Message-Id: <20191217210314.20410-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191217210314.20410-1-pierre-louis.bossart@linux.intel.com>
References: <20191217210314.20410-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before we add master driver support, make sure there is no ambiguity
and no occurrences of sdw_drv_ functions.

No functionality change.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/bus_type.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index 2b2830b622fa..9a0fd3ee1014 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -67,7 +67,7 @@ struct bus_type sdw_bus_type = {
 };
 EXPORT_SYMBOL_GPL(sdw_bus_type);
 
-static int sdw_drv_probe(struct device *dev)
+static int sdw_slave_drv_probe(struct device *dev)
 {
 	struct sdw_slave *slave = to_sdw_slave_device(dev);
 	struct sdw_driver *drv = to_sdw_slave_driver(dev->driver);
@@ -113,7 +113,7 @@ static int sdw_drv_probe(struct device *dev)
 	return 0;
 }
 
-static int sdw_drv_remove(struct device *dev)
+static int sdw_slave_drv_remove(struct device *dev)
 {
 	struct sdw_slave *slave = to_sdw_slave_device(dev);
 	struct sdw_driver *drv = to_sdw_slave_driver(dev->driver);
@@ -127,7 +127,7 @@ static int sdw_drv_remove(struct device *dev)
 	return ret;
 }
 
-static void sdw_drv_shutdown(struct device *dev)
+static void sdw_slave_drv_shutdown(struct device *dev)
 {
 	struct sdw_slave *slave = to_sdw_slave_device(dev);
 	struct sdw_driver *drv = to_sdw_slave_driver(dev->driver);
@@ -155,13 +155,13 @@ int __sdw_register_slave_driver(struct sdw_driver *drv,
 	}
 
 	drv->driver.owner = owner;
-	drv->driver.probe = sdw_drv_probe;
+	drv->driver.probe = sdw_slave_drv_probe;
 
 	if (drv->remove)
-		drv->driver.remove = sdw_drv_remove;
+		drv->driver.remove = sdw_slave_drv_remove;
 
 	if (drv->shutdown)
-		drv->driver.shutdown = sdw_drv_shutdown;
+		drv->driver.shutdown = sdw_slave_drv_shutdown;
 
 	return driver_register(&drv->driver);
 }
-- 
2.20.1

