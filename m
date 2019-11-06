Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D862BF1E6C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 20:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732590AbfKFTOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 14:14:44 -0500
Received: from mga12.intel.com ([192.55.52.136]:4046 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732077AbfKFTOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 14:14:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 11:14:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400"; 
   d="scan'208";a="402465808"
Received: from vidhipat-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.254.33.70])
  by fmsmga005.fm.intel.com with ESMTP; 06 Nov 2019 11:14:14 -0800
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
Subject: [PATCH v2 07/14] soundwire: add initial definitions for sdw_master_device
Date:   Wed,  6 Nov 2019 13:13:51 -0600
Message-Id: <20191106191358.5712-8-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191106191358.5712-1-pierre-louis.bossart@linux.intel.com>
References: <20191106191358.5712-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we want an explicit support for the SoundWire Master device, add
the definitions, following the Grey Bus example.

Unlike for the Slave device, we do not set a variable when dealing
with the master uevent.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/Makefile         |  2 +-
 drivers/soundwire/bus_type.c       |  4 +-
 drivers/soundwire/master.c         | 62 ++++++++++++++++++++++++++++++
 include/linux/soundwire/sdw.h      | 35 +++++++++++++++++
 include/linux/soundwire/sdw_type.h |  9 +++++
 5 files changed, 109 insertions(+), 3 deletions(-)
 create mode 100644 drivers/soundwire/master.c

diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
index 563894e5ecaf..89b29819dd3a 100644
--- a/drivers/soundwire/Makefile
+++ b/drivers/soundwire/Makefile
@@ -4,7 +4,7 @@
 #
 
 #Bus Objs
-soundwire-bus-objs := bus_type.o bus.o slave.o mipi_disco.o stream.o
+soundwire-bus-objs := bus_type.o bus.o master.o slave.o mipi_disco.o stream.o
 obj-$(CONFIG_SOUNDWIRE) += soundwire-bus.o
 
 ifdef CONFIG_DEBUG_FS
diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index bbdedce5eb26..fd234f63bf2f 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -59,8 +59,8 @@ static int sdw_uevent(struct device *dev, struct kobj_uevent_env *env)
 
 		if (add_uevent_var(env, "MODALIAS=%s", modalias))
 			return -ENOMEM;
-	} else {
-		/* only Slave device type supported */
+	} else if (!is_sdw_md(dev)) {
+		/* only Slave and Master device type supported */
 		dev_warn(dev, "uevent for unknown Soundwire type\n");
 		return -EINVAL;
 	}
diff --git a/drivers/soundwire/master.c b/drivers/soundwire/master.c
new file mode 100644
index 000000000000..6210098c892b
--- /dev/null
+++ b/drivers/soundwire/master.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// Copyright(c) 2019 Intel Corporation.
+
+#include <linux/device.h>
+#include <linux/acpi.h>
+#include <linux/soundwire/sdw.h>
+#include <linux/soundwire/sdw_type.h>
+#include "bus.h"
+
+static void sdw_md_release(struct device *dev)
+{
+	struct sdw_master_device *md = to_sdw_master_device(dev);
+
+	kfree(md);
+}
+
+struct device_type sdw_md_type = {
+	.name =		"soundwire_master",
+	.release =	sdw_md_release,
+};
+
+struct sdw_master_device *sdw_md_add(struct sdw_md_driver *driver,
+				     struct device *parent,
+				     struct fwnode_handle *fwnode,
+				     int link_id)
+{
+	struct sdw_master_device *md;
+	int ret;
+
+	if (!driver->probe) {
+		dev_err(parent, "mandatory probe callback missing\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	md = kzalloc(sizeof(*md), GFP_KERNEL);
+	if (!md)
+		return ERR_PTR(-ENOMEM);
+
+	md->link_id = link_id;
+
+	md->driver = driver;
+
+	md->dev.parent = parent;
+	md->dev.fwnode = fwnode;
+	md->dev.bus = &sdw_bus_type;
+	md->dev.type = &sdw_md_type;
+	md->dev.dma_mask = md->dev.parent->dma_mask;
+	dev_set_name(&md->dev, "sdw-master-%d", md->link_id);
+
+	ret = device_register(&md->dev);
+	if (ret) {
+		dev_err(parent, "Failed to add master: ret %d\n", ret);
+		/*
+		 * On err, don't free but drop ref as this will be freed
+		 * when release method is invoked.
+		 */
+		put_device(&md->dev);
+	}
+
+	return md;
+}
+EXPORT_SYMBOL(sdw_md_add);
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 3b618d7e6641..9efb71e9d2f6 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -579,6 +579,16 @@ struct sdw_slave {
 #define to_sdw_slave_device(d) \
 	container_of(d, struct sdw_slave, dev)
 
+struct sdw_master_device {
+	struct device dev;
+	int link_id;
+	struct sdw_md_driver *driver;
+	void *pdata; /* core does not touch */
+};
+
+#define to_sdw_master_device(d)	\
+	container_of(d, struct sdw_master_device, dev)
+
 struct sdw_driver {
 	const char *name;
 
@@ -593,6 +603,26 @@ struct sdw_driver {
 	struct device_driver driver;
 };
 
+struct sdw_md_driver {
+	/* initializations and allocations */
+	int (*probe)(struct sdw_master_device *md, void *link_ctx);
+	/* hardware enablement, all clock/power dependencies are available */
+	int (*startup)(struct sdw_master_device *md);
+	/* hardware disabled */
+	int (*shutdown)(struct sdw_master_device *md);
+	/* free all resources */
+	int (*remove)(struct sdw_master_device *md);
+	/*
+	 * enable/disable driver control while in clock-stop mode,
+	 * typically in always-on/D0ix modes. When the driver yields
+	 * control, another entity in the system (typically firmware
+	 * running on an always-on microprocessor) is responsible to
+	 * tracking Slave-initiated wakes
+	 */
+	int (*autonomous_clock_stop_enable)(struct sdw_master_device *md,
+					    bool state);
+};
+
 #define SDW_SLAVE_ENTRY(_mfg_id, _part_id, _drv_data) \
 	{ .mfg_id = (_mfg_id), .part_id = (_part_id), \
 	  .driver_data = (unsigned long)(_drv_data) }
@@ -782,6 +812,11 @@ struct sdw_bus {
 int sdw_add_bus_master(struct sdw_bus *bus);
 void sdw_delete_bus_master(struct sdw_bus *bus);
 
+struct sdw_master_device *sdw_md_add(struct sdw_md_driver *driver,
+				     struct device *parent,
+				     struct fwnode_handle *fwnode,
+				     int link_id);
+
 /**
  * sdw_port_config: Master or Slave Port configuration
  *
diff --git a/include/linux/soundwire/sdw_type.h b/include/linux/soundwire/sdw_type.h
index c681b3426478..463d6d018d56 100644
--- a/include/linux/soundwire/sdw_type.h
+++ b/include/linux/soundwire/sdw_type.h
@@ -6,15 +6,24 @@
 
 extern struct bus_type sdw_bus_type;
 extern struct device_type sdw_slave_type;
+extern struct device_type sdw_md_type;
 
 static inline int is_sdw_slave(const struct device *dev)
 {
 	return dev->type == &sdw_slave_type;
 }
 
+static inline int is_sdw_md(const struct device *dev)
+{
+	return dev->type == &sdw_md_type;
+}
+
 #define to_sdw_slave_driver(_drv) \
 	container_of(_drv, struct sdw_driver, driver)
 
+#define to_sdw_md_driver(_drv) \
+	container_of(_drv, struct sdw_md_driver, driver)
+
 #define sdw_register_slave_driver(drv) \
 	__sdw_register_slave_driver(drv, THIS_MODULE)
 
-- 
2.20.1

