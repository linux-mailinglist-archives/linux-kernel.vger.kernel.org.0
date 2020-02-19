Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5C4316425B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 11:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgBSKkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 05:40:49 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:55550 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726803AbgBSKkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 05:40:47 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582108846; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=3oBp+GQXIvHz9eMsTaJ9GKjk778UhbK5cdSMUYMH/24=; b=OdXpaTrHNm/B0FOs9CHXJKTMSYi17V5MnKgrVuFd3jQ5dmdkVoxKEbXX8DYrVXSUf0/2AYhx
 ZnzxcX9fvxzOIylgdC4mt4HRGzdsrf7tDah1ZPuqxZwmplHdizwj5ZQ5Roi1Kc4Igs6pqrZ9
 GrFT01T7D8RRtZ0Rla59UOIw0QI=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4d10ae.7f8e92e272d0-smtp-out-n03;
 Wed, 19 Feb 2020 10:40:46 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0281AC447A4; Wed, 19 Feb 2020 10:40:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from mkshah-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 96BE1C447A0;
        Wed, 19 Feb 2020 10:40:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 96BE1C447A0
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
From:   Maulik Shah <mkshah@codeaurora.org>
To:     swboyd@chromium.org, mka@chromium.org, evgreen@chromium.org,
        bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org,
        Maulik Shah <mkshah@codeaurora.org>
Subject: [PATCH v5 4/7] drivers: qcom: rpmh-rsc: Add RSC power domain support
Date:   Wed, 19 Feb 2020 16:10:07 +0530
Message-Id: <1582108810-21263-5-git-send-email-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582108810-21263-1-git-send-email-mkshah@codeaurora.org>
References: <1582108810-21263-1-git-send-email-mkshah@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add RSC power domain support. RSC is top level power domain in
hireachical CPU LPM modes. Once the rsc domain is down flush all
cached sleep and wake votes from controller.

Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
---
 drivers/soc/qcom/rpmh-internal.h |  2 +
 drivers/soc/qcom/rpmh-rsc.c      | 81 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
index 6eec32b..3736c14 100644
--- a/drivers/soc/qcom/rpmh-internal.h
+++ b/drivers/soc/qcom/rpmh-internal.h
@@ -8,6 +8,7 @@
 #define __RPM_INTERNAL_H__
 
 #include <linux/bitmap.h>
+#include <linux/pm_domain.h>
 #include <soc/qcom/tcs.h>
 
 #define TCS_TYPE_NR			4
@@ -102,6 +103,7 @@ struct rsc_drv {
 	DECLARE_BITMAP(tcs_in_use, MAX_TCS_NR);
 	spinlock_t lock;
 	struct rpmh_ctrlr client;
+	struct generic_pm_domain rsc_pd;
 };
 
 int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg);
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index e278fc1..92bca4c 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -499,6 +499,32 @@ static int tcs_ctrl_write(struct rsc_drv *drv, const struct tcs_request *msg)
 }
 
 /**
+ * rpmh_rsc_ctrlr_is_idle: Check if any of the AMCs are busy.
+ *
+ * @drv: The controller
+ *
+ * Return: false if the TCSes are engaged in handling requests, True otherwise.
+ */
+static bool rpmh_rsc_ctrlr_is_idle(struct rsc_drv *drv)
+{
+	int m;
+	struct tcs_group *tcs = get_tcs_of_type(drv, ACTIVE_TCS);
+	bool ret = true;
+	unsigned long flags;
+
+	spin_lock_irqsave(&drv->lock, flags);
+	for (m = tcs->offset; m < tcs->offset + tcs->num_tcs; m++) {
+		if (!tcs_is_free(drv, m)) {
+			ret = false;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&drv->lock, flags);
+
+	return ret;
+}
+
+/**
  * rpmh_rsc_write_ctrl_data: Write request to the controller
  *
  * @drv: the controller
@@ -521,6 +547,50 @@ int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv, const struct tcs_request *msg)
 	return tcs_ctrl_write(drv, msg);
 }
 
+static int rpmh_domain_power_off(struct generic_pm_domain *rsc_pd)
+{
+	struct rsc_drv *drv = container_of(rsc_pd, struct rsc_drv, rsc_pd);
+
+	/*
+	 * RPMh domain can not be powered off when there is pending ACK for
+	 * ACTIVE_TCS request. Exit when controller is busy.
+	 */
+	if (!rpmh_rsc_ctrlr_is_idle(drv))
+		return -EBUSY;
+
+	return rpmh_flush(&drv->client);
+}
+
+static int rpmh_probe_power_domain(struct platform_device *pdev,
+				   struct rsc_drv *drv)
+{
+	int ret;
+	struct generic_pm_domain *rsc_pd = &drv->rsc_pd;
+	struct device_node *dn = pdev->dev.of_node;
+
+	rsc_pd->name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s", dn->name);
+	if (!rsc_pd->name)
+		return -ENOMEM;
+
+	rsc_pd->name = kbasename(rsc_pd->name);
+	rsc_pd->power_off = rpmh_domain_power_off;
+	rsc_pd->flags |= GENPD_FLAG_IRQ_SAFE;
+
+	ret = pm_genpd_init(rsc_pd, NULL, false);
+	if (ret)
+		return ret;
+
+	ret = of_genpd_add_provider_simple(dn, rsc_pd);
+	if (ret)
+		goto remove_pd;
+
+	return ret;
+
+remove_pd:
+	pm_genpd_remove(rsc_pd);
+	return ret;
+}
+
 static int rpmh_probe_tcs_config(struct platform_device *pdev,
 				 struct rsc_drv *drv)
 {
@@ -663,6 +733,17 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	/*
+	 * Power domain is not required for controllers that support 'solver'
+	 * mode where they can be in autonomous mode executing low power mode
+	 * to power down.
+	 */
+	if (of_property_read_bool(dn, "#power-domain-cells")) {
+		ret = rpmh_probe_power_domain(pdev, drv);
+		if (ret)
+			return ret;
+	}
+
 	/* Enable the active TCS to send requests immediately */
 	write_tcs_reg(drv, RSC_DRV_IRQ_ENABLE, 0, drv->tcs[ACTIVE_TCS].mask);
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
