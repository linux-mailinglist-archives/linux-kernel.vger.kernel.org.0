Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43CF111D640
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 19:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730639AbfLLSvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 13:51:17 -0500
Received: from a27-186.smtp-out.us-west-2.amazonses.com ([54.240.27.186]:35740
        "EHLO a27-186.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730516AbfLLSvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 13:51:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1576176669;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=dJVSwMz2Vy2i2F+MMDTEB/Ea61CQO1altGX/sXH9PaU=;
        b=K6/GlVOZ4cTosL9Hepisjghj5nlnvbBCeA3F3Tp73EUCteMLC0DGQ3mv30hK1Xsa
        5lFXp5UghCih3gfPiUbzBY5C7tFCmezU9OUHMHOS9bAkVr4ych/rXzI+4jdOTX1et+Y
        vkROFFLJMuDFbRkEpk8uWYMJyn95YMvyx4geNxog=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1576176669;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=dJVSwMz2Vy2i2F+MMDTEB/Ea61CQO1altGX/sXH9PaU=;
        b=BS1CzeTZvk/Hlt9ewf531uiZutwyCPKfOI805BtJgkFXxcRAB1lrStnAv97Qq+xe
        fDkR+v0cxgOOMg4r63iriDFJSjyp6CGrIQD16Tg4i0fHiRmalHZwwtpSrFfxyIrBZqw
        ow+UUqjEr3KIuVYALPwqvgnVdNzbilEumINu9c0k=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B50CDC447A0
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=eberman@codeaurora.org
From:   Elliot Berman <eberman@codeaurora.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org, swboyd@chromium.org
Cc:     Elliot Berman <eberman@codeaurora.org>,
        saiprakash.ranjan@codeaurora.org, tsoni@codeaurora.org,
        sidgup@codeaurora.org, psodagud@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/17] firmware: qcom_scm: Apply consistent naming scheme to command IDs
Date:   Thu, 12 Dec 2019 18:51:09 +0000
Message-ID: <0101016efb735383-0a633dce-99e6-41e9-a7f0-548d2f20d985-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576176651-17089-1-git-send-email-eberman@codeaurora.org>
References: <1576176651-17089-1-git-send-email-eberman@codeaurora.org>
X-SES-Outgoing: 2019.12.12-54.240.27.186
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a consistent naming scheme for command IDs. The scheme is
QCOM_SCM_##svc_##cmd. Remove unused macros QCOM_SCM_FLAG_HLOS,
QCOM_SCM_FLAG_COLDBOOT_MC, QCOM_SCM_FLAG_WARMBOOT_MC,
QCOM_SCM_CMD_CORE_HOTPLUGGED, and QCOM_SCM_BOOT_ADDR_MC.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Elliot Berman <eberman@codeaurora.org>
---
 drivers/firmware/qcom_scm-32.c | 34 +++++++++++++++----------------
 drivers/firmware/qcom_scm-64.c | 40 ++++++++++++++++++-------------------
 drivers/firmware/qcom_scm.c    | 17 +++++++---------
 drivers/firmware/qcom_scm.h    | 45 +++++++++++++++++++-----------------------
 4 files changed, 64 insertions(+), 72 deletions(-)

diff --git a/drivers/firmware/qcom_scm-32.c b/drivers/firmware/qcom_scm-32.c
index 2542c42..6e62f73 100644
--- a/drivers/firmware/qcom_scm-32.c
+++ b/drivers/firmware/qcom_scm-32.c
@@ -357,7 +357,7 @@ int __qcom_scm_set_cold_boot_addr(void *entry, const cpumask_t *cpus)
 			set_cpu_present(cpu, false);
 	}
 
-	return qcom_scm_call_atomic2(QCOM_SCM_SVC_BOOT, QCOM_SCM_BOOT_ADDR,
+	return qcom_scm_call_atomic2(QCOM_SCM_SVC_BOOT, QCOM_SCM_BOOT_SET_ADDR,
 				    flags, virt_to_phys(entry));
 }
 
@@ -396,7 +396,7 @@ int __qcom_scm_set_warm_boot_addr(struct device *dev, void *entry,
 
 	cmd.addr = cpu_to_le32(virt_to_phys(entry));
 	cmd.flags = cpu_to_le32(flags);
-	ret = qcom_scm_call(dev, QCOM_SCM_SVC_BOOT, QCOM_SCM_BOOT_ADDR,
+	ret = qcom_scm_call(dev, QCOM_SCM_SVC_BOOT, QCOM_SCM_BOOT_SET_ADDR,
 			    &cmd, sizeof(cmd), NULL, 0);
 	if (!ret) {
 		for_each_cpu(cpu, cpus)
@@ -416,7 +416,7 @@ int __qcom_scm_set_warm_boot_addr(struct device *dev, void *entry,
  */
 void __qcom_scm_cpu_power_down(u32 flags)
 {
-	qcom_scm_call_atomic1(QCOM_SCM_SVC_BOOT, QCOM_SCM_CMD_TERMINATE_PC,
+	qcom_scm_call_atomic1(QCOM_SCM_SVC_BOOT, QCOM_SCM_BOOT_TERMINATE_PC,
 			flags & QCOM_SCM_FLUSH_FLAG_MASK);
 }
 
@@ -426,7 +426,7 @@ int __qcom_scm_is_call_available(struct device *dev, u32 svc_id, u32 cmd_id)
 	__le32 svc_cmd = cpu_to_le32((svc_id << 10) | cmd_id);
 	__le32 ret_val = 0;
 
-	ret = qcom_scm_call(dev, QCOM_SCM_SVC_INFO, QCOM_IS_CALL_AVAIL_CMD,
+	ret = qcom_scm_call(dev, QCOM_SCM_SVC_INFO, QCOM_SCM_INFO_IS_CALL_AVAIL,
 			    &svc_cmd, sizeof(svc_cmd), &ret_val,
 			    sizeof(ret_val));
 	if (ret)
@@ -441,7 +441,7 @@ int __qcom_scm_hdcp_req(struct device *dev, struct qcom_scm_hdcp_req *req,
 	if (req_cnt > QCOM_SCM_HDCP_MAX_REQ_CNT)
 		return -ERANGE;
 
-	return qcom_scm_call(dev, QCOM_SCM_SVC_HDCP, QCOM_SCM_CMD_HDCP,
+	return qcom_scm_call(dev, QCOM_SCM_SVC_HDCP, QCOM_SCM_HDCP_INVOKE,
 		req, req_cnt * sizeof(*req), resp, sizeof(*resp));
 }
 
@@ -460,7 +460,7 @@ int __qcom_scm_ocmem_lock(struct device *dev, u32 id, u32 offset, u32 size,
 	request.size = cpu_to_le32(size);
 	request.mode = cpu_to_le32(mode);
 
-	return qcom_scm_call(dev, QCOM_SCM_OCMEM_SVC, QCOM_SCM_OCMEM_LOCK_CMD,
+	return qcom_scm_call(dev, QCOM_SCM_SVC_OCMEM, QCOM_SCM_OCMEM_LOCK_CMD,
 			     &request, sizeof(request), NULL, 0);
 }
 
@@ -476,7 +476,7 @@ int __qcom_scm_ocmem_unlock(struct device *dev, u32 id, u32 offset, u32 size)
 	request.offset = cpu_to_le32(offset);
 	request.size = cpu_to_le32(size);
 
-	return qcom_scm_call(dev, QCOM_SCM_OCMEM_SVC, QCOM_SCM_OCMEM_UNLOCK_CMD,
+	return qcom_scm_call(dev, QCOM_SCM_SVC_OCMEM, QCOM_SCM_OCMEM_UNLOCK_CMD,
 			     &request, sizeof(request), NULL, 0);
 }
 
@@ -492,7 +492,7 @@ bool __qcom_scm_pas_supported(struct device *dev, u32 peripheral)
 
 	in = cpu_to_le32(peripheral);
 	ret = qcom_scm_call(dev, QCOM_SCM_SVC_PIL,
-			    QCOM_SCM_PAS_IS_SUPPORTED_CMD,
+			    QCOM_SCM_PIL_PAS_IS_SUPPORTED,
 			    &in, sizeof(in),
 			    &out, sizeof(out));
 
@@ -513,7 +513,7 @@ int __qcom_scm_pas_init_image(struct device *dev, u32 peripheral,
 	request.image_addr = cpu_to_le32(metadata_phys);
 
 	ret = qcom_scm_call(dev, QCOM_SCM_SVC_PIL,
-			    QCOM_SCM_PAS_INIT_IMAGE_CMD,
+			    QCOM_SCM_PIL_PAS_INIT_IMAGE,
 			    &request, sizeof(request),
 			    &scm_ret, sizeof(scm_ret));
 
@@ -536,7 +536,7 @@ int __qcom_scm_pas_mem_setup(struct device *dev, u32 peripheral,
 	request.len = cpu_to_le32(size);
 
 	ret = qcom_scm_call(dev, QCOM_SCM_SVC_PIL,
-			    QCOM_SCM_PAS_MEM_SETUP_CMD,
+			    QCOM_SCM_PIL_PAS_MEM_SETUP,
 			    &request, sizeof(request),
 			    &scm_ret, sizeof(scm_ret));
 
@@ -551,7 +551,7 @@ int __qcom_scm_pas_auth_and_reset(struct device *dev, u32 peripheral)
 
 	in = cpu_to_le32(peripheral);
 	ret = qcom_scm_call(dev, QCOM_SCM_SVC_PIL,
-			    QCOM_SCM_PAS_AUTH_AND_RESET_CMD,
+			    QCOM_SCM_PIL_PAS_AUTH_AND_RESET,
 			    &in, sizeof(in),
 			    &out, sizeof(out));
 
@@ -566,7 +566,7 @@ int __qcom_scm_pas_shutdown(struct device *dev, u32 peripheral)
 
 	in = cpu_to_le32(peripheral);
 	ret = qcom_scm_call(dev, QCOM_SCM_SVC_PIL,
-			    QCOM_SCM_PAS_SHUTDOWN_CMD,
+			    QCOM_SCM_PIL_PAS_SHUTDOWN,
 			    &in, sizeof(in),
 			    &out, sizeof(out));
 
@@ -579,7 +579,7 @@ int __qcom_scm_pas_mss_reset(struct device *dev, bool reset)
 	__le32 in = cpu_to_le32(reset);
 	int ret;
 
-	ret = qcom_scm_call(dev, QCOM_SCM_SVC_PIL, QCOM_SCM_PAS_MSS_RESET,
+	ret = qcom_scm_call(dev, QCOM_SCM_SVC_PIL, QCOM_SCM_PIL_PAS_MSS_RESET,
 			&in, sizeof(in),
 			&out, sizeof(out));
 
@@ -588,8 +588,8 @@ int __qcom_scm_pas_mss_reset(struct device *dev, bool reset)
 
 int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
 {
-	return qcom_scm_call_atomic2(QCOM_SCM_SVC_BOOT, QCOM_SCM_SET_DLOAD_MODE,
-				     enable ? QCOM_SCM_SET_DLOAD_MODE : 0, 0);
+	return qcom_scm_call_atomic2(QCOM_SCM_SVC_BOOT, QCOM_SCM_BOOT_SET_DLOAD_MODE,
+				     enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0, 0);
 }
 
 int __qcom_scm_set_remote_state(struct device *dev, u32 state, u32 id)
@@ -604,7 +604,7 @@ int __qcom_scm_set_remote_state(struct device *dev, u32 state, u32 id)
 	req.state = cpu_to_le32(state);
 	req.id = cpu_to_le32(id);
 
-	ret = qcom_scm_call(dev, QCOM_SCM_SVC_BOOT, QCOM_SCM_SET_REMOTE_STATE,
+	ret = qcom_scm_call(dev, QCOM_SCM_SVC_BOOT, QCOM_SCM_BOOT_SET_REMOTE_STATE,
 			    &req, sizeof(req), &scm_ret, sizeof(scm_ret));
 
 	return ret ? : le32_to_cpu(scm_ret);
@@ -629,7 +629,7 @@ int __qcom_scm_restore_sec_cfg(struct device *dev, u32 device_id,
 	cfg.id = cpu_to_le32(device_id);
 	cfg.ctx_bank_num = cpu_to_le32(spare);
 
-	ret = qcom_scm_call(dev, QCOM_SCM_SVC_MP, QCOM_SCM_RESTORE_SEC_CFG,
+	ret = qcom_scm_call(dev, QCOM_SCM_SVC_MP, QCOM_SCM_MP_RESTORE_SEC_CFG,
 			    &cfg, sizeof(cfg), &scm_ret, sizeof(scm_ret));
 
 	if (ret || scm_ret)
diff --git a/drivers/firmware/qcom_scm-64.c b/drivers/firmware/qcom_scm-64.c
index 9c7ea74..976c2b9 100644
--- a/drivers/firmware/qcom_scm-64.c
+++ b/drivers/firmware/qcom_scm-64.c
@@ -257,7 +257,7 @@ int __qcom_scm_is_call_available(struct device *dev, u32 svc_id, u32 cmd_id)
 	desc.args[0] = SCM_SMC_FNID(svc_id, cmd_id) |
 			(ARM_SMCCC_OWNER_SIP << ARM_SMCCC_OWNER_SHIFT);
 
-	ret = qcom_scm_call(dev, QCOM_SCM_SVC_INFO, QCOM_IS_CALL_AVAIL_CMD,
+	ret = qcom_scm_call(dev, QCOM_SCM_SVC_INFO, QCOM_SCM_INFO_IS_CALL_AVAIL,
 			    &desc, &res);
 
 	return ret ? : res.a1;
@@ -285,7 +285,7 @@ int __qcom_scm_hdcp_req(struct device *dev, struct qcom_scm_hdcp_req *req,
 	desc.args[9] = req[4].val;
 	desc.arginfo = QCOM_SCM_ARGS(10);
 
-	ret = qcom_scm_call(dev, QCOM_SCM_SVC_HDCP, QCOM_SCM_CMD_HDCP, &desc,
+	ret = qcom_scm_call(dev, QCOM_SCM_SVC_HDCP, QCOM_SCM_HDCP_INVOKE, &desc,
 			    &res);
 	*resp = res.a1;
 
@@ -308,11 +308,11 @@ void __qcom_scm_init(void)
 {
 	u64 cmd;
 	struct arm_smccc_res res;
-	u32 function = SCM_SMC_FNID(QCOM_SCM_SVC_INFO, QCOM_IS_CALL_AVAIL_CMD);
+	u32 fnid = SCM_SMC_FNID(QCOM_SCM_SVC_INFO, QCOM_SCM_INFO_IS_CALL_AVAIL);
 
 	/* First try a SMC64 call */
 	cmd = ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_64,
-				 ARM_SMCCC_OWNER_SIP, function);
+				 ARM_SMCCC_OWNER_SIP, fnid);
 
 	arm_smccc_smc(cmd, QCOM_SCM_ARGS(1), cmd & (~BIT(ARM_SMCCC_TYPE_SHIFT)),
 		      0, 0, 0, 0, 0, &res);
@@ -333,7 +333,7 @@ bool __qcom_scm_pas_supported(struct device *dev, u32 peripheral)
 	desc.arginfo = QCOM_SCM_ARGS(1);
 
 	ret = qcom_scm_call(dev, QCOM_SCM_SVC_PIL,
-				QCOM_SCM_PAS_IS_SUPPORTED_CMD,
+				QCOM_SCM_PIL_PAS_IS_SUPPORTED,
 				&desc, &res);
 
 	return ret ? false : !!res.a1;
@@ -350,7 +350,7 @@ int __qcom_scm_pas_init_image(struct device *dev, u32 peripheral,
 	desc.args[1] = metadata_phys;
 	desc.arginfo = QCOM_SCM_ARGS(2, QCOM_SCM_VAL, QCOM_SCM_RW);
 
-	ret = qcom_scm_call(dev, QCOM_SCM_SVC_PIL, QCOM_SCM_PAS_INIT_IMAGE_CMD,
+	ret = qcom_scm_call(dev, QCOM_SCM_SVC_PIL, QCOM_SCM_PIL_PAS_INIT_IMAGE,
 				&desc, &res);
 
 	return ret ? : res.a1;
@@ -368,7 +368,7 @@ int __qcom_scm_pas_mem_setup(struct device *dev, u32 peripheral,
 	desc.args[2] = size;
 	desc.arginfo = QCOM_SCM_ARGS(3);
 
-	ret = qcom_scm_call(dev, QCOM_SCM_SVC_PIL, QCOM_SCM_PAS_MEM_SETUP_CMD,
+	ret = qcom_scm_call(dev, QCOM_SCM_SVC_PIL, QCOM_SCM_PIL_PAS_MEM_SETUP,
 				&desc, &res);
 
 	return ret ? : res.a1;
@@ -384,7 +384,7 @@ int __qcom_scm_pas_auth_and_reset(struct device *dev, u32 peripheral)
 	desc.arginfo = QCOM_SCM_ARGS(1);
 
 	ret = qcom_scm_call(dev, QCOM_SCM_SVC_PIL,
-				QCOM_SCM_PAS_AUTH_AND_RESET_CMD,
+				QCOM_SCM_PIL_PAS_AUTH_AND_RESET,
 				&desc, &res);
 
 	return ret ? : res.a1;
@@ -399,7 +399,7 @@ int __qcom_scm_pas_shutdown(struct device *dev, u32 peripheral)
 	desc.args[0] = peripheral;
 	desc.arginfo = QCOM_SCM_ARGS(1);
 
-	ret = qcom_scm_call(dev, QCOM_SCM_SVC_PIL, QCOM_SCM_PAS_SHUTDOWN_CMD,
+	ret = qcom_scm_call(dev, QCOM_SCM_SVC_PIL, QCOM_SCM_PIL_PAS_SHUTDOWN,
 			&desc, &res);
 
 	return ret ? : res.a1;
@@ -415,7 +415,7 @@ int __qcom_scm_pas_mss_reset(struct device *dev, bool reset)
 	desc.args[1] = 0;
 	desc.arginfo = QCOM_SCM_ARGS(2);
 
-	ret = qcom_scm_call(dev, QCOM_SCM_SVC_PIL, QCOM_SCM_PAS_MSS_RESET, &desc,
+	ret = qcom_scm_call(dev, QCOM_SCM_SVC_PIL, QCOM_SCM_PIL_PAS_MSS_RESET, &desc,
 			    &res);
 
 	return ret ? : res.a1;
@@ -431,7 +431,7 @@ int __qcom_scm_set_remote_state(struct device *dev, u32 state, u32 id)
 	desc.args[1] = id;
 	desc.arginfo = QCOM_SCM_ARGS(2);
 
-	ret = qcom_scm_call(dev, QCOM_SCM_SVC_BOOT, QCOM_SCM_SET_REMOTE_STATE,
+	ret = qcom_scm_call(dev, QCOM_SCM_SVC_BOOT, QCOM_SCM_BOOT_SET_REMOTE_STATE,
 			    &desc, &res);
 
 	return ret ? : res.a1;
@@ -458,7 +458,7 @@ int __qcom_scm_assign_mem(struct device *dev, phys_addr_t mem_region,
 				     QCOM_SCM_VAL, QCOM_SCM_VAL);
 
 	ret = qcom_scm_call(dev, QCOM_SCM_SVC_MP,
-			    QCOM_MEM_PROT_ASSIGN_ID,
+			    QCOM_SCM_MP_ASSIGN,
 			    &desc, &res);
 
 	return ret ? : res.a1;
@@ -474,7 +474,7 @@ int __qcom_scm_restore_sec_cfg(struct device *dev, u32 device_id, u32 spare)
 	desc.args[1] = spare;
 	desc.arginfo = QCOM_SCM_ARGS(2);
 
-	ret = qcom_scm_call(dev, QCOM_SCM_SVC_MP, QCOM_SCM_RESTORE_SEC_CFG,
+	ret = qcom_scm_call(dev, QCOM_SCM_SVC_MP, QCOM_SCM_MP_RESTORE_SEC_CFG,
 			    &desc, &res);
 
 	return ret ? : res.a1;
@@ -491,7 +491,7 @@ int __qcom_scm_iommu_secure_ptbl_size(struct device *dev, u32 spare,
 	desc.arginfo = QCOM_SCM_ARGS(1);
 
 	ret = qcom_scm_call(dev, QCOM_SCM_SVC_MP,
-			    QCOM_SCM_IOMMU_SECURE_PTBL_SIZE, &desc, &res);
+			    QCOM_SCM_MP_IOMMU_SECURE_PTBL_SIZE, &desc, &res);
 
 	if (size)
 		*size = res.a1;
@@ -513,7 +513,7 @@ int __qcom_scm_iommu_secure_ptbl_init(struct device *dev, u64 addr, u32 size,
 				     QCOM_SCM_VAL);
 
 	ret = qcom_scm_call(dev, QCOM_SCM_SVC_MP,
-			    QCOM_SCM_IOMMU_SECURE_PTBL_INIT, &desc, &res);
+			    QCOM_SCM_MP_IOMMU_SECURE_PTBL_INIT, &desc, &res);
 
 	/* the pg table has been initialized already, ignore the error */
 	if (ret == -EPERM)
@@ -527,11 +527,11 @@ int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
 	struct qcom_scm_desc desc = {0};
 	struct arm_smccc_res res;
 
-	desc.args[0] = QCOM_SCM_SET_DLOAD_MODE;
-	desc.args[1] = enable ? QCOM_SCM_SET_DLOAD_MODE : 0;
+	desc.args[0] = QCOM_SCM_BOOT_SET_DLOAD_MODE;
+	desc.args[1] = enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0;
 	desc.arginfo = QCOM_SCM_ARGS(2);
 
-	return qcom_scm_call(dev, QCOM_SCM_SVC_BOOT, QCOM_SCM_SET_DLOAD_MODE,
+	return qcom_scm_call(dev, QCOM_SCM_SVC_BOOT, QCOM_SCM_BOOT_SET_DLOAD_MODE,
 			     &desc, &res);
 }
 
@@ -571,10 +571,10 @@ int __qcom_scm_qsmmu500_wait_safe_toggle(struct device *dev, bool en)
 	struct qcom_scm_desc desc = {0};
 	struct arm_smccc_res res;
 
-	desc.args[0] = QCOM_SCM_CONFIG_ERRATA1_CLIENT_ALL;
+	desc.args[0] = QCOM_SCM_SMMU_CONFIG_ERRATA1_CLIENT_ALL;
 	desc.args[1] = en;
 	desc.arginfo = QCOM_SCM_ARGS(2);
 
 	return qcom_scm_call_atomic(dev, QCOM_SCM_SVC_SMMU_PROGRAM,
-				    QCOM_SCM_CONFIG_ERRATA1, &desc, &res);
+				    QCOM_SCM_SMMU_CONFIG_ERRATA1, &desc, &res);
 }
diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 1ba0df4..097f8b3 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -1,8 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/*
- * Qualcomm SCM driver
- *
- * Copyright (c) 2010,2015, The Linux Foundation. All rights reserved.
+/* Copyright (c) 2010,2015,2019 The Linux Foundation. All rights reserved.
  * Copyright (C) 2015 Linaro Ltd.
  */
 #include <linux/platform_device.h>
@@ -142,7 +139,7 @@ bool qcom_scm_hdcp_available(void)
 		return ret;
 
 	ret = __qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_HDCP,
-						QCOM_SCM_CMD_HDCP);
+						QCOM_SCM_HDCP_INVOKE);
 
 	qcom_scm_clk_disable();
 
@@ -183,7 +180,7 @@ bool qcom_scm_pas_supported(u32 peripheral)
 	int ret;
 
 	ret = __qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_PIL,
-					   QCOM_SCM_PAS_IS_SUPPORTED_CMD);
+					   QCOM_SCM_PIL_PAS_IS_SUPPORTED);
 	if (ret <= 0)
 		return false;
 
@@ -196,7 +193,7 @@ EXPORT_SYMBOL(qcom_scm_pas_supported);
  */
 bool qcom_scm_ocmem_lock_available(void)
 {
-	return __qcom_scm_is_call_available(__scm->dev, QCOM_SCM_OCMEM_SVC,
+	return __qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_OCMEM,
 					    QCOM_SCM_OCMEM_LOCK_CMD);
 }
 EXPORT_SYMBOL(qcom_scm_ocmem_lock_available);
@@ -376,7 +373,7 @@ static const struct reset_control_ops qcom_scm_pas_reset_ops = {
 bool qcom_scm_restore_sec_cfg_available(void)
 {
 	return __qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_MP,
-					    QCOM_SCM_RESTORE_SEC_CFG);
+					    QCOM_SCM_MP_RESTORE_SEC_CFG);
 }
 EXPORT_SYMBOL(qcom_scm_restore_sec_cfg_available);
 
@@ -423,12 +420,12 @@ static void qcom_scm_set_download_mode(bool enable)
 
 	avail = __qcom_scm_is_call_available(__scm->dev,
 					     QCOM_SCM_SVC_BOOT,
-					     QCOM_SCM_SET_DLOAD_MODE);
+					     QCOM_SCM_BOOT_SET_DLOAD_MODE);
 	if (avail) {
 		ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
 	} else if (__scm->dload_mode_addr) {
 		ret = __qcom_scm_io_writel(__scm->dev, __scm->dload_mode_addr,
-					   enable ? QCOM_SCM_SET_DLOAD_MODE : 0);
+					   enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0);
 	} else {
 		dev_err(__scm->dev,
 			"No available mechanism for setting download mode\n");
diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
index 81dcf5f..afcca16 100644
--- a/drivers/firmware/qcom_scm.h
+++ b/drivers/firmware/qcom_scm.h
@@ -1,27 +1,22 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/* Copyright (c) 2010-2015, The Linux Foundation. All rights reserved.
+/* Copyright (c) 2010-2015,2019 The Linux Foundation. All rights reserved.
  */
 #ifndef __QCOM_SCM_INT_H
 #define __QCOM_SCM_INT_H
 
 #define QCOM_SCM_SVC_BOOT		0x1
-#define QCOM_SCM_BOOT_ADDR		0x1
-#define QCOM_SCM_SET_DLOAD_MODE		0x10
-#define QCOM_SCM_BOOT_ADDR_MC		0x11
-#define QCOM_SCM_SET_REMOTE_STATE	0xa
+#define QCOM_SCM_BOOT_SET_ADDR		0x1
+#define QCOM_SCM_BOOT_SET_DLOAD_MODE		0x10
+#define QCOM_SCM_BOOT_SET_REMOTE_STATE	0xa
 extern int __qcom_scm_set_remote_state(struct device *dev, u32 state, u32 id);
 extern int __qcom_scm_set_dload_mode(struct device *dev, bool enable);
 
-#define QCOM_SCM_FLAG_HLOS		0x01
-#define QCOM_SCM_FLAG_COLDBOOT_MC	0x02
-#define QCOM_SCM_FLAG_WARMBOOT_MC	0x04
 extern int __qcom_scm_set_warm_boot_addr(struct device *dev, void *entry,
 		const cpumask_t *cpus);
 extern int __qcom_scm_set_cold_boot_addr(void *entry, const cpumask_t *cpus);
 
-#define QCOM_SCM_CMD_TERMINATE_PC	0x2
+#define QCOM_SCM_BOOT_TERMINATE_PC	0x2
 #define QCOM_SCM_FLUSH_FLAG_MASK	0x3
-#define QCOM_SCM_CMD_CORE_HOTPLUGGED	0x10
 extern void __qcom_scm_cpu_power_down(u32 flags);
 
 #define QCOM_SCM_SVC_IO			0x5
@@ -31,18 +26,18 @@ extern int __qcom_scm_io_readl(struct device *dev, phys_addr_t addr, unsigned in
 extern int __qcom_scm_io_writel(struct device *dev, phys_addr_t addr, unsigned int val);
 
 #define QCOM_SCM_SVC_INFO		0x6
-#define QCOM_IS_CALL_AVAIL_CMD		0x1
+#define QCOM_SCM_INFO_IS_CALL_AVAIL	0x1
 extern int __qcom_scm_is_call_available(struct device *dev, u32 svc_id,
 		u32 cmd_id);
 
 #define QCOM_SCM_SVC_HDCP		0x11
-#define QCOM_SCM_CMD_HDCP		0x01
+#define QCOM_SCM_HDCP_INVOKE		0x01
 extern int __qcom_scm_hdcp_req(struct device *dev,
 		struct qcom_scm_hdcp_req *req, u32 req_cnt, u32 *resp);
 
 extern void __qcom_scm_init(void);
 
-#define QCOM_SCM_OCMEM_SVC			0xf
+#define QCOM_SCM_SVC_OCMEM			0xf
 #define QCOM_SCM_OCMEM_LOCK_CMD		0x1
 #define QCOM_SCM_OCMEM_UNLOCK_CMD		0x2
 
@@ -52,12 +47,12 @@ extern int __qcom_scm_ocmem_unlock(struct device *dev, u32 id, u32 offset,
 				   u32 size);
 
 #define QCOM_SCM_SVC_PIL		0x2
-#define QCOM_SCM_PAS_INIT_IMAGE_CMD	0x1
-#define QCOM_SCM_PAS_MEM_SETUP_CMD	0x2
-#define QCOM_SCM_PAS_AUTH_AND_RESET_CMD	0x5
-#define QCOM_SCM_PAS_SHUTDOWN_CMD	0x6
-#define QCOM_SCM_PAS_IS_SUPPORTED_CMD	0x7
-#define QCOM_SCM_PAS_MSS_RESET		0xa
+#define QCOM_SCM_PIL_PAS_INIT_IMAGE	0x1
+#define QCOM_SCM_PIL_PAS_MEM_SETUP	0x2
+#define QCOM_SCM_PIL_PAS_AUTH_AND_RESET	0x5
+#define QCOM_SCM_PIL_PAS_SHUTDOWN	0x6
+#define QCOM_SCM_PIL_PAS_IS_SUPPORTED	0x7
+#define QCOM_SCM_PIL_PAS_MSS_RESET		0xa
 extern bool __qcom_scm_pas_supported(struct device *dev, u32 peripheral);
 extern int  __qcom_scm_pas_init_image(struct device *dev, u32 peripheral,
 		dma_addr_t metadata_phys);
@@ -95,21 +90,21 @@ static inline int qcom_scm_remap_error(int err)
 }
 
 #define QCOM_SCM_SVC_MP			0xc
-#define QCOM_SCM_RESTORE_SEC_CFG	2
+#define QCOM_SCM_MP_RESTORE_SEC_CFG	2
 extern int __qcom_scm_restore_sec_cfg(struct device *dev, u32 device_id,
 				      u32 spare);
-#define QCOM_SCM_IOMMU_SECURE_PTBL_SIZE	3
-#define QCOM_SCM_IOMMU_SECURE_PTBL_INIT	4
+#define QCOM_SCM_MP_IOMMU_SECURE_PTBL_SIZE	3
+#define QCOM_SCM_MP_IOMMU_SECURE_PTBL_INIT	4
 #define QCOM_SCM_SVC_SMMU_PROGRAM	0x15
-#define QCOM_SCM_CONFIG_ERRATA1		0x3
-#define QCOM_SCM_CONFIG_ERRATA1_CLIENT_ALL	0x2
+#define QCOM_SCM_SMMU_CONFIG_ERRATA1		0x3
+#define QCOM_SCM_SMMU_CONFIG_ERRATA1_CLIENT_ALL	0x2
 extern int __qcom_scm_iommu_secure_ptbl_size(struct device *dev, u32 spare,
 					     size_t *size);
 extern int __qcom_scm_iommu_secure_ptbl_init(struct device *dev, u64 addr,
 					     u32 size, u32 spare);
 extern int __qcom_scm_qsmmu500_wait_safe_toggle(struct device *dev,
 						bool enable);
-#define QCOM_MEM_PROT_ASSIGN_ID	0x16
+#define QCOM_SCM_MP_ASSIGN	0x16
 extern int  __qcom_scm_assign_mem(struct device *dev,
 				  phys_addr_t mem_region, size_t mem_sz,
 				  phys_addr_t src, size_t src_sz,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

