Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 658ED169852
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2020 16:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgBWPOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Feb 2020 10:14:41 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:46731 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgBWPOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 10:14:41 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1j5sxq-0002b0-Ek; Sun, 23 Feb 2020 15:14:38 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: remove temporary variable CrystalCap
Date:   Sun, 23 Feb 2020 15:14:38 +0000
Message-Id: <20200223151438.415542-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently variable CrystalCap is being initialized with the value
0x20 that is never read so that is redundant and can be removed.
Clean up the code by removing the need for variable CrystalCap
since the calculation of the return value is relatively simple.

Addresses-Coverity: ("Unused Value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/rtl8723bs/hal/odm_CfoTracking.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_CfoTracking.c b/drivers/staging/rtl8723bs/hal/odm_CfoTracking.c
index 95edd148ac24..34d83b238265 100644
--- a/drivers/staging/rtl8723bs/hal/odm_CfoTracking.c
+++ b/drivers/staging/rtl8723bs/hal/odm_CfoTracking.c
@@ -40,16 +40,11 @@ static void odm_SetCrystalCap(void *pDM_VOID, u8 CrystalCap)
 static u8 odm_GetDefaultCrytaltalCap(void *pDM_VOID)
 {
 	PDM_ODM_T pDM_Odm = (PDM_ODM_T)pDM_VOID;
-	u8 CrystalCap = 0x20;
 
 	struct adapter *Adapter = pDM_Odm->Adapter;
 	struct hal_com_data *pHalData = GET_HAL_DATA(Adapter);
 
-	CrystalCap = pHalData->CrystalCap;
-
-	CrystalCap = CrystalCap & 0x3f;
-
-	return CrystalCap;
+	return pHalData->CrystalCap & 0x3f;
 }
 
 static void odm_SetATCStatus(void *pDM_VOID, bool ATCStatus)
-- 
2.25.0

