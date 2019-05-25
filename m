Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A54B82A4E6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2019 16:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfEYOhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 May 2019 10:37:07 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48840 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727007AbfEYOhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 10:37:07 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 94ED52BC17B17C2CD713;
        Sat, 25 May 2019 22:37:02 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Sat, 25 May 2019
 22:36:52 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <gregkh@linuxfoundation.org>, <himadri18.07@gmail.com>,
        <arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] staging: rtl8723bs: hal: Remove set but not used variable 'no_res' and 'phal'
Date:   Sat, 25 May 2019 22:36:40 +0800
Message-ID: <20190525143640.13356-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c: In function xmit_xmitframes:
drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c:205:5: warning: variable no_res set but not used [-Wunused-but-set-variable]
drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c: In function rtl8723bs_free_xmit_priv:
drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c:640:23: warning: variable phal set but not used [-Wunused-but-set-variable]

They are never used and can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
index 7b06aab04ee6..9cf8da799ade 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
@@ -202,7 +202,7 @@ static s32 xmit_xmitframes(struct adapter *padapter, struct xmit_priv *pxmitpriv
 	s32 err, ret;
 	u32 k = 0;
 	struct hw_xmit *hwxmits, *phwxmit;
-	u8 no_res, idx, hwentry;
+	u8 idx, hwentry;
 	struct tx_servq *ptxservq;
 	struct list_head *sta_plist, *sta_phead, *frame_plist, *frame_phead;
 	struct xmit_frame *pxmitframe;
@@ -213,7 +213,6 @@ static s32 xmit_xmitframes(struct adapter *padapter, struct xmit_priv *pxmitpriv
 	int inx[4];
 
 	err = 0;
-	no_res = false;
 	hwxmits = pxmitpriv->hwxmits;
 	hwentry = pxmitpriv->hwxmit_entry;
 	ptxservq = NULL;
@@ -637,7 +636,6 @@ s32 rtl8723bs_init_xmit_priv(struct adapter *padapter)
 
 void rtl8723bs_free_xmit_priv(struct adapter *padapter)
 {
-	struct hal_com_data *phal;
 	struct xmit_priv *pxmitpriv;
 	struct xmit_buf *pxmitbuf;
 	struct __queue *pqueue;
@@ -645,7 +643,6 @@ void rtl8723bs_free_xmit_priv(struct adapter *padapter)
 	struct list_head tmplist;
 
 
-	phal = GET_HAL_DATA(padapter);
 	pxmitpriv = &padapter->xmitpriv;
 	pqueue = &pxmitpriv->pending_xmitbuf_queue;
 	phead = get_list_head(pqueue);
-- 
2.17.1


