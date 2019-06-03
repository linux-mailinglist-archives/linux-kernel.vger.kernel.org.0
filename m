Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89879333E2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 17:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbfFCPvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 11:51:00 -0400
Received: from foss.arm.com ([217.140.101.70]:53500 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbfFCPvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:51:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0599515AB;
        Mon,  3 Jun 2019 08:51:00 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A35A63F246;
        Mon,  3 Jun 2019 08:50:58 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com, Sebastian Ott <sebott@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [RFC PATCH 01/57] drivers: s390/cio: Use driver_for_each_device
Date:   Mon,  3 Jun 2019 16:49:27 +0100
Message-Id: <1559577023-558-2-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cio driver use driver_find_device() to find all devices
to release them before the driver is unregistered. Instead,
it could easily use a lighter driver_for_each_device() helper
to iterate over all the devices.

Cc: Sebastian Ott <sebott@linux.ibm.com>
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/s390/cio/ccwgroup.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/cio/ccwgroup.c b/drivers/s390/cio/ccwgroup.c
index 4ebf6d4..a006945 100644
--- a/drivers/s390/cio/ccwgroup.c
+++ b/drivers/s390/cio/ccwgroup.c
@@ -581,9 +581,12 @@ int ccwgroup_driver_register(struct ccwgroup_driver *cdriver)
 }
 EXPORT_SYMBOL(ccwgroup_driver_register);
 
-static int __ccwgroup_match_all(struct device *dev, void *data)
+static int ccwgroup_release_device(struct device *dev, void *unused)
 {
-	return 1;
+	struct ccwgroup_device *gdev = to_ccwgroupdev(dev);
+
+	ccwgroup_ungroup(gdev);
+	return 0;
 }
 
 /**
@@ -594,16 +597,11 @@ static int __ccwgroup_match_all(struct device *dev, void *data)
  */
 void ccwgroup_driver_unregister(struct ccwgroup_driver *cdriver)
 {
-	struct device *dev;
+	int ret;
 
 	/* We don't want ccwgroup devices to live longer than their driver. */
-	while ((dev = driver_find_device(&cdriver->driver, NULL, NULL,
-					 __ccwgroup_match_all))) {
-		struct ccwgroup_device *gdev = to_ccwgroupdev(dev);
-
-		ccwgroup_ungroup(gdev);
-		put_device(dev);
-	}
+	ret = driver_for_each_device(&cdriver->driver, NULL, NULL,
+				     ccwgroup_release_device);
 	driver_unregister(&cdriver->driver);
 }
 EXPORT_SYMBOL(ccwgroup_driver_unregister);
-- 
2.7.4

