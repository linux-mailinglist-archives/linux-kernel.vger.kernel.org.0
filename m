Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3031D16260
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 12:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfEGKz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 06:55:56 -0400
Received: from foss.arm.com ([217.140.101.70]:50174 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbfEGKx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 06:53:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53B41168F;
        Tue,  7 May 2019 03:53:58 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 209873F5AF;
        Tue,  7 May 2019 03:53:56 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        rjw@rjwysocki.net, mathieu.poirier@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 12/30] coresight: stm: Rearrange probing the stimulus area
Date:   Tue,  7 May 2019 11:52:39 +0100
Message-Id: <1557226378-10131-13-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557226378-10131-1-git-send-email-suzuki.poulose@arm.com>
References: <1557226378-10131-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we are about to refactor the platform specific handling
re-arrange some of the DT specific property handling.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-stm.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 8f50484..3992a35 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -683,14 +683,15 @@ static const struct attribute_group *coresight_stm_groups[] = {
 	NULL,
 };
 
-static int stm_get_resource_byname(struct device_node *np,
-				   char *ch_base, struct resource *res)
+#ifdef CONFIG_OF
+static int of_stm_get_stimulus_area(struct device *dev, struct resource *res)
 {
 	const char *name = NULL;
 	int index = 0, found = 0;
+	struct device_node *np = dev->of_node;
 
 	while (!of_property_read_string_index(np, "reg-names", index, &name)) {
-		if (strcmp(ch_base, name)) {
+		if (strcmp("stm-stimulus-base", name)) {
 			index++;
 			continue;
 		}
@@ -705,6 +706,20 @@ static int stm_get_resource_byname(struct device_node *np,
 
 	return of_address_to_resource(np, index, res);
 }
+#else
+static inline int of_stm_get_stimulus_area(struct device *dev,
+					   struct resource *res)
+{
+	return -ENOENT;
+}
+#endif
+
+static int stm_get_stimulus_area(struct device *dev, struct resource *res)
+{
+	if (is_of_node(dev_fwnode(dev)))
+		return of_stm_get_stimulus_area(dev, res);
+	return -ENOENT;
+}
 
 static u32 stm_fundamental_data_size(struct stm_drvdata *drvdata)
 {
@@ -819,7 +834,7 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 		return PTR_ERR(base);
 	drvdata->base = base;
 
-	ret = stm_get_resource_byname(np, "stm-stimulus-base", &ch_res);
+	ret = stm_get_stimulus_area(dev, &ch_res);
 	if (ret)
 		return ret;
 	drvdata->chs.phys = ch_res.start;
-- 
2.7.4

