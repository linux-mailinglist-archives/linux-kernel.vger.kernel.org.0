Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAAA1133375
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 22:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbgAGVTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 16:19:01 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:16165 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729149AbgAGVE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:04:57 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1578431096; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=QGLx5ZAg/wwfnuGd9kbD8DdzWakIkQZ0RDx5bjkv+Bo=; b=t8oA9gdH6QglI+Pgfp43ce6Ibs3q1S53OSAlSDheOcE+xv8k4dQw1dzstN3758bkEjeKq2i7
 k8lTfVg80Ou3RezZpHjYK79FUe9EYnRj9ymaOdX+S7qHOyKfVV3gJDPrMIIHokdMPajttJUU
 gorNWHBPZvqVpG+CTsMLCi7IL0I=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e14f278.7f8147f8f928-smtp-out-n01;
 Tue, 07 Jan 2020 21:04:56 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E7655C447AD; Tue,  7 Jan 2020 21:04:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from eberman-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: eberman)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A227EC447AD;
        Tue,  7 Jan 2020 21:04:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A227EC447AD
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
Subject: [PATCH v5 17/17] firmware: qcom_scm: Dynamically support SMCCC and legacy conventions
Date:   Tue,  7 Jan 2020 13:04:26 -0800
Message-Id: <1578431066-19600-18-git-send-email-eberman@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578431066-19600-1-git-send-email-eberman@codeaurora.org>
References: <1578431066-19600-1-git-send-email-eberman@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dynamically support SMCCCC and legacy conventions by detecting which
convention to use at runtime. qcom_scm_call_atomic and qcom_scm_call can
then be moved in qcom_scm.c and use underlying convention backend as
appropriate. Thus, rename qcom_scm-64,-32 to reflect that they are
backends for -smc and -legacy, respectively.

Also add support for making SCM calls earlier than when SCM driver
probes to support use cases such as qcom_scm_set_cold_boot_addr. Support
is added by lazily initializing the convention and guarding the query
with a spin lock.  The limitation of these early SCM calls is that they
cannot use DMA, as in the case of >4 arguments for SMC convention and
any non-atomic call for legacy convention.

Change-Id: Ib46a29aeca4938b280821e526f2fdb6d1b461513
Tested-by: Brian Masney <masneyb@onstation.org> # arm32
Tested-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Elliot Berman <eberman@codeaurora.org>
---
 drivers/firmware/Kconfig                           |   8 --
 drivers/firmware/Makefile                          |   4 +-
 .../firmware/{qcom_scm-32.c => qcom_scm-legacy.c}  |  31 +----
 drivers/firmware/{qcom_scm-64.c => qcom_scm-smc.c} |  95 +-------------
 drivers/firmware/qcom_scm.c                        | 146 ++++++++++++++++++++-
 drivers/firmware/qcom_scm.h                        |  27 +++-
 6 files changed, 176 insertions(+), 135 deletions(-)
 rename drivers/firmware/{qcom_scm-32.c => qcom_scm-legacy.c} (90%)
 rename drivers/firmware/{qcom_scm-64.c => qcom_scm-smc.c} (57%)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index e40a77b..ea869ad 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -239,14 +239,6 @@ config QCOM_SCM
 	depends on ARM || ARM64
 	select RESET_CONTROLLER
 
-config QCOM_SCM_32
-	def_bool y
-	depends on QCOM_SCM && ARM
-
-config QCOM_SCM_64
-	def_bool y
-	depends on QCOM_SCM && ARM64
-
 config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
 	bool "Qualcomm download mode enabled by default"
 	depends on QCOM_SCM
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 747fb73..e9fb838 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -17,9 +17,7 @@ obj-$(CONFIG_ISCSI_IBFT)	+= iscsi_ibft.o
 obj-$(CONFIG_FIRMWARE_MEMMAP)	+= memmap.o
 obj-$(CONFIG_RASPBERRYPI_FIRMWARE) += raspberrypi.o
 obj-$(CONFIG_FW_CFG_SYSFS)	+= qemu_fw_cfg.o
-obj-$(CONFIG_QCOM_SCM)		+= qcom_scm.o
-obj-$(CONFIG_QCOM_SCM_64)	+= qcom_scm-64.o
-obj-$(CONFIG_QCOM_SCM_32)	+= qcom_scm-32.o
+obj-$(CONFIG_QCOM_SCM)		+= qcom_scm.o qcom_scm-smc.o qcom_scm-legacy.o
 obj-$(CONFIG_TI_SCI_PROTOCOL)	+= ti_sci.o
 obj-$(CONFIG_TRUSTED_FOUNDATIONS) += trusted_foundations.o
 obj-$(CONFIG_TURRIS_MOX_RWTM)	+= turris-mox-rwtm.o
diff --git a/drivers/firmware/qcom_scm-32.c b/drivers/firmware/qcom_scm-legacy.c
similarity index 90%
rename from drivers/firmware/qcom_scm-32.c
rename to drivers/firmware/qcom_scm-legacy.c
index 08220e7..8532e7c 100644
--- a/drivers/firmware/qcom_scm-32.c
+++ b/drivers/firmware/qcom_scm-legacy.c
@@ -26,7 +26,6 @@ struct arm_smccc_args {
 	unsigned long args[8];
 };
 
-#define SCM_LEGACY_FNID(s, c)	(((s) << 10) | ((c) & 0x3ff))
 
 /**
  * struct scm_legacy_command - one SCM command buffer
@@ -129,8 +128,8 @@ static void __scm_legacy_do(const struct arm_smccc_args *smc,
  * and response buffers is taken care of by qcom_scm_call; however, callers are
  * responsible for any other cached buffers passed over to the secure world.
  */
-int qcom_scm_call(struct device *dev, const struct qcom_scm_desc *desc,
-			 struct qcom_scm_res *res)
+int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
+		    struct qcom_scm_res *res)
 {
 	u8 arglen = desc->arginfo & 0xf;
 	int ret = 0, context_id;
@@ -218,9 +217,9 @@ int qcom_scm_call(struct device *dev, const struct qcom_scm_desc *desc,
  * This shall only be used with commands that are guaranteed to be
  * uninterruptable, atomic and SMP safe.
  */
-int qcom_scm_call_atomic(struct device *unused,
-			 const struct qcom_scm_desc *desc,
-			 struct qcom_scm_res *res)
+int scm_legacy_call_atomic(struct device *unused,
+			   const struct qcom_scm_desc *desc,
+			   struct qcom_scm_res *res)
 {
 	int context_id;
 	struct arm_smccc_res smc_res;
@@ -241,23 +240,3 @@ int qcom_scm_call_atomic(struct device *unused,
 
 	return smc_res.a0;
 }
-
-int __qcom_scm_is_call_available(struct device *dev, u32 svc_id, u32 cmd_id)
-{
-	int ret;
-	struct qcom_scm_desc desc = {
-		.svc = QCOM_SCM_SVC_INFO,
-		.cmd = QCOM_SCM_INFO_IS_CALL_AVAIL,
-		.args[0] = SCM_LEGACY_FNID(svc_id, cmd_id),
-		.arginfo = QCOM_SCM_ARGS(1),
-	};
-	struct qcom_scm_res res;
-
-	ret = qcom_scm_call(dev, &desc, &res);
-
-	return ret ? : res.result[0];
-}
-
-void __qcom_scm_init(void)
-{
-}
diff --git a/drivers/firmware/qcom_scm-64.c b/drivers/firmware/qcom_scm-smc.c
similarity index 57%
rename from drivers/firmware/qcom_scm-64.c
rename to drivers/firmware/qcom_scm-smc.c
index 4defc7c..497c13b 100644
--- a/drivers/firmware/qcom_scm-64.c
+++ b/drivers/firmware/qcom_scm-smc.c
@@ -14,8 +14,6 @@
 
 #include "qcom_scm.h"
 
-#define SCM_SMC_FNID(s, c) ((((s) & 0xFF) << 8) | ((c) & 0xFF))
-
 /**
  * struct arm_smccc_args
  * @args:	The array of values used in registers in smc instruction
@@ -24,7 +22,6 @@ struct arm_smccc_args {
 	unsigned long args[8];
 };
 
-static u64 qcom_smccc_convention = -1;
 static DEFINE_MUTEX(qcom_scm_lock);
 
 #define QCOM_SCM_EBUSY_WAIT_MS 30
@@ -80,8 +77,8 @@ static void __scm_smc_do(const struct arm_smccc_args *smc,
 	}  while (res->a0 == QCOM_SCM_V2_EBUSY);
 }
 
-static int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
-			  struct qcom_scm_res *res, bool atomic)
+int scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
+		 struct qcom_scm_res *res, bool atomic)
 {
 	int arglen = desc->arginfo & 0xf;
 	int i;
@@ -90,6 +87,9 @@ static int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
 	size_t alloc_len;
 	gfp_t flag = atomic ? GFP_ATOMIC : GFP_KERNEL;
 	u32 smccc_call_type = atomic ? ARM_SMCCC_FAST_CALL : ARM_SMCCC_STD_CALL;
+	u32 qcom_smccc_convention =
+			(qcom_scm_convention == SMC_CONVENTION_ARM_32) ?
+			ARM_SMCCC_SMC_32 : ARM_SMCCC_SMC_64;
 	struct arm_smccc_res smc_res;
 	struct arm_smccc_args smc = {0};
 
@@ -149,88 +149,3 @@ static int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
 
 	return (long)smc_res.a0 ? qcom_scm_remap_error(smc_res.a0) : 0;
 }
-
-/**
- * qcom_scm_call() - Invoke a syscall in the secure world
- * @dev:	device
- * @svc_id:	service identifier
- * @cmd_id:	command identifier
- * @desc:	Descriptor structure containing arguments and return values
- *
- * Sends a command to the SCM and waits for the command to finish processing.
- * This should *only* be called in pre-emptible context.
- */
-int qcom_scm_call(struct device *dev, const struct qcom_scm_desc *desc,
-		  struct qcom_scm_res *res)
-{
-	might_sleep();
-	return __scm_smc_call(dev, desc, res, false);
-}
-
-/**
- * qcom_scm_call_atomic() - atomic variation of qcom_scm_call()
- * @dev:	device
- * @svc_id:	service identifier
- * @cmd_id:	command identifier
- * @desc:	Descriptor structure containing arguments and return values
- * @res:	Structure containing results from SMC/HVC call
- *
- * Sends a command to the SCM and waits for the command to finish processing.
- * This can be called in atomic context.
- */
-int qcom_scm_call_atomic(struct device *dev, const struct qcom_scm_desc *desc,
-			 struct qcom_scm_res *res)
-{
-	return __scm_smc_call(dev, desc, res, true);
-}
-
-int __qcom_scm_is_call_available(struct device *dev, u32 svc_id, u32 cmd_id)
-{
-	int ret;
-	struct qcom_scm_desc desc = {
-		.svc = QCOM_SCM_SVC_INFO,
-		.cmd = QCOM_SCM_INFO_IS_CALL_AVAIL,
-		.owner = ARM_SMCCC_OWNER_SIP,
-	};
-	struct qcom_scm_res res;
-
-	desc.arginfo = QCOM_SCM_ARGS(1);
-	desc.args[0] = SCM_SMC_FNID(svc_id, cmd_id) |
-			(ARM_SMCCC_OWNER_SIP << ARM_SMCCC_OWNER_SHIFT);
-
-	ret = qcom_scm_call(dev, &desc, &res);
-
-	return ret ? : res.result[0];
-}
-
-void __qcom_scm_init(void)
-{
-	struct qcom_scm_desc desc = {
-		.svc = QCOM_SCM_SVC_INFO,
-		.cmd = QCOM_SCM_INFO_IS_CALL_AVAIL,
-		.args[0] = SCM_SMC_FNID(QCOM_SCM_SVC_INFO,
-					QCOM_SCM_INFO_IS_CALL_AVAIL) |
-			   (ARM_SMCCC_OWNER_SIP << ARM_SMCCC_OWNER_SHIFT),
-		.arginfo = QCOM_SCM_ARGS(1),
-		.owner = ARM_SMCCC_OWNER_SIP,
-	};
-	struct qcom_scm_res res;
-	int ret;
-
-	qcom_smccc_convention = ARM_SMCCC_SMC_64;
-	// Device isn't required as there is only one argument - no device
-	// needed to dma_map_single to secure world
-	ret = qcom_scm_call_atomic(NULL, &desc, &res);
-	if (!ret && res.result[0] == 1)
-		goto out;
-
-	qcom_smccc_convention = ARM_SMCCC_SMC_32;
-	ret = qcom_scm_call_atomic(NULL, &desc, &res);
-	if (!ret && res.result[0] == 1)
-		goto out;
-
-	qcom_smccc_convention = -1;
-	BUG();
-out:
-	pr_info("QCOM SCM SMC Convention: %lld\n", qcom_smccc_convention);
-}
diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 895f148..059bb0f 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -72,6 +72,13 @@ static struct qcom_scm_wb_entry qcom_scm_wb[] = {
 	{ .flag = QCOM_SCM_FLAG_WARMBOOT_CPU3 },
 };
 
+static const char *qcom_scm_convention_names[] = {
+	[SMC_CONVENTION_UNKNOWN] = "unknown",
+	[SMC_CONVENTION_ARM_32] = "smc arm 32",
+	[SMC_CONVENTION_ARM_64] = "smc arm 64",
+	[SMC_CONVENTION_LEGACY] = "smc legacy",
+};
+
 static struct qcom_scm *__scm;
 
 static int qcom_scm_clk_enable(void)
@@ -107,6 +114,143 @@ static void qcom_scm_clk_disable(void)
 	clk_disable_unprepare(__scm->bus_clk);
 }
 
+static int __qcom_scm_is_call_available(struct device *dev, u32 svc_id,
+					u32 cmd_id);
+
+enum qcom_scm_convention qcom_scm_convention;
+static bool has_queried __read_mostly;
+static DEFINE_SPINLOCK(query_lock);
+
+static void __query_convention(void)
+{
+	unsigned long flags;
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_INFO,
+		.cmd = QCOM_SCM_INFO_IS_CALL_AVAIL,
+		.args[0] = SCM_SMC_FNID(QCOM_SCM_SVC_INFO,
+					   QCOM_SCM_INFO_IS_CALL_AVAIL) |
+			   (ARM_SMCCC_OWNER_SIP << ARM_SMCCC_OWNER_SHIFT),
+		.arginfo = QCOM_SCM_ARGS(1),
+		.owner = ARM_SMCCC_OWNER_SIP,
+	};
+	struct qcom_scm_res res;
+	int ret;
+
+	spin_lock_irqsave(&query_lock, flags);
+	if (has_queried)
+		goto out;
+
+	qcom_scm_convention = SMC_CONVENTION_ARM_64;
+	// Device isn't required as there is only one argument - no device
+	// needed to dma_map_single to secure world
+	ret = scm_smc_call(NULL, &desc, &res, true);
+	if (!ret && res.result[0] == 1)
+		goto out;
+
+	qcom_scm_convention = SMC_CONVENTION_ARM_32;
+	ret = scm_smc_call(NULL, &desc, &res, true);
+	if (!ret && res.result[0] == 1)
+		goto out;
+
+	qcom_scm_convention = SMC_CONVENTION_LEGACY;
+out:
+	has_queried = true;
+	spin_unlock_irqrestore(&query_lock, flags);
+	pr_info("qcom_scm: convention: %s\n",
+		qcom_scm_convention_names[qcom_scm_convention]);
+}
+
+static inline enum qcom_scm_convention __get_convention(void)
+{
+	if (unlikely(!has_queried))
+		__query_convention();
+	return qcom_scm_convention;
+}
+
+/**
+ * qcom_scm_call() - Invoke a syscall in the secure world
+ * @dev:	device
+ * @svc_id:	service identifier
+ * @cmd_id:	command identifier
+ * @desc:	Descriptor structure containing arguments and return values
+ *
+ * Sends a command to the SCM and waits for the command to finish processing.
+ * This should *only* be called in pre-emptible context.
+ */
+static int qcom_scm_call(struct device *dev, const struct qcom_scm_desc *desc,
+			 struct qcom_scm_res *res)
+{
+	might_sleep();
+	switch (__get_convention()) {
+	case SMC_CONVENTION_ARM_32:
+	case SMC_CONVENTION_ARM_64:
+		return scm_smc_call(dev, desc, res, false);
+	case SMC_CONVENTION_LEGACY:
+		return scm_legacy_call(dev, desc, res);
+	default:
+		pr_err("Unknown current SCM calling convention.\n");
+		return -EINVAL;
+	}
+}
+
+/**
+ * qcom_scm_call_atomic() - atomic variation of qcom_scm_call()
+ * @dev:	device
+ * @svc_id:	service identifier
+ * @cmd_id:	command identifier
+ * @desc:	Descriptor structure containing arguments and return values
+ * @res:	Structure containing results from SMC/HVC call
+ *
+ * Sends a command to the SCM and waits for the command to finish processing.
+ * This can be called in atomic context.
+ */
+static int qcom_scm_call_atomic(struct device *dev,
+				const struct qcom_scm_desc *desc,
+				struct qcom_scm_res *res)
+{
+	switch (__get_convention()) {
+	case SMC_CONVENTION_ARM_32:
+	case SMC_CONVENTION_ARM_64:
+		return scm_smc_call(dev, desc, res, true);
+	case SMC_CONVENTION_LEGACY:
+		return scm_legacy_call_atomic(dev, desc, res);
+	default:
+		pr_err("Unknown current SCM calling convention.\n");
+		return -EINVAL;
+	}
+}
+
+static int __qcom_scm_is_call_available(struct device *dev, u32 svc_id,
+					u32 cmd_id)
+{
+	int ret;
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_INFO,
+		.cmd = QCOM_SCM_INFO_IS_CALL_AVAIL,
+		.owner = ARM_SMCCC_OWNER_SIP,
+	};
+	struct qcom_scm_res res;
+
+	desc.arginfo = QCOM_SCM_ARGS(1);
+	switch (__get_convention()) {
+	case SMC_CONVENTION_ARM_32:
+	case SMC_CONVENTION_ARM_64:
+		desc.args[0] = SCM_SMC_FNID(svc_id, cmd_id) |
+				(ARM_SMCCC_OWNER_SIP << ARM_SMCCC_OWNER_SHIFT);
+		break;
+	case SMC_CONVENTION_LEGACY:
+		desc.args[0] = SCM_LEGACY_FNID(svc_id, cmd_id);
+		break;
+	default:
+		pr_err("Unknown SMC convention being used\n");
+		return -EINVAL;
+	}
+
+	ret = qcom_scm_call(dev, &desc, &res);
+
+	return ret ? : res.result[0];
+}
+
 /**
  * qcom_scm_set_warm_boot_addr() - Set the warm boot address for cpus
  * @entry: Entry point function for the cpus
@@ -971,7 +1115,7 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	__scm = scm;
 	__scm->dev = &pdev->dev;
 
-	__qcom_scm_init();
+	__query_convention();
 
 	/*
 	 * If requested enable "download mode", from this point on warmboot
diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
index 9b7b357..d9ed670 100644
--- a/drivers/firmware/qcom_scm.h
+++ b/drivers/firmware/qcom_scm.h
@@ -3,6 +3,16 @@
  */
 #ifndef __QCOM_SCM_INT_H
 #define __QCOM_SCM_INT_H
+
+enum qcom_scm_convention {
+	SMC_CONVENTION_UNKNOWN,
+	SMC_CONVENTION_LEGACY,
+	SMC_CONVENTION_ARM_32,
+	SMC_CONVENTION_ARM_64,
+};
+
+extern enum qcom_scm_convention qcom_scm_convention;
+
 #define MAX_QCOM_SCM_ARGS 10
 #define MAX_QCOM_SCM_RETS 3
 
@@ -50,11 +60,16 @@ struct qcom_scm_res {
 	u64 result[MAX_QCOM_SCM_RETS];
 };
 
-extern int qcom_scm_call(struct device *dev, const struct qcom_scm_desc *desc,
-			 struct qcom_scm_res *res);
-extern int qcom_scm_call_atomic(struct device *dev,
-				const struct qcom_scm_desc *desc,
-				struct qcom_scm_res *res);
+#define SCM_SMC_FNID(s, c)	((((s) & 0xFF) << 8) | ((c) & 0xFF))
+extern int scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
+			struct qcom_scm_res *res, bool atomic);
+
+#define SCM_LEGACY_FNID(s, c)	(((s) << 10) | ((c) & 0x3ff))
+extern int scm_legacy_call_atomic(struct device *dev,
+				  const struct qcom_scm_desc *desc,
+				  struct qcom_scm_res *res);
+extern int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
+			   struct qcom_scm_res *res);
 
 #define QCOM_SCM_SVC_BOOT		0x01
 #define QCOM_SCM_BOOT_SET_ADDR		0x01
@@ -77,8 +92,6 @@ extern int qcom_scm_call_atomic(struct device *dev,
 
 #define QCOM_SCM_SVC_INFO		0x06
 #define QCOM_SCM_INFO_IS_CALL_AVAIL	0x01
-extern int __qcom_scm_is_call_available(struct device *dev, u32 svc_id,
-		u32 cmd_id);
 
 #define QCOM_SCM_SVC_MP				0x0c
 #define QCOM_SCM_MP_RESTORE_SEC_CFG		0x02
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
