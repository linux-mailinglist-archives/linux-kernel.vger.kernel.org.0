Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D72411D643
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 19:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730687AbfLLSvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 13:51:24 -0500
Received: from a27-18.smtp-out.us-west-2.amazonses.com ([54.240.27.18]:39284
        "EHLO a27-18.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730651AbfLLSvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 13:51:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1576176679;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=uq9M1dVWf+QqJzV6adGNLbbVNXhGOgFpQQ3FWV0kh5k=;
        b=dUcazDUDIYt2HgL0Rpv4RmK/VOzKh8Kqs6wnSdipOke76yHBlM0rtK1PbK2fJeBr
        RQGgGkNA31U00xhs1DltiAxJ3pSKCIxTZUXqHLOzUe9Wpc/r2YvE0YdhLSbir6bdpck
        7FOk+wImrAyGxBy0fVq5EUFrEmv1eTwGzZkFCyM4=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1576176679;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=uq9M1dVWf+QqJzV6adGNLbbVNXhGOgFpQQ3FWV0kh5k=;
        b=cXqGkwbfSCs5EuaBlZHN/CdRw/6T5jZotkp9s94UD8PErrTboUuCgkpFqdn/fmN7
        1dd2qJ4xeJ/V8i/uyMIi3+YKVOlCEyDzjG/EdbZQAPWnZ145OpF6ZpCRpnUdMPdcPGf
        6gG/Qc/uIg1forU870QeoD5XHZJqFpdo1H0NkJME=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4718FC4479F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=eberman@codeaurora.org
From:   Elliot Berman <eberman@codeaurora.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org, swboyd@chromium.org
Cc:     Elliot Berman <eberman@codeaurora.org>,
        saiprakash.ranjan@codeaurora.org, tsoni@codeaurora.org,
        sidgup@codeaurora.org, psodagud@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/17] firmware: qcom_scm-32: Use qcom_scm_desc in non-atomic calls
Date:   Thu, 12 Dec 2019 18:51:19 +0000
Message-ID: <0101016efb737a9f-c9f68d45-f966-409d-8f8f-a808ffc84e91-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576176651-17089-1-git-send-email-eberman@codeaurora.org>
References: <1576176651-17089-1-git-send-email-eberman@codeaurora.org>
X-SES-Outgoing: 2019.12.12-54.240.27.18
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use qcom_scm_desc in non-atomic calls to remove legacy convention
details from every SCM wrapper function. Implementations were copied
from qcom_scm-64 and are functionally equivalent when using the
qcom_scm_desc and qcom_scm_res structs.

Signed-off-by: Elliot Berman <eberman@codeaurora.org>
---
 drivers/firmware/qcom_scm-32.c | 367 ++++++++++++++++++++++++-----------------
 1 file changed, 218 insertions(+), 149 deletions(-)

diff --git a/drivers/firmware/qcom_scm-32.c b/drivers/firmware/qcom_scm-32.c
index fcbe9e0..ce3a61b 100644
--- a/drivers/firmware/qcom_scm-32.c
+++ b/drivers/firmware/qcom_scm-32.c
@@ -39,6 +39,52 @@ static struct qcom_scm_entry qcom_scm_wb[] = {
 
 static DEFINE_MUTEX(qcom_scm_lock);
 
+#define MAX_QCOM_SCM_ARGS 10
+#define MAX_QCOM_SCM_RETS 3
+
+enum qcom_scm_arg_types {
+	QCOM_SCM_VAL,
+	QCOM_SCM_RO,
+	QCOM_SCM_RW,
+	QCOM_SCM_BUFVAL,
+};
+
+#define QCOM_SCM_ARGS_IMPL(num, a, b, c, d, e, f, g, h, i, j, ...) (\
+			   (((a) & 0x3) << 4) | \
+			   (((b) & 0x3) << 6) | \
+			   (((c) & 0x3) << 8) | \
+			   (((d) & 0x3) << 10) | \
+			   (((e) & 0x3) << 12) | \
+			   (((f) & 0x3) << 14) | \
+			   (((g) & 0x3) << 16) | \
+			   (((h) & 0x3) << 18) | \
+			   (((i) & 0x3) << 20) | \
+			   (((j) & 0x3) << 22) | \
+			   ((num) & 0xf))
+
+#define QCOM_SCM_ARGS(...) QCOM_SCM_ARGS_IMPL(__VA_ARGS__, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
+
+/**
+ * struct qcom_scm_desc
+ * @arginfo:	Metadata describing the arguments in args[]
+ * @args:	The array of arguments for the secure syscall
+ */
+struct qcom_scm_desc {
+	u32 svc;
+	u32 cmd;
+	u32 arginfo;
+	u64 args[MAX_QCOM_SCM_ARGS];
+	u32 owner;
+};
+
+/**
+ * struct qcom_scm_res
+ * @result:	The values returned by the secure syscall
+ */
+struct qcom_scm_res {
+	u64 result[MAX_QCOM_SCM_RETS];
+};
+
 #define SCM_LEGACY_FNID(s, c)	(((s) << 10) | ((c) & 0x3ff))
 
 /**
@@ -134,16 +180,8 @@ static u32 __scm_legacy_do(u32 cmd_addr)
 }
 
 /**
- * qcom_scm_call() - Send an SCM command
- * @dev: struct device
- * @svc_id: service identifier
- * @cmd_id: command identifier
- * @cmd_buf: command buffer
- * @cmd_len: length of the command buffer
- * @resp_buf: response buffer
- * @resp_len: length of the response buffer
- *
- * Sends a command to the SCM and waits for the command to finish processing.
+ * qcom_scm_call() - Sends a command to the SCM and waits for the command to
+ * finish processing.
  *
  * A note on cache maintenance:
  * Note that any buffers that are expected to be accessed by the secure world
@@ -152,15 +190,20 @@ static u32 __scm_legacy_do(u32 cmd_addr)
  * and response buffers is taken care of by qcom_scm_call; however, callers are
  * responsible for any other cached buffers passed over to the secure world.
  */
-static int qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
-			 const void *cmd_buf, size_t cmd_len, void *resp_buf,
-			 size_t resp_len)
+static int qcom_scm_call(struct device *dev, const struct qcom_scm_desc *desc,
+			 struct qcom_scm_res *res)
 {
+	u8 arglen = desc->arginfo & 0xf;
 	int ret;
+	unsigned int i;
 	struct scm_legacy_command *cmd;
 	struct scm_legacy_response *rsp;
+	const size_t cmd_len = arglen * sizeof(__le32);
+	const size_t resp_len = MAX_QCOM_SCM_RETS * sizeof(__le32);
 	size_t alloc_len = sizeof(*cmd) + cmd_len + sizeof(*rsp) + resp_len;
 	dma_addr_t cmd_phys;
+	__le32 *arg_buf;
+	const __le32 *res_buf;
 
 	cmd = kzalloc(PAGE_ALIGN(alloc_len), GFP_KERNEL);
 	if (!cmd)
@@ -169,10 +212,11 @@ static int qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
 	cmd->len = cpu_to_le32(alloc_len);
 	cmd->buf_offset = cpu_to_le32(sizeof(*cmd));
 	cmd->resp_hdr_offset = cpu_to_le32(sizeof(*cmd) + cmd_len);
+	cmd->id = cpu_to_le32(SCM_LEGACY_FNID(desc->svc, desc->cmd));
 
-	cmd->id = cpu_to_le32(SCM_LEGACY_FNID(svc_id, cmd_id));
-	if (cmd_buf)
-		memcpy(scm_legacy_get_command_buffer(cmd), cmd_buf, cmd_len);
+	arg_buf = scm_legacy_get_command_buffer(cmd);
+	for (i = 0; i < arglen; i++)
+		arg_buf[i] = cpu_to_le32(desc->args[i]);
 
 	rsp = scm_legacy_command_to_response(cmd);
 
@@ -195,12 +239,14 @@ static int qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
 					sizeof(*rsp), DMA_FROM_DEVICE);
 	} while (!rsp->is_complete);
 
-	if (resp_buf) {
-		dma_sync_single_for_cpu(dev, cmd_phys + sizeof(*cmd) + cmd_len +
-					le32_to_cpu(rsp->buf_offset),
-					resp_len, DMA_FROM_DEVICE);
-		memcpy(resp_buf, scm_legacy_get_response_buffer(rsp),
-		       resp_len);
+	dma_sync_single_for_cpu(dev, cmd_phys + sizeof(*cmd) + cmd_len +
+				le32_to_cpu(rsp->buf_offset),
+				resp_len, DMA_FROM_DEVICE);
+
+	if (res) {
+		res_buf = scm_legacy_get_response_buffer(rsp);
+		for (i = 0; i < MAX_QCOM_SCM_RETS; i++)
+			res->result[i] = le32_to_cpu(res_buf[i]);
 	}
 out:
 	dma_unmap_single(dev, cmd_phys, alloc_len, DMA_TO_DEVICE);
@@ -304,10 +350,10 @@ int __qcom_scm_set_warm_boot_addr(struct device *dev, void *entry,
 	int ret;
 	int flags = 0;
 	int cpu;
-	struct {
-		__le32 flags;
-		__le32 addr;
-	} cmd;
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_BOOT,
+		.cmd = QCOM_SCM_BOOT_SET_ADDR,
+	};
 
 	/*
 	 * Reassign only if we are switching from hotplug entry point
@@ -323,10 +369,11 @@ int __qcom_scm_set_warm_boot_addr(struct device *dev, void *entry,
 	if (!flags)
 		return 0;
 
-	cmd.addr = cpu_to_le32(virt_to_phys(entry));
-	cmd.flags = cpu_to_le32(flags);
-	ret = qcom_scm_call(dev, QCOM_SCM_SVC_BOOT, QCOM_SCM_BOOT_SET_ADDR,
-			    &cmd, sizeof(cmd), NULL, 0);
+	desc.args[0] = flags;
+	desc.args[1] = virt_to_phys(entry);
+	desc.arginfo = QCOM_SCM_ARGS(2);
+
+	ret = qcom_scm_call(dev, &desc, NULL);
 	if (!ret) {
 		for_each_cpu(cpu, cpus)
 			qcom_scm_wb[cpu].entry = entry;
@@ -352,61 +399,80 @@ void __qcom_scm_cpu_power_down(u32 flags)
 int __qcom_scm_is_call_available(struct device *dev, u32 svc_id, u32 cmd_id)
 {
 	int ret;
-	__le32 svc_cmd = cpu_to_le32(SCM_LEGACY_FNID(svc_id, cmd_id));
-	__le32 ret_val = 0;
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_INFO,
+		.cmd = QCOM_SCM_INFO_IS_CALL_AVAIL,
+		.args[0] = SCM_LEGACY_FNID(svc_id, cmd_id),
+		.arginfo = QCOM_SCM_ARGS(1),
+	};
+	struct qcom_scm_res res;
 
-	ret = qcom_scm_call(dev, QCOM_SCM_SVC_INFO, QCOM_SCM_INFO_IS_CALL_AVAIL,
-			    &svc_cmd, sizeof(svc_cmd), &ret_val,
-			    sizeof(ret_val));
-	if (ret)
-		return ret;
+	ret = qcom_scm_call(dev, &desc, &res);
 
-	return le32_to_cpu(ret_val);
+	return ret ? : res.result[0];
 }
 
 int __qcom_scm_hdcp_req(struct device *dev, struct qcom_scm_hdcp_req *req,
 			u32 req_cnt, u32 *resp)
 {
+	int ret;
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_HDCP,
+		.cmd = QCOM_SCM_HDCP_INVOKE,
+	};
+	struct qcom_scm_res res;
+
 	if (req_cnt > QCOM_SCM_HDCP_MAX_REQ_CNT)
 		return -ERANGE;
 
-	return qcom_scm_call(dev, QCOM_SCM_SVC_HDCP, QCOM_SCM_HDCP_INVOKE,
-		req, req_cnt * sizeof(*req), resp, sizeof(*resp));
+	desc.args[0] = req[0].addr;
+	desc.args[1] = req[0].val;
+	desc.args[2] = req[1].addr;
+	desc.args[3] = req[1].val;
+	desc.args[4] = req[2].addr;
+	desc.args[5] = req[2].val;
+	desc.args[6] = req[3].addr;
+	desc.args[7] = req[3].val;
+	desc.args[8] = req[4].addr;
+	desc.args[9] = req[4].val;
+	desc.arginfo = QCOM_SCM_ARGS(10);
+
+	ret = qcom_scm_call(dev, &desc, &res);
+	*resp = res.result[0];
+
+	return ret;
 }
 
 int __qcom_scm_ocmem_lock(struct device *dev, u32 id, u32 offset, u32 size,
 			  u32 mode)
 {
-	struct ocmem_tz_lock {
-		__le32 id;
-		__le32 offset;
-		__le32 size;
-		__le32 mode;
-	} request;
-
-	request.id = cpu_to_le32(id);
-	request.offset = cpu_to_le32(offset);
-	request.size = cpu_to_le32(size);
-	request.mode = cpu_to_le32(mode);
-
-	return qcom_scm_call(dev, QCOM_SCM_SVC_OCMEM, QCOM_SCM_OCMEM_LOCK_CMD,
-			     &request, sizeof(request), NULL, 0);
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_OCMEM,
+		.cmd = QCOM_SCM_OCMEM_LOCK_CMD,
+	};
+
+	desc.args[0] = id;
+	desc.args[1] = offset;
+	desc.args[2] = size;
+	desc.args[3] = mode;
+	desc.arginfo = QCOM_SCM_ARGS(4);
+
+	return qcom_scm_call(dev, &desc, NULL);
 }
 
 int __qcom_scm_ocmem_unlock(struct device *dev, u32 id, u32 offset, u32 size)
 {
-	struct ocmem_tz_unlock {
-		__le32 id;
-		__le32 offset;
-		__le32 size;
-	} request;
-
-	request.id = cpu_to_le32(id);
-	request.offset = cpu_to_le32(offset);
-	request.size = cpu_to_le32(size);
-
-	return qcom_scm_call(dev, QCOM_SCM_SVC_OCMEM, QCOM_SCM_OCMEM_UNLOCK_CMD,
-			     &request, sizeof(request), NULL, 0);
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_OCMEM,
+		.cmd = QCOM_SCM_OCMEM_UNLOCK_CMD,
+	};
+
+	desc.args[0] = id;
+	desc.args[1] = offset;
+	desc.args[2] = size;
+	desc.arginfo = QCOM_SCM_ARGS(3);
+
+	return qcom_scm_call(dev, &desc, NULL);
 }
 
 void __qcom_scm_init(void)
@@ -415,104 +481,110 @@ void __qcom_scm_init(void)
 
 bool __qcom_scm_pas_supported(struct device *dev, u32 peripheral)
 {
-	__le32 out;
-	__le32 in;
 	int ret;
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_PIL,
+		.cmd = QCOM_SCM_PIL_PAS_IS_SUPPORTED,
+	};
+	struct qcom_scm_res res;
+
+	desc.args[0] = peripheral;
+	desc.arginfo = QCOM_SCM_ARGS(1);
 
-	in = cpu_to_le32(peripheral);
-	ret = qcom_scm_call(dev, QCOM_SCM_SVC_PIL,
-			    QCOM_SCM_PIL_PAS_IS_SUPPORTED,
-			    &in, sizeof(in),
-			    &out, sizeof(out));
+	ret = qcom_scm_call(dev, &desc, &res);
 
-	return ret ? false : !!out;
+	return ret ? false : !!res.result[0];
 }
 
 int __qcom_scm_pas_init_image(struct device *dev, u32 peripheral,
 			      dma_addr_t metadata_phys)
 {
-	__le32 scm_ret;
 	int ret;
-	struct {
-		__le32 proc;
-		__le32 image_addr;
-	} request;
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_PIL,
+		.cmd = QCOM_SCM_PIL_PAS_INIT_IMAGE,
+	};
+	struct qcom_scm_res res;
 
-	request.proc = cpu_to_le32(peripheral);
-	request.image_addr = cpu_to_le32(metadata_phys);
+	desc.args[0] = peripheral;
+	desc.args[1] = metadata_phys;
+	desc.arginfo = QCOM_SCM_ARGS(2, QCOM_SCM_VAL, QCOM_SCM_RW);
 
-	ret = qcom_scm_call(dev, QCOM_SCM_SVC_PIL,
-			    QCOM_SCM_PIL_PAS_INIT_IMAGE,
-			    &request, sizeof(request),
-			    &scm_ret, sizeof(scm_ret));
+	ret = qcom_scm_call(dev, &desc, &res);
 
-	return ret ? : le32_to_cpu(scm_ret);
+	return ret ? : res.result[0];
 }
 
 int __qcom_scm_pas_mem_setup(struct device *dev, u32 peripheral,
-			     phys_addr_t addr, phys_addr_t size)
+			      phys_addr_t addr, phys_addr_t size)
 {
-	__le32 scm_ret;
 	int ret;
-	struct {
-		__le32 proc;
-		__le32 addr;
-		__le32 len;
-	} request;
-
-	request.proc = cpu_to_le32(peripheral);
-	request.addr = cpu_to_le32(addr);
-	request.len = cpu_to_le32(size);
-
-	ret = qcom_scm_call(dev, QCOM_SCM_SVC_PIL,
-			    QCOM_SCM_PIL_PAS_MEM_SETUP,
-			    &request, sizeof(request),
-			    &scm_ret, sizeof(scm_ret));
-
-	return ret ? : le32_to_cpu(scm_ret);
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_PIL,
+		.cmd = QCOM_SCM_PIL_PAS_MEM_SETUP,
+	};
+	struct qcom_scm_res res;
+
+	desc.args[0] = peripheral;
+	desc.args[1] = addr;
+	desc.args[2] = size;
+	desc.arginfo = QCOM_SCM_ARGS(3);
+
+	ret = qcom_scm_call(dev, &desc, &res);
+
+	return ret ? : res.result[0];
 }
 
 int __qcom_scm_pas_auth_and_reset(struct device *dev, u32 peripheral)
 {
-	__le32 out;
-	__le32 in;
 	int ret;
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_PIL,
+		.cmd = QCOM_SCM_PIL_PAS_AUTH_AND_RESET,
+	};
+	struct qcom_scm_res res;
+
+	desc.args[0] = peripheral;
+	desc.arginfo = QCOM_SCM_ARGS(1);
 
-	in = cpu_to_le32(peripheral);
-	ret = qcom_scm_call(dev, QCOM_SCM_SVC_PIL,
-			    QCOM_SCM_PIL_PAS_AUTH_AND_RESET,
-			    &in, sizeof(in),
-			    &out, sizeof(out));
+	ret = qcom_scm_call(dev, &desc, &res);
 
-	return ret ? : le32_to_cpu(out);
+	return ret ? : res.result[0];
 }
 
 int __qcom_scm_pas_shutdown(struct device *dev, u32 peripheral)
 {
-	__le32 out;
-	__le32 in;
 	int ret;
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_PIL,
+		.cmd = QCOM_SCM_PIL_PAS_SHUTDOWN,
+	};
+	struct qcom_scm_res res;
+
+	desc.args[0] = peripheral;
+	desc.arginfo = QCOM_SCM_ARGS(1);
 
-	in = cpu_to_le32(peripheral);
-	ret = qcom_scm_call(dev, QCOM_SCM_SVC_PIL,
-			    QCOM_SCM_PIL_PAS_SHUTDOWN,
-			    &in, sizeof(in),
-			    &out, sizeof(out));
+	ret = qcom_scm_call(dev, &desc, &res);
 
-	return ret ? : le32_to_cpu(out);
+	return ret ? : res.result[0];
 }
 
 int __qcom_scm_pas_mss_reset(struct device *dev, bool reset)
 {
-	__le32 out;
-	__le32 in = cpu_to_le32(reset);
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_PIL,
+		.cmd = QCOM_SCM_PIL_PAS_MSS_RESET,
+	};
+	struct qcom_scm_res res;
 	int ret;
 
-	ret = qcom_scm_call(dev, QCOM_SCM_SVC_PIL, QCOM_SCM_PIL_PAS_MSS_RESET,
-			&in, sizeof(in),
-			&out, sizeof(out));
+	desc.args[0] = reset;
+	desc.args[1] = 0;
+	desc.arginfo = QCOM_SCM_ARGS(2);
 
-	return ret ? : le32_to_cpu(out);
+	ret = qcom_scm_call(dev, &desc, &res);
+
+	return ret ? : res.result[0];
 }
 
 int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
@@ -523,20 +595,19 @@ int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
 
 int __qcom_scm_set_remote_state(struct device *dev, u32 state, u32 id)
 {
-	struct {
-		__le32 state;
-		__le32 id;
-	} req;
-	__le32 scm_ret = 0;
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_BOOT,
+		.cmd = QCOM_SCM_BOOT_SET_REMOTE_STATE,
+	};
+	struct qcom_scm_res res;
 	int ret;
 
-	req.state = cpu_to_le32(state);
-	req.id = cpu_to_le32(id);
+	desc.args[0] = state;
+	desc.args[1] = id;
 
-	ret = qcom_scm_call(dev, QCOM_SCM_SVC_BOOT, QCOM_SCM_BOOT_SET_REMOTE_STATE,
-			    &req, sizeof(req), &scm_ret, sizeof(scm_ret));
+	ret = qcom_scm_call(dev, &desc, &res);
 
-	return ret ? : le32_to_cpu(scm_ret);
+	return ret ? : res.result[0];
 }
 
 int __qcom_scm_assign_mem(struct device *dev, phys_addr_t mem_region,
@@ -549,22 +620,20 @@ int __qcom_scm_assign_mem(struct device *dev, phys_addr_t mem_region,
 int __qcom_scm_restore_sec_cfg(struct device *dev, u32 device_id,
 			       u32 spare)
 {
-	struct msm_scm_sec_cfg {
-		__le32 id;
-		__le32 ctx_bank_num;
-	} cfg;
-	int ret, scm_ret = 0;
-
-	cfg.id = cpu_to_le32(device_id);
-	cfg.ctx_bank_num = cpu_to_le32(spare);
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_MP,
+		.cmd = QCOM_SCM_MP_RESTORE_SEC_CFG,
+	};
+	struct qcom_scm_res res;
+	int ret;
 
-	ret = qcom_scm_call(dev, QCOM_SCM_SVC_MP, QCOM_SCM_MP_RESTORE_SEC_CFG,
-			    &cfg, sizeof(cfg), &scm_ret, sizeof(scm_ret));
+	desc.args[0] = device_id;
+	desc.args[1] = spare;
+	desc.arginfo = QCOM_SCM_ARGS(2);
 
-	if (ret || scm_ret)
-		return ret ? ret : -EINVAL;
+	ret = qcom_scm_call(dev, &desc, &res);
 
-	return 0;
+	return ret ? : res.result[0];
 }
 
 int __qcom_scm_iommu_secure_ptbl_size(struct device *dev, u32 spare,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

