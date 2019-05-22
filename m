Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E071261FB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 12:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbfEVKf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 06:35:27 -0400
Received: from foss.arm.com ([217.140.101.70]:46980 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728438AbfEVKfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 06:35:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B62A15BF;
        Wed, 22 May 2019 03:35:24 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7BFCF3F575;
        Wed, 22 May 2019 03:35:23 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v4 05/30] coresight: tpiu: Clean up device specific data
Date:   Wed, 22 May 2019 11:34:38 +0100
Message-Id: <1558521304-27469-6-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558521304-27469-1-git-send-email-suzuki.poulose@arm.com>
References: <1558521304-27469-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to using the coresight device instead of the parent
amba device.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tpiu.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index 63d9af3..4dd3e7f 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -49,13 +49,11 @@
 
 /**
  * @base:	memory mapped base address for this component.
- * @dev:	the device entity associated to this component.
  * @atclk:	optional clock for the core parts of the TPIU.
  * @csdev:	component vitals needed by the framework.
  */
 struct tpiu_drvdata {
 	void __iomem		*base;
-	struct device		*dev;
 	struct clk		*atclk;
 	struct coresight_device	*csdev;
 };
@@ -75,7 +73,7 @@ static int tpiu_enable(struct coresight_device *csdev, u32 mode, void *__unused)
 
 	tpiu_enable_hw(drvdata);
 	atomic_inc(csdev->refcnt);
-	dev_dbg(drvdata->dev, "TPIU enabled\n");
+	dev_dbg(&csdev->dev, "TPIU enabled\n");
 	return 0;
 }
 
@@ -104,7 +102,7 @@ static int tpiu_disable(struct coresight_device *csdev)
 
 	tpiu_disable_hw(drvdata);
 
-	dev_dbg(drvdata->dev, "TPIU disabled\n");
+	dev_dbg(&csdev->dev, "TPIU disabled\n");
 	return 0;
 }
 
@@ -139,7 +137,6 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
 	if (!drvdata)
 		return -ENOMEM;
 
-	drvdata->dev = &adev->dev;
 	drvdata->atclk = devm_clk_get(&adev->dev, "atclk"); /* optional */
 	if (!IS_ERR(drvdata->atclk)) {
 		ret = clk_prepare_enable(drvdata->atclk);
-- 
2.7.4

