Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8F77333E9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 17:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbfFCPvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 11:51:22 -0400
Received: from foss.arm.com ([217.140.101.70]:53648 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728706AbfFCPvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:51:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41B63169E;
        Mon,  3 Jun 2019 08:51:17 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D6A593F246;
        Mon,  3 Jun 2019 08:51:15 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com, Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [RFC PATCH 12/57] of: platform: Use bus_find_device_by_of_node helper
Date:   Mon,  3 Jun 2019 16:49:38 +0100
Message-Id: <1559577023-558-13-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to using the bus_find_device_by_of_node helper

Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/of/platform.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 04ad312..b1e3a51 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -37,11 +37,6 @@ static const struct of_device_id of_skipped_node_table[] = {
 	{} /* Empty terminated list */
 };
 
-static int of_dev_node_match(struct device *dev, void *data)
-{
-	return dev->of_node == data;
-}
-
 /**
  * of_find_device_by_node - Find the platform_device associated with a node
  * @np: Pointer to device tree node
@@ -55,7 +50,7 @@ struct platform_device *of_find_device_by_node(struct device_node *np)
 {
 	struct device *dev;
 
-	dev = bus_find_device(&platform_bus_type, NULL, np, of_dev_node_match);
+	dev = bus_find_device_by_of_node(&platform_bus_type, NULL, np);
 	return dev ? to_platform_device(dev) : NULL;
 }
 EXPORT_SYMBOL(of_find_device_by_node);
-- 
2.7.4

