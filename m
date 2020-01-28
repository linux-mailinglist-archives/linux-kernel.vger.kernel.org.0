Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9E114C2C1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 23:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgA1WQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 17:16:24 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:30054 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726266AbgA1WQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 17:16:24 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580249783; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=FXsf/z/1DeoIKgsAIM/dfI6zvYtWCIvxuwhvpm/1k8o=; b=NLdGMSlWVAD6PMFvwgOQ8GP80ZYxTgLvqMbb/k4IcV/BtJEXgTnRzxTqwzdcT5/q6iu2Q2K/
 S/TOm5UwvYcRHBlC3athb+7fp5Uejsj07itjviOdOhgVDSC650xfkpsHGrGsf+1Ge1dS3HMB
 tlYM2+y8rbHeOIDREcZoTmsb6Vk=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e30b2b3.7f907e9094c8-smtp-out-n03;
 Tue, 28 Jan 2020 22:16:19 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 56309C4479F; Tue, 28 Jan 2020 22:16:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 29111C433A2;
        Tue, 28 Jan 2020 22:16:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 29111C433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     iommu@lists.linux-foundation.org
Cc:     robin.murphy@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/6] iommu: Add DOMAIN_ATTR_PTBASE
Date:   Tue, 28 Jan 2020 15:16:05 -0700
Message-Id: <1580249770-1088-2-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580249770-1088-1-git-send-email-jcrouse@codeaurora.org>
References: <1580249770-1088-1-git-send-email-jcrouse@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an attribute to return the base address of the pagetable. This is used
by auxiliary domains from arm-smmu to return the address of the pagetable
to the domain so that it can set the appropriate pagetable through it's
own means.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 include/linux/iommu.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index b14398b..0e9bcd9 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -128,6 +128,8 @@ enum iommu_attr {
 	DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
 	/* Enable split pagetables (for example, TTBR1 on arm-smmu) */
 	DOMAIN_ATTR_SPLIT_TABLES,
+	/* Return the pagetable base address */
+	DOMAIN_ATTR_PTBASE,
 	DOMAIN_ATTR_MAX,
 };
 
-- 
2.7.4
