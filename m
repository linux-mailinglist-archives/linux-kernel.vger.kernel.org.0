Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8138C3340D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 17:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbfFCPxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 11:53:03 -0400
Received: from foss.arm.com ([217.140.101.70]:54036 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729486AbfFCPwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:52:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66D651A25;
        Mon,  3 Jun 2019 08:52:11 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2AB413F246;
        Mon,  3 Jun 2019 08:52:10 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com, Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [RFC PATCH 47/57] drivers: mfd: Use driver_find_device_by_name helper
Date:   Mon,  3 Jun 2019 16:50:13 +0100
Message-Id: <1559577023-558-48-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new driver_find_device_by_name() helper.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/mfd/syscon.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 4f39ba5..e51e39a 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -190,18 +190,12 @@ struct regmap *syscon_regmap_lookup_by_compatible(const char *s)
 }
 EXPORT_SYMBOL_GPL(syscon_regmap_lookup_by_compatible);
 
-static int syscon_match_pdevname(struct device *dev, const void *data)
-{
-	return !strcmp(dev_name(dev), (const char *)data);
-}
-
 struct regmap *syscon_regmap_lookup_by_pdevname(const char *s)
 {
 	struct device *dev;
 	struct syscon *syscon;
 
-	dev = driver_find_device(&syscon_driver.driver, NULL, (void *)s,
-				 syscon_match_pdevname);
+	dev = driver_find_device_by_name(&syscon_driver.driver, NULL, s);
 	if (!dev)
 		return ERR_PTR(-EPROBE_DEFER);
 
-- 
2.7.4

