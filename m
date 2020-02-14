Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62B6715DB11
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 16:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbgBNPg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 10:36:29 -0500
Received: from foss.arm.com ([217.140.110.172]:34718 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729523AbgBNPg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:36:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB126101E;
        Fri, 14 Feb 2020 07:36:26 -0800 (PST)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBFE83F68E;
        Fri, 14 Feb 2020 07:36:25 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        cristian.marussi@arm.com
Subject: [RFC PATCH v2 01/13] firmware: arm_scmi: Add receive buffer support for notifications
Date:   Fri, 14 Feb 2020 15:35:23 +0000
Message-Id: <20200214153535.32046-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200214153535.32046-1-cristian.marussi@arm.com>
References: <20200214153535.32046-1-cristian.marussi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudeep Holla <sudeep.holla@arm.com>

With all the plumbing in place, let's just add the separate dedicated
receive buffers to handle notifications that can arrive asynchronously
from the platform firmware to OS.

Also add one check to see if the platform supports any receive channels
before allocating the receive buffers: since those buffers are optionally
supported though, the whole xfer initialization is also postponed to be
able to check for their existence in advance.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
[Changed parameters in __scmi_xfer_info_init()]
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
V1 --> V2:
- reviewed commit message
- reviewed parameters of __scmi_xfer_info_init()
---
 drivers/firmware/arm_scmi/driver.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index dbec767222e9..efb660c34b57 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -76,6 +76,7 @@ struct scmi_xfers_info {
  *	implementation version and (sub-)vendor identification.
  * @handle: Instance of SCMI handle to send to clients
  * @tx_minfo: Universal Transmit Message management info
+ * @rx_minfo: Universal Receive Message management info
  * @tx_idr: IDR object to map protocol id to Tx channel info pointer
  * @rx_idr: IDR object to map protocol id to Rx channel info pointer
  * @protocols_imp: List of protocols implemented, currently maximum of
@@ -89,6 +90,7 @@ struct scmi_info {
 	struct scmi_revision_info version;
 	struct scmi_handle handle;
 	struct scmi_xfers_info tx_minfo;
+	struct scmi_xfers_info rx_minfo;
 	struct idr tx_idr;
 	struct idr rx_idr;
 	u8 *protocols_imp;
@@ -525,13 +527,13 @@ int scmi_handle_put(const struct scmi_handle *handle)
 	return 0;
 }
 
-static int scmi_xfer_info_init(struct scmi_info *sinfo)
+static int __scmi_xfer_info_init(struct scmi_info *sinfo,
+				 struct scmi_xfers_info *info)
 {
 	int i;
 	struct scmi_xfer *xfer;
 	struct device *dev = sinfo->dev;
 	const struct scmi_desc *desc = sinfo->desc;
-	struct scmi_xfers_info *info = &sinfo->tx_minfo;
 
 	/* Pre-allocated messages, no more than what hdr.seq can support */
 	if (WARN_ON(desc->max_msg >= MSG_TOKEN_MAX)) {
@@ -566,6 +568,16 @@ static int scmi_xfer_info_init(struct scmi_info *sinfo)
 	return 0;
 }
 
+static int scmi_xfer_info_init(struct scmi_info *sinfo)
+{
+	int ret = __scmi_xfer_info_init(sinfo, &sinfo->tx_minfo);
+
+	if (!ret && idr_find(&sinfo->rx_idr, SCMI_PROTOCOL_BASE))
+		ret = __scmi_xfer_info_init(sinfo, &sinfo->rx_minfo);
+
+	return ret;
+}
+
 static int scmi_chan_setup(struct scmi_info *info, struct device *dev,
 			   int prot_id, bool tx)
 {
@@ -699,10 +711,6 @@ static int scmi_probe(struct platform_device *pdev)
 	info->desc = desc;
 	INIT_LIST_HEAD(&info->node);
 
-	ret = scmi_xfer_info_init(info);
-	if (ret)
-		return ret;
-
 	platform_set_drvdata(pdev, info);
 	idr_init(&info->tx_idr);
 	idr_init(&info->rx_idr);
@@ -715,6 +723,10 @@ static int scmi_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = scmi_xfer_info_init(info);
+	if (ret)
+		return ret;
+
 	ret = scmi_base_protocol_init(handle);
 	if (ret) {
 		dev_err(dev, "unable to communicate with SCMI(%d)\n", ret);
-- 
2.17.1

