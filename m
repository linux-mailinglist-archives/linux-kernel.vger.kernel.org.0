Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3258519590E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 15:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbgC0Oew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 10:34:52 -0400
Received: from foss.arm.com ([217.140.110.172]:45570 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727620AbgC0Oet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 10:34:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA5DE101E;
        Fri, 27 Mar 2020 07:34:48 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1AE83F71F;
        Fri, 27 Mar 2020 07:34:47 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        cristian.marussi@arm.com
Subject: [PATCH v6 02/13] firmware: arm_scmi: Update protocol commands and notification list
Date:   Fri, 27 Mar 2020 14:34:27 +0000
Message-Id: <20200327143438.5382-3-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200327143438.5382-1-cristian.marussi@arm.com>
References: <20200327143438.5382-1-cristian.marussi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudeep Holla <sudeep.holla@arm.com>

Add commands' enumerations and messages definitions for all existing
notify-enable commands across all protocols.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/base.c    | 7 +++++++
 drivers/firmware/arm_scmi/perf.c    | 5 +++++
 drivers/firmware/arm_scmi/power.c   | 6 ++++++
 drivers/firmware/arm_scmi/sensors.c | 4 ++++
 4 files changed, 22 insertions(+)

diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
index f804e8af6521..ce7d9203e41b 100644
--- a/drivers/firmware/arm_scmi/base.c
+++ b/drivers/firmware/arm_scmi/base.c
@@ -14,6 +14,13 @@ enum scmi_base_protocol_cmd {
 	BASE_DISCOVER_LIST_PROTOCOLS = 0x6,
 	BASE_DISCOVER_AGENT = 0x7,
 	BASE_NOTIFY_ERRORS = 0x8,
+	BASE_SET_DEVICE_PERMISSIONS = 0x9,
+	BASE_SET_PROTOCOL_PERMISSIONS = 0xa,
+	BASE_RESET_AGENT_CONFIGURATION = 0xb,
+};
+
+enum scmi_base_protocol_notify {
+	BASE_ERROR_EVENT = 0x0,
 };
 
 struct scmi_msg_resp_base_attributes {
diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index ec81e6f7e7a4..88509ec637d0 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -27,6 +27,11 @@ enum scmi_performance_protocol_cmd {
 	PERF_DESCRIBE_FASTCHANNEL = 0xb,
 };
 
+enum scmi_performance_protocol_notify {
+	PERFORMANCE_LIMITS_CHANGED = 0x0,
+	PERFORMANCE_LEVEL_CHANGED = 0x1,
+};
+
 struct scmi_opp {
 	u32 perf;
 	u32 power;
diff --git a/drivers/firmware/arm_scmi/power.c b/drivers/firmware/arm_scmi/power.c
index 214886ce84f1..cf7f0312381b 100644
--- a/drivers/firmware/arm_scmi/power.c
+++ b/drivers/firmware/arm_scmi/power.c
@@ -12,6 +12,12 @@ enum scmi_power_protocol_cmd {
 	POWER_STATE_SET = 0x4,
 	POWER_STATE_GET = 0x5,
 	POWER_STATE_NOTIFY = 0x6,
+	POWER_STATE_CHANGE_REQUESTED_NOTIFY = 0x7,
+};
+
+enum scmi_power_protocol_notify {
+	POWER_STATE_CHANGED = 0x0,
+	POWER_STATE_CHANGE_REQUESTED = 0x1,
 };
 
 struct scmi_msg_resp_power_attributes {
diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index eba61b9c1f53..db1b1ab303da 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -14,6 +14,10 @@ enum scmi_sensor_protocol_cmd {
 	SENSOR_READING_GET = 0x6,
 };
 
+enum scmi_sensor_protocol_notify {
+	SENSOR_TRIP_POINT_EVENT = 0x0,
+};
+
 struct scmi_msg_resp_sensor_attributes {
 	__le16 num_sensors;
 	u8 max_requests;
-- 
2.17.1

