Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 678F616241
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 12:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfEGKya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 06:54:30 -0400
Received: from foss.arm.com ([217.140.101.70]:50390 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727270AbfEGKyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 06:54:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5D7D374;
        Tue,  7 May 2019 03:54:24 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B14D53F5AF;
        Tue,  7 May 2019 03:54:23 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        rjw@rjwysocki.net, mathieu.poirier@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 30/30] coresight: acpi: Support for platform devices
Date:   Tue,  7 May 2019 11:52:57 +0100
Message-Id: <1557226378-10131-31-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557226378-10131-1-git-send-email-suzuki.poulose@arm.com>
References: <1557226378-10131-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for platform devices which do not appear on the AMBA
bus.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-replicator.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index c0e4225..5429527 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -5,6 +5,7 @@
  * Description: CoreSight Replicator driver
  */
 
+#include <linux/acpi.h>
 #include <linux/amba/bus.h>
 #include <linux/kernel.h>
 #include <linux/device.h>
@@ -296,11 +297,18 @@ static const struct of_device_id static_replicator_match[] = {
 	{}
 };
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id static_replicator_acpi_ids[] = {
+	{"ARMHC985", 0}, /* ARM CoreSight Static Replicator */
+};
+#endif
+
 static struct platform_driver static_replicator_driver = {
 	.probe          = static_replicator_probe,
 	.driver         = {
 		.name   = "coresight-static-replicator",
-		.of_match_table = static_replicator_match,
+		.of_match_table = of_match_ptr(static_replicator_match),
+		.acpi_match_table = ACPI_PTR(static_replicator_acpi_ids),
 		.pm	= &replicator_dev_pm_ops,
 		.suppress_bind_attrs = true,
 	},
-- 
2.7.4

