Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 495A816243
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 12:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbfEGKy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 06:54:26 -0400
Received: from foss.arm.com ([217.140.101.70]:50348 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727237AbfEGKyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 06:54:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F0751688;
        Tue,  7 May 2019 03:54:20 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4BB5D3F5AF;
        Tue,  7 May 2019 03:54:19 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        rjw@rjwysocki.net, mathieu.poirier@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 27/30] coresight: stm: ACPI support for parsing stimulus base
Date:   Tue,  7 May 2019 11:52:54 +0100
Message-Id: <1557226378-10131-28-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557226378-10131-1-git-send-email-suzuki.poulose@arm.com>
References: <1557226378-10131-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stimulus base for STM device must be listed as the second memory
resource, followed by the programming base address as described in
"Section 2.3 Resources" in ACPI for CoreSightTM 1.0 Platform Design
documen (DEN0067).

Add support for parsing the information for ACPI.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-stm.c | 53 ++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index e3e2b00..b908ca1 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -16,6 +16,7 @@
  * (C) 2015-2016 Chunyan Zhang <zhang.chunyan@linaro.org>
  */
 #include <asm/local.h>
+#include <linux/acpi.h>
 #include <linux/amba/bus.h>
 #include <linux/bitmap.h>
 #include <linux/clk.h>
@@ -716,10 +717,60 @@ static inline int of_stm_get_stimulus_area(struct device *dev,
 }
 #endif
 
+#ifdef CONFIG_ACPI
+static int acpi_stm_get_stimulus_area(struct device *dev, struct resource *res)
+{
+	int rc;
+	bool found_base = false;
+	struct resource_entry *rent;
+	LIST_HEAD(res_list);
+
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+
+	if (!adev)
+		return -ENODEV;
+	rc = acpi_dev_get_resources(adev, &res_list, NULL, NULL);
+	if (rc < 0)
+		return rc;
+
+	/*
+	 * The stimulus base for STM device must be listed as the second memory
+	 * resource, followed by the programming base address as described in
+	 * "Section 2.3 Resources" in ACPI for CoreSightTM 1.0 Platform Design
+	 * document (DEN0067).
+	 */
+	rc = -ENOENT;
+	list_for_each_entry(rent, &res_list, node) {
+		if (resource_type(rent->res) != IORESOURCE_MEM)
+			continue;
+		if (found_base) {
+			*res = *rent->res;
+			rc = 0;
+			break;
+		}
+
+		found_base = true;
+	}
+
+	acpi_dev_free_resource_list(&res_list);
+	return rc;
+}
+#else
+static inline int acpi_stm_get_stimulus_area(struct device *dev,
+					     struct resource *res)
+{
+	return -ENOENT;
+}
+#endif
+
 static int stm_get_stimulus_area(struct device *dev, struct resource *res)
 {
-	if (is_of_node(dev_fwnode(dev)))
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
+
+	if (is_of_node(fwnode))
 		return of_stm_get_stimulus_area(dev, res);
+	else if (is_acpi_node(fwnode))
+		return acpi_stm_get_stimulus_area(dev, res);
 	return -ENOENT;
 }
 
-- 
2.7.4

