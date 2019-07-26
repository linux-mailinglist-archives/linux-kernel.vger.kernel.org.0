Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E46976AF3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 16:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfGZODh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 10:03:37 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46608 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727004AbfGZODh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:03:37 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8BDE6CA4AD68E482E6F4;
        Fri, 26 Jul 2019 22:03:35 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Fri, 26 Jul 2019
 22:03:28 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <gregkh@linuxfoundation.org>, <shobhitkukreti@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] staging: rtl8723bs: remove set but not used variable 'bWifiBusy'
Date:   Fri, 26 Jul 2019 22:03:21 +0800
Message-ID: <20190726140321.19200-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

 In function halbtc8723b1ant_TdmaDurationAdjustForAcl:
drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c:1761:7: warning:
 variable bWifiBusy set but not used [-Wunused-but-set-variable]

It is never used so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
index 8e4caee..dd349c5 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
+++ b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
@@ -1758,7 +1758,6 @@ static void halbtc8723b1ant_TdmaDurationAdjustForAcl(
 	static s32 up, dn, m, n, WaitCount;
 	s32 result;   /* 0: no change, +1: increase WiFi duration, -1: decrease WiFi duration */
 	u8 retryCount = 0, btInfoExt;
-	bool bWifiBusy = false;
 
 	BTC_PRINT(
 		BTC_MSG_ALGORITHM,
@@ -1766,11 +1765,6 @@ static void halbtc8723b1ant_TdmaDurationAdjustForAcl(
 		("[BTCoex], TdmaDurationAdjustForAcl()\n")
 	);
 
-	if (BT_8723B_1ANT_WIFI_STATUS_CONNECTED_BUSY == wifiStatus)
-		bWifiBusy = true;
-	else
-		bWifiBusy = false;
-
 	if (
 		(BT_8723B_1ANT_WIFI_STATUS_NON_CONNECTED_ASSO_AUTH_SCAN == wifiStatus) ||
 		(BT_8723B_1ANT_WIFI_STATUS_CONNECTED_SCAN == wifiStatus) ||
-- 
2.7.4


