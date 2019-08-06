Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 889A38378B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 19:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387962AbfHFRCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 13:02:23 -0400
Received: from foss.arm.com ([217.140.110.172]:37026 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387916AbfHFRCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 13:02:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 252A0344;
        Tue,  6 Aug 2019 10:02:21 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E265F3F575;
        Tue,  6 Aug 2019 10:02:18 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, Peng Fan <peng.fan@nxp.com>,
        linux-kernel@vger.kernel.org,
        Bo Zhang <bozhang.zhang@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
        Gaku Inami <gaku.inami.xh@renesas.com>,
        aidapala@qti.qualcomm.com, pajay@qti.qualcomm.com,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        wesleys@xilinx.com, Felix Burton <fburton@xilinx.com>,
        Saeed Nowshadi <saeed.nowshadi@xilinx.com>,
        Ionela Voinescu <Ionela.Voinescu@arm.com>,
        Chris Redpath <Chris.Redpath@arm.com>,
        Quentin Perret <Quentin.Perret@arm.com>
Subject: [PATCH v2 2/5] firmware: arm_scmi: Make use SCMI v2.0 fastchannel for performance protocol
Date:   Tue,  6 Aug 2019 18:02:05 +0100
Message-Id: <20190806170208.6787-3-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190806170208.6787-1-sudeep.holla@arm.com>
References: <20190806170208.6787-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SCMI v2.0 adds support for "FastChannel" which do not use a message
header as they are specialized for a single message.

Only PERFORMANCE_LIMITS_{SET,GET} and PERFORMANCE_LEVEL_{SET,GET}
commands are supported over fastchannels. As they are optional, they
need to be discovered by PERFORMANCE_DESCRIBE_FASTCHANNEL command.
Further {LIMIT,LEVEL}_SET commands can have optional doorbell support.

Add support for making use of these fastchannels.

Cc: Ionela Voinescu <Ionela.Voinescu@arm.com>
Cc: Chris Redpath <Chris.Redpath@arm.com>
Cc: Quentin Perret <Quentin.Perret@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/perf.c | 104 +++++++++++++++++++++++++++++--
 1 file changed, 100 insertions(+), 4 deletions(-)

v1->v2:
	- Changed the macro SCMI_PERF_FC_RING_DB to use do {} while(0)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 6cce3e82e81e..fb7f6cab2c11 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -8,6 +8,7 @@
 #include <linux/bits.h>
 #include <linux/of.h>
 #include <linux/io.h>
+#include <linux/io-64-nonatomic-hi-lo.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/sort.h>
@@ -293,7 +294,42 @@ scmi_perf_describe_levels_get(const struct scmi_handle *handle, u32 domain,
 	return ret;
 }
 
-static int scmi_perf_limits_set(const struct scmi_handle *handle, u32 domain,
+#define SCMI_PERF_FC_RING_DB(doorbell, w)		\
+do {							\
+	u##w val = 0;					\
+	struct scmi_fc_db_info *db = doorbell;		\
+							\
+	if (db->mask)					\
+		val = ioread##w(db->addr) & db->mask;	\
+	iowrite##w((u##w)db->set | val, db->addr);	\
+} while(0)
+
+static void scmi_perf_fc_ring_db(struct scmi_fc_db_info *db)
+{
+	if (!db || !db->addr)
+		return;
+
+	if (db->width == 1)
+		SCMI_PERF_FC_RING_DB(db, 8);
+	else if (db->width == 2)
+		SCMI_PERF_FC_RING_DB(db, 16);
+	else if (db->width == 4)
+		SCMI_PERF_FC_RING_DB(db, 32);
+	else /* db->width == 8 */
+#ifdef CONFIG_64BIT
+		SCMI_PERF_FC_RING_DB(db, 64);
+#else
+	{
+		u64 val = 0;
+
+		if (db->mask)
+			val = ioread64_hi_lo(db->addr) & db->mask;
+		iowrite64_hi_lo(db->set, db->addr);
+	}
+#endif
+}
+
+static int scmi_perf_mb_limits_set(const struct scmi_handle *handle, u32 domain,
 				   u32 max_perf, u32 min_perf)
 {
 	int ret;
@@ -316,7 +352,23 @@ static int scmi_perf_limits_set(const struct scmi_handle *handle, u32 domain,
 	return ret;
 }
 
-static int scmi_perf_limits_get(const struct scmi_handle *handle, u32 domain,
+static int scmi_perf_limits_set(const struct scmi_handle *handle, u32 domain,
+				u32 max_perf, u32 min_perf)
+{
+	struct scmi_perf_info *pi = handle->perf_priv;
+	struct perf_dom_info *dom = pi->dom_info + domain;
+
+	if (dom->fc_info && dom->fc_info->limit_set_addr) {
+		iowrite32(max_perf, dom->fc_info->limit_set_addr);
+		iowrite32(min_perf, dom->fc_info->limit_set_addr + 4);
+		scmi_perf_fc_ring_db(dom->fc_info->limit_set_db);
+		return 0;
+	}
+
+	return scmi_perf_mb_limits_set(handle, domain, max_perf, min_perf);
+}
+
+static int scmi_perf_mb_limits_get(const struct scmi_handle *handle, u32 domain,
 				   u32 *max_perf, u32 *min_perf)
 {
 	int ret;
@@ -342,7 +394,22 @@ static int scmi_perf_limits_get(const struct scmi_handle *handle, u32 domain,
 	return ret;
 }
 
-static int scmi_perf_level_set(const struct scmi_handle *handle, u32 domain,
+static int scmi_perf_limits_get(const struct scmi_handle *handle, u32 domain,
+				u32 *max_perf, u32 *min_perf)
+{
+	struct scmi_perf_info *pi = handle->perf_priv;
+	struct perf_dom_info *dom = pi->dom_info + domain;
+
+	if (dom->fc_info && dom->fc_info->limit_get_addr) {
+		*max_perf = ioread32(dom->fc_info->limit_get_addr);
+		*min_perf = ioread32(dom->fc_info->limit_get_addr + 4);
+		return 0;
+	}
+
+	return scmi_perf_mb_limits_get(handle, domain, max_perf, min_perf);
+}
+
+static int scmi_perf_mb_level_set(const struct scmi_handle *handle, u32 domain,
 				  u32 level, bool poll)
 {
 	int ret;
@@ -365,7 +432,22 @@ static int scmi_perf_level_set(const struct scmi_handle *handle, u32 domain,
 	return ret;
 }
 
-static int scmi_perf_level_get(const struct scmi_handle *handle, u32 domain,
+static int scmi_perf_level_set(const struct scmi_handle *handle, u32 domain,
+			       u32 level, bool poll)
+{
+	struct scmi_perf_info *pi = handle->perf_priv;
+	struct perf_dom_info *dom = pi->dom_info + domain;
+
+	if (dom->fc_info && dom->fc_info->level_set_addr) {
+		iowrite32(level, dom->fc_info->level_set_addr);
+		scmi_perf_fc_ring_db(dom->fc_info->level_set_db);
+		return 0;
+	}
+
+	return scmi_perf_mb_level_set(handle, domain, level, poll);
+}
+
+static int scmi_perf_mb_level_get(const struct scmi_handle *handle, u32 domain,
 				  u32 *level, bool poll)
 {
 	int ret;
@@ -387,6 +469,20 @@ static int scmi_perf_level_get(const struct scmi_handle *handle, u32 domain,
 	return ret;
 }
 
+static int scmi_perf_level_get(const struct scmi_handle *handle, u32 domain,
+			       u32 *level, bool poll)
+{
+	struct scmi_perf_info *pi = handle->perf_priv;
+	struct perf_dom_info *dom = pi->dom_info + domain;
+
+	if (dom->fc_info && dom->fc_info->level_get_addr) {
+		*level = ioread32(dom->fc_info->level_get_addr);
+		return 0;
+	}
+
+	return scmi_perf_mb_level_get(handle, domain, level, poll);
+}
+
 static bool scmi_perf_fc_size_is_valid(u32 msg, u32 size)
 {
 	if ((msg == PERF_LEVEL_GET || msg == PERF_LEVEL_SET) && size == 4)
-- 
2.17.1

