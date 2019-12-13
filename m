Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A18711DD5A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2019 06:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731966AbfLMFEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Dec 2019 00:04:22 -0500
Received: from mga18.intel.com ([134.134.136.126]:21156 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727395AbfLMFEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 00:04:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 21:04:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,308,1571727600"; 
   d="scan'208";a="208340693"
Received: from vbagrodi-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.251.130.70])
  by orsmga008.jf.intel.com with ESMTP; 12 Dec 2019 21:04:18 -0800
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
Subject: [PATCH v4 03/15] soundwire: rename drv_to_sdw_slave_driver macro
Date:   Thu, 12 Dec 2019 23:03:57 -0600
Message-Id: <20191213050409.12776-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191213050409.12776-1-pierre-louis.bossart@linux.intel.com>
References: <20191213050409.12776-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align with previous renames and shorten macro

No functionality change

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/bus_type.c       | 9 ++++-----
 include/linux/soundwire/sdw_type.h | 3 ++-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index c0585bcc8a41..2b2830b622fa 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -34,7 +34,7 @@ sdw_get_device_id(struct sdw_slave *slave, struct sdw_driver *drv)
 static int sdw_bus_match(struct device *dev, struct device_driver *ddrv)
 {
 	struct sdw_slave *slave = to_sdw_slave_device(dev);
-	struct sdw_driver *drv = drv_to_sdw_slave_driver(ddrv);
+	struct sdw_driver *drv = to_sdw_slave_driver(ddrv);
 
 	return !!sdw_get_device_id(slave, drv);
 }
@@ -70,7 +70,7 @@ EXPORT_SYMBOL_GPL(sdw_bus_type);
 static int sdw_drv_probe(struct device *dev)
 {
 	struct sdw_slave *slave = to_sdw_slave_device(dev);
-	struct sdw_driver *drv = drv_to_sdw_slave_driver(dev->driver);
+	struct sdw_driver *drv = to_sdw_slave_driver(dev->driver);
 	const struct sdw_device_id *id;
 	int ret;
 
@@ -116,8 +116,7 @@ static int sdw_drv_probe(struct device *dev)
 static int sdw_drv_remove(struct device *dev)
 {
 	struct sdw_slave *slave = to_sdw_slave_device(dev);
-	struct sdw_driver *drv = drv_to_sdw_slave_driver(dev->driver);
-
+	struct sdw_driver *drv = to_sdw_slave_driver(dev->driver);
 	int ret = 0;
 
 	if (drv->remove)
@@ -131,7 +130,7 @@ static int sdw_drv_remove(struct device *dev)
 static void sdw_drv_shutdown(struct device *dev)
 {
 	struct sdw_slave *slave = to_sdw_slave_device(dev);
-	struct sdw_driver *drv = drv_to_sdw_slave_driver(dev->driver);
+	struct sdw_driver *drv = to_sdw_slave_driver(dev->driver);
 
 	if (drv->shutdown)
 		drv->shutdown(slave);
diff --git a/include/linux/soundwire/sdw_type.h b/include/linux/soundwire/sdw_type.h
index abaa21278152..7d4bc6a979bf 100644
--- a/include/linux/soundwire/sdw_type.h
+++ b/include/linux/soundwire/sdw_type.h
@@ -6,7 +6,7 @@
 
 extern struct bus_type sdw_bus_type;
 
-#define drv_to_sdw_slave_driver(_drv) \
+#define to_sdw_slave_driver(_drv) \
 	container_of(_drv, struct sdw_driver, driver)
 
 #define sdw_register_slave_driver(drv) \
@@ -29,4 +29,5 @@ int sdw_slave_modalias(const struct sdw_slave *slave, char *buf, size_t size);
 #define module_sdw_driver(__sdw_slave_driver) \
 	module_driver(__sdw_slave_driver, sdw_register_slave_driver, \
 			sdw_unregister_slave_driver)
+
 #endif /* __SOUNDWIRE_TYPES_H */
-- 
2.20.1

