Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3BD6B81D3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2019 21:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404535AbfISTwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Sep 2019 15:52:17 -0400
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:42866 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404506AbfISTwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 15:52:17 -0400
Received: from localhost.localdomain ([93.22.37.255])
        by mwinf5d35 with ME
        id 3XsC2100X5WHhHH03XsDuX; Thu, 19 Sep 2019 21:52:14 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 19 Sep 2019 21:52:14 +0200
X-ME-IP: 93.22.37.255
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] bluetooth: hci_nokia: Save a few cycles in 'nokia_enqueue()'
Date:   Thu, 19 Sep 2019 21:52:08 +0200
Message-Id: <20190919195208.2254-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'skb_pad()' a few lines above already initializes the "padded" byte to 0.
So there is no need to do it twice.

All what is needed is to increase the len of the skb. So 'skb_put(..., 1)'
is enough here.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/bluetooth/hci_nokia.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_nokia.c b/drivers/bluetooth/hci_nokia.c
index 6463350b7977..05f7f6de6863 100644
--- a/drivers/bluetooth/hci_nokia.c
+++ b/drivers/bluetooth/hci_nokia.c
@@ -520,7 +520,7 @@ static int nokia_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 		err = skb_pad(skb, 1);
 		if (err)
 			return err;
-		skb_put_u8(skb, 0x00);
+		skb_put(skb, 1);
 	}
 
 	skb_queue_tail(&btdev->txq, skb);
-- 
2.20.1

