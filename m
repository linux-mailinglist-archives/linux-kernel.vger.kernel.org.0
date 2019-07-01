Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38AF425522
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 18:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbfEUQOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 12:14:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58054 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728533AbfEUQOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 12:14:23 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1B380611FB; Tue, 21 May 2019 16:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558455262;
        bh=aGKLQAv1Wqo3iK9as+fTnW2wvo10dYipLbiZ+tTw6Qw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P67f9DuVuSI/OYxypF+ICnm2C4cvfpQN0sAcO368lOjJALeooaTKx7vix8hs+NMmH
         scqlRcZ5+urgTrih933Hs5for5q3k70VLEZlxbdsgNfwMzCVxwHV+dpGIL4dPCmMP6
         g08u4a7QzUexzIOIruXZtQl92UAnMFgB8jHqGwD0=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E5A3D60DB6;
        Tue, 21 May 2019 16:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558455252;
        bh=aGKLQAv1Wqo3iK9as+fTnW2wvo10dYipLbiZ+tTw6Qw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XbU4KG7BYVeqP+pX8713MzxW2ReuMEqPxBK8OCaomYnCqk8nnntMi+KsdEGJmYd5g
         dsnmVx8AfWokWZKPswurOQCdDIMEfd/ixPvupQlqrlcnErZFxfEY7224yQWRsaXXcN
         CbzeGwNUrHrmrp5uZJc7OAE1Wn8ubV85ZOddO/Cw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E5A3D60DB6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     jean-philippe.brucker@arm.com, linux-arm-msm@vger.kernel.org,
        hoegsberg@google.com, dianders@chromium.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 01/15] iommu/arm-smmu: Allow IOMMU enabled devices to skip DMA domains
Date:   Tue, 21 May 2019 10:13:49 -0600
Message-Id: <1558455243-32746-2-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558455243-32746-1-git-send-email-jcrouse@codeaurora.org>
References: <1558455243-32746-1-git-send-email-jcrouse@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow IOMMU enabled devices specified on an opt-in list to create a
default identity domain for a new IOMMU group and bypass the DMA
domain created by the IOMMU core. This allows the group to be properly
set up but otherwise skips touching the hardware until the client
device attaches a unmanaged domain of its own.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/iommu/arm-smmu.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c    | 29 +++++++++++++++++++++++------
 include/linux/iommu.h    |  3 +++
 3 files changed, 68 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 5e54cc0..a795ada 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1235,6 +1235,35 @@ static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
 	return 0;
 }
 
+struct arm_smmu_client_match_data {
+	bool use_identity_domain;
+};
+
+static const struct arm_smmu_client_match_data qcom_adreno = {
+	.use_identity_domain = true,
+};
+
+static const struct arm_smmu_client_match_data qcom_mdss = {
+	.use_identity_domain = true,
+};
+
+static const struct of_device_id arm_smmu_client_of_match[] = {
+	{ .compatible = "qcom,adreno", .data = &qcom_adreno },
+	{ .compatible = "qcom,mdp4", .data = &qcom_mdss },
+	{ .compatible = "qcom,mdss", .data = &qcom_mdss },
+	{ .compatible = "qcom,sdm845-mdss", .data = &qcom_mdss },
+	{},
+};
+
+static const struct arm_smmu_client_match_data *
+arm_smmu_client_data(struct device *dev)
+{
+	const struct of_device_id *match =
+		of_match_device(arm_smmu_client_of_match, dev);
+
+	return match ? match->data : NULL;
+}
+
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	int ret;
@@ -1552,6 +1581,7 @@ static struct iommu_group *arm_smmu_device_group(struct device *dev)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct arm_smmu_device *smmu = fwspec_smmu(fwspec);
+	const struct arm_smmu_client_match_data *client;
 	struct iommu_group *group = NULL;
 	int i, idx;
 
@@ -1573,6 +1603,18 @@ static struct iommu_group *arm_smmu_device_group(struct device *dev)
 	else
 		group = generic_device_group(dev);
 
+	client = arm_smmu_client_data(dev);
+
+	/*
+	 * If the client chooses to bypass the dma domain, create a identity
+	 * domain as a default placeholder. This will give the device a
+	 * default domain but skip DMA operations and not consume a context
+	 * bank
+	 */
+	if (client && client->no_dma_domain)
+		iommu_group_set_default_domain(group, dev,
+			IOMMU_DOMAIN_IDENTITY);
+
 	return group;
 }
 
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 67ee662..af3e1ed 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1062,6 +1062,24 @@ struct iommu_group *fsl_mc_device_group(struct device *dev)
 	return group;
 }
 
+struct iommu_domain *iommu_group_set_default_domain(struct iommu_group *group,
+		struct device *dev, unsigned int type)
+{
+	struct iommu_domain *dom;
+
+	dom = __iommu_domain_alloc(dev->bus, type);
+	if (!dom)
+		return NULL;
+
+	/* FIXME: Error if the default domain is already set? */
+	group->default_domain = dom;
+	if (!group->domain)
+		group->domain = dom;
+
+	return dom;
+}
+EXPORT_SYMBOL_GPL(iommu_group_set_default_domain);
+
 /**
  * iommu_group_get_for_dev - Find or create the IOMMU group for a device
  * @dev: target device
@@ -1099,9 +1117,12 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 	if (!group->default_domain) {
 		struct iommu_domain *dom;
 
-		dom = __iommu_domain_alloc(dev->bus, iommu_def_domain_type);
+		dom = iommu_group_set_default_domain(group, dev,
+			iommu_def_domain_type);
+
 		if (!dom && iommu_def_domain_type != IOMMU_DOMAIN_DMA) {
-			dom = __iommu_domain_alloc(dev->bus, IOMMU_DOMAIN_DMA);
+			dom = iommu_group_set_default_domain(group, dev,
+				IOMMU_DOMAIN_DMA);
 			if (dom) {
 				dev_warn(dev,
 					 "failed to allocate default IOMMU domain of type %u; falling back to IOMMU_DOMAIN_DMA",
@@ -1109,10 +1130,6 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 			}
 		}
 
-		group->default_domain = dom;
-		if (!group->domain)
-			group->domain = dom;
-
 		if (dom && !iommu_dma_strict) {
 			int attr = 1;
 			iommu_domain_set_attr(dom,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a815cf6..4ef8bd5 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -394,6 +394,9 @@ extern int iommu_group_id(struct iommu_group *group);
 extern struct iommu_group *iommu_group_get_for_dev(struct device *dev);
 extern struct iommu_domain *iommu_group_default_domain(struct iommu_group *);
 
+struct iommu_domain *iommu_group_set_default_domain(struct iommu_group *group,
+		struct device *dev, unsigned int type);
+
 extern int iommu_domain_get_attr(struct iommu_domain *domain, enum iommu_attr,
 				 void *data);
 extern int iommu_domain_set_attr(struct iommu_domain *domain, enum iommu_attr,
-- 
2.7.4

