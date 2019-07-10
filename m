Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E433262509
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 17:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391360AbfGHPrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 11:47:55 -0400
Received: from foss.arm.com ([217.140.110.172]:52400 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391330AbfGHPrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:47:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BF301516;
        Mon,  8 Jul 2019 08:47:51 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 22E9F3F59C;
        Mon,  8 Jul 2019 08:47:50 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Bo Zhang <bozhang.zhang@broadcom.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH 08/11] firmware: arm_scmi: Drop async flag in sensor_ops->reading_get
Date:   Mon,  8 Jul 2019 16:47:27 +0100
Message-Id: <20190708154730.16643-9-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190708154730.16643-1-sudeep.holla@arm.com>
References: <20190708154730.16643-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SENSOR_DESCRIPTION_GET provides attributes to indicate if the sensor
supports asynchronous read. Ideally we should be able to read that flag
and use asynchronous reads for any sensors with that attribute set.

In order to add that support, let's drop the async flag passed to
sensor_ops->reading_get and dynamically switch between sync and async
flags based on the attributes as provided by the firmware.

Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/sensors.c | 4 ++--
 drivers/hwmon/scmi-hwmon.c          | 2 +-
 include/linux/scmi_protocol.h       | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index 17dbabd8a94a..1b5757c77a35 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -211,7 +211,7 @@ scmi_sensor_trip_point_config(const struct scmi_handle *handle, u32 sensor_id,
 }
 
 static int scmi_sensor_reading_get(const struct scmi_handle *handle,
-				   u32 sensor_id, bool async, u64 *value)
+				   u32 sensor_id, u64 *value)
 {
 	int ret;
 	struct scmi_xfer *t;
@@ -225,7 +225,7 @@ static int scmi_sensor_reading_get(const struct scmi_handle *handle,
 
 	sensor = t->tx.buf;
 	sensor->id = cpu_to_le32(sensor_id);
-	sensor->flags = cpu_to_le32(async ? SENSOR_READ_ASYNC : 0);
+	sensor->flags = cpu_to_le32(0);
 
 	ret = scmi_do_xfer(handle, t);
 	if (!ret) {
diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
index 0c93fc5ca762..8a7732c0bef3 100644
--- a/drivers/hwmon/scmi-hwmon.c
+++ b/drivers/hwmon/scmi-hwmon.c
@@ -72,7 +72,7 @@ static int scmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 	const struct scmi_handle *h = scmi_sensors->handle;
 
 	sensor = *(scmi_sensors->info[type] + channel);
-	ret = h->sensor_ops->reading_get(h, sensor->id, false, &value);
+	ret = h->sensor_ops->reading_get(h, sensor->id, &value);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index ea6b72018752..697e30fb9004 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -182,7 +182,7 @@ struct scmi_sensor_ops {
 	int (*trip_point_config)(const struct scmi_handle *handle,
 				 u32 sensor_id, u8 trip_id, u64 trip_value);
 	int (*reading_get)(const struct scmi_handle *handle, u32 sensor_id,
-			   bool async, u64 *value);
+			   u64 *value);
 };
 
 /**
-- 
2.17.1

