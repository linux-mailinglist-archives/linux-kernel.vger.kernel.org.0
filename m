Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39FFD87720
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 12:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406354AbfHIKWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 06:22:20 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4653 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726037AbfHIKWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 06:22:20 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 360CEC9566F2D0524110;
        Fri,  9 Aug 2019 18:22:18 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Fri, 9 Aug 2019
 18:22:09 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <gregkh@linuxfoundation.org>, <ard.biesheuvel@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] staging: wusbcore: Fix build error without CONFIG_USB
Date:   Fri, 9 Aug 2019 18:21:50 +0800
Message-ID: <20190809102150.66896-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB_WUSB should depends on CONFIG_USB, otherwise building fails

drivers/staging/wusbcore/wusbhc.o: In function `wusbhc_giveback_urb':
wusbhc.c:(.text+0xa28): undefined reference to `usb_hcd_giveback_urb'

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 71ed79b0e4be ("USB: Move wusbcore and UWB to staging as it is obsolete")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/staging/wusbcore/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wusbcore/Kconfig b/drivers/staging/wusbcore/Kconfig
index 056c60b..a559d02 100644
--- a/drivers/staging/wusbcore/Kconfig
+++ b/drivers/staging/wusbcore/Kconfig
@@ -4,7 +4,7 @@
 #
 config USB_WUSB
 	tristate "Enable Wireless USB extensions"
-	depends on UWB
+	depends on UWB && USB
 	select CRYPTO
 	select CRYPTO_AES
 	select CRYPTO_CCM
-- 
2.7.4


