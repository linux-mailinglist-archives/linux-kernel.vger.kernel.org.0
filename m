Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 200FE333EA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 17:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbfFCPvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 11:51:24 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53684 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728963AbfFCPvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:51:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E8B215AB;
        Mon,  3 Jun 2019 08:51:22 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 623803F246;
        Mon,  3 Jun 2019 08:51:21 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: [RFC PATCH 16/57] net: hns_roce: Use bus_find_device_by_fwnode helper
Date:   Mon,  3 Jun 2019 16:49:42 +0100
Message-Id: <1559577023-558-17-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to using the bus_find_device_by_fwnode helper

Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 4c5d0f1..0985078 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -4497,19 +4497,13 @@ static const struct acpi_device_id hns_roce_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, hns_roce_acpi_match);
 
-static int hns_roce_node_match(struct device *dev, void *fwnode)
-{
-	return dev->fwnode == fwnode;
-}
-
 static struct
 platform_device *hns_roce_find_pdev(struct fwnode_handle *fwnode)
 {
 	struct device *dev;
 
 	/* get the 'device' corresponding to the matching 'fwnode' */
-	dev = bus_find_device(&platform_bus_type, NULL,
-			      fwnode, hns_roce_node_match);
+	dev = bus_find_device_by_fwnode(&platform_bus_type, NULL, fwnode);
 	/* get the platform device */
 	return dev ? to_platform_device(dev) : NULL;
 }
-- 
2.7.4

