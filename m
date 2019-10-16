Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE5E4D8A03
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 09:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391189AbfJPHmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 03:42:25 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3778 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728201AbfJPHmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:42:25 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 69F6FD40EE297C4244F5;
        Wed, 16 Oct 2019 15:42:22 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Wed, 16 Oct 2019 15:42:14 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <zhongjiang@huawei.com>
Subject: [PATCH] staging: rtl8723bs: remove an redundant null check before kfree()
Date:   Wed, 16 Oct 2019 15:38:26 +0800
Message-ID: <1571211506-19005-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kfree() has taken null pointer into account. hence it is safe to remove
the unnecessary check.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/staging/rtl8723bs/core/rtw_xmit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index 7011c2a..4597f4f 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -2210,8 +2210,7 @@ void rtw_free_hwxmits(struct adapter *padapter)
 	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
 
 	hwxmits = pxmitpriv->hwxmits;
-	if (hwxmits)
-		kfree(hwxmits);
+	kfree(hwxmits);
 }
 
 void rtw_init_hwxmits(struct hw_xmit *phwxmit, sint entry)
-- 
1.7.12.4

