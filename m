Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14049170C0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 08:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbfEHGGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 02:06:53 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40322 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728623AbfEHGGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 02:06:50 -0400
Received: by mail-pf1-f193.google.com with SMTP id u17so9933109pfn.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 23:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=weXR0ozFuBouXZ8KcycdlER5X3DNpYZdQnnp0CK/2lg=;
        b=mkdN9syqvzlVse/daNYDUR2HnLOM2uWwamfO2Rkh/MYGR7TrSw8ugaxkCSPV9+txEO
         NlExxcgbG0l5RS7Vx2hbALWM/4AyUox0g961hWsrTFmAzj2IEyXyo9U/rhqITPH1aLgJ
         E8MBFBmPeP9b84aYf9SDPc43NyVN1J7sZKIdYLRAI9OGmcW9KJrpUhOw2Tw8hfyXhl+k
         TnE4ASpsvGE01ZQablbcwc6/NIzqCb9nxeLXtrqz88RTuEpv70GzUSoC3cQPyHVzKKbw
         u/CfnhCbVlkhRZPZkITk5g4dvvtE9woC9Aox5upOuuuwHmWQoFVgd8a4kYgssHterYQX
         bdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=weXR0ozFuBouXZ8KcycdlER5X3DNpYZdQnnp0CK/2lg=;
        b=YfQiqg5Arkj+BI1dM/YXrecrRfvJna6L5cn8oVHR2ucqhOpC3AXus90ivBYu+UdPke
         sUfBygJL9Cmzu6uFzO73MpvX2UkUW+ELv6mKQc5OJl2Gb6ImzAX/SCSss1jgPXvAAsoH
         8kogOUx4Gygv6Kt6ut5ISCK6QrejhDZLeLcaCFgj6n7iuUzDSX8RmsYH2cCPmoQZQB29
         0K2sZGrrY/wP6+EsxEFVp3xdMeEZJvyhUGweBuD34eBb0UunpZ+eBpqLnfu61qQd1LAA
         Dwfd/yfigU7gMoln5K3cgFfsIe4dz3ZtXEg5ImjfA0gcx/3JrS5vf8uaam1ZH8WP7mZ5
         4+uA==
X-Gm-Message-State: APjAAAWHMYqWp5by8K7hS6zJS7XbhjF3fFSBG8XYnTIhI2mSo9yTdKDm
        0UmtwT0K+162l9xtYiwAEXuHDQ==
X-Google-Smtp-Source: APXvYqx/prK1YIZYl21CfwClPhXFai0hRQXuSMnx3bvBRE7GOW8u34na/7F6EmOiUBJrm8hoIJMu4A==
X-Received: by 2002:a63:c24c:: with SMTP id l12mr29315720pgg.173.1557295609480;
        Tue, 07 May 2019 23:06:49 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id t5sm2756130pgn.80.2019.05.07.23.06.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 23:06:48 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Chris Lew <clew@codeaurora.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 2/5] net: qrtr: Implement outgoing flow control
Date:   Tue,  7 May 2019 23:06:40 -0700
Message-Id: <20190508060643.30936-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190508060643.30936-1-bjorn.andersson@linaro.org>
References: <20190508060643.30936-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to prevent overconsumption of resources on the remote side QRTR
implements a flow control mechanism.

The mechanism works by the sender keeping track of the number of
outstanding unconfirmed messages that has been transmitted to a
particular node/port pair.

Upon count reaching a low watermark (L) the confirm_rx bit is set in the
outgoing message and when the count reaching a high watermark (H)
transmission will be blocked upon the reception of a resume_tx message
from the remote, that resets the counter to 0.

This guarantees that there will be at most 2H - L messages in flight.
Values chosen for L and H are 5 and 10 respectively.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 net/qrtr/qrtr.c | 143 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 136 insertions(+), 7 deletions(-)

diff --git a/net/qrtr/qrtr.c b/net/qrtr/qrtr.c
index 07a35362fba2..62abd622618d 100644
--- a/net/qrtr/qrtr.c
+++ b/net/qrtr/qrtr.c
@@ -16,6 +16,7 @@
 #include <linux/qrtr.h>
 #include <linux/termios.h>	/* For TIOCINQ/OUTQ */
 #include <linux/numa.h>
+#include <linux/wait.h>
 
 #include <net/sock.h>
 
@@ -121,6 +122,9 @@ static DEFINE_MUTEX(qrtr_port_lock);
  * @ep: endpoint
  * @ref: reference count for node
  * @nid: node id
+ * @qrtr_tx_flow: tree with tx counts per flow
+ * @resume_tx: waiters for a resume tx from the remote
+ * @qrtr_tx_lock: lock for qrtr_tx_flow
  * @rx_queue: receive queue
  * @work: scheduled work struct for recv work
  * @item: list item for broadcast list
@@ -131,11 +135,26 @@ struct qrtr_node {
 	struct kref ref;
 	unsigned int nid;
 
+	struct radix_tree_root qrtr_tx_flow;
+	struct wait_queue_head resume_tx;
+	struct mutex qrtr_tx_lock; /* for qrtr_tx_flow */
+
 	struct sk_buff_head rx_queue;
 	struct work_struct work;
 	struct list_head item;
 };
 
+/**
+ * struct qrtr_tx_flow - tx flow control
+ * @pending: number of waiting senders
+ */
+struct qrtr_tx_flow {
+	atomic_t pending;
+};
+
+#define QRTR_TX_FLOW_HIGH	10
+#define QRTR_TX_FLOW_LOW	5
+
 static int qrtr_local_enqueue(struct qrtr_node *node, struct sk_buff *skb,
 			      int type, struct sockaddr_qrtr *from,
 			      struct sockaddr_qrtr *to);
@@ -150,7 +169,9 @@ static int qrtr_bcast_enqueue(struct qrtr_node *node, struct sk_buff *skb,
  */
 static void __qrtr_node_release(struct kref *kref)
 {
+	struct radix_tree_iter iter;
 	struct qrtr_node *node = container_of(kref, struct qrtr_node, ref);
+	void __rcu **slot;
 
 	if (node->nid != QRTR_EP_NID_AUTO)
 		radix_tree_delete(&qrtr_nodes, node->nid);
@@ -158,6 +179,12 @@ static void __qrtr_node_release(struct kref *kref)
 	list_del(&node->item);
 	mutex_unlock(&qrtr_node_lock);
 
+	/* Free tx flow counters */
+	radix_tree_for_each_slot(slot, &node->qrtr_tx_flow, &iter, 0) {
+		radix_tree_iter_delete(&node->qrtr_tx_flow, &iter, slot);
+		kfree(*slot);
+	}
+
 	skb_queue_purge(&node->rx_queue);
 	kfree(node);
 }
@@ -178,15 +205,106 @@ static void qrtr_node_release(struct qrtr_node *node)
 	kref_put_mutex(&node->ref, __qrtr_node_release, &qrtr_node_lock);
 }
 
+/**
+ * qrtr_tx_resume() - reset flow control counter
+ * @node:	qrtr_node that the QRTR_TYPE_RESUME_TX packet arrived on
+ * @skb:	resume_tx packet
+ */
+static void qrtr_tx_resume(struct qrtr_node *node, struct sk_buff *skb)
+{
+	struct qrtr_ctrl_pkt *pkt = (struct qrtr_ctrl_pkt *)skb->data;
+	struct qrtr_tx_flow *flow;
+	unsigned long key;
+	u64 remote_node = le32_to_cpu(pkt->client.node);
+	u32 remote_port = le32_to_cpu(pkt->client.port);
+
+	key = remote_node << 32 | remote_port;
+
+	flow = radix_tree_lookup(&node->qrtr_tx_flow, key);
+	if (flow)
+		atomic_set(&flow->pending, 0);
+
+	wake_up_interruptible_all(&node->resume_tx);
+
+	consume_skb(skb);
+}
+
+/**
+ * qrtr_tx_wait() - flow control for outgoing packets
+ * @node:	qrtr_node that the packet is to be send to
+ * @dest_node:	node id of the destination
+ * @dest_port:	port number of the destination
+ * @type:	type of message
+ *
+ * The flow control scheme is based around the low and high "watermarks". When
+ * the low watermark is passed the confirm_rx flag is set on the outgoing
+ * message, which will trigger the remote to send a control message of the type
+ * QRTR_TYPE_RESUME_TX to reset the counter. If the high watermark is hit
+ * further transmision should be paused.
+ *
+ * Return: 1 if confirm_rx should be set, 0 otherwise or errno failure
+ */
+static int qrtr_tx_wait(struct qrtr_node *node, int dest_node, int dest_port,
+			int type)
+{
+	struct qrtr_tx_flow *flow;
+	unsigned long key = (u64)dest_node << 32 | dest_port;
+	int confirm_rx = 0;
+	int ret;
+
+	/* Never set confirm_rx on non-data packets */
+	if (type != QRTR_TYPE_DATA)
+		return 0;
+
+	mutex_lock(&node->qrtr_tx_lock);
+	flow = radix_tree_lookup(&node->qrtr_tx_flow, key);
+	if (!flow) {
+		flow = kzalloc(sizeof(*flow), GFP_KERNEL);
+		if (!flow)
+			confirm_rx = 1;
+		else
+			radix_tree_insert(&node->qrtr_tx_flow, key, flow);
+	}
+	mutex_unlock(&node->qrtr_tx_lock);
+
+	for (;;) {
+		ret = wait_event_interruptible(node->resume_tx,
+					       atomic_read(&flow->pending) < QRTR_TX_FLOW_HIGH ||
+					       !node->ep);
+		if (ret)
+			return ret;
+
+		if (!node->ep)
+			return -EPIPE;
+
+		mutex_lock(&node->qrtr_tx_lock);
+		if (atomic_read(&flow->pending) < QRTR_TX_FLOW_HIGH) {
+			confirm_rx = atomic_inc_return(&flow->pending) == QRTR_TX_FLOW_LOW;
+			mutex_unlock(&node->qrtr_tx_lock);
+			break;
+		}
+		mutex_unlock(&node->qrtr_tx_lock);
+	}
+
+	return confirm_rx;
+}
+
 /* Pass an outgoing packet socket buffer to the endpoint driver. */
 static int qrtr_node_enqueue(struct qrtr_node *node, struct sk_buff *skb,
 			     int type, struct sockaddr_qrtr *from,
 			     struct sockaddr_qrtr *to)
 {
 	struct qrtr_hdr_v1 *hdr;
+	int confirm_rx;
 	size_t len = skb->len;
 	int rc = -ENODEV;
 
+	confirm_rx = qrtr_tx_wait(node, to->sq_node, to->sq_port, type);
+	if (confirm_rx < 0) {
+		kfree_skb(skb);
+		return confirm_rx;
+	}
+
 	hdr = skb_push(skb, sizeof(*hdr));
 	hdr->version = cpu_to_le32(QRTR_PROTO_VER_1);
 	hdr->type = cpu_to_le32(type);
@@ -201,7 +319,7 @@ static int qrtr_node_enqueue(struct qrtr_node *node, struct sk_buff *skb,
 	}
 
 	hdr->size = cpu_to_le32(len);
-	hdr->confirm_rx = 0;
+	hdr->confirm_rx = !!confirm_rx;
 
 	skb_put_padto(skb, ALIGN(len, 4));
 
@@ -318,7 +436,8 @@ int qrtr_endpoint_post(struct qrtr_endpoint *ep, const void *data, size_t len)
 	if (len != ALIGN(size, 4) + hdrlen)
 		goto err;
 
-	if (cb->dst_port != QRTR_PORT_CTRL && cb->type != QRTR_TYPE_DATA)
+	if (cb->dst_port != QRTR_PORT_CTRL && cb->type != QRTR_TYPE_DATA &&
+	    cb->type != QRTR_TYPE_RESUME_TX)
 		goto err;
 
 	skb_put_data(skb, data + hdrlen, size);
@@ -377,14 +496,18 @@ static void qrtr_node_rx_work(struct work_struct *work)
 
 		qrtr_node_assign(node, cb->src_node);
 
-		ipc = qrtr_port_lookup(cb->dst_port);
-		if (!ipc) {
-			kfree_skb(skb);
+		if (cb->type == QRTR_TYPE_RESUME_TX) {
+			qrtr_tx_resume(node, skb);
 		} else {
-			if (sock_queue_rcv_skb(&ipc->sk, skb))
+			ipc = qrtr_port_lookup(cb->dst_port);
+			if (!ipc) {
 				kfree_skb(skb);
+			} else {
+				if (sock_queue_rcv_skb(&ipc->sk, skb))
+					kfree_skb(skb);
 
-			qrtr_port_put(ipc);
+				qrtr_port_put(ipc);
+			}
 		}
 	}
 }
@@ -415,6 +538,9 @@ int qrtr_endpoint_register(struct qrtr_endpoint *ep, unsigned int nid)
 	node->nid = QRTR_EP_NID_AUTO;
 	node->ep = ep;
 
+	INIT_RADIX_TREE(&node->qrtr_tx_flow, GFP_KERNEL);
+	init_waitqueue_head(&node->resume_tx);
+
 	qrtr_node_assign(node, nid);
 
 	mutex_lock(&qrtr_node_lock);
@@ -449,6 +575,9 @@ void qrtr_endpoint_unregister(struct qrtr_endpoint *ep)
 		qrtr_local_enqueue(NULL, skb, QRTR_TYPE_BYE, &src, &dst);
 	}
 
+	/* Wake up any transmitters waiting for resume-tx from the node */
+	wake_up_interruptible_all(&node->resume_tx);
+
 	qrtr_node_release(node);
 	ep->node = NULL;
 }
-- 
2.18.0

