Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38E68133353
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 22:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbgAGVFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 16:05:12 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:13912 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729173AbgAGVFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:05:04 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1578431103; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=ZvHFSezhpPkxviiWSmO3GLxrJ3vHqxlRy7hTlIF72sI=; b=neB5hha2YG6zb7lUhw96hvgPMfARdncdQBtsjOWlNEG1P6xDhsKbiswgS7wmShYeHDtKkiHy
 m+p5Lj9oWwZZ8YmuI0jBbxvzryYoXQN6acJubUEIo5ViVNh4VcG6vxEjfLaOs4/32jnVAK0l
 OM8ZWjc5YKfGTXKGimdWHQa7FjQ=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e14f27b.7f342b967a40-smtp-out-n02;
 Tue, 07 Jan 2020 21:04:59 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4D778C447AA; Tue,  7 Jan 2020 21:04:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from eberman-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: eberman)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AFA4FC447B2;
        Tue,  7 Jan 2020 21:04:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AFA4FC447B2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=eberman@codeaurora.org
From:   Elliot Berman <eberman@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>, agross@kernel.org,
        swboyd@chromium.org, Stephan Gerhold <stephan@gerhold.net>
Cc:     Elliot Berman <eberman@codeaurora.org>,
        saiprakash.ranjan@codeaurora.org, tsoni@codeaurora.org,
        sidgup@codeaurora.org, psodagud@codeaurora.org,
        Brian Masney <masneyb@onstation.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 16/17] firmware: qcom_scm: Remove thin wrappers
Date:   Tue,  7 Jan 2020 13:04:25 -0800
Message-Id: <1578431066-19600-17-git-send-email-eberman@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578431066-19600-1-git-send-email-eberman@codeaurora.org>
References: <1578431066-19600-1-git-send-email-eberman@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qcom_scm-32 and qcom_scm-64 implementations are nearly identical, so
make qcom_scm_call and qcom_scm_call_atomic unique to each and the SCM
descriptor creation common to each. There are the following catches:
- __qcom_scm_is_call_available is still in each -32,-64 implementation
  as the argument is unique to each convention
- For some functions, only one implementation was provided in -32 or
  -64. The actual implementation was moved into qcom_scm.c
- io_writel and io_readl in -64 were non-atomic calls and in -32 they
  were. Atomic is the better option, so use it.

Change-Id: Iecc28c4a7afef2fc39c7da207c8f53f27447727e
Tested-by: Brian Masney <masneyb@onstation.org> # arm32
Tested-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Elliot Berman <eberman@codeaurora.org>
---
 drivers/firmware/qcom_scm-32.c | 461 +----------------------------------------
 drivers/firmware/qcom_scm-64.c | 434 +-------------------------------------
 drivers/firmware/qcom_scm.c    | 394 ++++++++++++++++++++++++++++++++---
 drivers/firmware/qcom_scm.h    |  87 ++++----
 4 files changed, 428 insertions(+), 948 deletions(-)

diff --git a/drivers/firmware/qcom_scm-32.c b/drivers/firmware/qcom_scm-32.c
index e9b396c..08220e7 100644
--- a/drivers/firmware/qcom_scm-32.c
+++ b/drivers/firmware/qcom_scm-32.c
@@ -15,75 +15,8 @@
 
 #include "qcom_scm.h"
 
-#define QCOM_SCM_FLAG_COLDBOOT_CPU0	0x00
-#define QCOM_SCM_FLAG_COLDBOOT_CPU1	0x01
-#define QCOM_SCM_FLAG_COLDBOOT_CPU2	0x08
-#define QCOM_SCM_FLAG_COLDBOOT_CPU3	0x20
-
-#define QCOM_SCM_FLAG_WARMBOOT_CPU0	0x04
-#define QCOM_SCM_FLAG_WARMBOOT_CPU1	0x02
-#define QCOM_SCM_FLAG_WARMBOOT_CPU2	0x10
-#define QCOM_SCM_FLAG_WARMBOOT_CPU3	0x40
-
-struct qcom_scm_entry {
-	int flag;
-	void *entry;
-};
-
-static struct qcom_scm_entry qcom_scm_wb[] = {
-	{ .flag = QCOM_SCM_FLAG_WARMBOOT_CPU0 },
-	{ .flag = QCOM_SCM_FLAG_WARMBOOT_CPU1 },
-	{ .flag = QCOM_SCM_FLAG_WARMBOOT_CPU2 },
-	{ .flag = QCOM_SCM_FLAG_WARMBOOT_CPU3 },
-};
-
 static DEFINE_MUTEX(qcom_scm_lock);
 
-#define MAX_QCOM_SCM_ARGS 10
-#define MAX_QCOM_SCM_RETS 3
-
-enum qcom_scm_arg_types {
-	QCOM_SCM_VAL,
-	QCOM_SCM_RO,
-	QCOM_SCM_RW,
-	QCOM_SCM_BUFVAL,
-};
-
-#define QCOM_SCM_ARGS_IMPL(num, a, b, c, d, e, f, g, h, i, j, ...) (\
-			   (((a) & 0x3) << 4) | \
-			   (((b) & 0x3) << 6) | \
-			   (((c) & 0x3) << 8) | \
-			   (((d) & 0x3) << 10) | \
-			   (((e) & 0x3) << 12) | \
-			   (((f) & 0x3) << 14) | \
-			   (((g) & 0x3) << 16) | \
-			   (((h) & 0x3) << 18) | \
-			   (((i) & 0x3) << 20) | \
-			   (((j) & 0x3) << 22) | \
-			   ((num) & 0xf))
-
-#define QCOM_SCM_ARGS(...) QCOM_SCM_ARGS_IMPL(__VA_ARGS__, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
-
-/**
- * struct qcom_scm_desc
- * @arginfo:	Metadata describing the arguments in args[]
- * @args:	The array of arguments for the secure syscall
- */
-struct qcom_scm_desc {
-	u32 svc;
-	u32 cmd;
-	u32 arginfo;
-	u64 args[MAX_QCOM_SCM_ARGS];
-	u32 owner;
-};
-
-/**
- * struct qcom_scm_res
- * @result:	The values returned by the secure syscall
- */
-struct qcom_scm_res {
-	u64 result[MAX_QCOM_SCM_RETS];
-};
 
 /**
  * struct arm_smccc_args
@@ -196,7 +129,7 @@ static void __scm_legacy_do(const struct arm_smccc_args *smc,
  * and response buffers is taken care of by qcom_scm_call; however, callers are
  * responsible for any other cached buffers passed over to the secure world.
  */
-static int qcom_scm_call(struct device *dev, const struct qcom_scm_desc *desc,
+int qcom_scm_call(struct device *dev, const struct qcom_scm_desc *desc,
 			 struct qcom_scm_res *res)
 {
 	u8 arglen = desc->arginfo & 0xf;
@@ -285,9 +218,9 @@ static int qcom_scm_call(struct device *dev, const struct qcom_scm_desc *desc,
  * This shall only be used with commands that are guaranteed to be
  * uninterruptable, atomic and SMP safe.
  */
-static int qcom_scm_call_atomic(struct device *unused,
-				const struct qcom_scm_desc *desc,
-				struct qcom_scm_res *res)
+int qcom_scm_call_atomic(struct device *unused,
+			 const struct qcom_scm_desc *desc,
+			 struct qcom_scm_res *res)
 {
 	int context_id;
 	struct arm_smccc_res smc_res;
@@ -309,113 +242,6 @@ static int qcom_scm_call_atomic(struct device *unused,
 	return smc_res.a0;
 }
 
-/**
- * qcom_scm_set_cold_boot_addr() - Set the cold boot address for cpus
- * @entry: Entry point function for the cpus
- * @cpus: The cpumask of cpus that will use the entry point
- *
- * Set the cold boot address of the cpus. Any cpu outside the supported
- * range would be removed from the cpu present mask.
- */
-int __qcom_scm_set_cold_boot_addr(struct device *dev, void *entry,
-				  const cpumask_t *cpus)
-{
-	int flags = 0;
-	int cpu;
-	int scm_cb_flags[] = {
-		QCOM_SCM_FLAG_COLDBOOT_CPU0,
-		QCOM_SCM_FLAG_COLDBOOT_CPU1,
-		QCOM_SCM_FLAG_COLDBOOT_CPU2,
-		QCOM_SCM_FLAG_COLDBOOT_CPU3,
-	};
-	struct qcom_scm_desc desc = {
-		.svc = QCOM_SCM_SVC_BOOT,
-		.cmd = QCOM_SCM_BOOT_SET_ADDR,
-	};
-
-	if (!cpus || (cpus && cpumask_empty(cpus)))
-		return -EINVAL;
-
-	for_each_cpu(cpu, cpus) {
-		if (cpu < ARRAY_SIZE(scm_cb_flags))
-			flags |= scm_cb_flags[cpu];
-		else
-			set_cpu_present(cpu, false);
-	}
-
-	desc.args[0] = flags;
-	desc.args[1] = virt_to_phys(entry);
-	desc.arginfo = QCOM_SCM_ARGS(2);
-
-	return qcom_scm_call_atomic(dev, &desc, NULL);
-}
-
-/**
- * qcom_scm_set_warm_boot_addr() - Set the warm boot address for cpus
- * @entry: Entry point function for the cpus
- * @cpus: The cpumask of cpus that will use the entry point
- *
- * Set the Linux entry point for the SCM to transfer control to when coming
- * out of a power down. CPU power down may be executed on cpuidle or hotplug.
- */
-int __qcom_scm_set_warm_boot_addr(struct device *dev, void *entry,
-				  const cpumask_t *cpus)
-{
-	int ret;
-	int flags = 0;
-	int cpu;
-	struct qcom_scm_desc desc = {
-		.svc = QCOM_SCM_SVC_BOOT,
-		.cmd = QCOM_SCM_BOOT_SET_ADDR,
-	};
-
-	/*
-	 * Reassign only if we are switching from hotplug entry point
-	 * to cpuidle entry point or vice versa.
-	 */
-	for_each_cpu(cpu, cpus) {
-		if (entry == qcom_scm_wb[cpu].entry)
-			continue;
-		flags |= qcom_scm_wb[cpu].flag;
-	}
-
-	/* No change in entry function */
-	if (!flags)
-		return 0;
-
-	desc.args[0] = flags;
-	desc.args[1] = virt_to_phys(entry);
-	desc.arginfo = QCOM_SCM_ARGS(2);
-
-	ret = qcom_scm_call(dev, &desc, NULL);
-	if (!ret) {
-		for_each_cpu(cpu, cpus)
-			qcom_scm_wb[cpu].entry = entry;
-	}
-
-	return ret;
-}
-
-/**
- * qcom_scm_cpu_power_down() - Power down the cpu
- * @flags - Flags to flush cache
- *
- * This is an end point to power down cpu. If there was a pending interrupt,
- * the control would return from this function, otherwise, the cpu jumps to the
- * warm boot entry point set for this cpu upon reset.
- */
-void __qcom_scm_cpu_power_down(struct device *dev, u32 flags)
-{
-	struct qcom_scm_desc desc = {
-		.svc = QCOM_SCM_SVC_BOOT,
-		.cmd = QCOM_SCM_BOOT_TERMINATE_PC,
-		.args[0] = flags & QCOM_SCM_FLUSH_FLAG_MASK,
-		.arginfo = QCOM_SCM_ARGS(1),
-	};
-
-	qcom_scm_call_atomic(dev, &desc, NULL);
-}
-
 int __qcom_scm_is_call_available(struct device *dev, u32 svc_id, u32 cmd_id)
 {
 	int ret;
@@ -432,285 +258,6 @@ int __qcom_scm_is_call_available(struct device *dev, u32 svc_id, u32 cmd_id)
 	return ret ? : res.result[0];
 }
 
-int __qcom_scm_hdcp_req(struct device *dev, struct qcom_scm_hdcp_req *req,
-			u32 req_cnt, u32 *resp)
-{
-	int ret;
-	struct qcom_scm_desc desc = {
-		.svc = QCOM_SCM_SVC_HDCP,
-		.cmd = QCOM_SCM_HDCP_INVOKE,
-	};
-	struct qcom_scm_res res;
-
-	if (req_cnt > QCOM_SCM_HDCP_MAX_REQ_CNT)
-		return -ERANGE;
-
-	desc.args[0] = req[0].addr;
-	desc.args[1] = req[0].val;
-	desc.args[2] = req[1].addr;
-	desc.args[3] = req[1].val;
-	desc.args[4] = req[2].addr;
-	desc.args[5] = req[2].val;
-	desc.args[6] = req[3].addr;
-	desc.args[7] = req[3].val;
-	desc.args[8] = req[4].addr;
-	desc.args[9] = req[4].val;
-	desc.arginfo = QCOM_SCM_ARGS(10);
-
-	ret = qcom_scm_call(dev, &desc, &res);
-	*resp = res.result[0];
-
-	return ret;
-}
-
-int __qcom_scm_ocmem_lock(struct device *dev, u32 id, u32 offset, u32 size,
-			  u32 mode)
-{
-	struct qcom_scm_desc desc = {
-		.svc = QCOM_SCM_SVC_OCMEM,
-		.cmd = QCOM_SCM_OCMEM_LOCK_CMD,
-	};
-
-	desc.args[0] = id;
-	desc.args[1] = offset;
-	desc.args[2] = size;
-	desc.args[3] = mode;
-	desc.arginfo = QCOM_SCM_ARGS(4);
-
-	return qcom_scm_call(dev, &desc, NULL);
-}
-
-int __qcom_scm_ocmem_unlock(struct device *dev, u32 id, u32 offset, u32 size)
-{
-	struct qcom_scm_desc desc = {
-		.svc = QCOM_SCM_SVC_OCMEM,
-		.cmd = QCOM_SCM_OCMEM_UNLOCK_CMD,
-	};
-
-	desc.args[0] = id;
-	desc.args[1] = offset;
-	desc.args[2] = size;
-	desc.arginfo = QCOM_SCM_ARGS(3);
-
-	return qcom_scm_call(dev, &desc, NULL);
-}
-
 void __qcom_scm_init(void)
 {
 }
-
-bool __qcom_scm_pas_supported(struct device *dev, u32 peripheral)
-{
-	int ret;
-	struct qcom_scm_desc desc = {
-		.svc = QCOM_SCM_SVC_PIL,
-		.cmd = QCOM_SCM_PIL_PAS_IS_SUPPORTED,
-	};
-	struct qcom_scm_res res;
-
-	desc.args[0] = peripheral;
-	desc.arginfo = QCOM_SCM_ARGS(1);
-
-	ret = qcom_scm_call(dev, &desc, &res);
-
-	return ret ? false : !!res.result[0];
-}
-
-int __qcom_scm_pas_init_image(struct device *dev, u32 peripheral,
-			      dma_addr_t metadata_phys)
-{
-	int ret;
-	struct qcom_scm_desc desc = {
-		.svc = QCOM_SCM_SVC_PIL,
-		.cmd = QCOM_SCM_PIL_PAS_INIT_IMAGE,
-	};
-	struct qcom_scm_res res;
-
-	desc.args[0] = peripheral;
-	desc.args[1] = metadata_phys;
-	desc.arginfo = QCOM_SCM_ARGS(2, QCOM_SCM_VAL, QCOM_SCM_RW);
-
-	ret = qcom_scm_call(dev, &desc, &res);
-
-	return ret ? : res.result[0];
-}
-
-int __qcom_scm_pas_mem_setup(struct device *dev, u32 peripheral,
-			      phys_addr_t addr, phys_addr_t size)
-{
-	int ret;
-	struct qcom_scm_desc desc = {
-		.svc = QCOM_SCM_SVC_PIL,
-		.cmd = QCOM_SCM_PIL_PAS_MEM_SETUP,
-	};
-	struct qcom_scm_res res;
-
-	desc.args[0] = peripheral;
-	desc.args[1] = addr;
-	desc.args[2] = size;
-	desc.arginfo = QCOM_SCM_ARGS(3);
-
-	ret = qcom_scm_call(dev, &desc, &res);
-
-	return ret ? : res.result[0];
-}
-
-int __qcom_scm_pas_auth_and_reset(struct device *dev, u32 peripheral)
-{
-	int ret;
-	struct qcom_scm_desc desc = {
-		.svc = QCOM_SCM_SVC_PIL,
-		.cmd = QCOM_SCM_PIL_PAS_AUTH_AND_RESET,
-	};
-	struct qcom_scm_res res;
-
-	desc.args[0] = peripheral;
-	desc.arginfo = QCOM_SCM_ARGS(1);
-
-	ret = qcom_scm_call(dev, &desc, &res);
-
-	return ret ? : res.result[0];
-}
-
-int __qcom_scm_pas_shutdown(struct device *dev, u32 peripheral)
-{
-	int ret;
-	struct qcom_scm_desc desc = {
-		.svc = QCOM_SCM_SVC_PIL,
-		.cmd = QCOM_SCM_PIL_PAS_SHUTDOWN,
-	};
-	struct qcom_scm_res res;
-
-	desc.args[0] = peripheral;
-	desc.arginfo = QCOM_SCM_ARGS(1);
-
-	ret = qcom_scm_call(dev, &desc, &res);
-
-	return ret ? : res.result[0];
-}
-
-int __qcom_scm_pas_mss_reset(struct device *dev, bool reset)
-{
-	struct qcom_scm_desc desc = {
-		.svc = QCOM_SCM_SVC_PIL,
-		.cmd = QCOM_SCM_PIL_PAS_MSS_RESET,
-	};
-	struct qcom_scm_res res;
-	int ret;
-
-	desc.args[0] = reset;
-	desc.args[1] = 0;
-	desc.arginfo = QCOM_SCM_ARGS(2);
-
-	ret = qcom_scm_call(dev, &desc, &res);
-
-	return ret ? : res.result[0];
-}
-
-int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
-{
-	struct qcom_scm_desc desc = {
-		.svc = QCOM_SCM_SVC_BOOT,
-		.cmd = QCOM_SCM_BOOT_SET_DLOAD_MODE,
-	};
-
-	desc.args[0] = QCOM_SCM_BOOT_SET_DLOAD_MODE;
-	desc.args[1] = enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0;
-	desc.arginfo = QCOM_SCM_ARGS(2);
-
-	return qcom_scm_call_atomic(dev, &desc, NULL);
-}
-
-int __qcom_scm_set_remote_state(struct device *dev, u32 state, u32 id)
-{
-	struct qcom_scm_desc desc = {
-		.svc = QCOM_SCM_SVC_BOOT,
-		.cmd = QCOM_SCM_BOOT_SET_REMOTE_STATE,
-	};
-	struct qcom_scm_res res;
-	int ret;
-
-	desc.args[0] = state;
-	desc.args[1] = id;
-
-	ret = qcom_scm_call(dev, &desc, &res);
-
-	return ret ? : res.result[0];
-}
-
-int __qcom_scm_assign_mem(struct device *dev, phys_addr_t mem_region,
-			  size_t mem_sz, phys_addr_t src, size_t src_sz,
-			  phys_addr_t dest, size_t dest_sz)
-{
-	return -ENODEV;
-}
-
-int __qcom_scm_restore_sec_cfg(struct device *dev, u32 device_id,
-			       u32 spare)
-{
-	struct qcom_scm_desc desc = {
-		.svc = QCOM_SCM_SVC_MP,
-		.cmd = QCOM_SCM_MP_RESTORE_SEC_CFG,
-	};
-	struct qcom_scm_res res;
-	int ret;
-
-	desc.args[0] = device_id;
-	desc.args[1] = spare;
-	desc.arginfo = QCOM_SCM_ARGS(2);
-
-	ret = qcom_scm_call(dev, &desc, &res);
-
-	return ret ? : res.result[0];
-}
-
-int __qcom_scm_iommu_secure_ptbl_size(struct device *dev, u32 spare,
-				      size_t *size)
-{
-	return -ENODEV;
-}
-
-int __qcom_scm_iommu_secure_ptbl_init(struct device *dev, u64 addr, u32 size,
-				      u32 spare)
-{
-	return -ENODEV;
-}
-
-int __qcom_scm_io_readl(struct device *dev, phys_addr_t addr,
-			unsigned int *val)
-{
-	int ret;
-	struct qcom_scm_desc desc = {
-		.svc = QCOM_SCM_SVC_IO,
-		.cmd = QCOM_SCM_IO_READ,
-	};
-	struct qcom_scm_res res;
-
-	desc.args[0] = addr;
-	desc.arginfo = QCOM_SCM_ARGS(1);
-
-	ret = qcom_scm_call_atomic(dev, &desc, &res);
-	if (ret >= 0)
-		*val = res.result[0];
-
-	return ret < 0 ? ret : 0;
-}
-
-int __qcom_scm_io_writel(struct device *dev, phys_addr_t addr, unsigned int val)
-{
-	struct qcom_scm_desc desc = {
-		.svc = QCOM_SCM_SVC_IO,
-		.cmd = QCOM_SCM_IO_WRITE,
-	};
-
-	desc.args[0] = addr;
-	desc.args[1] = val;
-	desc.arginfo = QCOM_SCM_ARGS(2);
-
-	return qcom_scm_call_atomic(dev, &desc, NULL);
-}
-
-int __qcom_scm_qsmmu500_wait_safe_toggle(struct device *dev, bool enable)
-{
-	return -ENODEV;
-}
diff --git a/drivers/firmware/qcom_scm-64.c b/drivers/firmware/qcom_scm-64.c
index 9507047..4defc7c 100644
--- a/drivers/firmware/qcom_scm-64.c
+++ b/drivers/firmware/qcom_scm-64.c
@@ -16,52 +16,6 @@
 
 #define SCM_SMC_FNID(s, c) ((((s) & 0xFF) << 8) | ((c) & 0xFF))
 
-#define MAX_QCOM_SCM_ARGS 10
-#define MAX_QCOM_SCM_RETS 3
-
-enum qcom_scm_arg_types {
-	QCOM_SCM_VAL,
-	QCOM_SCM_RO,
-	QCOM_SCM_RW,
-	QCOM_SCM_BUFVAL,
-};
-
-#define QCOM_SCM_ARGS_IMPL(num, a, b, c, d, e, f, g, h, i, j, ...) (\
-			   (((a) & 0x3) << 4) | \
-			   (((b) & 0x3) << 6) | \
-			   (((c) & 0x3) << 8) | \
-			   (((d) & 0x3) << 10) | \
-			   (((e) & 0x3) << 12) | \
-			   (((f) & 0x3) << 14) | \
-			   (((g) & 0x3) << 16) | \
-			   (((h) & 0x3) << 18) | \
-			   (((i) & 0x3) << 20) | \
-			   (((j) & 0x3) << 22) | \
-			   ((num) & 0xf))
-
-#define QCOM_SCM_ARGS(...) QCOM_SCM_ARGS_IMPL(__VA_ARGS__, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
-
-/**
- * struct qcom_scm_desc
- * @arginfo:	Metadata describing the arguments in args[]
- * @args:	The array of arguments for the secure syscall
- */
-struct qcom_scm_desc {
-	u32 svc;
-	u32 cmd;
-	u32 arginfo;
-	u64 args[MAX_QCOM_SCM_ARGS];
-	u32 owner;
-};
-
-/**
- * struct qcom_scm_res
- * @result:	The values returned by the secure syscall
- */
-struct qcom_scm_res {
-	u64 result[MAX_QCOM_SCM_RETS];
-};
-
 /**
  * struct arm_smccc_args
  * @args:	The array of values used in registers in smc instruction
@@ -206,8 +160,8 @@ static int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
  * Sends a command to the SCM and waits for the command to finish processing.
  * This should *only* be called in pre-emptible context.
  */
-static int qcom_scm_call(struct device *dev, const struct qcom_scm_desc *desc,
-			 struct qcom_scm_res *res)
+int qcom_scm_call(struct device *dev, const struct qcom_scm_desc *desc,
+		  struct qcom_scm_res *res)
 {
 	might_sleep();
 	return __scm_smc_call(dev, desc, res, false);
@@ -224,54 +178,12 @@ static int qcom_scm_call(struct device *dev, const struct qcom_scm_desc *desc,
  * Sends a command to the SCM and waits for the command to finish processing.
  * This can be called in atomic context.
  */
-static int qcom_scm_call_atomic(struct device *dev,
-				const struct qcom_scm_desc *desc,
-				struct qcom_scm_res *res)
+int qcom_scm_call_atomic(struct device *dev, const struct qcom_scm_desc *desc,
+			 struct qcom_scm_res *res)
 {
 	return __scm_smc_call(dev, desc, res, true);
 }
 
-/**
- * qcom_scm_set_cold_boot_addr() - Set the cold boot address for cpus
- * @entry: Entry point function for the cpus
- * @cpus: The cpumask of cpus that will use the entry point
- *
- * Set the cold boot address of the cpus. Any cpu outside the supported
- * range would be removed from the cpu present mask.
- */
-int __qcom_scm_set_cold_boot_addr(struct device *dev, void *entry,
-				  const cpumask_t *cpus)
-{
-	return -ENOTSUPP;
-}
-
-/**
- * qcom_scm_set_warm_boot_addr() - Set the warm boot address for cpus
- * @dev: Device pointer
- * @entry: Entry point function for the cpus
- * @cpus: The cpumask of cpus that will use the entry point
- *
- * Set the Linux entry point for the SCM to transfer control to when coming
- * out of a power down. CPU power down may be executed on cpuidle or hotplug.
- */
-int __qcom_scm_set_warm_boot_addr(struct device *dev, void *entry,
-				  const cpumask_t *cpus)
-{
-	return -ENOTSUPP;
-}
-
-/**
- * qcom_scm_cpu_power_down() - Power down the cpu
- * @flags - Flags to flush cache
- *
- * This is an end point to power down cpu. If there was a pending interrupt,
- * the control would return from this function, otherwise, the cpu jumps to the
- * warm boot entry point set for this cpu upon reset.
- */
-void __qcom_scm_cpu_power_down(struct device *dev, u32 flags)
-{
-}
-
 int __qcom_scm_is_call_available(struct device *dev, u32 svc_id, u32 cmd_id)
 {
 	int ret;
@@ -291,50 +203,6 @@ int __qcom_scm_is_call_available(struct device *dev, u32 svc_id, u32 cmd_id)
 	return ret ? : res.result[0];
 }
 
-int __qcom_scm_hdcp_req(struct device *dev, struct qcom_scm_hdcp_req *req,
-			u32 req_cnt, u32 *resp)
-{
-	int ret;
-	struct qcom_scm_desc desc = {
-		.svc = QCOM_SCM_SVC_HDCP,
-		.cmd = QCOM_SCM_HDCP_INVOKE,
-		.owner = ARM_SMCCC_OWNER_SIP,
-	};
-	struct qcom_scm_res res;
-
-	if (req_cnt > QCOM_SCM_HDCP_MAX_REQ_CNT)
-		return -ERANGE;
-
-	desc.args[0] = req[0].addr;
-	desc.args[1] = req[0].val;
-	desc.args[2] = req[1].addr;
-	desc.args[3] = req[1].val;
-	desc.args[4] = req[2].addr;
-	desc.args[5] = req[2].val;
-	desc.args[6] = req[3].addr;
-	desc.args[7] = req[3].val;
-	desc.args[8] = req[4].addr;
-	desc.args[9] = req[4].val;
-	desc.arginfo = QCOM_SCM_ARGS(10);
-
-	ret = qcom_scm_call(dev, &desc, &res);
-	*resp = res.result[0];
-
-	return ret;
-}
-
-int __qcom_scm_ocmem_lock(struct device *dev, uint32_t id, uint32_t offset,
-			  uint32_t size, uint32_t mode)
-{
-	return -ENOTSUPP;
-}
-
-int __qcom_scm_ocmem_unlock(struct device *dev, uint32_t id, uint32_t offset,
-			    uint32_t size)
-{
-	return -ENOTSUPP;
-}
-
 void __qcom_scm_init(void)
 {
 	struct qcom_scm_desc desc = {
@@ -366,297 +234,3 @@ void __qcom_scm_init(void)
 out:
 	pr_info("QCOM SCM SMC Convention: %lld\n", qcom_smccc_convention);
 }
-
-bool __qcom_scm_pas_supported(struct device *dev, u32 peripheral)
-{
-	int ret;
-	struct qcom_scm_desc desc = {
-		.svc = QCOM_SCM_SVC_PIL,
-		.cmd = QCOM_SCM_PIL_PAS_IS_SUPPORTED,
-		.owner = ARM_SMCCC_OWNER_SIP,
-	};
-	struct qcom_scm_res res;
-
-	desc.args[0] = peripheral;
-	desc.arginfo = QCOM_SCM_ARGS(1);
-
-	ret = qcom_scm_call(dev, &desc, &res);
-
-	return ret ? false : !!res.result[0];
-}
-
-int __qcom_scm_pas_init_image(struct device *dev, u32 peripheral,
-			      dma_addr_t metadata_phys)
-{
-	int ret;
-	struct qcom_scm_desc desc = {
-		.svc = QCOM_SCM_SVC_PIL,
-		.cmd = QCOM_SCM_PIL_PAS_INIT_IMAGE,
-		.owner = ARM_SMCCC_OWNER_SIP,
-	};
-	struct qcom_scm_res res;
-
-	desc.args[0] = peripheral;
-	desc.args[1] = metadata_phys;
-	desc.arginfo = QCOM_SCM_ARGS(2, QCOM_SCM_VAL, QCOM_SCM_RW);
-
-	ret = qcom_scm_call(dev, &desc, &res);
-
-	return ret ? : res.result[0];
-}
-
-int __qcom_scm_pas_mem_setup(struct device *dev, u32 peripheral,
-			      phys_addr_t addr, phys_addr_t size)
-{
-	int ret;
-	struct qcom_scm_desc desc = {
-		.svc = QCOM_SCM_SVC_PIL,
-		.cmd = QCOM_SCM_PIL_PAS_MEM_SETUP,
-		.owner = ARM_SMCCC_OWNER_SIP,
-	};
-	struct qcom_scm_res res;
-
-	desc.args[0] = peripheral;
-	desc.args[1] = addr;
-	desc.args[2] = size;
-	desc.arginfo = QCOM_SCM_ARGS(3);
-
-	ret = qcom_scm_call(dev, &desc, &res);
-
-	return ret ? : res.result[0];
-}
-
-int __qcom_scm_pas_auth_and_reset(struct device *dev, u32 peripheral)
-{
-	int ret;
-	struct qcom_scm_desc desc = {
-		.svc = QCOM_SCM_SVC_PIL,
-		.cmd = QCOM_SCM_PIL_PAS_AUTH_AND_RESET,
-		.owner = ARM_SMCCC_OWNER_SIP,
-	};
-	struct qcom_scm_res res;
-
-	desc.args[0] = peripheral;
-	desc.arginfo = QCOM_SCM_ARGS(1);
-
-	ret = qcom_scm_call(dev, &desc, &res);
-
-	return ret ? : res.result[0];
-}
-
-int __qcom_scm_pas_shutdown(struct device *dev, u32 peripheral)
-{
-	int ret;
-	struct qcom_scm_desc desc = {
-		.svc = QCOM_SCM_SVC_PIL,
-		.cmd = QCOM_SCM_PIL_PAS_SHUTDOWN,
-		.owner = ARM_SMCCC_OWNER_SIP,
-	};
-	struct qcom_scm_res res;
-
-	desc.args[0] = peripheral;
-	desc.arginfo = QCOM_SCM_ARGS(1);
-
-	ret = qcom_scm_call(dev, &desc, &res);
-
-	return ret ? : res.result[0];
-}
-
-int __qcom_scm_pas_mss_reset(struct device *dev, bool reset)
-{
-	struct qcom_scm_desc desc = {
-		.svc = QCOM_SCM_SVC_PIL,
-		.cmd = QCOM_SCM_PIL_PAS_MSS_RESET,
-		.owner = ARM_SMCCC_OWNER_SIP,
-	};
-	struct qcom_scm_res res;
-	int ret;
-
-	desc.args[0] = reset;
-	desc.args[1] = 0;
-	desc.arginfo = QCOM_SCM_ARGS(2);
-
-	ret = qcom_scm_call(dev, &desc, &res);
-
-	return ret ? : res.result[0];
-}
-
-int __qcom_scm_set_remote_state(struct device *dev, u32 state, u32 id)
-{
-	struct qcom_scm_desc desc = {
-		.svc = QCOM_SCM_SVC_BOOT,
-		.cmd = QCOM_SCM_BOOT_SET_REMOTE_STATE,
-		.owner = ARM_SMCCC_OWNER_SIP,
-	};
-	struct qcom_scm_res res;
-	int ret;
-
-	desc.args[0] = state;
-	desc.args[1] = id;
-	desc.arginfo = QCOM_SCM_ARGS(2);
-
-	ret = qcom_scm_call(dev, &desc, &res);
-
-	return ret ? : res.result[0];
-}
-
-int __qcom_scm_assign_mem(struct device *dev, phys_addr_t mem_region,
-			  size_t mem_sz, phys_addr_t src, size_t src_sz,
-			  phys_addr_t dest, size_t dest_sz)
-{
-	int ret;
-	struct qcom_scm_desc desc = {
-		.svc = QCOM_SCM_SVC_MP,
-		.cmd = QCOM_SCM_MP_ASSIGN,
-		.owner = ARM_SMCCC_OWNER_SIP,
-	};
-	struct qcom_scm_res res;
-
-	desc.args[0] = mem_region;
-	desc.args[1] = mem_sz;
-	desc.args[2] = src;
-	desc.args[3] = src_sz;
-	desc.args[4] = dest;
-	desc.args[5] = dest_sz;
-	desc.args[6] = 0;
-
-	desc.arginfo = QCOM_SCM_ARGS(7, QCOM_SCM_RO, QCOM_SCM_VAL,
-				     QCOM_SCM_RO, QCOM_SCM_VAL, QCOM_SCM_RO,
-				     QCOM_SCM_VAL, QCOM_SCM_VAL);
-
-	ret = qcom_scm_call(dev, &desc, &res);
-
-	return ret ? : res.result[0];
-}
-
-int __qcom_scm_restore_sec_cfg(struct device *dev, u32 device_id, u32 spare)
-{
-	struct qcom_scm_desc desc = {
-		.svc = QCOM_SCM_SVC_MP,
-		.cmd = QCOM_SCM_MP_RESTORE_SEC_CFG,
-		.owner = ARM_SMCCC_OWNER_SIP,
-	};
-	struct qcom_scm_res res;
-	int ret;
-
-	desc.args[0] = device_id;
-	desc.args[1] = spare;
-	desc.arginfo = QCOM_SCM_ARGS(2);
-
-	ret = qcom_scm_call(dev, &desc, &res);
-
-	return ret ? : res.result[0];
-}
-
-int __qcom_scm_iommu_secure_ptbl_size(struct device *dev, u32 spare,
-				      size_t *size)
-{
-	struct qcom_scm_desc desc = {
-		.svc = QCOM_SCM_SVC_MP,
-		.cmd = QCOM_SCM_MP_IOMMU_SECURE_PTBL_SIZE,
-		.owner = ARM_SMCCC_OWNER_SIP,
-	};
-	struct qcom_scm_res res;
-	int ret;
-
-	desc.args[0] = spare;
-	desc.arginfo = QCOM_SCM_ARGS(1);
-
-	ret = qcom_scm_call(dev, &desc, &res);
-
-	if (size)
-		*size = res.result[0];
-
-	return ret ? : res.result[1];
-}
-
-int __qcom_scm_iommu_secure_ptbl_init(struct device *dev, u64 addr, u32 size,
-				      u32 spare)
-{
-	struct qcom_scm_desc desc = {
-		.svc = QCOM_SCM_SVC_MP,
-		.cmd = QCOM_SCM_MP_IOMMU_SECURE_PTBL_INIT,
-		.owner = ARM_SMCCC_OWNER_SIP,
-	};
-	int ret;
-
-	desc.args[0] = addr;
-	desc.args[1] = size;
-	desc.args[2] = spare;
-	desc.arginfo = QCOM_SCM_ARGS(3, QCOM_SCM_RW, QCOM_SCM_VAL,
-				     QCOM_SCM_VAL);
-
-	ret = qcom_scm_call(dev, &desc, NULL);
-
-	/* the pg table has been initialized already, ignore the error */
-	if (ret == -EPERM)
-		ret = 0;
-
-	return ret;
-}
-
-int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
-{
-	struct qcom_scm_desc desc = {
-		.svc = QCOM_SCM_SVC_BOOT,
-		.cmd = QCOM_SCM_BOOT_SET_DLOAD_MODE,
-		.owner = ARM_SMCCC_OWNER_SIP,
-	};
-
-	desc.args[0] = QCOM_SCM_BOOT_SET_DLOAD_MODE;
-	desc.args[1] = enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0;
-	desc.arginfo = QCOM_SCM_ARGS(2);
-
-	return qcom_scm_call(dev, &desc, NULL);
-}
-
-int __qcom_scm_io_readl(struct device *dev, phys_addr_t addr,
-			unsigned int *val)
-{
-	struct qcom_scm_desc desc = {
-		.svc = QCOM_SCM_SVC_IO,
-		.cmd = QCOM_SCM_IO_READ,
-		.owner = ARM_SMCCC_OWNER_SIP,
-	};
-	struct qcom_scm_res res;
-	int ret;
-
-	desc.args[0] = addr;
-	desc.arginfo = QCOM_SCM_ARGS(1);
-
-	ret = qcom_scm_call(dev, &desc, &res);
-	if (ret >= 0)
-		*val = res.result[0];
-
-	return ret < 0 ? ret : 0;
-}
-
-int __qcom_scm_io_writel(struct device *dev, phys_addr_t addr, unsigned int val)
-{
-	struct qcom_scm_desc desc = {
-		.svc = QCOM_SCM_SVC_IO,
-		.cmd = QCOM_SCM_IO_WRITE,
-		.owner = ARM_SMCCC_OWNER_SIP,
-	};
-
-	desc.args[0] = addr;
-	desc.args[1] = val;
-	desc.arginfo = QCOM_SCM_ARGS(2);
-
-	return qcom_scm_call(dev, &desc, NULL);
-}
-
-int __qcom_scm_qsmmu500_wait_safe_toggle(struct device *dev, bool en)
-{
-	struct qcom_scm_desc desc = {
-		.svc = QCOM_SCM_SVC_SMMU_PROGRAM,
-		.cmd = QCOM_SCM_SMMU_CONFIG_ERRATA1,
-		.owner = ARM_SMCCC_OWNER_SIP,
-	};
-
-	desc.args[0] = QCOM_SCM_SMMU_CONFIG_ERRATA1_CLIENT_ALL;
-	desc.args[1] = en;
-	desc.arginfo = QCOM_SCM_ARGS(2);
-
-	return qcom_scm_call_atomic(dev, &desc, NULL);
-}
diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 5ba4c85..895f148 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -16,6 +16,7 @@
 #include <linux/of_platform.h>
 #include <linux/clk.h>
 #include <linux/reset-controller.h>
+#include <linux/arm-smccc.h>
 
 #include "qcom_scm.h"
 
@@ -49,6 +50,28 @@ struct qcom_scm_mem_map_info {
 	__le64 mem_size;
 };
 
+#define QCOM_SCM_FLAG_COLDBOOT_CPU0	0x00
+#define QCOM_SCM_FLAG_COLDBOOT_CPU1	0x01
+#define QCOM_SCM_FLAG_COLDBOOT_CPU2	0x08
+#define QCOM_SCM_FLAG_COLDBOOT_CPU3	0x20
+
+#define QCOM_SCM_FLAG_WARMBOOT_CPU0	0x04
+#define QCOM_SCM_FLAG_WARMBOOT_CPU1	0x02
+#define QCOM_SCM_FLAG_WARMBOOT_CPU2	0x10
+#define QCOM_SCM_FLAG_WARMBOOT_CPU3	0x40
+
+struct qcom_scm_wb_entry {
+	int flag;
+	void *entry;
+};
+
+static struct qcom_scm_wb_entry qcom_scm_wb[] = {
+	{ .flag = QCOM_SCM_FLAG_WARMBOOT_CPU0 },
+	{ .flag = QCOM_SCM_FLAG_WARMBOOT_CPU1 },
+	{ .flag = QCOM_SCM_FLAG_WARMBOOT_CPU2 },
+	{ .flag = QCOM_SCM_FLAG_WARMBOOT_CPU3 },
+};
+
 static struct qcom_scm *__scm;
 
 static int qcom_scm_clk_enable(void)
@@ -94,7 +117,39 @@ static void qcom_scm_clk_disable(void)
  */
 int qcom_scm_set_warm_boot_addr(void *entry, const cpumask_t *cpus)
 {
-	return __qcom_scm_set_warm_boot_addr(__scm->dev, entry, cpus);
+	int ret;
+	int flags = 0;
+	int cpu;
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_BOOT,
+		.cmd = QCOM_SCM_BOOT_SET_ADDR,
+		.arginfo = QCOM_SCM_ARGS(2),
+	};
+
+	/*
+	 * Reassign only if we are switching from hotplug entry point
+	 * to cpuidle entry point or vice versa.
+	 */
+	for_each_cpu(cpu, cpus) {
+		if (entry == qcom_scm_wb[cpu].entry)
+			continue;
+		flags |= qcom_scm_wb[cpu].flag;
+	}
+
+	/* No change in entry function */
+	if (!flags)
+		return 0;
+
+	desc.args[0] = flags;
+	desc.args[1] = virt_to_phys(entry);
+
+	ret = qcom_scm_call(__scm->dev, &desc, NULL);
+	if (!ret) {
+		for_each_cpu(cpu, cpus)
+			qcom_scm_wb[cpu].entry = entry;
+	}
+
+	return ret;
 }
 EXPORT_SYMBOL(qcom_scm_set_warm_boot_addr);
 
@@ -108,8 +163,35 @@ EXPORT_SYMBOL(qcom_scm_set_warm_boot_addr);
  */
 int qcom_scm_set_cold_boot_addr(void *entry, const cpumask_t *cpus)
 {
-	return __qcom_scm_set_cold_boot_addr(__scm ? __scm->dev : NULL, entry,
-					     cpus);
+	int flags = 0;
+	int cpu;
+	int scm_cb_flags[] = {
+		QCOM_SCM_FLAG_COLDBOOT_CPU0,
+		QCOM_SCM_FLAG_COLDBOOT_CPU1,
+		QCOM_SCM_FLAG_COLDBOOT_CPU2,
+		QCOM_SCM_FLAG_COLDBOOT_CPU3,
+	};
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_BOOT,
+		.cmd = QCOM_SCM_BOOT_SET_ADDR,
+		.arginfo = QCOM_SCM_ARGS(2),
+		.owner = ARM_SMCCC_OWNER_SIP,
+	};
+
+	if (!cpus || (cpus && cpumask_empty(cpus)))
+		return -EINVAL;
+
+	for_each_cpu(cpu, cpus) {
+		if (cpu < ARRAY_SIZE(scm_cb_flags))
+			flags |= scm_cb_flags[cpu];
+		else
+			set_cpu_present(cpu, false);
+	}
+
+	desc.args[0] = flags;
+	desc.args[1] = virt_to_phys(entry);
+
+	return qcom_scm_call_atomic(__scm ? __scm->dev : NULL, &desc, NULL);
 }
 EXPORT_SYMBOL(qcom_scm_set_cold_boot_addr);
 
@@ -123,16 +205,52 @@ EXPORT_SYMBOL(qcom_scm_set_cold_boot_addr);
  */
 void qcom_scm_cpu_power_down(u32 flags)
 {
-	__qcom_scm_cpu_power_down(__scm ? __scm->dev : NULL, flags);
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_BOOT,
+		.cmd = QCOM_SCM_BOOT_TERMINATE_PC,
+		.args[0] = flags & QCOM_SCM_FLUSH_FLAG_MASK,
+		.arginfo = QCOM_SCM_ARGS(1),
+		.owner = ARM_SMCCC_OWNER_SIP,
+	};
+
+	qcom_scm_call_atomic(__scm ? __scm->dev : NULL, &desc, NULL);
 }
 EXPORT_SYMBOL(qcom_scm_cpu_power_down);
 
 int qcom_scm_set_remote_state(u32 state, u32 id)
 {
-	return __qcom_scm_set_remote_state(__scm->dev, state, id);
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_BOOT,
+		.cmd = QCOM_SCM_BOOT_SET_REMOTE_STATE,
+		.arginfo = QCOM_SCM_ARGS(2),
+		.args[0] = state,
+		.args[1] = id,
+		.owner = ARM_SMCCC_OWNER_SIP,
+	};
+	struct qcom_scm_res res;
+	int ret;
+
+	ret = qcom_scm_call(__scm->dev, &desc, &res);
+
+	return ret ? : res.result[0];
 }
 EXPORT_SYMBOL(qcom_scm_set_remote_state);
 
+static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
+{
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_BOOT,
+		.cmd = QCOM_SCM_BOOT_SET_DLOAD_MODE,
+		.arginfo = QCOM_SCM_ARGS(2),
+		.args[0] = QCOM_SCM_BOOT_SET_DLOAD_MODE,
+		.owner = ARM_SMCCC_OWNER_SIP,
+	};
+
+	desc.args[1] = enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0;
+
+	return qcom_scm_call(__scm->dev, &desc, NULL);
+}
+
 static void qcom_scm_set_download_mode(bool enable)
 {
 	bool avail;
@@ -144,8 +262,8 @@ static void qcom_scm_set_download_mode(bool enable)
 	if (avail) {
 		ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
 	} else if (__scm->dload_mode_addr) {
-		ret = __qcom_scm_io_writel(__scm->dev, __scm->dload_mode_addr,
-					   enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0);
+		ret = qcom_scm_io_writel(__scm->dload_mode_addr,
+				enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0);
 	} else {
 		dev_err(__scm->dev,
 			"No available mechanism for setting download mode\n");
@@ -172,6 +290,14 @@ int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size)
 	dma_addr_t mdata_phys;
 	void *mdata_buf;
 	int ret;
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_PIL,
+		.cmd = QCOM_SCM_PIL_PAS_INIT_IMAGE,
+		.arginfo = QCOM_SCM_ARGS(2, QCOM_SCM_VAL, QCOM_SCM_RW),
+		.args[0] = peripheral,
+		.owner = ARM_SMCCC_OWNER_SIP,
+	};
+	struct qcom_scm_res res;
 
 	/*
 	 * During the scm call memory protection will be enabled for the meta
@@ -190,14 +316,16 @@ int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size)
 	if (ret)
 		goto free_metadata;
 
-	ret = __qcom_scm_pas_init_image(__scm->dev, peripheral, mdata_phys);
+	desc.args[1] = mdata_phys;
+
+	ret = qcom_scm_call(__scm->dev, &desc, &res);
 
 	qcom_scm_clk_disable();
 
 free_metadata:
 	dma_free_coherent(__scm->dev, size, mdata_buf, mdata_phys);
 
-	return ret;
+	return ret ? : res.result[0];
 }
 EXPORT_SYMBOL(qcom_scm_pas_init_image);
 
@@ -213,15 +341,25 @@ EXPORT_SYMBOL(qcom_scm_pas_init_image);
 int qcom_scm_pas_mem_setup(u32 peripheral, phys_addr_t addr, phys_addr_t size)
 {
 	int ret;
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_PIL,
+		.cmd = QCOM_SCM_PIL_PAS_MEM_SETUP,
+		.arginfo = QCOM_SCM_ARGS(3),
+		.args[0] = peripheral,
+		.args[1] = addr,
+		.args[2] = size,
+		.owner = ARM_SMCCC_OWNER_SIP,
+	};
+	struct qcom_scm_res res;
 
 	ret = qcom_scm_clk_enable();
 	if (ret)
 		return ret;
 
-	ret = __qcom_scm_pas_mem_setup(__scm->dev, peripheral, addr, size);
+	ret = qcom_scm_call(__scm->dev, &desc, &res);
 	qcom_scm_clk_disable();
 
-	return ret;
+	return ret ? : res.result[0];
 }
 EXPORT_SYMBOL(qcom_scm_pas_mem_setup);
 
@@ -235,15 +373,23 @@ EXPORT_SYMBOL(qcom_scm_pas_mem_setup);
 int qcom_scm_pas_auth_and_reset(u32 peripheral)
 {
 	int ret;
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_PIL,
+		.cmd = QCOM_SCM_PIL_PAS_AUTH_AND_RESET,
+		.arginfo = QCOM_SCM_ARGS(1),
+		.args[0] = peripheral,
+		.owner = ARM_SMCCC_OWNER_SIP,
+	};
+	struct qcom_scm_res res;
 
 	ret = qcom_scm_clk_enable();
 	if (ret)
 		return ret;
 
-	ret = __qcom_scm_pas_auth_and_reset(__scm->dev, peripheral);
+	ret = qcom_scm_call(__scm->dev, &desc, &res);
 	qcom_scm_clk_disable();
 
-	return ret;
+	return ret ? : res.result[0];
 }
 EXPORT_SYMBOL(qcom_scm_pas_auth_and_reset);
 
@@ -256,15 +402,24 @@ EXPORT_SYMBOL(qcom_scm_pas_auth_and_reset);
 int qcom_scm_pas_shutdown(u32 peripheral)
 {
 	int ret;
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_PIL,
+		.cmd = QCOM_SCM_PIL_PAS_SHUTDOWN,
+		.arginfo = QCOM_SCM_ARGS(1),
+		.args[0] = peripheral,
+		.owner = ARM_SMCCC_OWNER_SIP,
+	};
+	struct qcom_scm_res res;
 
 	ret = qcom_scm_clk_enable();
 	if (ret)
 		return ret;
 
-	ret = __qcom_scm_pas_shutdown(__scm->dev, peripheral);
+	ret = qcom_scm_call(__scm->dev, &desc, &res);
+
 	qcom_scm_clk_disable();
 
-	return ret;
+	return ret ? : res.result[0];
 }
 EXPORT_SYMBOL(qcom_scm_pas_shutdown);
 
@@ -278,16 +433,44 @@ EXPORT_SYMBOL(qcom_scm_pas_shutdown);
 bool qcom_scm_pas_supported(u32 peripheral)
 {
 	int ret;
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_PIL,
+		.cmd = QCOM_SCM_PIL_PAS_IS_SUPPORTED,
+		.arginfo = QCOM_SCM_ARGS(1),
+		.args[0] = peripheral,
+		.owner = ARM_SMCCC_OWNER_SIP,
+	};
+	struct qcom_scm_res res;
 
 	ret = __qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_PIL,
 					   QCOM_SCM_PIL_PAS_IS_SUPPORTED);
 	if (ret <= 0)
 		return false;
 
-	return __qcom_scm_pas_supported(__scm->dev, peripheral);
+	ret = qcom_scm_call(__scm->dev, &desc, &res);
+
+	return ret ? false : !!res.result[0];
 }
 EXPORT_SYMBOL(qcom_scm_pas_supported);
 
+static int __qcom_scm_pas_mss_reset(struct device *dev, bool reset)
+{
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_PIL,
+		.cmd = QCOM_SCM_PIL_PAS_MSS_RESET,
+		.arginfo = QCOM_SCM_ARGS(2),
+		.args[0] = reset,
+		.args[1] = 0,
+		.owner = ARM_SMCCC_OWNER_SIP,
+	};
+	struct qcom_scm_res res;
+	int ret;
+
+	ret = qcom_scm_call(__scm->dev, &desc, &res);
+
+	return ret ? : res.result[0];
+}
+
 static int qcom_scm_pas_reset_assert(struct reset_controller_dev *rcdev,
 				     unsigned long idx)
 {
@@ -313,13 +496,38 @@ static const struct reset_control_ops qcom_scm_pas_reset_ops = {
 
 int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val)
 {
-	return __qcom_scm_io_readl(__scm->dev, addr, val);
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_IO,
+		.cmd = QCOM_SCM_IO_READ,
+		.arginfo = QCOM_SCM_ARGS(1),
+		.args[0] = addr,
+		.owner = ARM_SMCCC_OWNER_SIP,
+	};
+	struct qcom_scm_res res;
+	int ret;
+
+
+	ret = qcom_scm_call(__scm->dev, &desc, &res);
+	if (ret >= 0)
+		*val = res.result[0];
+
+	return ret < 0 ? ret : 0;
 }
 EXPORT_SYMBOL(qcom_scm_io_readl);
 
 int qcom_scm_io_writel(phys_addr_t addr, unsigned int val)
 {
-	return __qcom_scm_io_writel(__scm->dev, addr, val);
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_IO,
+		.cmd = QCOM_SCM_IO_WRITE,
+		.arginfo = QCOM_SCM_ARGS(2),
+		.args[0] = addr,
+		.args[1] = val,
+		.owner = ARM_SMCCC_OWNER_SIP,
+	};
+
+
+	return qcom_scm_call(__scm->dev, &desc, NULL);
 }
 EXPORT_SYMBOL(qcom_scm_io_writel);
 
@@ -338,22 +546,101 @@ EXPORT_SYMBOL(qcom_scm_restore_sec_cfg_available);
 
 int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare)
 {
-	return __qcom_scm_restore_sec_cfg(__scm->dev, device_id, spare);
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_MP,
+		.cmd = QCOM_SCM_MP_RESTORE_SEC_CFG,
+		.arginfo = QCOM_SCM_ARGS(2),
+		.args[0] = device_id,
+		.args[1] = spare,
+		.owner = ARM_SMCCC_OWNER_SIP,
+	};
+	struct qcom_scm_res res;
+	int ret;
+
+	ret = qcom_scm_call(__scm->dev, &desc, &res);
+
+	return ret ? : res.result[0];
 }
 EXPORT_SYMBOL(qcom_scm_restore_sec_cfg);
 
 int qcom_scm_iommu_secure_ptbl_size(u32 spare, size_t *size)
 {
-	return __qcom_scm_iommu_secure_ptbl_size(__scm->dev, spare, size);
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_MP,
+		.cmd = QCOM_SCM_MP_IOMMU_SECURE_PTBL_SIZE,
+		.arginfo = QCOM_SCM_ARGS(1),
+		.args[0] = spare,
+		.owner = ARM_SMCCC_OWNER_SIP,
+	};
+	struct qcom_scm_res res;
+	int ret;
+
+	ret = qcom_scm_call(__scm->dev, &desc, &res);
+
+	if (size)
+		*size = res.result[0];
+
+	return ret ? : res.result[1];
 }
 EXPORT_SYMBOL(qcom_scm_iommu_secure_ptbl_size);
 
 int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare)
 {
-	return __qcom_scm_iommu_secure_ptbl_init(__scm->dev, addr, size, spare);
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_MP,
+		.cmd = QCOM_SCM_MP_IOMMU_SECURE_PTBL_INIT,
+		.arginfo = QCOM_SCM_ARGS(3, QCOM_SCM_RW, QCOM_SCM_VAL,
+					 QCOM_SCM_VAL),
+		.args[0] = addr,
+		.args[1] = size,
+		.args[2] = spare,
+		.owner = ARM_SMCCC_OWNER_SIP,
+	};
+	int ret;
+
+	desc.args[0] = addr;
+	desc.args[1] = size;
+	desc.args[2] = spare;
+	desc.arginfo = QCOM_SCM_ARGS(3, QCOM_SCM_RW, QCOM_SCM_VAL,
+				     QCOM_SCM_VAL);
+
+	ret = qcom_scm_call(__scm->dev, &desc, NULL);
+
+	/* the pg table has been initialized already, ignore the error */
+	if (ret == -EPERM)
+		ret = 0;
+
+	return ret;
 }
 EXPORT_SYMBOL(qcom_scm_iommu_secure_ptbl_init);
 
+static int __qcom_scm_assign_mem(struct device *dev, phys_addr_t mem_region,
+				 size_t mem_sz, phys_addr_t src, size_t src_sz,
+				 phys_addr_t dest, size_t dest_sz)
+{
+	int ret;
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_MP,
+		.cmd = QCOM_SCM_MP_ASSIGN,
+		.arginfo = QCOM_SCM_ARGS(7, QCOM_SCM_RO, QCOM_SCM_VAL,
+					 QCOM_SCM_RO, QCOM_SCM_VAL, QCOM_SCM_RO,
+					 QCOM_SCM_VAL, QCOM_SCM_VAL),
+		.args[0] = mem_region,
+		.args[1] = mem_sz,
+		.args[2] = src,
+		.args[3] = src_sz,
+		.args[4] = dest,
+		.args[5] = dest_sz,
+		.args[6] = 0,
+		.owner = ARM_SMCCC_OWNER_SIP,
+	};
+	struct qcom_scm_res res;
+
+	ret = qcom_scm_call(dev, &desc, &res);
+
+	return ret ? : res.result[0];
+}
+
 /**
  * qcom_scm_assign_mem() - Make a secure call to reassign memory ownership
  * @mem_addr: mem region whose ownership need to be reassigned
@@ -458,7 +745,17 @@ EXPORT_SYMBOL(qcom_scm_ocmem_lock_available);
 int qcom_scm_ocmem_lock(enum qcom_scm_ocmem_client id, u32 offset, u32 size,
 			u32 mode)
 {
-	return __qcom_scm_ocmem_lock(__scm->dev, id, offset, size, mode);
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_OCMEM,
+		.cmd = QCOM_SCM_OCMEM_LOCK_CMD,
+		.args[0] = id,
+		.args[1] = offset,
+		.args[2] = size,
+		.args[3] = mode,
+		.arginfo = QCOM_SCM_ARGS(4),
+	};
+
+	return qcom_scm_call(__scm->dev, &desc, NULL);
 }
 EXPORT_SYMBOL(qcom_scm_ocmem_lock);
 
@@ -472,7 +769,16 @@ EXPORT_SYMBOL(qcom_scm_ocmem_lock);
  */
 int qcom_scm_ocmem_unlock(enum qcom_scm_ocmem_client id, u32 offset, u32 size)
 {
-	return __qcom_scm_ocmem_unlock(__scm->dev, id, offset, size);
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_OCMEM,
+		.cmd = QCOM_SCM_OCMEM_UNLOCK_CMD,
+		.args[0] = id,
+		.args[1] = offset,
+		.args[2] = size,
+		.arginfo = QCOM_SCM_ARGS(3),
+	};
+
+	return qcom_scm_call(__scm->dev, &desc, NULL);
 }
 EXPORT_SYMBOL(qcom_scm_ocmem_unlock);
 
@@ -507,20 +813,56 @@ EXPORT_SYMBOL(qcom_scm_hdcp_available);
  */
 int qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32 req_cnt, u32 *resp)
 {
-	int ret = qcom_scm_clk_enable();
+	int ret;
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_HDCP,
+		.cmd = QCOM_SCM_HDCP_INVOKE,
+		.arginfo = QCOM_SCM_ARGS(10),
+		.args = {
+			req[0].addr,
+			req[0].val,
+			req[1].addr,
+			req[1].val,
+			req[2].addr,
+			req[2].val,
+			req[3].addr,
+			req[3].val,
+			req[4].addr,
+			req[4].val
+		},
+		.owner = ARM_SMCCC_OWNER_SIP,
+	};
+	struct qcom_scm_res res;
+
+	if (req_cnt > QCOM_SCM_HDCP_MAX_REQ_CNT)
+		return -ERANGE;
 
+	ret = qcom_scm_clk_enable();
 	if (ret)
 		return ret;
 
-	ret = __qcom_scm_hdcp_req(__scm->dev, req, req_cnt, resp);
+	ret = qcom_scm_call(__scm->dev, &desc, &res);
+	*resp = res.result[0];
+
 	qcom_scm_clk_disable();
+
 	return ret;
 }
 EXPORT_SYMBOL(qcom_scm_hdcp_req);
 
 int qcom_scm_qsmmu500_wait_safe_toggle(bool en)
 {
-	return __qcom_scm_qsmmu500_wait_safe_toggle(__scm->dev, en);
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_SMMU_PROGRAM,
+		.cmd = QCOM_SCM_SMMU_CONFIG_ERRATA1,
+		.arginfo = QCOM_SCM_ARGS(2),
+		.args[0] = QCOM_SCM_SMMU_CONFIG_ERRATA1_CLIENT_ALL,
+		.args[1] = en,
+		.owner = ARM_SMCCC_OWNER_SIP,
+	};
+
+
+	return qcom_scm_call_atomic(__scm->dev, &desc, NULL);
 }
 EXPORT_SYMBOL(qcom_scm_qsmmu500_wait_safe_toggle);
 
diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
index 56ace3b..9b7b357 100644
--- a/drivers/firmware/qcom_scm.h
+++ b/drivers/firmware/qcom_scm.h
@@ -3,19 +3,64 @@
  */
 #ifndef __QCOM_SCM_INT_H
 #define __QCOM_SCM_INT_H
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
+extern int qcom_scm_call(struct device *dev, const struct qcom_scm_desc *desc,
+			 struct qcom_scm_res *res);
+extern int qcom_scm_call_atomic(struct device *dev,
+				const struct qcom_scm_desc *desc,
+				struct qcom_scm_res *res);
 
 #define QCOM_SCM_SVC_BOOT		0x01
 #define QCOM_SCM_BOOT_SET_ADDR		0x01
 #define QCOM_SCM_BOOT_TERMINATE_PC	0x02
 #define QCOM_SCM_BOOT_SET_DLOAD_MODE	0x10
 #define QCOM_SCM_BOOT_SET_REMOTE_STATE	0x0a
-extern int __qcom_scm_set_warm_boot_addr(struct device *dev, void *entry,
-		const cpumask_t *cpus);
-extern int __qcom_scm_set_cold_boot_addr(struct device *dev, void *entry,
-		const cpumask_t *cpus);
-extern void __qcom_scm_cpu_power_down(struct device *dev, u32 flags);
-extern int __qcom_scm_set_remote_state(struct device *dev, u32 state, u32 id);
-extern int __qcom_scm_set_dload_mode(struct device *dev, bool enable);
 #define QCOM_SCM_FLUSH_FLAG_MASK	0x3
 
 #define QCOM_SCM_SVC_PIL		0x02
@@ -25,20 +70,10 @@ extern int __qcom_scm_set_dload_mode(struct device *dev, bool enable);
 #define QCOM_SCM_PIL_PAS_SHUTDOWN	0x06
 #define QCOM_SCM_PIL_PAS_IS_SUPPORTED	0x07
 #define QCOM_SCM_PIL_PAS_MSS_RESET	0x0a
-extern bool __qcom_scm_pas_supported(struct device *dev, u32 peripheral);
-extern int  __qcom_scm_pas_init_image(struct device *dev, u32 peripheral,
-		dma_addr_t metadata_phys);
-extern int  __qcom_scm_pas_mem_setup(struct device *dev, u32 peripheral,
-		phys_addr_t addr, phys_addr_t size);
-extern int  __qcom_scm_pas_auth_and_reset(struct device *dev, u32 peripheral);
-extern int  __qcom_scm_pas_shutdown(struct device *dev, u32 peripheral);
-extern int  __qcom_scm_pas_mss_reset(struct device *dev, bool reset);
 
 #define QCOM_SCM_SVC_IO			0x05
 #define QCOM_SCM_IO_READ		0x01
 #define QCOM_SCM_IO_WRITE		0x02
-extern int __qcom_scm_io_readl(struct device *dev, phys_addr_t addr, unsigned int *val);
-extern int __qcom_scm_io_writel(struct device *dev, phys_addr_t addr, unsigned int val);
 
 #define QCOM_SCM_SVC_INFO		0x06
 #define QCOM_SCM_INFO_IS_CALL_AVAIL	0x01
@@ -50,35 +85,17 @@ extern int __qcom_scm_is_call_available(struct device *dev, u32 svc_id,
 #define QCOM_SCM_MP_IOMMU_SECURE_PTBL_SIZE	0x03
 #define QCOM_SCM_MP_IOMMU_SECURE_PTBL_INIT	0x04
 #define QCOM_SCM_MP_ASSIGN			0x16
-extern int __qcom_scm_restore_sec_cfg(struct device *dev, u32 device_id,
-				      u32 spare);
-extern int __qcom_scm_iommu_secure_ptbl_size(struct device *dev, u32 spare,
-					     size_t *size);
-extern int __qcom_scm_iommu_secure_ptbl_init(struct device *dev, u64 addr,
-					     u32 size, u32 spare);
-extern int  __qcom_scm_assign_mem(struct device *dev,
-				  phys_addr_t mem_region, size_t mem_sz,
-				  phys_addr_t src, size_t src_sz,
-				  phys_addr_t dest, size_t dest_sz);
 
 #define QCOM_SCM_SVC_OCMEM		0x0f
 #define QCOM_SCM_OCMEM_LOCK_CMD		0x01
 #define QCOM_SCM_OCMEM_UNLOCK_CMD	0x02
-extern int __qcom_scm_ocmem_lock(struct device *dev, u32 id, u32 offset,
-				 u32 size, u32 mode);
-extern int __qcom_scm_ocmem_unlock(struct device *dev, u32 id, u32 offset,
-				   u32 size);
 
 #define QCOM_SCM_SVC_HDCP		0x11
 #define QCOM_SCM_HDCP_INVOKE		0x01
-extern int __qcom_scm_hdcp_req(struct device *dev,
-		struct qcom_scm_hdcp_req *req, u32 req_cnt, u32 *resp);
 
 #define QCOM_SCM_SVC_SMMU_PROGRAM		0x15
 #define QCOM_SCM_SMMU_CONFIG_ERRATA1		0x03
 #define QCOM_SCM_SMMU_CONFIG_ERRATA1_CLIENT_ALL	0x02
-extern int __qcom_scm_qsmmu500_wait_safe_toggle(struct device *dev,
-						bool enable);
 
 extern void __qcom_scm_init(void);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
