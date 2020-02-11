Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBA615918B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 15:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbgBKOGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 09:06:36 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:37972 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728894AbgBKOGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 09:06:35 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 61D49BADB9EBDCB6FF24;
        Tue, 11 Feb 2020 22:06:33 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Tue, 11 Feb 2020
 22:06:25 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <jerome.pouiller@silabs.com>, <gregkh@linuxfoundation.org>
CC:     <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] staging: wfx: remove set but not used variable 'tx_priv'
Date:   Tue, 11 Feb 2020 22:03:34 +0800
Message-ID: <20200211140334.55248-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/staging/wfx/queue.c: In function wfx_tx_queues_get:
drivers/staging/wfx/queue.c:484:28: warning: variable tx_priv set but not used [-Wunused-but-set-variable]

commit 2e57865e79cf ("staging: wfx: pspoll_mask make no sense")
left behind this unused variable.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/staging/wfx/queue.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/wfx/queue.c b/drivers/staging/wfx/queue.c
index 0bcc61f..c73d158 100644
--- a/drivers/staging/wfx/queue.c
+++ b/drivers/staging/wfx/queue.c
@@ -481,7 +481,6 @@ struct hif_msg *wfx_tx_queues_get(struct wfx_dev *wdev)
 	struct wfx_queue *vif_queue = NULL;
 	u32 tx_allowed_mask = 0;
 	u32 vif_tx_allowed_mask = 0;
-	const struct wfx_tx_priv *tx_priv = NULL;
 	struct wfx_vif *wvif;
 	int not_found;
 	int burst;
@@ -541,7 +540,6 @@ struct hif_msg *wfx_tx_queues_get(struct wfx_dev *wdev)
 		skb = wfx_tx_queue_get(wdev, queue, tx_allowed_mask);
 		if (!skb)
 			continue;
-		tx_priv = wfx_skb_tx_priv(skb);
 		hif = (struct hif_msg *) skb->data;
 		wvif = wdev_to_wvif(wdev, hif->interface);
 		WARN_ON(!wvif);
-- 
2.7.4


