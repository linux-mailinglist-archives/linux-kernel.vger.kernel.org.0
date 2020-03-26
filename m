Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56E1A194271
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 16:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgCZPIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 11:08:53 -0400
Received: from 8bytes.org ([81.169.241.247]:55804 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727803AbgCZPIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 11:08:48 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id A256357; Thu, 26 Mar 2020 16:08:45 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-mediatek@lists.infradead.org, guohanjun@huawei.com,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH v4 01/16] iommu: Define dev_iommu_fwspec_get() for !CONFIG_IOMMU_API
Date:   Thu, 26 Mar 2020 16:08:26 +0100
Message-Id: <20200326150841.10083-2-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326150841.10083-1-joro@8bytes.org>
References: <20200326150841.10083-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

There are users outside of the IOMMU code that need to call that
function. Define it for !CONFIG_IOMMU_API too so that compilation does
not break.

Reported-by: kbuild test robot <lkp@intel.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 include/linux/iommu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d1b5f4d98569..3c4ca041d7a2 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1073,6 +1073,10 @@ static inline int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
 	return -ENODEV;
 }
 
+static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *dev)
+{
+	return NULL;
+}
 #endif /* CONFIG_IOMMU_API */
 
 #ifdef CONFIG_IOMMU_DEBUGFS
-- 
2.17.1

