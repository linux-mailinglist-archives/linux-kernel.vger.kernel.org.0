Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F90462514
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 17:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403935AbfGHPsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 11:48:24 -0400
Received: from foss.arm.com ([217.140.110.172]:52364 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387472AbfGHPrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:47:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F4A61516;
        Mon,  8 Jul 2019 08:47:46 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3C8C33F59C;
        Mon,  8 Jul 2019 08:47:45 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Bo Zhang <bozhang.zhang@broadcom.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>
Subject: [PATCH 04/11] firmware: arm_scmi: Separate out tx buffer handling and prepare to add rx
Date:   Mon,  8 Jul 2019 16:47:23 +0100
Message-Id: <20190708154730.16643-5-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190708154730.16643-1-sudeep.holla@arm.com>
References: <20190708154730.16643-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we pre-allocate transmit buffers only and use the first free
slot in that pre-allocated buffer for transmitting any new message that
are generally originated from OS to the platform firmware.

Notifications or the delayed responses on the other hand are originated
from the platform firmware and consumes by the OS. It's better to have
separate and dedicated pre-allocated buffers to handle the notifications.
We can still use the transmit buffers for the delayed responses.

In addition, let's prepare existing scmi_xfer_{get,put} for acquiring
and releasing a slot to identify the right(tx/rx) buffers.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 40 ++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index e9b762348eff..1a7ffd3f8534 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -111,7 +111,7 @@ struct scmi_chan_info {
  * @handle: Instance of SCMI handle to send to clients
  * @version: SCMI revision information containing protocol version,
  *	implementation version and (sub-)vendor identification.
- * @minfo: Message info
+ * @tx_minfo: Universal Transmit Message management info
  * @tx_idr: IDR object to map protocol id to Tx channel info pointer
  * @rx_idr: IDR object to map protocol id to Rx channel info pointer
  * @protocols_imp: List of protocols implemented, currently maximum of
@@ -124,7 +124,7 @@ struct scmi_info {
 	const struct scmi_desc *desc;
 	struct scmi_revision_info version;
 	struct scmi_handle handle;
-	struct scmi_xfers_info minfo;
+	struct scmi_xfers_info tx_minfo;
 	struct idr tx_idr;
 	struct idr rx_idr;
 	u8 *protocols_imp;
@@ -251,6 +251,7 @@ static void scmi_tx_prepare(struct mbox_client *cl, void *m)
  * scmi_xfer_get() - Allocate one message
  *
  * @handle: Pointer to SCMI entity handle
+ * @minfo: Pointer to Tx/Rx Message management info based on channel type
  *
  * Helper function which is used by various message functions that are
  * exposed to clients of this driver for allocating a message traffic event.
@@ -261,13 +262,13 @@ static void scmi_tx_prepare(struct mbox_client *cl, void *m)
  *
  * Return: 0 if all went fine, else corresponding error.
  */
-static struct scmi_xfer *scmi_xfer_get(const struct scmi_handle *handle)
+static struct scmi_xfer *scmi_xfer_get(const struct scmi_handle *handle,
+				       struct scmi_xfers_info *minfo)
 {
 	u16 xfer_id;
 	struct scmi_xfer *xfer;
 	unsigned long flags, bit_pos;
 	struct scmi_info *info = handle_to_scmi_info(handle);
-	struct scmi_xfers_info *minfo = &info->minfo;
 
 	/* Keep the locked section as small as possible */
 	spin_lock_irqsave(&minfo->xfer_lock, flags);
@@ -290,18 +291,17 @@ static struct scmi_xfer *scmi_xfer_get(const struct scmi_handle *handle)
 }
 
 /**
- * scmi_xfer_put() - Release a message
+ * __scmi_xfer_put() - Release a message
  *
- * @handle: Pointer to SCMI entity handle
+ * @minfo: Pointer to Tx/Rx Message management info based on channel type
  * @xfer: message that was reserved by scmi_xfer_get
  *
  * This holds a spinlock to maintain integrity of internal data structures.
  */
-void scmi_xfer_put(const struct scmi_handle *handle, struct scmi_xfer *xfer)
+static void
+__scmi_xfer_put(struct scmi_xfers_info *minfo, struct scmi_xfer *xfer)
 {
 	unsigned long flags;
-	struct scmi_info *info = handle_to_scmi_info(handle);
-	struct scmi_xfers_info *minfo = &info->minfo;
 
 	/*
 	 * Keep the locked section as small as possible
@@ -332,7 +332,7 @@ static void scmi_rx_callback(struct mbox_client *cl, void *m)
 	struct scmi_chan_info *cinfo = client_to_scmi_chan_info(cl);
 	struct device *dev = cinfo->dev;
 	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
-	struct scmi_xfers_info *minfo = &info->minfo;
+	struct scmi_xfers_info *minfo = &info->tx_minfo;
 	struct scmi_shared_mem __iomem *mem = cinfo->payload;
 
 	xfer_id = MSG_XTRACT_TOKEN(ioread32(&mem->msg_header));
@@ -351,6 +351,19 @@ static void scmi_rx_callback(struct mbox_client *cl, void *m)
 	complete(&xfer->done);
 }
 
+/**
+ * scmi_xfer_put() - Release a transmit message
+ *
+ * @handle: Pointer to SCMI entity handle
+ * @xfer: message that was reserved by scmi_xfer_get
+ */
+void scmi_xfer_put(const struct scmi_handle *handle, struct scmi_xfer *xfer)
+{
+	struct scmi_info *info = handle_to_scmi_info(handle);
+
+	__scmi_xfer_put(&info->tx_minfo, xfer);
+}
+
 static bool
 scmi_xfer_poll_done(const struct scmi_chan_info *cinfo, struct scmi_xfer *xfer)
 {
@@ -440,7 +453,7 @@ int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
 }
 
 /**
- * scmi_xfer_get_init() - Allocate and initialise one message
+ * scmi_xfer_get_init() - Allocate and initialise one message for transmit
  *
  * @handle: Pointer to SCMI entity handle
  * @msg_id: Message identifier
@@ -461,6 +474,7 @@ int scmi_xfer_get_init(const struct scmi_handle *handle, u8 msg_id, u8 prot_id,
 	int ret;
 	struct scmi_xfer *xfer;
 	struct scmi_info *info = handle_to_scmi_info(handle);
+	struct scmi_xfers_info *minfo = &info->tx_minfo;
 	struct device *dev = info->dev;
 
 	/* Ensure we have sane transfer sizes */
@@ -468,7 +482,7 @@ int scmi_xfer_get_init(const struct scmi_handle *handle, u8 msg_id, u8 prot_id,
 	    tx_size > info->desc->max_msg_size)
 		return -ERANGE;
 
-	xfer = scmi_xfer_get(handle);
+	xfer = scmi_xfer_get(handle, minfo);
 	if (IS_ERR(xfer)) {
 		ret = PTR_ERR(xfer);
 		dev_err(dev, "failed to get free message slot(%d)\n", ret);
@@ -607,7 +621,7 @@ static int scmi_xfer_info_init(struct scmi_info *sinfo)
 	struct scmi_xfer *xfer;
 	struct device *dev = sinfo->dev;
 	const struct scmi_desc *desc = sinfo->desc;
-	struct scmi_xfers_info *info = &sinfo->minfo;
+	struct scmi_xfers_info *info = &sinfo->tx_minfo;
 
 	/* Pre-allocated messages, no more than what hdr.seq can support */
 	if (WARN_ON(desc->max_msg >= MSG_TOKEN_MAX)) {
-- 
2.17.1

