Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4900419BC5B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 09:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387477AbgDBHQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 03:16:03 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12671 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725789AbgDBHQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 03:16:03 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 616E0578530F22AAE740;
        Thu,  2 Apr 2020 15:15:57 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Thu, 2 Apr 2020
 15:15:51 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <dvhart@infradead.org>, <andy@infradead.org>, <2pi@mok.nu>,
        <yuehaibing@huawei.com>
CC:     <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] platform/x86: wmi: Make two functions static
Date:   Thu, 2 Apr 2020 15:15:49 +0800
Message-ID: <20200402071549.3304-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warnings:

drivers/platform/x86/xiaomi-wmi.c:26:5: warning: symbol 'xiaomi_wmi_probe' was not declared. Should it be static?
drivers/platform/x86/xiaomi-wmi.c:51:6: warning: symbol 'xiaomi_wmi_notify' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/platform/x86/xiaomi-wmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/xiaomi-wmi.c b/drivers/platform/x86/xiaomi-wmi.c
index 601cbb282f54..54a2546bb93b 100644
--- a/drivers/platform/x86/xiaomi-wmi.c
+++ b/drivers/platform/x86/xiaomi-wmi.c
@@ -23,7 +23,7 @@ struct xiaomi_wmi {
 	unsigned int key_code;
 };
 
-int xiaomi_wmi_probe(struct wmi_device *wdev, const void *context)
+static int xiaomi_wmi_probe(struct wmi_device *wdev, const void *context)
 {
 	struct xiaomi_wmi *data;
 
@@ -48,7 +48,7 @@ int xiaomi_wmi_probe(struct wmi_device *wdev, const void *context)
 	return input_register_device(data->input_dev);
 }
 
-void xiaomi_wmi_notify(struct wmi_device *wdev, union acpi_object *dummy)
+static void xiaomi_wmi_notify(struct wmi_device *wdev, union acpi_object *dummy)
 {
 	struct xiaomi_wmi *data;
 
-- 
2.17.1


