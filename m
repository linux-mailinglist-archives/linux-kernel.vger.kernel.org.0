Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B777D17301E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 06:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgB1FBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 00:01:18 -0500
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:50217 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgB1FBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 00:01:18 -0500
Received: from localhost.localdomain ([92.140.213.100])
        by mwinf5d77 with ME
        id 851F220012AY1JL0351FSg; Fri, 28 Feb 2020 06:01:16 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 28 Feb 2020 06:01:16 +0100
X-ME-IP: 92.140.213.100
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] Bluetooth: hci_h4: Remove a redundant assignment in 'h4_flush()'
Date:   Fri, 28 Feb 2020 06:01:13 +0100
Message-Id: <20200228050113.25041-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'hu->priv' is set twice to NULL in this function.
Axe one of these assignments.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/bluetooth/hci_h4.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
index 6dc1fbeb564b..0b84a05a730b 100644
--- a/drivers/bluetooth/hci_h4.c
+++ b/drivers/bluetooth/hci_h4.c
@@ -71,8 +71,6 @@ static int h4_close(struct hci_uart *hu)
 {
 	struct h4_struct *h4 = hu->priv;
 
-	hu->priv = NULL;
-
 	BT_DBG("hu %p", hu);
 
 	skb_queue_purge(&h4->txq);
-- 
2.20.1

