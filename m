Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1CA3342D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 17:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbfFCPyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 11:54:36 -0400
Received: from foss.arm.com ([217.140.101.70]:53676 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728118AbfFCPvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:51:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 254F9169E;
        Mon,  3 Jun 2019 08:51:21 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0BA403F246;
        Mon,  3 Jun 2019 08:51:19 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com, "David S. Miller" <davem@davemloft.net>
Subject: [RFC PATCH 15/57] net: hisilicon: hnfs:Use bus_find_device_by_fwnode helper
Date:   Mon,  3 Jun 2019 16:49:41 +0100
Message-Id: <1559577023-558-16-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to using the bus_find_device_by_fwnode helper

Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c
index 09c16d8..b801ab7 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c
@@ -754,17 +754,11 @@ struct dsaf_misc_op *hns_misc_op_get(struct dsaf_device *dsaf_dev)
 	return (void *)misc_op;
 }
 
-static int hns_dsaf_dev_match(struct device *dev, void *fwnode)
-{
-	return dev->fwnode == fwnode;
-}
-
 struct
 platform_device *hns_dsaf_find_platform_device(struct fwnode_handle *fwnode)
 {
 	struct device *dev;
 
-	dev = bus_find_device(&platform_bus_type, NULL,
-			      fwnode, hns_dsaf_dev_match);
+	dev = bus_find_device_by_fwnode(&platform_bus_type, NULL, fwnode);
 	return dev ? to_platform_device(dev) : NULL;
 }
-- 
2.7.4

