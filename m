Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3096A11D5C0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 19:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730446AbfLLShC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 13:37:02 -0500
Received: from a27-21.smtp-out.us-west-2.amazonses.com ([54.240.27.21]:32878
        "EHLO a27-21.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730211AbfLLShA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 13:37:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1576175819;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=3O+wXC7g249LCZBdLWpVNcA7JpQ8PQ2bILr41dWjDV4=;
        b=PCIDH7w2gODDQ4imVpoQ1Nz1+skjxLCDN4PyJG0xxNPskCUuqt+ftvipaH5pKxep
        PLjkPFxJdoAcpbmSwfSOujVKVKAG/lHrCuo5x5A/OBTQIfsFEjSu7WsfQoKeSWibr5u
        upou1MtSyTsXySXC+X/gg2WMmpbaAcAhpqcitWcY=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1576175819;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=3O+wXC7g249LCZBdLWpVNcA7JpQ8PQ2bILr41dWjDV4=;
        b=hMoGQQxO+REU1h+TyV/GUPN1ENIt8f49CIAtxxx81Ai3JRgn22rM5K0CpM2f9vaq
        I013OENt71BHGEh3zpsOBwaUiwVK1uZFxsIEOcuNXqhlGKwu25Rl/r5fSYRwTlH5LW4
        99FQP7Cg6HlMAnXaZ0gvH/lyDaLJzjJxxrTP1CjE=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 19172C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=eberman@codeaurora.org
From:   Elliot Berman <eberman@codeaurora.org>
To:     bjorn.anderssen@linaro.org, saiprakash.ranjan@codeaurora.org,
        agross@kernel.org, swboyd@chromium.org
Cc:     Elliot Berman <eberman@codeaurora.org>, tsoni@codeaurora.org,
        sidgup@codeaurora.org, psodagud@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/17] firmware: qcom_scm: Rename macros and structures
Date:   Thu, 12 Dec 2019 18:36:58 +0000
Message-ID: <0101016efb6658b0-04a0d7dc-a806-4383-9236-3ae05db86d62-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576175807-11775-1-git-send-email-eberman@codeaurora.org>
References: <1576175807-11775-1-git-send-email-eberman@codeaurora.org>
X-SES-Outgoing: 2019.12.12-54.240.27.21
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename legacy-specific structures and macros with legacy prefix; rename
smc-specific structures and macros with smc prefix. This should make it
clearer which structures are generic to "SCM" and which are specfically
for implementing the convention.

Signed-off-by: Elliot Berman <eberman@codeaurora.org>
---
 drivers/firmware/qcom_scm-32.c | 71 ++++++++++++++++++++++--------------------
 drivers/firmware/qcom_scm-64.c | 53 +++++++++++++++----------------
 2 files changed, 64 insertions(+), 60 deletions(-)

diff --git a/drivers/firmware/qcom_scm-32.c b/drivers/firmware/qcom_scm-32.c
index 48e2ef7..2542c42 100644
--- a/drivers/firmware/qcom_scm-32.c
+++ b/drivers/firmware/qcom_scm-32.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/* Copyright (c) 2010,2015, The Linux Foundation. All rights reserved.
+/* Copyright (c) 2010,2015,2019 The Linux Foundation. All rights reserved.
  * Copyright (C) 2015 Linaro Ltd.
  */
 
@@ -39,30 +39,30 @@ static struct qcom_scm_entry qcom_scm_wb[] = {
 static DEFINE_MUTEX(qcom_scm_lock);
 
 /**
- * struct qcom_scm_command - one SCM command buffer
+ * struct scm_legacy_command - one SCM command buffer
  * @len: total available memory for command and response
  * @buf_offset: start of command buffer
  * @resp_hdr_offset: start of response buffer
  * @id: command to be executed
- * @buf: buffer returned from qcom_scm_get_command_buffer()
+ * @buf: buffer returned from scm_legacy_get_command_buffer()
  *
  * An SCM command is laid out in memory as follows:
  *
- *	------------------- <--- struct qcom_scm_command
+ *	------------------- <--- struct scm_legacy_command
  *	| command header  |
- *	------------------- <--- qcom_scm_get_command_buffer()
+ *	------------------- <--- scm_legacy_get_command_buffer()
  *	| command buffer  |
- *	------------------- <--- struct qcom_scm_response and
- *	| response header |      qcom_scm_command_to_response()
- *	------------------- <--- qcom_scm_get_response_buffer()
+ *	------------------- <--- struct scm_legacy_response and
+ *	| response header |      scm_legacy_command_to_response()
+ *	------------------- <--- scm_legacy_get_response_buffer()
  *	| response buffer |
  *	-------------------
  *
  * There can be arbitrary padding between the headers and buffers so
- * you should always use the appropriate qcom_scm_get_*_buffer() routines
+ * you should always use the appropriate scm_legacy_get_*_buffer() routines
  * to access the buffers in a safe manner.
  */
-struct qcom_scm_command {
+struct scm_legacy_command {
 	__le32 len;
 	__le32 buf_offset;
 	__le32 resp_hdr_offset;
@@ -71,52 +71,54 @@ struct qcom_scm_command {
 };
 
 /**
- * struct qcom_scm_response - one SCM response buffer
+ * struct scm_legacy_response - one SCM response buffer
  * @len: total available memory for response
- * @buf_offset: start of response data relative to start of qcom_scm_response
+ * @buf_offset: start of response data relative to start of scm_legacy_response
  * @is_complete: indicates if the command has finished processing
  */
-struct qcom_scm_response {
+struct scm_legacy_response {
 	__le32 len;
 	__le32 buf_offset;
 	__le32 is_complete;
 };
 
 /**
- * qcom_scm_command_to_response() - Get a pointer to a qcom_scm_response
+ * scm_legacy_command_to_response() - Get a pointer to a scm_legacy_response
  * @cmd: command
  *
  * Returns a pointer to a response for a command.
  */
-static inline struct qcom_scm_response *qcom_scm_command_to_response(
-		const struct qcom_scm_command *cmd)
+static inline struct scm_legacy_response *scm_legacy_command_to_response(
+		const struct scm_legacy_command *cmd)
 {
 	return (void *)cmd + le32_to_cpu(cmd->resp_hdr_offset);
 }
 
 /**
- * qcom_scm_get_command_buffer() - Get a pointer to a command buffer
+ * scm_legacy_get_command_buffer() - Get a pointer to a command buffer
  * @cmd: command
  *
  * Returns a pointer to the command buffer of a command.
  */
-static inline void *qcom_scm_get_command_buffer(const struct qcom_scm_command *cmd)
+static inline void *scm_legacy_get_command_buffer(
+		const struct scm_legacy_command *cmd)
 {
 	return (void *)cmd->buf;
 }
 
 /**
- * qcom_scm_get_response_buffer() - Get a pointer to a response buffer
+ * scm_legacy_get_response_buffer() - Get a pointer to a response buffer
  * @rsp: response
  *
  * Returns a pointer to a response buffer of a response.
  */
-static inline void *qcom_scm_get_response_buffer(const struct qcom_scm_response *rsp)
+static inline void *scm_legacy_get_response_buffer(
+		const struct scm_legacy_response *rsp)
 {
 	return (void *)rsp + le32_to_cpu(rsp->buf_offset);
 }
 
-static u32 smc(u32 cmd_addr)
+static u32 __scm_legacy_do(u32 cmd_addr)
 {
 	int context_id;
 	register u32 r0 asm("r0") = 1;
@@ -164,8 +166,8 @@ static int qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
 			 size_t resp_len)
 {
 	int ret;
-	struct qcom_scm_command *cmd;
-	struct qcom_scm_response *rsp;
+	struct scm_legacy_command *cmd;
+	struct scm_legacy_response *rsp;
 	size_t alloc_len = sizeof(*cmd) + cmd_len + sizeof(*rsp) + resp_len;
 	dma_addr_t cmd_phys;
 
@@ -179,9 +181,9 @@ static int qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
 
 	cmd->id = cpu_to_le32((svc_id << 10) | cmd_id);
 	if (cmd_buf)
-		memcpy(qcom_scm_get_command_buffer(cmd), cmd_buf, cmd_len);
+		memcpy(scm_legacy_get_command_buffer(cmd), cmd_buf, cmd_len);
 
-	rsp = qcom_scm_command_to_response(cmd);
+	rsp = scm_legacy_command_to_response(cmd);
 
 	cmd_phys = dma_map_single(dev, cmd, alloc_len, DMA_TO_DEVICE);
 	if (dma_mapping_error(dev, cmd_phys)) {
@@ -190,7 +192,7 @@ static int qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
 	}
 
 	mutex_lock(&qcom_scm_lock);
-	ret = smc(cmd_phys);
+	ret = __scm_legacy_do(cmd_phys);
 	if (ret < 0)
 		ret = qcom_scm_remap_error(ret);
 	mutex_unlock(&qcom_scm_lock);
@@ -206,7 +208,7 @@ static int qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
 		dma_sync_single_for_cpu(dev, cmd_phys + sizeof(*cmd) + cmd_len +
 					le32_to_cpu(rsp->buf_offset),
 					resp_len, DMA_FROM_DEVICE);
-		memcpy(resp_buf, qcom_scm_get_response_buffer(rsp),
+		memcpy(resp_buf, scm_legacy_get_response_buffer(rsp),
 		       resp_len);
 	}
 out:
@@ -215,11 +217,12 @@ static int qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
 	return ret;
 }
 
-#define SCM_CLASS_REGISTER	(0x2 << 8)
-#define SCM_MASK_IRQS		BIT(5)
-#define SCM_ATOMIC(svc, cmd, n) (((((svc) << 10)|((cmd) & 0x3ff)) << 12) | \
-				SCM_CLASS_REGISTER | \
-				SCM_MASK_IRQS | \
+#define SCM_LEGACY_CLASS_REGISTER		(0x2 << 8)
+#define SCM_LEGACY_MASK_IRQS		BIT(5)
+#define SCM_LEGACY_ATOMIC_ID(svc, cmd, n) \
+				(((((svc) << 10)|((cmd) & 0x3ff)) << 12) | \
+				SCM_LEGACY_CLASS_REGISTER | \
+				SCM_LEGACY_MASK_IRQS | \
 				(n & 0xf))
 
 /**
@@ -235,7 +238,7 @@ static s32 qcom_scm_call_atomic1(u32 svc, u32 cmd, u32 arg1)
 {
 	int context_id;
 
-	register u32 r0 asm("r0") = SCM_ATOMIC(svc, cmd, 1);
+	register u32 r0 asm("r0") = SCM_LEGACY_ATOMIC_ID(svc, cmd, 1);
 	register u32 r1 asm("r1") = (u32)&context_id;
 	register u32 r2 asm("r2") = arg1;
 
@@ -268,7 +271,7 @@ static s32 qcom_scm_call_atomic2(u32 svc, u32 cmd, u32 arg1, u32 arg2)
 {
 	int context_id;
 
-	register u32 r0 asm("r0") = SCM_ATOMIC(svc, cmd, 2);
+	register u32 r0 asm("r0") = SCM_LEGACY_ATOMIC_ID(svc, cmd, 2);
 	register u32 r1 asm("r1") = (u32)&context_id;
 	register u32 r2 asm("r2") = arg1;
 	register u32 r3 asm("r3") = arg2;
diff --git a/drivers/firmware/qcom_scm-64.c b/drivers/firmware/qcom_scm-64.c
index 3c58503..9c7ea74 100644
--- a/drivers/firmware/qcom_scm-64.c
+++ b/drivers/firmware/qcom_scm-64.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/* Copyright (c) 2015, The Linux Foundation. All rights reserved.
+/* Copyright (c) 2015,2019 The Linux Foundation. All rights reserved.
  */
 
 #include <linux/io.h>
@@ -14,7 +14,7 @@
 
 #include "qcom_scm.h"
 
-#define QCOM_SCM_FNID(s, c) ((((s) & 0xFF) << 8) | ((c) & 0xFF))
+#define SCM_SMC_FNID(s, c) ((((s) & 0xFF) << 8) | ((c) & 0xFF))
 
 #define MAX_QCOM_SCM_ARGS 10
 #define MAX_QCOM_SCM_RETS 3
@@ -58,11 +58,11 @@ static DEFINE_MUTEX(qcom_scm_lock);
 #define QCOM_SCM_EBUSY_WAIT_MS 30
 #define QCOM_SCM_EBUSY_MAX_RETRY 20
 
-#define N_EXT_QCOM_SCM_ARGS 7
-#define FIRST_EXT_ARG_IDX 3
-#define N_REGISTER_ARGS (MAX_QCOM_SCM_ARGS - N_EXT_QCOM_SCM_ARGS + 1)
+#define SCM_SMC_N_EXT_ARGS 7
+#define SCM_SMC_FIRST_EXT_IDX 3
+#define SCM_SMC_N_REG_ARGS (MAX_QCOM_SCM_ARGS - SCM_SMC_N_EXT_ARGS + 1)
 
-static void __qcom_scm_call_do(const struct qcom_scm_desc *desc,
+static void __scm_smc_do_quirk(const struct qcom_scm_desc *desc,
 			       struct arm_smccc_res *res, u32 fn_id,
 			       u64 x5, u32 type)
 {
@@ -85,22 +85,23 @@ static void __qcom_scm_call_do(const struct qcom_scm_desc *desc,
 	} while (res->a0 == QCOM_SCM_INTERRUPTED);
 }
 
-static void qcom_scm_call_do(const struct qcom_scm_desc *desc,
+static void __scm_smc_do(const struct qcom_scm_desc *desc,
 			     struct arm_smccc_res *res, u32 fn_id,
 			     u64 x5, bool atomic)
 {
 	int retry_count = 0;
 
 	if (atomic) {
-		__qcom_scm_call_do(desc, res, fn_id, x5, ARM_SMCCC_FAST_CALL);
+		__scm_smc_do_quirk(desc, res, fn_id, x5,
+					 ARM_SMCCC_FAST_CALL);
 		return;
 	}
 
 	do {
 		mutex_lock(&qcom_scm_lock);
 
-		__qcom_scm_call_do(desc, res, fn_id, x5,
-				   ARM_SMCCC_STD_CALL);
+		__scm_smc_do_quirk(desc, res, fn_id, x5,
+					 ARM_SMCCC_STD_CALL);
 
 		mutex_unlock(&qcom_scm_lock);
 
@@ -112,21 +113,21 @@ static void qcom_scm_call_do(const struct qcom_scm_desc *desc,
 	}  while (res->a0 == QCOM_SCM_V2_EBUSY);
 }
 
-static int ___qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
-			    const struct qcom_scm_desc *desc,
-			    struct arm_smccc_res *res, bool atomic)
+static int __scm_smc_call(struct device *dev, u32 svc_id, u32 cmd_id,
+				  const struct qcom_scm_desc *desc,
+				  struct arm_smccc_res *res, bool atomic)
 {
 	int arglen = desc->arginfo & 0xf;
 	int i;
-	u32 fn_id = QCOM_SCM_FNID(svc_id, cmd_id);
-	u64 x5 = desc->args[FIRST_EXT_ARG_IDX];
+	u32 fn_id = SCM_SMC_FNID(svc_id, cmd_id);
+	u64 x5 = desc->args[SCM_SMC_FIRST_EXT_IDX];
 	dma_addr_t args_phys = 0;
 	void *args_virt = NULL;
 	size_t alloc_len;
 	gfp_t flag = atomic ? GFP_ATOMIC : GFP_KERNEL;
 
-	if (unlikely(arglen > N_REGISTER_ARGS)) {
-		alloc_len = N_EXT_QCOM_SCM_ARGS * sizeof(u64);
+	if (unlikely(arglen > SCM_SMC_N_REG_ARGS)) {
+		alloc_len = SCM_SMC_N_EXT_ARGS * sizeof(u64);
 		args_virt = kzalloc(PAGE_ALIGN(alloc_len), flag);
 
 		if (!args_virt)
@@ -135,15 +136,15 @@ static int ___qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
 		if (qcom_smccc_convention == ARM_SMCCC_SMC_32) {
 			__le32 *args = args_virt;
 
-			for (i = 0; i < N_EXT_QCOM_SCM_ARGS; i++)
+			for (i = 0; i < SCM_SMC_N_EXT_ARGS; i++)
 				args[i] = cpu_to_le32(desc->args[i +
-						      FIRST_EXT_ARG_IDX]);
+						      SCM_SMC_FIRST_EXT_IDX]);
 		} else {
 			__le64 *args = args_virt;
 
-			for (i = 0; i < N_EXT_QCOM_SCM_ARGS; i++)
+			for (i = 0; i < SCM_SMC_N_EXT_ARGS; i++)
 				args[i] = cpu_to_le64(desc->args[i +
-						      FIRST_EXT_ARG_IDX]);
+						      SCM_SMC_FIRST_EXT_IDX]);
 		}
 
 		args_phys = dma_map_single(dev, args_virt, alloc_len,
@@ -157,7 +158,7 @@ static int ___qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
 		x5 = args_phys;
 	}
 
-	qcom_scm_call_do(desc, res, fn_id, x5, atomic);
+	__scm_smc_do(desc, res, fn_id, x5, atomic);
 
 	if (args_virt) {
 		dma_unmap_single(dev, args_phys, alloc_len, DMA_TO_DEVICE);
@@ -185,7 +186,7 @@ static int qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
 			 struct arm_smccc_res *res)
 {
 	might_sleep();
-	return ___qcom_scm_call(dev, svc_id, cmd_id, desc, res, false);
+	return __scm_smc_call(dev, svc_id, cmd_id, desc, res, false);
 }
 
 /**
@@ -203,7 +204,7 @@ static int qcom_scm_call_atomic(struct device *dev, u32 svc_id, u32 cmd_id,
 				const struct qcom_scm_desc *desc,
 				struct arm_smccc_res *res)
 {
-	return ___qcom_scm_call(dev, svc_id, cmd_id, desc, res, true);
+	return __scm_smc_call(dev, svc_id, cmd_id, desc, res, true);
 }
 
 /**
@@ -253,7 +254,7 @@ int __qcom_scm_is_call_available(struct device *dev, u32 svc_id, u32 cmd_id)
 	struct arm_smccc_res res;
 
 	desc.arginfo = QCOM_SCM_ARGS(1);
-	desc.args[0] = QCOM_SCM_FNID(svc_id, cmd_id) |
+	desc.args[0] = SCM_SMC_FNID(svc_id, cmd_id) |
 			(ARM_SMCCC_OWNER_SIP << ARM_SMCCC_OWNER_SHIFT);
 
 	ret = qcom_scm_call(dev, QCOM_SCM_SVC_INFO, QCOM_IS_CALL_AVAIL_CMD,
@@ -307,7 +308,7 @@ void __qcom_scm_init(void)
 {
 	u64 cmd;
 	struct arm_smccc_res res;
-	u32 function = QCOM_SCM_FNID(QCOM_SCM_SVC_INFO, QCOM_IS_CALL_AVAIL_CMD);
+	u32 function = SCM_SMC_FNID(QCOM_SCM_SVC_INFO, QCOM_IS_CALL_AVAIL_CMD);
 
 	/* First try a SMC64 call */
 	cmd = ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_64,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

