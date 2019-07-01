Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 486DA31042
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 16:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfEaOdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 10:33:40 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52430 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbfEaOdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 10:33:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C90415AD;
        Fri, 31 May 2019 07:33:38 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9FEBE3F5AF;
        Fri, 31 May 2019 07:33:36 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 1/6] mailbox: add support for doorbell/signal mode controllers
Date:   Fri, 31 May 2019 15:33:15 +0100
Message-Id: <20190531143320.8895-2-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190531143320.8895-1-sudeep.holla@arm.com>
References: <20190531143320.8895-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some mailbox controllers are lack FIFOs or memory to transmit data.
They typically contains single doorbell registers to just signal the
remote. The actually data is transmitted/shared using some shared memory
which is not part of the mailbox.

Such controllers don't need to transmit any data, they just transmit
the signal. In such controllers the data pointer passed to
mbox_send_message is passed to client via it's tx_prepare callback.
Controller doesn't need any data to be passed from the client.

This patch introduce the new API send_signal to support such doorbell/
signal mode in mailbox controllers. This is useful to avoid another
layer of abstraction as typically multiple channels can be multiplexied
into single register.

Cc: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mailbox/mailbox.c          | 11 ++++++++++-
 include/linux/mailbox_controller.h | 11 +++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 38d9df3fb199..e26a079f8223 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -77,7 +77,10 @@ static void msg_submit(struct mbox_chan *chan)
 	if (chan->cl->tx_prepare)
 		chan->cl->tx_prepare(chan->cl, data);
 	/* Try to submit a message to the MBOX controller */
-	err = chan->mbox->ops->send_data(chan, data);
+	if (chan->mbox->ops->send_data)
+		err = chan->mbox->ops->send_data(chan, data);
+	else
+		err = chan->mbox->ops->send_signal(chan);
 	if (!err) {
 		chan->active_req = data;
 		chan->msg_count--;
@@ -481,6 +484,12 @@ int mbox_controller_register(struct mbox_controller *mbox)
 	/* Sanity check */
 	if (!mbox || !mbox->dev || !mbox->ops || !mbox->num_chans)
 		return -EINVAL;
+	/*
+	 * A controller can support either doorbell mode or normal message
+	 * transmission mode but not both
+	 */
+	if (mbox->ops->send_data && mbox->ops->send_signal)
+		return -EINVAL;
 
 	if (mbox->txdone_irq)
 		txdone = TXDONE_BY_IRQ;
diff --git a/include/linux/mailbox_controller.h b/include/linux/mailbox_controller.h
index 4994a438444c..b3f547ad782a 100644
--- a/include/linux/mailbox_controller.h
+++ b/include/linux/mailbox_controller.h
@@ -24,6 +24,16 @@ struct mbox_chan;
  *		transmission of data is reported by the controller via
  *		mbox_chan_txdone (if it has some TX ACK irq). It must not
  *		sleep.
+ * @send_signal: The API asks the MBOX controller driver, in atomic
+ *		 context try to transmit a signal on the bus. Returns 0 if
+ *		 data is accepted for transmission, -EBUSY while rejecting
+ *		 if the remote hasn't yet absorbed the last signal sent. Actual
+ *		 transmission of data must be handled by the client and  is
+ *		 reported by the controller via mbox_chan_txdone (if it has
+ *		 some TX ACK irq). It must not sleep. Unlike send_data,
+ *		 send_signal doesn't handle any messages/data. It just sends
+ *		 notification signal(doorbell) and client needs to prepare all
+ *		 the data.
  * @flush:	Called when a client requests transmissions to be blocking but
  *		the context doesn't allow sleeping. Typically the controller
  *		will implement a busy loop waiting for the data to flush out.
@@ -49,6 +59,7 @@ struct mbox_chan;
  */
 struct mbox_chan_ops {
 	int (*send_data)(struct mbox_chan *chan, void *data);
+	int (*send_signal)(struct mbox_chan *chan);
 	int (*flush)(struct mbox_chan *chan, unsigned long timeout);
 	int (*startup)(struct mbox_chan *chan);
 	void (*shutdown)(struct mbox_chan *chan);
-- 
2.17.1

