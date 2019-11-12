Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 572C3F9C2B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 22:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfKLVYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 16:24:07 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:39224 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbfKLVXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 16:23:22 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A7B0B60D83; Tue, 12 Nov 2019 21:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573593801;
        bh=0UWW0rRiXr5uzuNzBnxmiwinxhzqv4//UV0PjBT639s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZoME8pavg9+yDmDbQ3QMOB/x8RjHrvAX5f1kWZwuPcUP8LEmPbQzmEd3pTqcey97+
         2R0b03AMrfbT4btF0iScB6sKDqPVWRUcDBDQK6jw/cyC3PoOmEbeG6y6i1OnAdd7Gi
         aozMlb5jOp6e0iPj9J8tTSqQijqSBo6DJfCdQETM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from eberman-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: eberman@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A54EC60D7E;
        Tue, 12 Nov 2019 21:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573593793;
        bh=0UWW0rRiXr5uzuNzBnxmiwinxhzqv4//UV0PjBT639s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N43tycCs6JSMLXH5/sZ9F+vuMZPYzmmDQwfdu5DETTu83gPzUSYI3UOWRzLN0oCsY
         XxCwedq8JJHeVeNkffzbp2QS0sNrWwCc85twyvRxami9awDJpgvw4rHTgkglMQphgU
         o+gF0Nv/c0ixq5i/BMdvCcq2Czh9CCKhHFF5HHNo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A54EC60D7E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=eberman@codeaurora.org
From:   Elliot Berman <eberman@codeaurora.org>
To:     bjorn.andersson@linaro.org, saiprakash.ranjan@codeaurora.org,
        agross@kernel.org, swboyd@chromium.org
Cc:     Elliot Berman <eberman@codeaurora.org>, tsoni@codeaurora.org,
        sidgup@codeaurora.org, psodagud@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/18] firmware: qcom_scm-64: Improve SMC convention detection
Date:   Tue, 12 Nov 2019 13:22:46 -0800
Message-Id: <1573593774-12539-11-git-send-email-eberman@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573593774-12539-1-git-send-email-eberman@codeaurora.org>
References: <1573593774-12539-1-git-send-email-eberman@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve the calling convention detection to use
__qcom_scm_is_call_available() and not blindly assume 32-bit mode if
the checks fails.

Signed-off-by: Elliot Berman <eberman@codeaurora.org>
---
 drivers/firmware/qcom_scm-64.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/firmware/qcom_scm-64.c b/drivers/firmware/qcom_scm-64.c
index 977654bb..b82b450 100644
--- a/drivers/firmware/qcom_scm-64.c
+++ b/drivers/firmware/qcom_scm-64.c
@@ -302,21 +302,20 @@ int __qcom_scm_hdcp_req(struct device *dev, struct qcom_scm_hdcp_req *req,
 
 void __qcom_scm_init(void)
 {
-	u64 cmd;
-	struct arm_smccc_res res;
-	u32 function = SMCCC_FUNCNUM(QCOM_SCM_SVC_INFO, QCOM_SCM_INFO_IS_CALL_AVAIL);
-
-	/* First try a SMC64 call */
-	cmd = ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_64,
-				 ARM_SMCCC_OWNER_SIP, function);
-
-	arm_smccc_smc(cmd, QCOM_SCM_ARGS(1), cmd & (~BIT(ARM_SMCCC_TYPE_SHIFT)),
-		      0, 0, 0, 0, 0, &res);
-
-	if (!res.a0 && res.a1)
-		qcom_smccc_convention = ARM_SMCCC_SMC_64;
-	else
-		qcom_smccc_convention = ARM_SMCCC_SMC_32;
+	qcom_smccc_convention = ARM_SMCCC_SMC_64;
+	if (__qcom_scm_is_call_available(NULL, QCOM_SCM_SVC_INFO,
+			QCOM_SCM_INFO_IS_CALL_AVAIL) == 1)
+		goto out;
+
+	qcom_smccc_convention = ARM_SMCCC_SMC_32;
+	if (__qcom_scm_is_call_available(NULL, QCOM_SCM_SVC_INFO,
+			QCOM_SCM_INFO_IS_CALL_AVAIL) == 1)
+		goto out;
+
+	qcom_smccc_convention = -1;
+	BUG();
+out:
+	pr_debug("QCOM SCM SMC Convention: %llu\n", qcom_smccc_convention);
 }
 
 bool __qcom_scm_pas_supported(struct device *dev, u32 peripheral)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

