Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 608FE170C3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 08:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbfEHGG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 02:06:58 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44886 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728656AbfEHGGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 02:06:53 -0400
Received: by mail-pg1-f195.google.com with SMTP id z16so9536200pgv.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 23:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5QvIkqbGDWQGjQdB0qAWbmXE/7oiAphBuUP129NNJWE=;
        b=XlyYvX0tNDttRdrX9Y56BXVlXB+gkmyxJXfc2/BRsx+beiWJQjcRC/0Rd971GPHLi+
         oH8Rx2zMq46kxdWEeuN5mz5tAEolSZ/ESm0UgIjEsxdeoVZvs3oJLeiVJkHg8W9wBuaW
         YmWBLtX3pA96S+nSWGrh5bKMgetnNbAf4VKMpoHJCynFwIuQKZ5m4GTgiKEnzduJ0wM6
         mDpUSpotslyr/9KdLEntdOICFYnuTxxCfIeQl0ib270QMtYBrHp1eeNZbpQ5BYBez8gw
         Z4+gNmwvFGHR3mRT687M2M3ReUiLN9seiY0yi3Z5QdMfbAKM1w47s/bxtCApOGHlZ8Ss
         Ilkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5QvIkqbGDWQGjQdB0qAWbmXE/7oiAphBuUP129NNJWE=;
        b=uCi9MlYLvc6clbNt1MD8+0QYEljhRut6XDMTMj6b4OYBYCWDawLbKd4bVgNBB2BiRc
         B+pYGQ3ZhXdTn831DgKGXQ68zKCQX+pcsBVtXKt/JGCcBm7lnc5lsH+lxMHmT3XuXnYd
         dtp88pnT/mUnc/SnDyxwDptSlkDt6IksNWiaYZh0aodCO3mjlu4SaAN0HRzjylSNImBr
         4R4e5gUzUt8j9EtU26gGJ5J86+WsD3bNN9Ln5wZjkPu4OubCmqcoCeF+gc7SARmvcuMQ
         sPRdiYnIK0aOmFsCim32F1pqjSiSrvLyzEvFt1x/6vUyL9JyCyie34zrg/xQt4vgr+nb
         Zy7w==
X-Gm-Message-State: APjAAAWv+lQPHb/Jy5E3ieKg7gx5w2xUfG7pkAT3k4Z8kPmiJBm+uNbk
        APRkUt40kFNS9bb+2mAZVBCFhw==
X-Google-Smtp-Source: APXvYqxPEzjs7BfkX+QiaVlof/E4zXOHhfuVzV97FIuOAi2my2Vx0PXlMxHMYR8cLW0FmoQhYUlhrw==
X-Received: by 2002:a63:7c6:: with SMTP id 189mr44184260pgh.247.1557295612735;
        Tue, 07 May 2019 23:06:52 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id t5sm2756130pgn.80.2019.05.07.23.06.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 23:06:52 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Chris Lew <clew@codeaurora.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 5/5] net: qrtr: Remove receive worker
Date:   Tue,  7 May 2019 23:06:43 -0700
Message-Id: <20190508060643.30936-6-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190508060643.30936-1-bjorn.andersson@linaro.org>
References: <20190508060643.30936-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than enqueuing messages and scheduling a worker to deliver them
to the individual sockets we can now, thanks to the previous work, move
this directly into the endpoint callback.

This saves us a context switch per incoming message and removes the
possibility of an opportunistic suspend to happen between the message is
coming from the endpoint until it ends up in the socket's receive
buffer.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 net/qrtr/qrtr.c | 54 ++++++++++++++++---------------------------------
 1 file changed, 17 insertions(+), 37 deletions(-)

diff --git a/net/qrtr/qrtr.c b/net/qrtr/qrtr.c
index d2eef43a3124..25cd5ddce5b9 100644
--- a/net/qrtr/qrtr.c
+++ b/net/qrtr/qrtr.c
@@ -163,6 +163,8 @@ static int qrtr_local_enqueue(struct qrtr_node *node, struct sk_buff *skb,
 static int qrtr_bcast_enqueue(struct qrtr_node *node, struct sk_buff *skb,
 			      int type, struct sockaddr_qrtr *from,
 			      struct sockaddr_qrtr *to);
+static struct qrtr_sock *qrtr_port_lookup(int port);
+static void qrtr_port_put(struct qrtr_sock *ipc);
 
 /* Release node resources and free the node.
  *
@@ -386,6 +388,7 @@ int qrtr_endpoint_post(struct qrtr_endpoint *ep, const void *data, size_t len)
 	struct qrtr_node *node = ep->node;
 	const struct qrtr_hdr_v1 *v1;
 	const struct qrtr_hdr_v2 *v2;
+	struct qrtr_sock *ipc;
 	struct sk_buff *skb;
 	struct qrtr_cb *cb;
 	unsigned int size;
@@ -450,8 +453,20 @@ int qrtr_endpoint_post(struct qrtr_endpoint *ep, const void *data, size_t len)
 
 	skb_put_data(skb, data + hdrlen, size);
 
-	skb_queue_tail(&node->rx_queue, skb);
-	schedule_work(&node->work);
+	qrtr_node_assign(node, cb->src_node);
+
+	if (cb->type == QRTR_TYPE_RESUME_TX) {
+		qrtr_tx_resume(node, skb);
+	} else {
+		ipc = qrtr_port_lookup(cb->dst_port);
+		if (!ipc)
+			goto err;
+
+		if (sock_queue_rcv_skb(&ipc->sk, skb))
+			goto err;
+
+		qrtr_port_put(ipc);
+	}
 
 	return 0;
 
@@ -486,40 +501,6 @@ static struct sk_buff *qrtr_alloc_ctrl_packet(struct qrtr_ctrl_pkt **pkt)
 	return skb;
 }
 
-static struct qrtr_sock *qrtr_port_lookup(int port);
-static void qrtr_port_put(struct qrtr_sock *ipc);
-
-/* Handle and route a received packet.
- *
- * This will auto-reply with resume-tx packet as necessary.
- */
-static void qrtr_node_rx_work(struct work_struct *work)
-{
-	struct qrtr_node *node = container_of(work, struct qrtr_node, work);
-	struct sk_buff *skb;
-
-	while ((skb = skb_dequeue(&node->rx_queue)) != NULL) {
-		struct qrtr_sock *ipc;
-		struct qrtr_cb *cb = (struct qrtr_cb *)skb->cb;
-
-		qrtr_node_assign(node, cb->src_node);
-
-		if (cb->type == QRTR_TYPE_RESUME_TX) {
-			qrtr_tx_resume(node, skb);
-		} else {
-			ipc = qrtr_port_lookup(cb->dst_port);
-			if (!ipc) {
-				kfree_skb(skb);
-			} else {
-				if (sock_queue_rcv_skb(&ipc->sk, skb))
-					kfree_skb(skb);
-
-				qrtr_port_put(ipc);
-			}
-		}
-	}
-}
-
 /**
  * qrtr_endpoint_register() - register a new endpoint
  * @ep: endpoint to register
@@ -539,7 +520,6 @@ int qrtr_endpoint_register(struct qrtr_endpoint *ep, unsigned int nid)
 	if (!node)
 		return -ENOMEM;
 
-	INIT_WORK(&node->work, qrtr_node_rx_work);
 	kref_init(&node->ref);
 	mutex_init(&node->ep_lock);
 	skb_queue_head_init(&node->rx_queue);
-- 
2.18.0

