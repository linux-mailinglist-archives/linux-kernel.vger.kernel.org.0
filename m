Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 226AB16262
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 12:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfEGK4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 06:56:10 -0400
Received: from foss.arm.com ([217.140.101.70]:50140 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbfEGKxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 06:53:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E39141688;
        Tue,  7 May 2019 03:53:53 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B098B3F5AF;
        Tue,  7 May 2019 03:53:52 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        rjw@rjwysocki.net, mathieu.poirier@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 09/30] coresight: Use coresight device names for sinks in PMU attribute
Date:   Tue,  7 May 2019 11:52:36 +0100
Message-Id: <1557226378-10131-10-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557226378-10131-1-git-send-email-suzuki.poulose@arm.com>
References: <1557226378-10131-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Move to using the coresight device name instead of the parent
device name for SINK attribute for PMU.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 3c62944..5c1ca0d 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -523,7 +523,7 @@ int etm_perf_add_symlink_sink(struct coresight_device *csdev)
 	unsigned long hash;
 	const char *name;
 	struct device *pmu_dev = etm_pmu.dev;
-	struct device *pdev = csdev->dev.parent;
+	struct device *dev = &csdev->dev;
 	struct dev_ext_attribute *ea;
 
 	if (csdev->type != CORESIGHT_DEV_TYPE_SINK &&
@@ -536,15 +536,15 @@ int etm_perf_add_symlink_sink(struct coresight_device *csdev)
 	if (!etm_perf_up)
 		return -EPROBE_DEFER;
 
-	ea = devm_kzalloc(pdev, sizeof(*ea), GFP_KERNEL);
+	ea = devm_kzalloc(dev, sizeof(*ea), GFP_KERNEL);
 	if (!ea)
 		return -ENOMEM;
 
-	name = dev_name(pdev);
+	name = dev_name(dev);
 	/* See function coresight_get_sink_by_id() to know where this is used */
 	hash = hashlen_hash(hashlen_string(NULL, name));
 
-	ea->attr.attr.name = devm_kstrdup(pdev, name, GFP_KERNEL);
+	ea->attr.attr.name = devm_kstrdup(dev, name, GFP_KERNEL);
 	if (!ea->attr.attr.name)
 		return -ENOMEM;
 
-- 
2.7.4

