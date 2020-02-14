Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 043DD15DB19
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 16:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387671AbgBNPgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 10:36:53 -0500
Received: from foss.arm.com ([217.140.110.172]:34802 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387524AbgBNPgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:36:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A271C113E;
        Fri, 14 Feb 2020 07:36:36 -0800 (PST)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A29B03F68E;
        Fri, 14 Feb 2020 07:36:35 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        cristian.marussi@arm.com
Subject: [RFC PATCH v2 09/13] firmware: arm_scmi: Add Power notifications support
Date:   Fri, 14 Feb 2020 15:35:31 +0000
Message-Id: <20200214153535.32046-10-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200214153535.32046-1-cristian.marussi@arm.com>
References: <20200214153535.32046-1-cristian.marussi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make SCMI Power protocol register with the notification core.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
V1 --> V2
- simplified .set_notify_enabled() implementation moving the ALL_SRCIDs
  logic out of protocol. ALL_SRCIDs logic is now in charge of the
  notification core, together with proper reference counting of enables
- switched to devres protocol-registration
---
 drivers/firmware/arm_scmi/power.c | 127 +++++++++++++++++++++++++++++-
 include/linux/scmi_protocol.h     |  15 ++++
 2 files changed, 141 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/power.c b/drivers/firmware/arm_scmi/power.c
index cf7f0312381b..8bd073bcdf1c 100644
--- a/drivers/firmware/arm_scmi/power.c
+++ b/drivers/firmware/arm_scmi/power.c
@@ -6,6 +6,7 @@
  */
 
 #include "common.h"
+#include "notify.h"
 
 enum scmi_power_protocol_cmd {
 	POWER_DOMAIN_ATTRIBUTES = 0x3,
@@ -48,6 +49,12 @@ struct scmi_power_state_notify {
 	__le32 notify_enable;
 };
 
+struct scmi_power_state_notify_payld {
+	__le32 agent_id;
+	__le32 domain_id;
+	__le32 power_state;
+};
+
 struct power_dom_info {
 	bool state_set_sync;
 	bool state_set_async;
@@ -61,6 +68,14 @@ struct scmi_power_info {
 	u64 stats_addr;
 	u32 stats_size;
 	struct power_dom_info *dom_info;
+	const struct scmi_handle *handle;
+};
+
+static struct scmi_power_info *pinfo;
+
+static enum scmi_power_protocol_cmd evt_2_cmd[] = {
+	POWER_STATE_NOTIFY,
+	POWER_STATE_CHANGE_REQUESTED_NOTIFY,
 };
 
 static int scmi_power_attributes_get(const struct scmi_handle *handle,
@@ -186,11 +201,114 @@ static struct scmi_power_ops power_ops = {
 	.state_get = scmi_power_state_get,
 };
 
+static int scmi_power_request_notify(const struct scmi_handle *handle,
+				     u32 domain, int message_id, bool enable)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_power_state_notify *notify;
+
+	ret = scmi_xfer_get_init(handle, message_id, SCMI_PROTOCOL_POWER,
+				 sizeof(*notify), 0, &t);
+	if (ret)
+		return ret;
+
+	notify = t->tx.buf;
+	notify->domain = cpu_to_le32(domain);
+	notify->notify_enable = enable ? cpu_to_le32(BIT(0)) : 0;
+
+	ret = scmi_do_xfer(handle, t);
+
+	scmi_xfer_put(handle, t);
+	return ret;
+}
+
+static bool scmi_power_set_notify_enabled(u8 evt_id, u32 src_id, bool enable)
+{
+	int ret, cmd_id;
+
+	cmd_id = MAP_EVT_TO_ENABLE_CMD(evt_id, evt_2_cmd);
+	if (cmd_id < 0)
+		return false;
+
+	ret = scmi_power_request_notify(pinfo->handle, src_id, cmd_id, enable);
+	if (ret)
+		pr_warn("SCMI Notifications - Proto:%X - FAIL_ENABLE - evt[%X] dom[%d] - ret:%d\n",
+				SCMI_PROTOCOL_POWER, evt_id, src_id, ret);
+
+	return !ret ? true : false;
+}
+
+static void *scmi_power_fill_custom_report(u8 evt_id, u64 timestamp,
+					   const void *payld, size_t payld_sz,
+					   void *report, u32 *src_id)
+{
+	void *rep = NULL;
+
+	switch (evt_id) {
+	case POWER_STATE_CHANGED:
+	{
+		const struct scmi_power_state_notify_payld *p = payld;
+		struct scmi_power_state_changed_report *r = report;
+
+		if (sizeof(*p) != payld_sz)
+			break;
+
+		r->timestamp = timestamp;
+		r->agent_id = le32_to_cpu(p->agent_id);
+		r->domain_id = le32_to_cpu(p->domain_id);
+		r->power_state = le32_to_cpu(p->power_state);
+		*src_id = r->domain_id;
+		rep = r;
+		break;
+	}
+	case POWER_STATE_CHANGE_REQUESTED:
+	{
+		const struct scmi_power_state_notify_payld *p = payld;
+		struct scmi_power_state_change_requested_report *r = report;
+
+		if (sizeof(*p) != payld_sz)
+			break;
+
+		r->timestamp = timestamp;
+		r->agent_id = le32_to_cpu(p->agent_id);
+		r->domain_id = le32_to_cpu(p->domain_id);
+		r->power_state = le32_to_cpu(p->power_state);
+		*src_id = r->domain_id;
+		rep = r;
+		break;
+	}
+	default:
+		break;
+	}
+
+	return rep;
+}
+
+static const struct scmi_event power_events[] = {
+	{
+		.evt_id = POWER_STATE_CHANGED,
+		.max_payld_sz = 12,
+		.max_report_sz =
+			sizeof(struct scmi_power_state_changed_report),
+	},
+	{
+		.evt_id = POWER_STATE_CHANGE_REQUESTED,
+		.max_payld_sz = 12,
+		.max_report_sz =
+			sizeof(struct scmi_power_state_change_requested_report),
+	},
+};
+
+static const struct scmi_protocol_event_ops power_event_ops = {
+	.set_notify_enabled = scmi_power_set_notify_enabled,
+	.fill_custom_report = scmi_power_fill_custom_report,
+};
+
 static int scmi_power_protocol_init(struct scmi_handle *handle)
 {
 	int domain;
 	u32 version;
-	struct scmi_power_info *pinfo;
 
 	scmi_version_get(handle, SCMI_PROTOCOL_POWER, &version);
 
@@ -214,7 +332,14 @@ static int scmi_power_protocol_init(struct scmi_handle *handle)
 		scmi_power_domain_attributes_get(handle, domain, dom);
 	}
 
+	scmi_register_protocol_events(handle->dev,
+				      SCMI_PROTOCOL_POWER, PAGE_SIZE,
+				      &power_event_ops, power_events,
+				      ARRAY_SIZE(power_events),
+				      pinfo->num_domains);
+
 	pinfo->version = version;
+	pinfo->handle = handle;
 	handle->power_ops = &power_ops;
 	handle->power_priv = pinfo;
 
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index f675f2aa7d87..3ec9f1ffa1bf 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -9,6 +9,7 @@
 #define _LINUX_SCMI_PROTOCOL_H
 
 #include <linux/device.h>
+#include <linux/ktime.h>
 #include <linux/notifier.h>
 #include <linux/types.h>
 
@@ -381,4 +382,18 @@ int scmi_register_event_notifier(u8 proto_id, u8 evt_id, u32 *src_id,
 int scmi_unregister_event_notifier(u8 proto_id, u8 evt_id, u32 *src_id,
 				   struct notifier_block *nb);
 
+struct scmi_power_state_changed_report {
+	ktime_t	timestamp;
+	u32	agent_id;
+	u32	domain_id;
+	u32	power_state;
+};
+
+struct scmi_power_state_change_requested_report {
+	ktime_t	timestamp;
+	u32	agent_id;
+	u32	domain_id;
+	u32	power_state;
+};
+
 #endif /* _LINUX_SCMI_PROTOCOL_H */
-- 
2.17.1

