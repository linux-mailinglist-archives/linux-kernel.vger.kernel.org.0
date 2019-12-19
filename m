Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45F5C12632E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 14:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfLSNPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 08:15:44 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:21907 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726836AbfLSNPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 08:15:41 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576761340; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=ey3WkaTUT+/okXLTbhjw6mNVNY5gdOyxxVH0V4Lo0/s=; b=XrlYHBAtQB9vg5mUzSGUC7nGegbC4YXHHpS0lgEzxsvbHQt95xMqWu2JuldEErcafanfzTMI
 iPxnI6j0lASm1O6NRroSzMkrfKo/zL9n0/9bxwM4M4Kngt46W7+Tb11tZxS21aav/nmas1fV
 7rWiXsXPA5wjoe73lNMr9TOhbng=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfb77fb.7f43022f38b8-smtp-out-n03;
 Thu, 19 Dec 2019 13:15:39 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C3A2EC447A4; Thu, 19 Dec 2019 13:15:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from smasetty-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: smasetty)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 80E02C447A5;
        Thu, 19 Dec 2019 13:15:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 80E02C447A5
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=smasetty@codeaurora.org
From:   Sharat Masetty <smasetty@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     dri-devel@freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, will@kernel.org,
        robin.murphy@arm.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org, jcrouse@codeaurora.org,
        saiprakash.ranjan@codeaurora.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH 2/5] iommu/arm-smmu: Add domain attribute for QCOM system cache
Date:   Thu, 19 Dec 2019 18:44:43 +0530
Message-Id: <1576761286-20451-3-git-send-email-smasetty@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1576761286-20451-1-git-send-email-smasetty@codeaurora.org>
References: <1576761286-20451-1-git-send-email-smasetty@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vivek Gautam <vivek.gautam@codeaurora.org>

Add iommu domain attribute for using system cache aka last level
cache on QCOM SoCs by client drivers like GPU to set right
attributes for caching the hardware pagetables into the system cache.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Co-developed-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 drivers/iommu/arm-smmu-qcom.c | 10 ++++++++++
 drivers/iommu/arm-smmu.c      | 14 ++++++++++++++
 drivers/iommu/arm-smmu.h      |  1 +
 include/linux/iommu.h         |  1 +
 4 files changed, 26 insertions(+)

diff --git a/drivers/iommu/arm-smmu-qcom.c b/drivers/iommu/arm-smmu-qcom.c
index 24c071c..d1d22df 100644
--- a/drivers/iommu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm-smmu-qcom.c
@@ -30,7 +30,17 @@ static int qcom_sdm845_smmu500_reset(struct arm_smmu_device *smmu)
 	return ret;
 }
 
+static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
+				  struct io_pgtable_cfg *pgtbl_cfg)
+{
+	if (smmu_domain->sys_cache)
+		pgtbl_cfg->coherent_walk = false;
+
+	return 0;
+}
+
 static const struct arm_smmu_impl qcom_smmu_impl = {
+	.init_context = qcom_smmu_init_context,
 	.reset = qcom_sdm845_smmu500_reset,
 };
 
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 4f7e0c0..055b548 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1466,6 +1466,9 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
 		case DOMAIN_ATTR_NESTING:
 			*(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
 			return 0;
+		case DOMAIN_ATTR_QCOM_SYS_CACHE:
+			*((int *)data) = smmu_domain->sys_cache;
+			return 0;
 		default:
 			return -ENODEV;
 		}
@@ -1506,6 +1509,17 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
 			else
 				smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
 			break;
+		case DOMAIN_ATTR_QCOM_SYS_CACHE:
+			if (smmu_domain->smmu) {
+				ret = -EPERM;
+				goto out_unlock;
+			}
+
+			if (*((int *)data))
+				smmu_domain->sys_cache = true;
+			else
+				smmu_domain->sys_cache = false;
+			break;
 		default:
 			ret = -ENODEV;
 		}
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index f57cdbe..8aeaaf0 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -322,6 +322,7 @@ struct arm_smmu_domain {
 	struct mutex			init_mutex; /* Protects smmu pointer */
 	spinlock_t			cb_lock; /* Serialises ATS1* ops and TLB syncs */
 	struct iommu_domain		domain;
+	bool				sys_cache;
 };
 
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 0c60e75..bd61c60 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -127,6 +127,7 @@ enum iommu_attr {
 	DOMAIN_ATTR_FSL_PAMUV1,
 	DOMAIN_ATTR_NESTING,	/* two stages of translation */
 	DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
+	DOMAIN_ATTR_QCOM_SYS_CACHE,
 	DOMAIN_ATTR_MAX,
 };
 
-- 
1.9.1
