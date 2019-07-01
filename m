Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC051625E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 12:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfEGKzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 06:55:31 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50258 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727087AbfEGKyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 06:54:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28A77168F;
        Tue,  7 May 2019 03:54:10 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E9E283F5AF;
        Tue,  7 May 2019 03:54:08 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        rjw@rjwysocki.net, mathieu.poirier@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 20/30] coresight: Cleanup coresight_remove_conns
Date:   Tue,  7 May 2019 11:52:47 +0100
Message-Id: <1557226378-10131-21-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557226378-10131-1-git-send-email-suzuki.poulose@arm.com>
References: <1557226378-10131-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a device is unregistered, we remove all connection
references to it, by searching the connection records of
all devices in the coresight bus, via coresight_remove_conns.
We could avoid searching if this device doesn't have an input
port (e.g, a source). Also document the purpose of the function.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 04b5d3c..068bd2f 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -1096,10 +1096,21 @@ static int coresight_remove_match(struct device *dev, void *data)
 	return 0;
 }
 
+/*
+ * coresight_remove_conns - Remove references to this given devices
+ * from the connections of other devices.
+ */
 static void coresight_remove_conns(struct coresight_device *csdev)
 {
-	bus_for_each_dev(&coresight_bustype, NULL,
-			 csdev, coresight_remove_match);
+	/*
+	 * Another device will point to this device only if there is
+	 * an output port connected to this one. i.e, if the device
+	 * doesn't have at least one input port, there is no point
+	 * in searching all the devices.
+	 */
+	if (csdev->nr_inport)
+		bus_for_each_dev(&coresight_bustype, NULL,
+				 csdev, coresight_remove_match);
 }
 
 /**
-- 
2.7.4

