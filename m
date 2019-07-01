Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87C9F33DB4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 06:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfFDEIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 00:08:52 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17662 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725267AbfFDEIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 00:08:52 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C13FA121CC2D2C73DBD3;
        Tue,  4 Jun 2019 12:08:48 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Tue, 4 Jun 2019 12:08:39 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] driver core: show the error number when driver_sysfs_add() fails
Date:   Tue, 4 Jun 2019 12:15:46 +0800
Message-ID: <20190604041546.54380-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If driver_sysfs_add() fails, kernel shows following message,

  really_probe: driver_sysfs_add(portman.0) failed
  ppdev: probe of portman.0 failed with error 0

It's better to show the error number like other probe_failed path.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/base/dd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 0df9b4461766..04ee4e196530 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -493,7 +493,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 			goto probe_failed;
 	}
 
-	if (driver_sysfs_add(dev)) {
+	ret = driver_sysfs_add(dev);
+	if (ret) {
 		printk(KERN_ERR "%s: driver_sysfs_add(%s) failed\n",
 			__func__, dev_name(dev));
 		goto probe_failed;
-- 
2.20.1

