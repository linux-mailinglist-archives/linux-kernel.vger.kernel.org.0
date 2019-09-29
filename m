Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D124DC1494
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2019 15:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbfI2NgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Sep 2019 09:36:08 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48914 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725937AbfI2NgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 09:36:07 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C75899D10838FA607073;
        Sun, 29 Sep 2019 21:36:03 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Sun, 29 Sep 2019
 21:35:55 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <cascardo@holoscopio.com>, <don@syst.com.br>,
        <dvhart@infradead.org>, <andy@infradead.org>
CC:     <yukuai3@huawei.com>, <zhengbin13@huawei.com>,
        <yi.zhang@huawei.com>, <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] classmate-laptop: remove unused variable
Date:   Sun, 29 Sep 2019 21:42:49 +0800
Message-ID: <1569764569-9177-1-git-send-email-yukuai3@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/platform/x86/classmate-laptop.c: In function cmpc_accel_remove_v4:
drivers/platform/x86/classmate-laptop.c:424:21: warning: variable accel
set but not used [-Wunused-but-set-variable]
drivers/platform/x86/classmate-laptop.c: In function cmpc_accel_remove:
drivers/platform/x86/classmate-laptop.c:660:21: warning: variable accel
set but not used [-Wunused-but-set-variable]

In function cmpc_accel_remove_v4 and cmpc_accel_remove, variable accel is
set but not used, so it can be removed. In that case, variable inputdev is
set but not used and can be removed.

Fixes: 7125587df4e8 ("classmate-laptop: Add support for Classmate V4 accelerometer.")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 drivers/platform/x86/classmate-laptop.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/platform/x86/classmate-laptop.c b/drivers/platform/x86/classmate-laptop.c
index 86cc2cc..af063f6 100644
--- a/drivers/platform/x86/classmate-laptop.c
+++ b/drivers/platform/x86/classmate-laptop.c
@@ -420,12 +420,6 @@ static int cmpc_accel_add_v4(struct acpi_device *acpi)
 
 static int cmpc_accel_remove_v4(struct acpi_device *acpi)
 {
-	struct input_dev *inputdev;
-	struct cmpc_accel *accel;
-
-	inputdev = dev_get_drvdata(&acpi->dev);
-	accel = dev_get_drvdata(&inputdev->dev);
-
 	device_remove_file(&acpi->dev, &cmpc_accel_sensitivity_attr_v4);
 	device_remove_file(&acpi->dev, &cmpc_accel_g_select_attr_v4);
 	return cmpc_remove_acpi_notify_device(acpi);
@@ -656,12 +650,6 @@ static int cmpc_accel_add(struct acpi_device *acpi)
 
 static int cmpc_accel_remove(struct acpi_device *acpi)
 {
-	struct input_dev *inputdev;
-	struct cmpc_accel *accel;
-
-	inputdev = dev_get_drvdata(&acpi->dev);
-	accel = dev_get_drvdata(&inputdev->dev);
-
 	device_remove_file(&acpi->dev, &cmpc_accel_sensitivity_attr);
 	return cmpc_remove_acpi_notify_device(acpi);
 }
-- 
2.7.4

