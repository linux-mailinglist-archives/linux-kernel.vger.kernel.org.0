Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88C117696E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 15:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388392AbfGZNwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 09:52:02 -0400
Received: from foss.arm.com ([217.140.110.172]:44508 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728291AbfGZNv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:51:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6D42337;
        Fri, 26 Jul 2019 06:51:55 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6E2F93F694;
        Fri, 26 Jul 2019 06:51:54 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, Peng Fan <peng.fan@nxp.com>,
        linux-kernel@vger.kernel.org,
        Bo Zhang <bozhang.zhang@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
        Gaku Inami <gaku.inami.xh@renesas.com>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [PATCH v2 06/10] firmware: arm_scmi: Add support for asynchronous commands and delayed response
Date:   Fri, 26 Jul 2019 14:51:34 +0100
Message-Id: <20190726135138.9858-7-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726135138.9858-1-sudeep.holla@arm.com>
References: <20190726135138.9858-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Messages that are sent to platform, also known as commands and can be:

1. Synchronous commands that block the channel until the requested work
has been completed. The platform responds to these commands over the
same channel and hence can't be used to send another command until the
previous command has completed.

2. Asynchronous commands on the other hand, the platform schedules the
requested work to complete later in time and returns almost immediately
freeing the channel for new commands. The response indicates the success
or failure in the ability to schedule the requested work. When the work
has completed, the platform sends an additional delayed response message.

Using the same transmit buffer used for sending the asynchronous command
even for the delayed response corresponding to it simplifies handling of
the delayed response. It's the caller of asynchronous command that is
responsible for allocating the completion flag that scmi driver can
complete to indicate the arrival of delayed response.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/common.h |  6 ++++-
 drivers/firmware/arm_scmi/driver.c | 43 ++++++++++++++++++++++++++++--
 2 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index a9eee62c7142..43884e4ceac5 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -84,17 +84,21 @@ struct scmi_msg {
  * @rx: Receive message, the buffer should be pre-allocated to store
  *	message. If request-ACK protocol is used, we can reuse the same
  *	buffer for the rx path as we use for the tx path.
- * @done: completion event
+ * @done: command message transmit completion event
+ * @async: pointer to delayed response message received event completion
  */
 struct scmi_xfer {
 	struct scmi_msg_hdr hdr;
 	struct scmi_msg tx;
 	struct scmi_msg rx;
 	struct completion done;
+	struct completion *async_done;
 };
 
 void scmi_xfer_put(const struct scmi_handle *h, struct scmi_xfer *xfer);
 int scmi_do_xfer(const struct scmi_handle *h, struct scmi_xfer *xfer);
+int scmi_do_xfer_with_response(const struct scmi_handle *h,
+			       struct scmi_xfer *xfer);
 int scmi_xfer_get_init(const struct scmi_handle *h, u8 msg_id, u8 prot_id,
 		       size_t tx_size, size_t rx_size, struct scmi_xfer **p);
 int scmi_handle_put(const struct scmi_handle *handle);
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 9a670918b050..59f7db1a66c2 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -345,6 +345,8 @@ __scmi_xfer_put(struct scmi_xfers_info *minfo, struct scmi_xfer *xfer)
  */
 static void scmi_rx_callback(struct mbox_client *cl, void *m)
 {
+	u8 msg_type;
+	u32 msg_hdr;
 	u16 xfer_id;
 	struct scmi_xfer *xfer;
 	struct scmi_chan_info *cinfo = client_to_scmi_chan_info(cl);
@@ -353,7 +355,12 @@ static void scmi_rx_callback(struct mbox_client *cl, void *m)
 	struct scmi_xfers_info *minfo = &info->tx_minfo;
 	struct scmi_shared_mem __iomem *mem = cinfo->payload;
 
-	xfer_id = MSG_XTRACT_TOKEN(ioread32(&mem->msg_header));
+	msg_hdr = ioread32(&mem->msg_header);
+	msg_type = MSG_XTRACT_TYPE(msg_hdr);
+	xfer_id = MSG_XTRACT_TOKEN(msg_hdr);
+
+	if (msg_type == MSG_TYPE_NOTIFICATION)
+		return; /* Notifications not yet supported */
 
 	/* Are we even expecting this? */
 	if (!test_bit(xfer_id, minfo->xfer_alloc_table)) {
@@ -366,7 +373,11 @@ static void scmi_rx_callback(struct mbox_client *cl, void *m)
 	scmi_dump_header_dbg(dev, &xfer->hdr);
 
 	scmi_fetch_response(xfer, mem);
-	complete(&xfer->done);
+
+	if (msg_type == MSG_TYPE_DELAYED_RESP)
+		complete(xfer->async_done);
+	else
+		complete(&xfer->done);
 }
 
 /**
@@ -470,6 +481,34 @@ int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
 	return ret;
 }
 
+#define SCMI_MAX_RESPONSE_TIMEOUT	(2 * MSEC_PER_SEC)
+
+/**
+ * scmi_do_xfer_with_response() - Do one transfer and wait until the delayed
+ *	response is received
+ *
+ * @handle: Pointer to SCMI entity handle
+ * @xfer: Transfer to initiate and wait for response
+ *
+ * Return: -ETIMEDOUT in case of no delayed response, if transmit error,
+ *	return corresponding error, else if all goes well, return 0.
+ */
+int scmi_do_xfer_with_response(const struct scmi_handle *handle,
+			       struct scmi_xfer *xfer)
+{
+	int ret, timeout = msecs_to_jiffies(SCMI_MAX_RESPONSE_TIMEOUT);
+	DECLARE_COMPLETION_ONSTACK(async_response);
+
+	xfer->async_done = &async_response;
+
+	ret = scmi_do_xfer(handle, xfer);
+	if (!ret && !wait_for_completion_timeout(xfer->async_done, timeout))
+		ret = -ETIMEDOUT;
+
+	xfer->async_done = NULL;
+	return ret;
+}
+
 /**
  * scmi_xfer_get_init() - Allocate and initialise one message for transmit
  *
-- 
2.17.1

