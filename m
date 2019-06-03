Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3393341F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 17:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbfFCPxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 11:53:55 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53824 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729339AbfFCPvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:51:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69BF31AED;
        Mon,  3 Jun 2019 08:51:43 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2DCE63F246;
        Mon,  3 Jun 2019 08:51:42 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: [RFC PATCH 29/57] drivers: stm: Use class_find_device_by_name() helper
Date:   Mon,  3 Jun 2019 16:49:55 +0100
Message-Id: <1559577023-558-30-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new class_find_device_by_name() helper.

Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/stm/core.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index e55b902..e110958 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -89,13 +89,6 @@ static struct class stm_class = {
 	.dev_groups	= stm_groups,
 };
 
-static int stm_dev_match(struct device *dev, const void *data)
-{
-	const char *name = data;
-
-	return sysfs_streq(name, dev_name(dev));
-}
-
 /**
  * stm_find_device() - find stm device by name
  * @buf:	character buffer containing the name
@@ -116,7 +109,7 @@ struct stm_device *stm_find_device(const char *buf)
 	if (!stm_core_up)
 		return NULL;
 
-	dev = class_find_device(&stm_class, NULL, buf, stm_dev_match);
+	dev = class_find_device_by_name(&stm_class, NULL, buf);
 	if (!dev)
 		return NULL;
 
-- 
2.7.4

