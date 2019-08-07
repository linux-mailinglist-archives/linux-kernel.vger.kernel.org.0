Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57D688522E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2019 19:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389179AbfHGRhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Aug 2019 13:37:48 -0400
Received: from foss.arm.com ([217.140.110.172]:52442 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388640AbfHGRhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 13:37:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9F4328;
        Wed,  7 Aug 2019 10:37:46 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 23A043F575;
        Wed,  7 Aug 2019 10:37:46 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v2] firmware: arm_scmi: Use {get,put}_unaligned_le{32,64} accessors
Date:   Wed,  7 Aug 2019 18:37:39 +0100
Message-Id: <20190807173739.5939-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190807130038.26878-1-sudeep.holla@arm.com>
References: <20190807130038.26878-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of type-casting the {tx,rx}.buf all over the place while
accessing them to read/write __le{32,64} from/to the firmware, let's
use the existing {get,put}_unaligned_le{32,64} accessors to hide all
the type cast ugliness.

Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/base.c    |  2 +-
 drivers/firmware/arm_scmi/clock.c   | 12 ++++--------
 drivers/firmware/arm_scmi/common.h  |  2 ++
 drivers/firmware/arm_scmi/perf.c    |  8 ++++----
 drivers/firmware/arm_scmi/power.c   |  6 +++---
 drivers/firmware/arm_scmi/reset.c   |  2 +-
 drivers/firmware/arm_scmi/sensors.c | 17 ++++++-----------
 7 files changed, 21 insertions(+), 28 deletions(-)

v1->v2:
	- Dropped incorrect void ptr arithmetic and used unaligned_le64
	  accessors instead

diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
index 204390297f4b..f804e8af6521 100644
--- a/drivers/firmware/arm_scmi/base.c
+++ b/drivers/firmware/arm_scmi/base.c
@@ -204,7 +204,7 @@ static int scmi_base_discover_agent_get(const struct scmi_handle *handle,
 	if (ret)
 		return ret;

-	*(__le32 *)t->tx.buf = cpu_to_le32(id);
+	put_unaligned_le32(id, t->tx.buf);

 	ret = scmi_do_xfer(handle, t);
 	if (!ret)
diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index 4a32ae1822a3..32526a793f3a 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -107,7 +107,7 @@ static int scmi_clock_attributes_get(const struct scmi_handle *handle,
 	if (ret)
 		return ret;

-	*(__le32 *)t->tx.buf = cpu_to_le32(clk_id);
+	put_unaligned_le32(clk_id, t->tx.buf);
 	attr = t->rx.buf;

 	ret = scmi_do_xfer(handle, t);
@@ -204,15 +204,11 @@ scmi_clock_rate_get(const struct scmi_handle *handle, u32 clk_id, u64 *value)
 	if (ret)
 		return ret;

-	*(__le32 *)t->tx.buf = cpu_to_le32(clk_id);
+	put_unaligned_le32(clk_id, t->tx.buf);

 	ret = scmi_do_xfer(handle, t);
-	if (!ret) {
-		__le32 *pval = t->rx.buf;
-
-		*value = le32_to_cpu(*pval);
-		*value |= (u64)le32_to_cpu(*(pval + 1)) << 32;
-	}
+	if (!ret)
+		*value = get_unaligned_le64(t->rx.buf);

 	scmi_xfer_put(handle, t);
 	return ret;
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 43884e4ceac5..5237c2ff79fe 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -15,6 +15,8 @@
 #include <linux/scmi_protocol.h>
 #include <linux/types.h>

+#include <asm/unaligned.h>
+
 #define PROTOCOL_REV_MINOR_MASK	GENMASK(15, 0)
 #define PROTOCOL_REV_MAJOR_MASK	GENMASK(31, 16)
 #define PROTOCOL_REV_MAJOR(x)	(u16)(FIELD_GET(PROTOCOL_REV_MAJOR_MASK, (x)))
diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index fb7f6cab2c11..9b338e66a24e 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -195,7 +195,7 @@ scmi_perf_domain_attributes_get(const struct scmi_handle *handle, u32 domain,
 	if (ret)
 		return ret;

-	*(__le32 *)t->tx.buf = cpu_to_le32(domain);
+	put_unaligned_le32(domain, t->tx.buf);
 	attr = t->rx.buf;

 	ret = scmi_do_xfer(handle, t);
@@ -380,7 +380,7 @@ static int scmi_perf_mb_limits_get(const struct scmi_handle *handle, u32 domain,
 	if (ret)
 		return ret;

-	*(__le32 *)t->tx.buf = cpu_to_le32(domain);
+	put_unaligned_le32(domain, t->tx.buf);

 	ret = scmi_do_xfer(handle, t);
 	if (!ret) {
@@ -459,11 +459,11 @@ static int scmi_perf_mb_level_get(const struct scmi_handle *handle, u32 domain,
 		return ret;

 	t->hdr.poll_completion = poll;
-	*(__le32 *)t->tx.buf = cpu_to_le32(domain);
+	put_unaligned_le32(domain, t->tx.buf);

 	ret = scmi_do_xfer(handle, t);
 	if (!ret)
-		*level = le32_to_cpu(*(__le32 *)t->rx.buf);
+		*level = get_unaligned_le32(t->rx.buf);

 	scmi_xfer_put(handle, t);
 	return ret;
diff --git a/drivers/firmware/arm_scmi/power.c b/drivers/firmware/arm_scmi/power.c
index 62f3401a1f01..5abef7079c0a 100644
--- a/drivers/firmware/arm_scmi/power.c
+++ b/drivers/firmware/arm_scmi/power.c
@@ -96,7 +96,7 @@ scmi_power_domain_attributes_get(const struct scmi_handle *handle, u32 domain,
 	if (ret)
 		return ret;

-	*(__le32 *)t->tx.buf = cpu_to_le32(domain);
+	put_unaligned_le32(domain, t->tx.buf);
 	attr = t->rx.buf;

 	ret = scmi_do_xfer(handle, t);
@@ -147,11 +147,11 @@ scmi_power_state_get(const struct scmi_handle *handle, u32 domain, u32 *state)
 	if (ret)
 		return ret;

-	*(__le32 *)t->tx.buf = cpu_to_le32(domain);
+	put_unaligned_le32(domain, t->tx.buf);

 	ret = scmi_do_xfer(handle, t);
 	if (!ret)
-		*state = le32_to_cpu(*(__le32 *)t->rx.buf);
+		*state = get_unaligned_le32(t->rx.buf);

 	scmi_xfer_put(handle, t);
 	return ret;
diff --git a/drivers/firmware/arm_scmi/reset.c b/drivers/firmware/arm_scmi/reset.c
index 11cb8b5ccf34..c1d67a2af12f 100644
--- a/drivers/firmware/arm_scmi/reset.c
+++ b/drivers/firmware/arm_scmi/reset.c
@@ -88,7 +88,7 @@ scmi_reset_domain_attributes_get(const struct scmi_handle *handle, u32 domain,
 	if (ret)
 		return ret;

-	*(__le32 *)t->tx.buf = cpu_to_le32(domain);
+	put_unaligned_le32(domain, t->tx.buf);
 	attr = t->rx.buf;

 	ret = scmi_do_xfer(handle, t);
diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index 7570308a16a0..a400ea805fc2 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -120,7 +120,7 @@ static int scmi_sensor_description_get(const struct scmi_handle *handle,

 	do {
 		/* Set the number of sensors to be skipped/already read */
-		*(__le32 *)t->tx.buf = cpu_to_le32(desc_index);
+		put_unaligned_le32(desc_index, t->tx.buf);

 		ret = scmi_do_xfer(handle, t);
 		if (ret)
@@ -217,7 +217,6 @@ static int scmi_sensor_reading_get(const struct scmi_handle *handle,
 				   u32 sensor_id, u64 *value)
 {
 	int ret;
-	__le32 *pval;
 	struct scmi_xfer *t;
 	struct scmi_msg_sensor_reading_get *sensor;
 	struct sensors_info *si = handle->sensor_priv;
@@ -229,24 +228,20 @@ static int scmi_sensor_reading_get(const struct scmi_handle *handle,
 	if (ret)
 		return ret;

-	pval = t->rx.buf;
 	sensor = t->tx.buf;
 	sensor->id = cpu_to_le32(sensor_id);

 	if (s->async) {
 		sensor->flags = cpu_to_le32(SENSOR_READ_ASYNC);
 		ret = scmi_do_xfer_with_response(handle, t);
-		if (!ret) {
-			*value = le32_to_cpu(*(pval + 1));
-			*value |= (u64)le32_to_cpu(*(pval + 2)) << 32;
-		}
+		if (!ret)
+			*value = get_unaligned_le64((void *)
+						    ((__le32 *)t->rx.buf + 1));
 	} else {
 		sensor->flags = cpu_to_le32(0);
 		ret = scmi_do_xfer(handle, t);
-		if (!ret) {
-			*value = le32_to_cpu(*pval);
-			*value |= (u64)le32_to_cpu(*(pval + 1)) << 32;
-		}
+		if (!ret)
+			*value = get_unaligned_le64(t->rx.buf);
 	}

 	scmi_xfer_put(handle, t);
--
2.17.1

