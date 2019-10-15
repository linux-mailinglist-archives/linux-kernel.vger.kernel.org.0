Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F067DD75A4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 13:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbfJOLzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 07:55:23 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3764 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729411AbfJOLzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 07:55:23 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8496D818DE099A0C078F;
        Tue, 15 Oct 2019 19:55:21 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Tue, 15 Oct 2019
 19:55:13 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jarias.linux@gmail.com>,
        <julia.lawall@lip6.fr>, <colin.king@canonical.com>,
        <hdegoede@redhat.com>, <hariprasad.kelam@gmail.com>,
        <nachukannan@gmail.com>, <pakki001@umn.edu>,
        <hardiksingh.k@gmail.com>, <nishkadg.linux@gmail.com>,
        <dan.carpenter@oracle.com>
CC:     <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 -next] staging: rtl8723bs: remove unnecessary null check
Date:   Tue, 15 Oct 2019 19:55:11 +0800
Message-ID: <20191015115511.26560-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20191015114053.23496-1-yuehaibing@huawei.com>
References: <20191015114053.23496-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Null check before kfree is redundant, so remove it.
This is detected by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: remove unnecessary 'hwxmits'
---
 drivers/staging/rtl8723bs/core/rtw_xmit.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index 7011c2a..6d193f1 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -2206,12 +2206,9 @@ s32 rtw_alloc_hwxmits(struct adapter *padapter)
 
 void rtw_free_hwxmits(struct adapter *padapter)
 {
-	struct hw_xmit *hwxmits;
 	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
 
-	hwxmits = pxmitpriv->hwxmits;
-	if (hwxmits)
-		kfree(hwxmits);
+	kfree(pxmitpriv->hwxmits);
 }
 
 void rtw_init_hwxmits(struct hw_xmit *phwxmit, sint entry)
-- 
2.7.4


