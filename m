Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B86CB261FA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 12:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbfEVKhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 06:37:11 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47042 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729271AbfEVKfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 06:35:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7678115BF;
        Wed, 22 May 2019 03:35:32 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5D8843F575;
        Wed, 22 May 2019 03:35:31 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v4 11/30] coresight: etm3x: Rearrange cp14 access detection
Date:   Wed, 22 May 2019 11:34:44 +0100
Message-Id: <1558521304-27469-12-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558521304-27469-1-git-send-email-suzuki.poulose@arm.com>
References: <1558521304-27469-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we are about to refactor the platform specific handling,
move the DT property handling to generic helpers.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm3x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index 9c92491..fa2f141 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -802,9 +802,9 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 			return PTR_ERR(pdata);
 
 		adev->dev.platform_data = pdata;
-		drvdata->use_cp14 = of_property_read_bool(np, "arm,cp14");
 	}
 
+	drvdata->use_cp14 = fwnode_property_read_bool(dev->fwnode, "arm,cp14");
 	dev_set_drvdata(dev, drvdata);
 
 	/* Validity for the resource is already checked by the AMBA core */
-- 
2.7.4

