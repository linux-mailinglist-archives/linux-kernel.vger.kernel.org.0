Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D698142A9D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 13:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgATMY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 07:24:57 -0500
Received: from foss.arm.com ([217.140.110.172]:59526 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728894AbgATMYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 07:24:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A4E613A1;
        Mon, 20 Jan 2020 04:24:31 -0800 (PST)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 648423F68E;
        Mon, 20 Jan 2020 04:24:30 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, cristian.marussi@arm.com
Subject: [RFC PATCH 06/11] firmware: arm_scmi: Enable core notifications
Date:   Mon, 20 Jan 2020 12:23:28 +0000
Message-Id: <20200120122333.46217-7-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200120122333.46217-1-cristian.marussi@arm.com>
References: <20200120122333.46217-1-cristian.marussi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize and enable SCMI Notification core support during bus/driver
init and probe phases: protocol can register their supported events
and users can register their callbacks for interested events.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/bus.c    | 3 +++
 drivers/firmware/arm_scmi/driver.c | 7 +++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index db55c43a2cbd..80d5ad29d205 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -14,6 +14,7 @@
 #include <linux/device.h>
 
 #include "common.h"
+#include "notify.h"
 
 static DEFINE_IDA(scmi_bus_id);
 static DEFINE_IDR(scmi_protocols);
@@ -234,6 +235,7 @@ static int __init scmi_bus_init(void)
 {
 	int retval;
 
+	scmi_notification_init();
 	retval = bus_register(&scmi_bus_type);
 	if (retval)
 		pr_err("scmi protocol bus register failed (%d)\n", retval);
@@ -245,6 +247,7 @@ subsys_initcall(scmi_bus_init);
 static void __exit scmi_bus_exit(void)
 {
 	scmi_devices_unregister();
+	scmi_notification_exit();
 	bus_unregister(&scmi_bus_type);
 	ida_destroy(&scmi_bus_id);
 }
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index a43fad29de11..a60559201f2d 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -28,6 +28,7 @@
 #include <linux/slab.h>
 
 #include "common.h"
+#include "notify.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/scmi.h>
@@ -350,14 +351,14 @@ __scmi_xfer_put(struct scmi_xfers_info *minfo, struct scmi_xfer *xfer)
 
 static void scmi_handle_notification(struct scmi_chan_info *cinfo, u32 msg_hdr)
 {
-	ktime_t ts;
+	u64 ts;
 	struct scmi_xfer *xfer;
 	struct device *dev = cinfo->dev;
 	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
 	struct scmi_xfers_info *minfo = &info->rx_minfo;
 	struct scmi_shared_mem __iomem *mem = cinfo->payload;
 
-	ts = ktime_get_boottime();
+	ts = ktime_get_boottime_ns();
 	xfer = scmi_xfer_get(cinfo->handle, minfo);
 	if (IS_ERR(xfer)) {
 		dev_err(dev, "failed to get free message slot (%ld)\n",
@@ -370,6 +371,8 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo, u32 msg_hdr)
 	unpack_scmi_header(msg_hdr, &xfer->hdr);
 	scmi_dump_header_dbg(dev, &xfer->hdr);
 	scmi_fetch_notification(xfer, info->desc->max_msg_size, mem);
+	scmi_notify(xfer->hdr.protocol_id, xfer->hdr.id, xfer->rx.buf,
+		    xfer->rx.len, ts);
 	__scmi_xfer_put(minfo, xfer);
 
 	iowrite32(SCMI_SHMEM_CHAN_STAT_CHANNEL_FREE, &mem->channel_status);
-- 
2.17.1

