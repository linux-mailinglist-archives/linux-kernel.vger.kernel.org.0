Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95797333EB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 17:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbfFCPv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 11:51:28 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53706 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728963AbfFCPvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:51:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C7AD169E;
        Mon,  3 Jun 2019 08:51:25 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3375A3F246;
        Mon,  3 Jun 2019 08:51:24 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [RFC PATCH 18/57] drivers: intel_th: Use bus_find_device_by_devt helper
Date:   Mon,  3 Jun 2019 16:49:44 +0100
Message-Id: <1559577023-558-19-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to using the bus_find_device_by_devt helper

Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/intel_th/core.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index 033dce5..a85e236 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -789,13 +789,6 @@ static int intel_th_populate(struct intel_th *th)
 	return 0;
 }
 
-static int match_devt(struct device *dev, void *data)
-{
-	dev_t devt = (dev_t)(unsigned long)data;
-
-	return dev->devt == devt;
-}
-
 static int intel_th_output_open(struct inode *inode, struct file *file)
 {
 	const struct file_operations *fops;
@@ -803,9 +796,7 @@ static int intel_th_output_open(struct inode *inode, struct file *file)
 	struct device *dev;
 	int err;
 
-	dev = bus_find_device(&intel_th_bus, NULL,
-			      (void *)(unsigned long)inode->i_rdev,
-			      match_devt);
+	dev = bus_find_device_by_devt(&intel_th_bus, NULL, inode->i_rdev);
 	if (!dev || !dev->driver)
 		return -ENODEV;
 
-- 
2.7.4

