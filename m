Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF807D2FF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 03:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbfHABxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 21:53:25 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51482 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726334AbfHABxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 21:53:25 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 34FC2BF9F088E20BF035;
        Thu,  1 Aug 2019 09:53:19 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Thu, 1 Aug 2019
 09:53:12 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] staging: rtl8723bs: remove set but not used variable 'bEEPROMCheck'
Date:   Thu, 1 Aug 2019 09:53:07 +0800
Message-ID: <20190801015307.44572-1-yuehaibing@huawei.com>
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

drivers/staging/rtl8723bs//hal/odm_CfoTracking.c: In function 'odm_SetCrystalCap':
drivers/staging/rtl8723bs//hal/odm_CfoTracking.c:14:7: warning:
 variable 'bEEPROMCheck' set but not used [-Wunused-but-set-variable]

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/staging/rtl8723bs/hal/odm_CfoTracking.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_CfoTracking.c b/drivers/staging/rtl8723bs/hal/odm_CfoTracking.c
index a733046..95edd14 100644
--- a/drivers/staging/rtl8723bs/hal/odm_CfoTracking.c
+++ b/drivers/staging/rtl8723bs/hal/odm_CfoTracking.c
@@ -11,11 +11,6 @@ static void odm_SetCrystalCap(void *pDM_VOID, u8 CrystalCap)
 {
 	PDM_ODM_T pDM_Odm = (PDM_ODM_T)pDM_VOID;
 	PCFO_TRACKING pCfoTrack = &pDM_Odm->DM_CfoTrack;
-	bool bEEPROMCheck;
-	struct adapter *Adapter = pDM_Odm->Adapter;
-	struct hal_com_data *pHalData = GET_HAL_DATA(Adapter);
-
-	bEEPROMCheck = pHalData->EEPROMVersion >= 0x01;
 
 	if (pCfoTrack->CrystalCap == CrystalCap)
 		return;
-- 
2.7.4


