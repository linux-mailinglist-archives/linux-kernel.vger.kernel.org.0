Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFC30179520
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 17:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388107AbgCDQ0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 11:26:45 -0500
Received: from foss.arm.com ([217.140.110.172]:36566 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbgCDQ0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:26:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B6F911B3;
        Wed,  4 Mar 2020 08:26:41 -0800 (PST)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 489603F6CF;
        Wed,  4 Mar 2020 08:26:40 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        cristian.marussi@arm.com
Subject: [PATCH v4 04/13] firmware: arm_scmi: Add support for notifications message processing
Date:   Wed,  4 Mar 2020 16:25:49 +0000
Message-Id: <20200304162558.48836-5-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200304162558.48836-1-cristian.marussi@arm.com>
References: <20200304162558.48836-1-cristian.marussi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudeep Holla <sudeep.holla@arm.com>

Add the mechanisms to distinguish notifications from delayed responses and
to properly fetch notification messages upon reception: notifications
processing does not continue further after the fetch phase.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
[Reworked/renamed scmi_handle_xfer_delayed_resp()]
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
V1 --> V2
- switch the notif/delayed_resp message processing logic to use new
  transport independent layer methods
- reviewed logic of scmi_handle_xfer_delayed_resp() while renaming it as
  scmi_handle_response()
- properly relocated tracer points
---
 drivers/firmware/arm_scmi/driver.c | 84 +++++++++++++++++++++++-------
 1 file changed, 64 insertions(+), 20 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index efb660c34b57..868cc36a07c9 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -202,29 +202,42 @@ __scmi_xfer_put(struct scmi_xfers_info *minfo, struct scmi_xfer *xfer)
 	spin_unlock_irqrestore(&minfo->xfer_lock, flags);
 }
 
-/**
- * scmi_rx_callback() - callback for receiving messages
- *
- * @cinfo: SCMI channel info
- * @msg_hdr: Message header
- *
- * Processes one received message to appropriate transfer information and
- * signals completion of the transfer.
- *
- * NOTE: This function will be invoked in IRQ context, hence should be
- * as optimal as possible.
- */
-void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr)
+static void scmi_handle_notification(struct scmi_chan_info *cinfo, u32 msg_hdr)
 {
-	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
-	struct scmi_xfers_info *minfo = &info->tx_minfo;
-	u16 xfer_id = MSG_XTRACT_TOKEN(msg_hdr);
-	u8 msg_type = MSG_XTRACT_TYPE(msg_hdr);
-	struct device *dev = cinfo->dev;
 	struct scmi_xfer *xfer;
+	struct device *dev = cinfo->dev;
+	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
+	struct scmi_xfers_info *minfo = &info->rx_minfo;
+
+	xfer = scmi_xfer_get(cinfo->handle, minfo);
+	if (IS_ERR(xfer)) {
+		dev_err(dev, "failed to get free message slot (%ld)\n",
+			PTR_ERR(xfer));
+		info->desc->ops->clear_notification(cinfo);
+		return;
+	}
+
+	unpack_scmi_header(msg_hdr, &xfer->hdr);
+	scmi_dump_header_dbg(dev, &xfer->hdr);
+	info->desc->ops->fetch_notification(cinfo, info->desc->max_msg_size,
+					    xfer);
+
+	trace_scmi_rx_done(xfer->transfer_id, xfer->hdr.id,
+			   xfer->hdr.protocol_id, xfer->hdr.seq,
+			   MSG_TYPE_NOTIFICATION);
 
-	if (msg_type == MSG_TYPE_NOTIFICATION)
-		return; /* Notifications not yet supported */
+	__scmi_xfer_put(minfo, xfer);
+
+	info->desc->ops->clear_notification(cinfo);
+}
+
+static void scmi_handle_response(struct scmi_chan_info *cinfo,
+				 u16 xfer_id, u8 msg_type)
+{
+	struct scmi_xfer *xfer;
+	struct device *dev = cinfo->dev;
+	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
+	struct scmi_xfers_info *minfo = &info->tx_minfo;
 
 	/* Are we even expecting this? */
 	if (!test_bit(xfer_id, minfo->xfer_alloc_table)) {
@@ -248,6 +261,37 @@ void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr)
 		complete(&xfer->done);
 }
 
+/**
+ * scmi_rx_callback() - callback for receiving messages
+ *
+ * @cinfo: SCMI channel info
+ * @msg_hdr: Message header
+ *
+ * Processes one received message to appropriate transfer information and
+ * signals completion of the transfer.
+ *
+ * NOTE: This function will be invoked in IRQ context, hence should be
+ * as optimal as possible.
+ */
+void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr)
+{
+	u16 xfer_id = MSG_XTRACT_TOKEN(msg_hdr);
+	u8 msg_type = MSG_XTRACT_TYPE(msg_hdr);
+
+	switch (msg_type) {
+	case MSG_TYPE_NOTIFICATION:
+		scmi_handle_notification(cinfo, msg_hdr);
+		break;
+	case MSG_TYPE_COMMAND:
+	case MSG_TYPE_DELAYED_RESP:
+		scmi_handle_response(cinfo, xfer_id, msg_type);
+		break;
+	default:
+		WARN_ONCE(1, "received unknown msg_type:%d\n", msg_type);
+		break;
+	}
+}
+
 /**
  * scmi_xfer_put() - Release a transmit message
  *
-- 
2.17.1

