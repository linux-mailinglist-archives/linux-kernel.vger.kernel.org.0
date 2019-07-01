Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1974233411
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 17:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbfFCPxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 11:53:25 -0400
Received: from foss.arm.com ([217.140.101.70]:53956 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729463AbfFCPwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:52:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D92D8169E;
        Mon,  3 Jun 2019 08:51:59 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E43D93F246;
        Mon,  3 Jun 2019 08:51:58 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com
Subject: [RFC PATCH 40/57] drivers: spi: Use class_find_device_by_of_node helper
Date:   Mon,  3 Jun 2019 16:50:06 +0100
Message-Id: <1559577023-558-41-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the generic helper to find a device matching the of_node.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/spi/spi.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 5224ded..e1295e9 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3549,21 +3549,14 @@ EXPORT_SYMBOL_GPL(of_find_spi_device_by_node);
 #endif /* IS_ENABLED(CONFIG_OF) */
 
 #if IS_ENABLED(CONFIG_OF_DYNAMIC)
-static int __spi_of_controller_match(struct device *dev, const void *data)
-{
-	return dev->of_node == data;
-}
-
 /* the spi controllers are not using spi_bus, so we find it with another way */
 static struct spi_controller *of_find_spi_controller_by_node(struct device_node *node)
 {
 	struct device *dev;
 
-	dev = class_find_device(&spi_master_class, NULL, node,
-				__spi_of_controller_match);
+	dev = class_find_device_by_of_node(&spi_master_class, NULL, node);
 	if (!dev && IS_ENABLED(CONFIG_SPI_SLAVE))
-		dev = class_find_device(&spi_slave_class, NULL, node,
-					__spi_of_controller_match);
+		dev = class_find_device_by_of_node(&spi_slave_class, NULL, node);
 	if (!dev)
 		return NULL;
 
-- 
2.7.4

