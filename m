Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 722E3BF35B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 14:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfIZMvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Sep 2019 08:51:00 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56517 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfIZMvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 08:51:00 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iDTEY-0003Mz-3X; Thu, 26 Sep 2019 12:50:58 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: clean up indentation issue
Date:   Thu, 26 Sep 2019 13:50:57 +0100
Message-Id: <20190926125057.16158-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The RT_TRACE is indented incorrectly, add in the missing tabs.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index f932cb15e4e5..b08712a9c029 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -715,8 +715,8 @@ void rtl92e_set_wireless_mode(struct net_device *dev, u8 wireless_mode)
 	if ((wireless_mode == WIRELESS_MODE_N_24G) ||
 	    (wireless_mode == WIRELESS_MODE_N_5G)) {
 		priv->rtllib->pHTInfo->bEnableHT = 1;
-	RT_TRACE(COMP_DBG, "%s(), wireless_mode:%x, bEnableHT = 1\n",
-		 __func__, wireless_mode);
+		RT_TRACE(COMP_DBG, "%s(), wireless_mode:%x, bEnableHT = 1\n",
+			 __func__, wireless_mode);
 	} else {
 		priv->rtllib->pHTInfo->bEnableHT = 0;
 		RT_TRACE(COMP_DBG, "%s(), wireless_mode:%x, bEnableHT = 0\n",
-- 
2.20.1

