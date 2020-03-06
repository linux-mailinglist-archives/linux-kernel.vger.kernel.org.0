Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB7817B506
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 04:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgCFDnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 22:43:42 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11179 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726251AbgCFDnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 22:43:42 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7A5B81D8692CED9F8EA4;
        Fri,  6 Mar 2020 11:43:40 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Fri, 6 Mar 2020 11:43:33 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <puck.chen@hisilicon.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <tzimmermann@suse.de>, <kraxel@redhat.com>,
        <alexander.deucher@amd.com>, <tglx@linutronix.de>,
        <dri-devel@lists.freedesktop.org>, <xinliang.liu@linaro.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH 3/4] drm/hisilicon: Add the load and unload for hibmc_driver
Date:   Fri, 6 Mar 2020 11:43:03 +0800
Message-ID: <1583466184-7060-6-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583466184-7060-1-git-send-email-tiantao6@hisilicon.com>
References: <1583466184-7060-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

using the load and unload function provided by drm framework instead of
doing the same work in the hibmc_pci_probe and do some code cleanup.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
Signed-off-by: Gong junjie <gongjunjie2@huawei.com>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 62 +++++++++----------------
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h |  2 +
 2 files changed, 24 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index 79a180a..51f1c70 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -23,7 +23,7 @@
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
-
+#include <drm/drm_pci.h>
 #include "hibmc_drm_drv.h"
 #include "hibmc_drm_regs.h"
 
@@ -49,6 +49,8 @@ static irqreturn_t hibmc_drm_interrupt(int irq, void *arg)
 
 static struct drm_driver hibmc_driver = {
 	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
+	.load			= hibmc_load,
+	.unload			= hibmc_unload,
 	.fops			= &hibmc_fops,
 	.name			= "hibmc",
 	.date			= "20160828",
@@ -232,6 +234,21 @@ static int hibmc_hw_map(struct hibmc_drm_private *priv)
 	return 0;
 }
 
+static void hibmc_hw_unmap(struct hibmc_drm_private *priv)
+{
+	struct drm_device *dev = priv->dev;
+
+	if (priv->mmio) {
+		devm_iounmap(dev->dev, priv->mmio);
+		priv->mmio = NULL;
+	}
+
+	if (priv->fb_map) {
+		devm_iounmap(dev->dev, priv->fb_map);
+		priv->fb_map = NULL;
+	}
+}
+
 static int hibmc_hw_init(struct hibmc_drm_private *priv)
 {
 	int ret;
@@ -245,7 +262,7 @@ static int hibmc_hw_init(struct hibmc_drm_private *priv)
 	return 0;
 }
 
-static int hibmc_unload(struct drm_device *dev)
+void hibmc_unload(struct drm_device *dev)
 {
 	struct hibmc_drm_private *priv = dev->dev_private;
 
@@ -258,11 +275,12 @@ static int hibmc_unload(struct drm_device *dev)
 
 	hibmc_kms_fini(priv);
 	hibmc_mm_fini(priv);
+	hibmc_hw_unmap(priv);
 	dev->dev_private = NULL;
 	return 0;
 }
 
-static int hibmc_load(struct drm_device *dev)
+int hibmc_load(struct drm_device *dev, unsigned long flags)
 {
 	struct hibmc_drm_private *priv;
 	int ret;
@@ -332,43 +350,7 @@ static int hibmc_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		return ret;
 
-	dev = drm_dev_alloc(&hibmc_driver, &pdev->dev);
-	if (IS_ERR(dev)) {
-		DRM_ERROR("failed to allocate drm_device\n");
-		return PTR_ERR(dev);
-	}
-
-	dev->pdev = pdev;
-	pci_set_drvdata(pdev, dev);
-
-	ret = pci_enable_device(pdev);
-	if (ret) {
-		DRM_ERROR("failed to enable pci device: %d\n", ret);
-		goto err_free;
-	}
-
-	ret = hibmc_load(dev);
-	if (ret) {
-		DRM_ERROR("failed to load hibmc: %d\n", ret);
-		goto err_disable;
-	}
-
-	ret = drm_dev_register(dev, 0);
-	if (ret) {
-		DRM_ERROR("failed to register drv for userspace access: %d\n",
-			  ret);
-		goto err_unload;
-	}
-	return 0;
-
-err_unload:
-	hibmc_unload(dev);
-err_disable:
-	pci_disable_device(pdev);
-err_free:
-	drm_dev_put(dev);
-
-	return ret;
+	return drm_get_pci_dev(pdev, ent, &hibmc_driver);
 }
 
 static void hibmc_pci_remove(struct pci_dev *pdev)
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
index 50a0c1f..4e89cd7 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
@@ -37,6 +37,8 @@ void hibmc_set_power_mode(struct hibmc_drm_private *priv,
 void hibmc_set_current_gate(struct hibmc_drm_private *priv,
 			    unsigned int gate);
 
+int hibmc_load(struct drm_device *dev, unsigned long flags);
+void hibmc_unload(struct drm_device *dev);
 int hibmc_de_init(struct hibmc_drm_private *priv);
 int hibmc_vdac_init(struct hibmc_drm_private *priv);
 
-- 
2.7.4

