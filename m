Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFDF01051C9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 12:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfKULuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 06:50:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:39752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727297AbfKULuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 06:50:02 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B014208A3;
        Thu, 21 Nov 2019 11:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574337002;
        bh=DHeiJVQlW7y4ddlQ/LaGON1SaFa79wUh5PTwgg5/o8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=el74vyNOgy/VHH87tsM/060IuAl5FpETWUlRLRujX4ywRbhO1vLc+Mdz+r0QIcr/u
         5hT/M5MSU9uiaFCFGbDm4tvGnrSTh4+gjwbEZtf2S7El9w9lUWx5LayVudOhgcirfY
         lpZJxgLMJfQaVSS/15lL5+O+mC6S1XACegl3T/rw=
From:   Will Deacon <will@kernel.org>
To:     iommu@lists.linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        John Garry <john.garry@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v3 14/14] iommu/arm-smmu: Update my email address in MODULE_AUTHOR()
Date:   Thu, 21 Nov 2019 11:49:18 +0000
Message-Id: <20191121114918.2293-15-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191121114918.2293-1-will@kernel.org>
References: <20191121114918.2293-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I no longer work for Arm, so update the stale reference to my old email
address.

Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/arm-smmu-v3.c | 2 +-
 drivers/iommu/arm-smmu.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index f79b14f75107..7669beafc493 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -3732,5 +3732,5 @@ static struct platform_driver arm_smmu_driver = {
 module_platform_driver(arm_smmu_driver);
 
 MODULE_DESCRIPTION("IOMMU API for ARM architected SMMUv3 implementations");
-MODULE_AUTHOR("Will Deacon <will.deacon@arm.com>");
+MODULE_AUTHOR("Will Deacon <will@kernel.org>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 100ab5b9c255..d55acc48aee3 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -2291,5 +2291,5 @@ static struct platform_driver arm_smmu_driver = {
 module_platform_driver(arm_smmu_driver);
 
 MODULE_DESCRIPTION("IOMMU API for ARM architected SMMU implementations");
-MODULE_AUTHOR("Will Deacon <will.deacon@arm.com>");
+MODULE_AUTHOR("Will Deacon <will@kernel.org>");
 MODULE_LICENSE("GPL v2");
-- 
2.24.0.432.g9d3f5f5b63-goog

