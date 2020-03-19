Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1545E18BB4B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 16:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgCSPlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 11:41:13 -0400
Received: from inva021.nxp.com ([92.121.34.21]:51828 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728077AbgCSPlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 11:41:12 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C5EC12000D3;
        Thu, 19 Mar 2020 16:41:10 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B81182000C1;
        Thu, 19 Mar 2020 16:41:10 +0100 (CET)
Received: from fsr-ub1864-111.ea.freescale.net (fsr-ub1864-111.ea.freescale.net [10.171.82.141])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 520F8205C2;
        Thu, 19 Mar 2020 16:41:10 +0100 (CET)
From:   Diana Craciun <diana.craciun@oss.nxp.com>
To:     linux-kernel@vger.kernel.org, laurentiu.tudor@nxp.com,
        stuyoder@gmail.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, bharatb.yadav@gmail.com
Cc:     Bharat Bhushan <Bharat.Bhushan@nxp.com>,
        "J . German Rivera" <German.Rivera@freescale.com>,
        Stuart Yoder <stuart.yoder@nxp.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>
Subject: [PATCH 04/10] bus/fsl-mc: Propagate driver_override for a child DPRC's children
Date:   Thu, 19 Mar 2020 17:40:45 +0200
Message-Id: <20200319154051.30609-5-diana.craciun@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200319154051.30609-1-diana.craciun@oss.nxp.com>
References: <20200319154051.30609-1-diana.craciun@oss.nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bharat Bhushan <Bharat.Bhushan@nxp.com>

When a child DPRC is bound to the vfio_fsl_mc driver via
driver_override, its own children should not be bound to corresponding
host kernel drivers, but instead should be bound to the vfio_fsl_mc
driver as well.

Currently, when a child container is scanned by the vfio_fsl_mc
driver, child devices found are automatically bound to corresponding
host kernel drivers (e.g., DPMCP and DPBP objects are bound to the
fsl_mc_allocator driver, DPNI objects are bound to the ldpaa_eth
driver, etc), Then, the user has to manually unbind these child
devices from their drivers, set the driver_override sysfs attribute
to vfio_fsl_mc driver, for each of them and rebind them.

Signed-off-by: J. German Rivera <German.Rivera@freescale.com>
Signed-off-by: Stuart Yoder <stuart.yoder@nxp.com>
Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
---
 drivers/bus/fsl-mc/dprc-driver.c    | 12 ++++++++----
 drivers/bus/fsl-mc/fsl-mc-bus.c     | 18 +++++++++++++++++-
 drivers/bus/fsl-mc/fsl-mc-private.h |  2 ++
 include/linux/fsl/mc.h              |  2 ++
 4 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
index d373b28abe2d..7eaf78900dfc 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -155,6 +155,8 @@ static void check_plugged_state_change(struct fsl_mc_device *mc_dev,
  * dprc_add_new_devices - Adds devices to the logical bus for a DPRC
  *
  * @mc_bus_dev: pointer to the fsl-mc device that represents a DPRC object
+ * @driver_override: driver override to apply to new objects found in the
+ * DPRC, or NULL, if none.
  * @obj_desc_array: array of device descriptors for child devices currently
  * present in the physical DPRC.
  * @num_child_objects_in_mc: number of entries in obj_desc_array
@@ -164,6 +166,7 @@ static void check_plugged_state_change(struct fsl_mc_device *mc_dev,
  * in the physical DPRC.
  */
 static void dprc_add_new_devices(struct fsl_mc_device *mc_bus_dev,
+				 const char *driver_override,
 				 struct fsl_mc_obj_desc *obj_desc_array,
 				 int num_child_objects_in_mc)
 {
@@ -188,7 +191,7 @@ static void dprc_add_new_devices(struct fsl_mc_device *mc_bus_dev,
 		}
 
 		error = fsl_mc_device_add(obj_desc, NULL, &mc_bus_dev->dev,
-					  &child_dev);
+					  driver_override, &child_dev);
 		if (error < 0)
 			continue;
 	}
@@ -214,6 +217,7 @@ static void dprc_add_new_devices(struct fsl_mc_device *mc_bus_dev,
  * of the device drivers for the non-allocatable devices.
  */
 static int dprc_scan_objects(struct fsl_mc_device *mc_bus_dev,
+			    const char *driver_override,
 			    bool alloc_interrupts)
 {
 	int num_child_objects;
@@ -313,7 +317,7 @@ static int dprc_scan_objects(struct fsl_mc_device *mc_bus_dev,
 	dprc_remove_devices(mc_bus_dev, child_obj_desc_array,
 			    num_child_objects);
 
-	dprc_add_new_devices(mc_bus_dev, child_obj_desc_array,
+	dprc_add_new_devices(mc_bus_dev, driver_override, child_obj_desc_array,
 			     num_child_objects);
 
 	if (child_obj_desc_array)
@@ -342,7 +346,7 @@ static int dprc_scan_container(struct fsl_mc_device *mc_bus_dev)
 	 * Discover objects in the DPRC:
 	 */
 	mutex_lock(&mc_bus->scan_mutex);
-	error = dprc_scan_objects(mc_bus_dev, true);
+	error = dprc_scan_objects(mc_bus_dev, NULL, true);
 	mutex_unlock(&mc_bus->scan_mutex);
 	if (error < 0) {
 		fsl_mc_cleanup_all_resource_pools(mc_bus_dev);
@@ -412,7 +416,7 @@ static irqreturn_t dprc_irq0_handler_thread(int irq_num, void *arg)
 		      DPRC_IRQ_EVENT_OBJ_DESTROYED |
 		      DPRC_IRQ_EVENT_OBJ_CREATED)) {
 
-		error = dprc_scan_objects(mc_dev, true);
+		error = dprc_scan_objects(mc_dev, NULL, true);
 		if (error < 0) {
 			/*
 			 * If the error is -ENXIO, we ignore it, as it indicates
diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index baf8259262a9..b9ccac9862b7 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -617,6 +617,7 @@ static void fsl_mc_device_release(struct device *dev)
 int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 		      struct fsl_mc_io *mc_io,
 		      struct device *parent_dev,
+		      const char *driver_override,
 		      struct fsl_mc_device **new_mc_dev)
 {
 	int error;
@@ -649,6 +650,19 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 
 	mc_dev->obj_desc = *obj_desc;
 	mc_dev->mc_io = mc_io;
+
+	if (driver_override) {
+		/*
+		 * We trust driver_override, so we don't need to use
+		 * kstrndup() here
+		 */
+		mc_dev->driver_override = kstrdup(driver_override, GFP_KERNEL);
+		if (!mc_dev->driver_override) {
+			error = -ENOMEM;
+			goto error_cleanup_dev;
+		}
+	}
+
 	device_initialize(&mc_dev->dev);
 	mc_dev->dev.parent = parent_dev;
 	mc_dev->dev.bus = &fsl_mc_bus_type;
@@ -740,6 +754,7 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 
 error_cleanup_dev:
 	kfree(mc_dev->regions);
+	kfree(mc_dev->driver_override);
 	kfree(mc_bus);
 	kfree(mc_dev);
 
@@ -980,7 +995,8 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 	obj_desc.irq_count = 1;
 	obj_desc.region_count = 0;
 
-	error = fsl_mc_device_add(&obj_desc, mc_io, &pdev->dev, &mc_bus_dev);
+	error = fsl_mc_device_add(&obj_desc, mc_io, &pdev->dev, NULL,
+				 &mc_bus_dev);
 	if (error < 0)
 		goto error_cleanup_mc_io;
 
diff --git a/drivers/bus/fsl-mc/fsl-mc-private.h b/drivers/bus/fsl-mc/fsl-mc-private.h
index 21ca8c756ee7..be6bb0fb4603 100644
--- a/drivers/bus/fsl-mc/fsl-mc-private.h
+++ b/drivers/bus/fsl-mc/fsl-mc-private.h
@@ -3,6 +3,7 @@
  * Freescale Management Complex (MC) bus private declarations
  *
  * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2019-2020 NXP
  *
  */
 #ifndef _FSL_MC_PRIVATE_H_
@@ -567,6 +568,7 @@ struct fsl_mc_bus {
 int __must_check fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 				   struct fsl_mc_io *mc_io,
 				   struct device *parent_dev,
+				   const char *driver_override,
 				   struct fsl_mc_device **new_mc_dev);
 
 void fsl_mc_device_remove(struct fsl_mc_device *mc_dev);
diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index 88095fd30c80..f997f8091408 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -3,6 +3,7 @@
  * Freescale Management Complex (MC) bus public interface
  *
  * Copyright (C) 2014-2016 Freescale Semiconductor, Inc.
+ * Copyright 2019-2020 NXP
  * Author: German Rivera <German.Rivera@freescale.com>
  *
  */
@@ -161,6 +162,7 @@ struct fsl_mc_obj_desc {
  * @regions: pointer to array of MMIO region entries
  * @irqs: pointer to array of pointers to interrupts allocated to this device
  * @resource: generic resource associated with this MC object device, if any.
+ * @driver_override: Driver name to force a match
  *
  * Generic device object for MC object devices that are "attached" to a
  * MC bus.
-- 
2.17.1

