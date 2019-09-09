Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB2C5AD4F3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2019 10:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389341AbfIIIhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Sep 2019 04:37:47 -0400
Received: from mail.jv-coder.de ([5.9.79.73]:47070 "EHLO mail.jv-coder.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727003AbfIIIhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 04:37:47 -0400
Received: from ubuntu.localdomain (unknown [37.156.92.209])
        by mail.jv-coder.de (Postfix) with ESMTPSA id BD6AD9F681;
        Mon,  9 Sep 2019 08:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
        t=1568018264; bh=zY/1ofIhpVZLmVanmMvgSnDnQqqIxXY/7E9pjv3hfJo=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=NChUk80kjL96BsB0SP6L3oETn7wowCoPj3o1BojqTW7E1ZJXd8y1Ga/IdI29mF6tZ
         u5cCsyCN5v20qLBa2gZBkVavc71YBXxJcYMoKhmc3og8HsfuthgjPFKrWB2huuHUf5
         04U2aZKP1+tEnCLe1+Aph97GQ43Y4vdVnmR3cTjU=
From:   Joerg Vehlow <lkml@jv-coder.de>
To:     linux-kernel@vger.kernel.org, joerg.vehlow@aox-tech.de
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] xfrm_input: Protect queue with lock
Date:   Mon,  9 Sep 2019 10:37:00 +0200
Message-Id: <20190909083700.63579-1-lkml@jv-coder.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.jv-coder.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

During the skb_queue_splice_init the tasklet could have been preempted
and __skb_queue_tail called, which led to an inconsistent queue.

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 net/xfrm/xfrm_input.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 790b514f86b6..4c4e669fcd16 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -512,12 +512,15 @@ EXPORT_SYMBOL(xfrm_input_resume);
 
 static void xfrm_trans_reinject(unsigned long data)
 {
+	unsigned long flags;
 	struct xfrm_trans_tasklet *trans = (void *)data;
 	struct sk_buff_head queue;
 	struct sk_buff *skb;
 
 	__skb_queue_head_init(&queue);
+	spin_lock_irqsave(&trans->queue.lock, flags);
 	skb_queue_splice_init(&trans->queue, &queue);
+	spin_unlock_irqrestore(&trans->queue.lock, flags);
 
 	while ((skb = __skb_dequeue(&queue)))
 		XFRM_TRANS_SKB_CB(skb)->finish(dev_net(skb->dev), NULL, skb);
@@ -535,7 +538,7 @@ int xfrm_trans_queue(struct sk_buff *skb,
 		return -ENOBUFS;
 
 	XFRM_TRANS_SKB_CB(skb)->finish = finish;
-	__skb_queue_tail(&trans->queue, skb);
+	skb_queue_tail(&trans->queue, skb);
 	tasklet_schedule(&trans->tasklet);
 	return 0;
 }
@@ -560,7 +563,7 @@ void __init xfrm_input_init(void)
 		struct xfrm_trans_tasklet *trans;
 
 		trans = &per_cpu(xfrm_trans_tasklet, i);
-		__skb_queue_head_init(&trans->queue);
+		skb_queue_head_init(&trans->queue);
 		tasklet_init(&trans->tasklet, xfrm_trans_reinject,
 			     (unsigned long)trans);
 	}
-- 
2.20.1

