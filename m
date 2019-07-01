Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3570F3E3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 12:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfD3KNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 06:13:40 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33084 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfD3KNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 06:13:38 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3UADETW038022;
        Tue, 30 Apr 2019 05:13:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556619194;
        bh=MWtrPahtIOeKiBLanA0wAIrcq9Wj+FL+6gin61n3LTc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=bn3vZjnDNtPPlpsZdg24JAGU1iqIcTrfpACppktTNgY38fhFXRsbKY4JwCcm9Vjug
         pxSnoKz+5Q5GvCy2F4Zc7CVzzbCDN6OztWPxL/tZ0XpRTpUwnttag0l7BtcyDF9HSp
         KbB5BsU0cPBwPcrK0nqG6I5A94W3Nq/c2kXwJ4eM=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3UADECQ106741
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Apr 2019 05:13:14 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 30
 Apr 2019 05:13:14 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 30 Apr 2019 05:13:14 -0500
Received: from uda0131933.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3UAD0Y4085082;
        Tue, 30 Apr 2019 05:13:10 -0500
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>
CC:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, Tony Lindgren <tony@atomide.com>,
        <linus.walleij@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>
Subject: [PATCH v8 02/14] firmware: ti_sci: Add support for RM core ops
Date:   Tue, 30 Apr 2019 15:42:18 +0530
Message-ID: <20190430101230.21794-3-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430101230.21794-1-lokeshvutla@ti.com>
References: <20190430101230.21794-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TISCI provides support for getting the resources(IRQ, RING etc..)
assigned to a specific device. These resources can be handled by
the client and in turn sends TISCI cmd to configure the resources.

It is very important that client should keep track on usage of these
resources.

Add support for TISCI commands to get resource ranges.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Changes since v7:
- None

 drivers/firmware/ti_sci.c              | 170 +++++++++++++++++++++++++
 drivers/firmware/ti_sci.h              |  42 ++++++
 include/linux/soc/ti/ti_sci_protocol.h |  27 ++++
 3 files changed, 239 insertions(+)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 852043531233..503195223c09 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -64,6 +64,22 @@ struct ti_sci_xfers_info {
 	spinlock_t xfer_lock;
 };
 
+/**
+ * struct ti_sci_rm_type_map - Structure representing TISCI Resource
+ *				management representation of dev_ids.
+ * @dev_id:	TISCI device ID
+ * @type:	Corresponding id as identified by TISCI RM.
+ *
+ * Note: This is used only as a work around for using RM range apis
+ *	for AM654 SoC. For future SoCs dev_id will be used as type
+ *	for RM range APIs. In order to maintain ABI backward compatibility
+ *	type is not being changed for AM654 SoC.
+ */
+struct ti_sci_rm_type_map {
+	u32 dev_id;
+	u16 type;
+};
+
 /**
  * struct ti_sci_desc - Description of SoC integration
  * @default_host_id:	Host identifier representing the compute entity
@@ -71,12 +87,14 @@ struct ti_sci_xfers_info {
  * @max_msgs: Maximum number of messages that can be pending
  *		  simultaneously in the system
  * @max_msg_size: Maximum size of data per message that can be handled.
+ * @rm_type_map: RM resource type mapping structure.
  */
 struct ti_sci_desc {
 	u8 default_host_id;
 	int max_rx_timeout_ms;
 	int max_msgs;
 	int max_msg_size;
+	struct ti_sci_rm_type_map *rm_type_map;
 };
 
 /**
@@ -1600,6 +1618,153 @@ static int ti_sci_cmd_core_reboot(const struct ti_sci_handle *handle)
 	return ret;
 }
 
+static int ti_sci_get_resource_type(struct ti_sci_info *info, u16 dev_id,
+				    u16 *type)
+{
+	struct ti_sci_rm_type_map *rm_type_map = info->desc->rm_type_map;
+	bool found = false;
+	int i;
+
+	/* If map is not provided then assume dev_id is used as type */
+	if (!rm_type_map) {
+		*type = dev_id;
+		return 0;
+	}
+
+	for (i = 0; rm_type_map[i].dev_id; i++) {
+		if (rm_type_map[i].dev_id == dev_id) {
+			*type = rm_type_map[i].type;
+			found = true;
+			break;
+		}
+	}
+
+	if (!found)
+		return -EINVAL;
+
+	return 0;
+}
+
+/**
+ * ti_sci_get_resource_range - Helper to get a range of resources assigned
+ *			       to a host. Resource is uniquely identified by
+ *			       type and subtype.
+ * @handle:		Pointer to TISCI handle.
+ * @dev_id:		TISCI device ID.
+ * @subtype:		Resource assignment subtype that is being requested
+ *			from the given device.
+ * @s_host:		Host processor ID to which the resources are allocated
+ * @range_start:	Start index of the resource range
+ * @range_num:		Number of resources in the range
+ *
+ * Return: 0 if all went fine, else return appropriate error.
+ */
+static int ti_sci_get_resource_range(const struct ti_sci_handle *handle,
+				     u32 dev_id, u8 subtype, u8 s_host,
+				     u16 *range_start, u16 *range_num)
+{
+	struct ti_sci_msg_resp_get_resource_range *resp;
+	struct ti_sci_msg_req_get_resource_range *req;
+	struct ti_sci_xfer *xfer;
+	struct ti_sci_info *info;
+	struct device *dev;
+	u16 type;
+	int ret = 0;
+
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+	if (!handle)
+		return -EINVAL;
+
+	info = handle_to_ti_sci_info(handle);
+	dev = info->dev;
+
+	xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_GET_RESOURCE_RANGE,
+				   TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
+				   sizeof(*req), sizeof(*resp));
+	if (IS_ERR(xfer)) {
+		ret = PTR_ERR(xfer);
+		dev_err(dev, "Message alloc failed(%d)\n", ret);
+		return ret;
+	}
+
+	ret = ti_sci_get_resource_type(info, dev_id, &type);
+	if (ret) {
+		dev_err(dev, "rm type lookup failed for %u\n", dev_id);
+		goto fail;
+	}
+
+	req = (struct ti_sci_msg_req_get_resource_range *)xfer->xfer_buf;
+	req->secondary_host = s_host;
+	req->type = type & MSG_RM_RESOURCE_TYPE_MASK;
+	req->subtype = subtype & MSG_RM_RESOURCE_SUBTYPE_MASK;
+
+	ret = ti_sci_do_xfer(info, xfer);
+	if (ret) {
+		dev_err(dev, "Mbox send fail %d\n", ret);
+		goto fail;
+	}
+
+	resp = (struct ti_sci_msg_resp_get_resource_range *)xfer->xfer_buf;
+
+	if (!ti_sci_is_response_ack(resp)) {
+		ret = -ENODEV;
+	} else if (!resp->range_start && !resp->range_num) {
+		ret = -ENODEV;
+	} else {
+		*range_start = resp->range_start;
+		*range_num = resp->range_num;
+	};
+
+fail:
+	ti_sci_put_one_xfer(&info->minfo, xfer);
+
+	return ret;
+}
+
+/**
+ * ti_sci_cmd_get_resource_range - Get a range of resources assigned to host
+ *				   that is same as ti sci interface host.
+ * @handle:		Pointer to TISCI handle.
+ * @dev_id:		TISCI device ID.
+ * @subtype:		Resource assignment subtype that is being requested
+ *			from the given device.
+ * @range_start:	Start index of the resource range
+ * @range_num:		Number of resources in the range
+ *
+ * Return: 0 if all went fine, else return appropriate error.
+ */
+static int ti_sci_cmd_get_resource_range(const struct ti_sci_handle *handle,
+					 u32 dev_id, u8 subtype,
+					 u16 *range_start, u16 *range_num)
+{
+	return ti_sci_get_resource_range(handle, dev_id, subtype,
+					 TI_SCI_IRQ_SECONDARY_HOST_INVALID,
+					 range_start, range_num);
+}
+
+/**
+ * ti_sci_cmd_get_resource_range_from_shost - Get a range of resources
+ *					      assigned to a specified host.
+ * @handle:		Pointer to TISCI handle.
+ * @dev_id:		TISCI device ID.
+ * @subtype:		Resource assignment subtype that is being requested
+ *			from the given device.
+ * @s_host:		Host processor ID to which the resources are allocated
+ * @range_start:	Start index of the resource range
+ * @range_num:		Number of resources in the range
+ *
+ * Return: 0 if all went fine, else return appropriate error.
+ */
+static
+int ti_sci_cmd_get_resource_range_from_shost(const struct ti_sci_handle *handle,
+					     u32 dev_id, u8 subtype, u8 s_host,
+					     u16 *range_start, u16 *range_num)
+{
+	return ti_sci_get_resource_range(handle, dev_id, subtype, s_host,
+					 range_start, range_num);
+}
+
 /*
  * ti_sci_setup_ops() - Setup the operations structures
  * @info:	pointer to TISCI pointer
@@ -1610,6 +1775,7 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
 	struct ti_sci_core_ops *core_ops = &ops->core_ops;
 	struct ti_sci_dev_ops *dops = &ops->dev_ops;
 	struct ti_sci_clk_ops *cops = &ops->clk_ops;
+	struct ti_sci_rm_core_ops *rm_core_ops = &ops->rm_core_ops;
 
 	core_ops->reboot_device = ti_sci_cmd_core_reboot;
 
@@ -1640,6 +1806,10 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
 	cops->get_best_match_freq = ti_sci_cmd_clk_get_match_freq;
 	cops->set_freq = ti_sci_cmd_clk_set_freq;
 	cops->get_freq = ti_sci_cmd_clk_get_freq;
+
+	rm_core_ops->get_range = ti_sci_cmd_get_resource_range;
+	rm_core_ops->get_range_from_shost =
+				ti_sci_cmd_get_resource_range_from_shost;
 }
 
 /**
diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
index 12bf316b68df..a043c4762791 100644
--- a/drivers/firmware/ti_sci.h
+++ b/drivers/firmware/ti_sci.h
@@ -35,6 +35,9 @@
 #define TI_SCI_MSG_QUERY_CLOCK_FREQ	0x010d
 #define TI_SCI_MSG_GET_CLOCK_FREQ	0x010e
 
+/* Resource Management Requests */
+#define TI_SCI_MSG_GET_RESOURCE_RANGE	0x1500
+
 /**
  * struct ti_sci_msg_hdr - Generic Message Header for All messages and responses
  * @type:	Type of messages: One of TI_SCI_MSG* values
@@ -461,4 +464,43 @@ struct ti_sci_msg_resp_get_clock_freq {
 	u64 freq_hz;
 } __packed;
 
+#define TI_SCI_IRQ_SECONDARY_HOST_INVALID	0xff
+
+/**
+ * struct ti_sci_msg_req_get_resource_range - Request to get a host's assigned
+ *					      range of resources.
+ * @hdr:		Generic Header
+ * @type:		Unique resource assignment type
+ * @subtype:		Resource assignment subtype within the resource type.
+ * @secondary_host:	Host processing entity to which the resources are
+ *			allocated. This is required only when the destination
+ *			host id id different from ti sci interface host id,
+ *			else TI_SCI_IRQ_SECONDARY_HOST_INVALID can be passed.
+ *
+ * Request type is TI_SCI_MSG_GET_RESOURCE_RANGE. Responded with requested
+ * resource range which is of type TI_SCI_MSG_GET_RESOURCE_RANGE.
+ */
+struct ti_sci_msg_req_get_resource_range {
+	struct ti_sci_msg_hdr hdr;
+#define MSG_RM_RESOURCE_TYPE_MASK	GENMASK(9, 0)
+#define MSG_RM_RESOURCE_SUBTYPE_MASK	GENMASK(5, 0)
+	u16 type;
+	u8 subtype;
+	u8 secondary_host;
+} __packed;
+
+/**
+ * struct ti_sci_msg_resp_get_resource_range - Response to resource get range.
+ * @hdr:		Generic Header
+ * @range_start:	Start index of the resource range.
+ * @range_num:		Number of resources in the range.
+ *
+ * Response to request TI_SCI_MSG_GET_RESOURCE_RANGE.
+ */
+struct ti_sci_msg_resp_get_resource_range {
+	struct ti_sci_msg_hdr hdr;
+	u16 range_start;
+	u16 range_num;
+} __packed;
+
 #endif /* __TI_SCI_H */
diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
index 515587e9d373..0c92a922db6a 100644
--- a/include/linux/soc/ti/ti_sci_protocol.h
+++ b/include/linux/soc/ti/ti_sci_protocol.h
@@ -192,15 +192,42 @@ struct ti_sci_clk_ops {
 			u64 *current_freq);
 };
 
+/**
+ * struct ti_sci_rm_core_ops - Resource management core operations
+ * @get_range:		Get a range of resources belonging to ti sci host.
+ * @get_rage_from_shost:	Get a range of resources belonging to
+ *				specified host id.
+ *			- s_host: Host processing entity to which the
+ *				  resources are allocated
+ *
+ * NOTE: for these functions, all the parameters are consolidated and defined
+ * as below:
+ * - handle:	Pointer to TISCI handle as retrieved by *ti_sci_get_handle
+ * - dev_id:	TISCI device ID.
+ * - subtype:	Resource assignment subtype that is being requested
+ *		from the given device.
+ * - range_start:	Start index of the resource range
+ * - range_end:		Number of resources in the range
+ */
+struct ti_sci_rm_core_ops {
+	int (*get_range)(const struct ti_sci_handle *handle, u32 dev_id,
+			 u8 subtype, u16 *range_start, u16 *range_num);
+	int (*get_range_from_shost)(const struct ti_sci_handle *handle,
+				    u32 dev_id, u8 subtype, u8 s_host,
+				    u16 *range_start, u16 *range_num);
+};
+
 /**
  * struct ti_sci_ops - Function support for TI SCI
  * @dev_ops:	Device specific operations
  * @clk_ops:	Clock specific operations
+ * @rm_core_ops:	Resource management core operations.
  */
 struct ti_sci_ops {
 	struct ti_sci_core_ops core_ops;
 	struct ti_sci_dev_ops dev_ops;
 	struct ti_sci_clk_ops clk_ops;
+	struct ti_sci_rm_core_ops rm_core_ops;
 };
 
 /**
-- 
2.21.0

