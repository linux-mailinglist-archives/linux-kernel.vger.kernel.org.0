Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C03EEFEB2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 14:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389044AbfKENfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 08:35:52 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:55870 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388313AbfKENfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 08:35:52 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id ACF784E9D9F9149A606F;
        Tue,  5 Nov 2019 21:35:42 +0800 (CST)
Received: from localhost.localdomain (10.90.53.225) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Tue, 5 Nov 2019 21:35:36 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <perex@perex.cz>, <gregkh@linuxfoundation.org>,
        <davem@davemloft.net>, <rfontana@redhat.com>,
        <kstewart@linuxfoundation.org>, <joe@perches.com>,
        <tglx@linutronix.d>
CC:     Chenwandun <chenwandun@huawei.com>
Subject: [PATCH] hp100: remove set but not used variable val
Date:   Tue, 5 Nov 2019 21:42:40 +0800
Message-ID: <1572961360-67523-1-git-send-email-chenwandun@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chenwandun <chenwandun@huawei.com>

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/staging/hp/hp100.c: In function hp100_start_xmit:
drivers/staging/hp/hp100.c:1629:10: warning: variable val set but not used [-Wunused-but-set-variable]

Signed-off-by: Chenwandun <chenwandun@huawei.com>
---
 drivers/staging/hp/hp100.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/hp/hp100.c b/drivers/staging/hp/hp100.c
index 6ec78f5..7e91737 100644
--- a/drivers/staging/hp/hp100.c
+++ b/drivers/staging/hp/hp100.c
@@ -1626,7 +1626,6 @@ static netdev_tx_t hp100_start_xmit(struct sk_buff *skb,
 	unsigned long flags;
 	int i, ok_flag;
 	int ioaddr = dev->base_addr;
-	u_short val;
 	struct hp100_private *lp = netdev_priv(dev);
 
 #ifdef HP100_DEBUG_B
@@ -1695,13 +1694,12 @@ static netdev_tx_t hp100_start_xmit(struct sk_buff *skb,
 
 	spin_lock_irqsave(&lp->lock, flags);
 	hp100_ints_off();
-	val = hp100_inw(IRQ_STATUS);
 	/* Ack / clear the interrupt TX_COMPLETE interrupt - this interrupt is set
 	 * when the current packet being transmitted on the wire is completed. */
 	hp100_outw(HP100_TX_COMPLETE, IRQ_STATUS);
 #ifdef HP100_DEBUG_TX
 	printk("hp100: %s: start_xmit: irq_status=0x%.4x, irqmask=0x%.4x, len=%d\n",
-			dev->name, val, hp100_inw(IRQ_MASK), (int) skb->len);
+			dev->name, hp100_inw(IRQ_STATUS), hp100_inw(IRQ_MASK), (int) skb->len);
 #endif
 
 	ok_flag = skb->len >= HP100_MIN_PACKET_SIZE;
-- 
2.7.4

