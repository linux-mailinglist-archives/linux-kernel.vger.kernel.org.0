Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A448917A492
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 12:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgCELsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 06:48:12 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:28475 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727112AbgCELsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 06:48:11 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583408890; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=Xm0f9iLG1kfIa4GEsMoG6L2oVuckGJKpJtznF776PRM=; b=GijTBdWo5fthMH945k3S+WNkGCHFary27asculrwwTkF9/fLGT7CJ0BHhUJy4IwsDbycA8Le
 tiU9Z8gMY3KUQ+6c0emnRobaCiDf8q2XV+HXb5iItYjKfOgnutNtd3bQ+QFRfNnybVLkteGZ
 EBEG02g9zOiC6vQJWnEeQURSw04=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e60e6fa.7f6e36f65030-smtp-out-n01;
 Thu, 05 Mar 2020 11:48:10 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6FD21C447A2; Thu,  5 Mar 2020 11:48:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mkshah-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D95E7C4479F;
        Thu,  5 Mar 2020 11:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D95E7C4479F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
From:   Maulik Shah <mkshah@codeaurora.org>
To:     swboyd@chromium.org, mka@chromium.org, evgreen@chromium.org,
        bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org,
        Maulik Shah <mkshah@codeaurora.org>
Subject: [PATCH v11 3/4] soc: qcom: rpmh: Invoke rpmh_flush() for dirty caches
Date:   Thu,  5 Mar 2020 17:17:35 +0530
Message-Id: <1583408856-1120-4-git-send-email-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583408856-1120-1-git-send-email-mkshah@codeaurora.org>
References: <1583408856-1120-1-git-send-email-mkshah@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add changes to invoke rpmh flush() from within cache_lock when the data
in cache is dirty.

This is done only if OSI is not supported in PSCI. If OSI is supported
rpmh_flush can get invoked when the last cpu going to power collapse
deepest low power mode.

Also remove "depends on COMPILE_TEST" for Kconfig option QCOM_RPMH so the
driver is only compiled for arm64 which supports psci_has_osi_support()
API.

Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
Reviewed-by: Srinivas Rao L <lsrao@codeaurora.org>
---
 drivers/soc/qcom/rpmh.c | 49 +++++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index 03630ae..1951f6a 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/psci.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
@@ -113,13 +114,14 @@ static struct cache_req *__find_req(struct rpmh_ctrlr *ctrlr, u32 addr)
 	return req;
 }
 
-static struct cache_req *cache_rpm_request(struct rpmh_ctrlr *ctrlr,
+static int cache_rpm_request(struct rpmh_ctrlr *ctrlr,
 					   enum rpmh_state state,
 					   struct tcs_cmd *cmd)
 {
 	struct cache_req *req;
 	unsigned long flags;
 	u32 old_sleep_val, old_wake_val;
+	int ret = 0;
 
 	spin_lock_irqsave(&ctrlr->cache_lock, flags);
 	req = __find_req(ctrlr, cmd->addr);
@@ -155,10 +157,13 @@ static struct cache_req *cache_rpm_request(struct rpmh_ctrlr *ctrlr,
 			req->sleep_val != UINT_MAX &&
 			req->wake_val != UINT_MAX;
 
+	if (ctrlr->dirty && !psci_has_osi_support())
+		ret = rpmh_flush(ctrlr);
+
 unlock:
 	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
 
-	return req;
+	return ret;
 }
 
 /**
@@ -176,17 +181,16 @@ static int __rpmh_write(const struct device *dev, enum rpmh_state state,
 			struct rpmh_request *rpm_msg)
 {
 	struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
-	int ret = -EINVAL;
-	struct cache_req *req;
+	int ret;
 	int i;
 
 	rpm_msg->msg.state = state;
 
 	/* Cache the request in our store and link the payload */
 	for (i = 0; i < rpm_msg->msg.num_cmds; i++) {
-		req = cache_rpm_request(ctrlr, state, &rpm_msg->msg.cmds[i]);
-		if (IS_ERR(req))
-			return PTR_ERR(req);
+		ret = cache_rpm_request(ctrlr, state, &rpm_msg->msg.cmds[i]);
+		if (ret)
+			return ret;
 	}
 
 	rpm_msg->msg.state = state;
@@ -283,26 +287,32 @@ int rpmh_write(const struct device *dev, enum rpmh_state state,
 }
 EXPORT_SYMBOL(rpmh_write);
 
-static void cache_batch(struct rpmh_ctrlr *ctrlr, struct batch_cache_req *req)
+static int cache_batch(struct rpmh_ctrlr *ctrlr, struct batch_cache_req *req)
 {
 	unsigned long flags;
+	int ret = 0;
 
 	spin_lock_irqsave(&ctrlr->cache_lock, flags);
+
 	list_add_tail(&req->list, &ctrlr->batch_cache);
 	ctrlr->dirty = true;
+
+	if (!psci_has_osi_support())
+		ret = rpmh_flush(ctrlr);
+
 	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
+
+	return ret;
 }
 
 static int flush_batch(struct rpmh_ctrlr *ctrlr)
 {
 	struct batch_cache_req *req;
 	const struct rpmh_request *rpm_msg;
-	unsigned long flags;
 	int ret = 0;
 	int i;
 
 	/* Send Sleep/Wake requests to the controller, expect no response */
-	spin_lock_irqsave(&ctrlr->cache_lock, flags);
 	list_for_each_entry(req, &ctrlr->batch_cache, list) {
 		for (i = 0; i < req->count; i++) {
 			rpm_msg = req->rpm_msgs + i;
@@ -312,7 +322,6 @@ static int flush_batch(struct rpmh_ctrlr *ctrlr)
 				break;
 		}
 	}
-	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
 
 	return ret;
 }
@@ -384,10 +393,8 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
 		cmd += n[i];
 	}
 
-	if (state != RPMH_ACTIVE_ONLY_STATE) {
-		cache_batch(ctrlr, req);
-		return 0;
-	}
+	if (state != RPMH_ACTIVE_ONLY_STATE)
+		return cache_batch(ctrlr, req);
 
 	for (i = 0; i < count; i++) {
 		struct completion *compl = &compls[i];
@@ -450,12 +457,10 @@ static int send_single(struct rpmh_ctrlr *ctrlr, enum rpmh_state state,
  *
  * @ctrlr: controller making request to flush cached data
  *
- * Return: -EBUSY if the controller is busy, probably waiting on a response
- * to a RPMH request sent earlier.
+ * Return: 0 on success, error number otherwise.
  *
- * This function is always called from the sleep code from the last CPU
- * that is powering down the entire system. Since no other RPMH API would be
- * executing at this time, it is safe to run lockless.
+ * This function can either be called from sleep code on the last CPU
+ * (thus no spinlock needed) or with the ctrlr->cache_lock already held.
  */
 int rpmh_flush(struct rpmh_ctrlr *ctrlr)
 {
@@ -472,10 +477,6 @@ int rpmh_flush(struct rpmh_ctrlr *ctrlr)
 	if (ret)
 		return ret;
 
-	/*
-	 * Nobody else should be calling this function other than system PM,
-	 * hence we can run without locks.
-	 */
 	list_for_each_entry(p, &ctrlr->cache, list) {
 		if (!is_req_valid(p)) {
 			pr_debug("%s: skipping RPMH req: a:%#x s:%#x w:%#x",
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
