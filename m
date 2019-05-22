Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D80B261D3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 12:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbfEVKf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 06:35:28 -0400
Received: from foss.arm.com ([217.140.101.70]:46968 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729175AbfEVKfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 06:35:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F2BD15AB;
        Wed, 22 May 2019 03:35:23 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2FB593F575;
        Wed, 22 May 2019 03:35:22 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v4 04/30] coresight: catu: Cleanup device specific data
Date:   Wed, 22 May 2019 11:34:37 +0100
Message-Id: <1558521304-27469-5-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558521304-27469-1-git-send-email-suzuki.poulose@arm.com>
References: <1558521304-27469-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to using the CoreSight device instead of the real
amba device.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-catu.c | 13 +++++++------
 drivers/hwtracing/coresight/coresight-catu.h |  1 -
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index d948a72..63109c9 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -408,13 +408,14 @@ static int catu_enable_hw(struct catu_drvdata *drvdata, void *data)
 	int rc;
 	u32 control, mode;
 	struct etr_buf *etr_buf = data;
+	struct device *dev = &drvdata->csdev->dev;
 
 	if (catu_wait_for_ready(drvdata))
-		dev_warn(drvdata->dev, "Timeout while waiting for READY\n");
+		dev_warn(dev, "Timeout while waiting for READY\n");
 
 	control = catu_read_control(drvdata);
 	if (control & BIT(CATU_CONTROL_ENABLE)) {
-		dev_warn(drvdata->dev, "CATU is already enabled\n");
+		dev_warn(dev, "CATU is already enabled\n");
 		return -EBUSY;
 	}
 
@@ -440,7 +441,7 @@ static int catu_enable_hw(struct catu_drvdata *drvdata, void *data)
 	catu_write_irqen(drvdata, 0);
 	catu_write_mode(drvdata, mode);
 	catu_write_control(drvdata, control);
-	dev_dbg(drvdata->dev, "Enabled in %s mode\n",
+	dev_dbg(dev, "Enabled in %s mode\n",
 		(mode == CATU_MODE_PASS_THROUGH) ?
 		"Pass through" :
 		"Translate");
@@ -461,15 +462,16 @@ static int catu_enable(struct coresight_device *csdev, void *data)
 static int catu_disable_hw(struct catu_drvdata *drvdata)
 {
 	int rc = 0;
+	struct device *dev = &drvdata->csdev->dev;
 
 	catu_write_control(drvdata, 0);
 	coresight_disclaim_device_unlocked(drvdata->base);
 	if (catu_wait_for_ready(drvdata)) {
-		dev_info(drvdata->dev, "Timeout while waiting for READY\n");
+		dev_info(dev, "Timeout while waiting for READY\n");
 		rc = -EAGAIN;
 	}
 
-	dev_dbg(drvdata->dev, "Disabled\n");
+	dev_dbg(dev, "Disabled\n");
 	return rc;
 }
 
@@ -519,7 +521,6 @@ static int catu_probe(struct amba_device *adev, const struct amba_id *id)
 		goto out;
 	}
 
-	drvdata->dev = dev;
 	dev_set_drvdata(dev, drvdata);
 	base = devm_ioremap_resource(dev, &adev->res);
 	if (IS_ERR(base)) {
diff --git a/drivers/hwtracing/coresight/coresight-catu.h b/drivers/hwtracing/coresight/coresight-catu.h
index 1d2ad18..80ceee3 100644
--- a/drivers/hwtracing/coresight/coresight-catu.h
+++ b/drivers/hwtracing/coresight/coresight-catu.h
@@ -61,7 +61,6 @@
 #define CATU_IRQEN_OFF		0x0
 
 struct catu_drvdata {
-	struct device *dev;
 	void __iomem *base;
 	struct coresight_device *csdev;
 	int irq;
-- 
2.7.4

