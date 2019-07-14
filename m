Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACD5F67CDB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2019 05:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbfGND5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Jul 2019 23:57:32 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52422 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728009AbfGND5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 23:57:32 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2A7F83AB7ACB01E0A67B;
        Sun, 14 Jul 2019 11:57:30 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Sun, 14 Jul 2019 11:57:21 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <joern@lazybastard.org>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <marek.vasut@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nixiaoming@huawei.com>, <zhoubo.zhao@huawei.com>,
        <dylix.dailei@huawei.com>
Subject: [PATCH] mtd: phram: Module parameters add writable permissions
Date:   Sun, 14 Jul 2019 11:57:18 +0800
Message-ID: <1563076638-101332-1-git-send-email-nixiaoming@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The phram code implements managing multiple devices through a linked
list.
However, due to the module parameter permission of 0, the
/sys/module/phram/parameters/phram interface is missing.
The command line arguments in insmod can only create one device.

Therefore, add writable permissions to the module parameters, create
/sys/module/phram/parameters/phram interface, and create multi-device
support.

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
---
 drivers/mtd/devices/phram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/phram.c b/drivers/mtd/devices/phram.c
index c467286..931e5c2 100644
--- a/drivers/mtd/devices/phram.c
+++ b/drivers/mtd/devices/phram.c
@@ -294,7 +294,7 @@ static int phram_param_call(const char *val, const struct kernel_param *kp)
 #endif
 }
 
-module_param_call(phram, phram_param_call, NULL, NULL, 000);
+module_param_call(phram, phram_param_call, NULL, NULL, 0200);
 MODULE_PARM_DESC(phram, "Memory region to map. \"phram=<name>,<start>,<length>\"");
 
 
-- 
1.8.5.6

