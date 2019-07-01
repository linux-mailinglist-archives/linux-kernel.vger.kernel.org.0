Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A18433421
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 17:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbfFCPyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 11:54:11 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53766 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729210AbfFCPve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:51:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 573D11A25;
        Mon,  3 Jun 2019 08:51:34 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 620843F246;
        Mon,  3 Jun 2019 08:51:33 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com
Subject: [RFC PATCH 24/57] drivers: staging: most-core: Use bus_find_device_by_name
Date:   Mon,  3 Jun 2019 16:49:50 +0100
Message-Id: <1559577023-558-25-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use bus_find_device_by_name() helper.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/staging/most/core.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/staging/most/core.c b/drivers/staging/most/core.c
index 86a8545..b9841adb 100644
--- a/drivers/staging/most/core.c
+++ b/drivers/staging/most/core.c
@@ -561,13 +561,6 @@ static int split_string(char *buf, char **a, char **b, char **c, char **d)
 	return 0;
 }
 
-static int match_bus_dev(struct device *dev, void *data)
-{
-	char *mdev_name = data;
-
-	return !strcmp(dev_name(dev), mdev_name);
-}
-
 /**
  * get_channel - get pointer to channel
  * @mdev: name of the device interface
@@ -579,7 +572,7 @@ static struct most_channel *get_channel(char *mdev, char *mdev_ch)
 	struct most_interface *iface;
 	struct most_channel *c, *tmp;
 
-	dev = bus_find_device(&mc.bus, NULL, mdev, match_bus_dev);
+	dev = bus_find_device_by_name(&mc.bus, NULL, mdev);
 	if (!dev)
 		return NULL;
 	iface = to_most_interface(dev);
-- 
2.7.4

