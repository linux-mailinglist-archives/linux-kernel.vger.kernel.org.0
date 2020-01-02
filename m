Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2762A12E575
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jan 2020 12:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgABLDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jan 2020 06:03:05 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:51448 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728107AbgABLDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 06:03:05 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1577962984; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=Kh5To+EGbT//PbB0ZXQ0h0S3u/fbkwAeO+mv8pFr1t8=; b=SgtyL/a4glJo+wVjcXy7nGH4ZHCHFEucUvu3XVMkh/tC5+DwhopAAn26jFd/EZUlDcAs7JVk
 nRjWXvLakb5Oy5ESw7aCWLu9do9SREQio5BL2kepG5LyJSjU6HWx7zNj9t+6oQpA66+yASLZ
 hIJCQy9znyMNlvFQrTtt37AYidg=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e0dcde5.7f6e5297bfb8-smtp-out-n01;
 Thu, 02 Jan 2020 11:03:01 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 85726C447AC; Thu,  2 Jan 2020 11:03:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from smasetty-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: smasetty)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 40A05C447A9;
        Thu,  2 Jan 2020 11:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 40A05C447A9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=smasetty@codeaurora.org
From:   Sharat Masetty <smasetty@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     dri-devel@freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, will@kernel.org,
        robin.murphy@arm.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org, jcrouse@codeaurora.org,
        saiprakash.ranjan@codeaurora.org,
        Sharat Masetty <smasetty@codeaurora.org>
Subject: [PATCH v2 7/7] drm/msm/a6xx: Add support for using system cache(LLC)
Date:   Thu,  2 Jan 2020 16:32:13 +0530
Message-Id: <1577962933-13577-8-git-send-email-smasetty@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1577962933-13577-1-git-send-email-smasetty@codeaurora.org>
References: <1577962933-13577-1-git-send-email-smasetty@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last level system cache can be partitioned to 32 different slices
of which GPU has two slices preallocated. One slice is used for caching GPU
buffers and the other slice is used for caching the GPU SMMU pagetables.
This patch talks to the core system cache driver to acquire the slice handles,
configure the SCID's to those slices and activates and deactivates the slices
upon GPU power collapse and restore.

Some support from the IOMMU driver is also needed to make use of the
system cache. IOMMU_QCOM_SYS_CACHE is a buffer protection flag which enables
caching GPU data buffers in the system cache with memory attributes such
as outer cacheable, read-allocate, write-allocate for buffers. The GPU
then has the ability to override a few cacheability parameters which it
does to override write-allocate to write-no-allocate as the GPU hardware
does not benefit much from it.

Similarly DOMAIN_ATTR_QCOM_SYS_CACHE is another domain level attribute
used by the IOMMU driver to set the right attributes to cache the hardware
pagetables into the system cache.

Signed-off-by: Sharat Masetty <smasetty@codeaurora.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 100 ++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h |   3 +
 drivers/gpu/drm/msm/msm_iommu.c       |   3 +
 drivers/gpu/drm/msm/msm_mmu.h         |   4 ++
 4 files changed, 110 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index ab562f6..d15eb99f 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -9,6 +9,8 @@
 #include "a6xx_gmu.xml.h"

 #include <linux/devfreq.h>
+#include <linux/bitfield.h>
+#include <linux/soc/qcom/llcc-qcom.h>

 #define GPU_PAS_ID 13

@@ -781,6 +783,81 @@ static void a6xx_bus_clear_pending_transactions(struct adreno_gpu *adreno_gpu)
 	gpu_write(gpu, REG_A6XX_GBIF_HALT, 0x0);
 }

+static void a6xx_llc_rmw(struct a6xx_gpu *a6xx_gpu, u32 reg, u32 mask, u32 or)
+{
+	return msm_rmw(a6xx_gpu->llc_mmio + (reg << 2), mask, or);
+}
+
+static void a6xx_llc_write(struct a6xx_gpu *a6xx_gpu, u32 reg, u32 value)
+{
+	return msm_writel(value, a6xx_gpu->llc_mmio + (reg << 2));
+}
+
+static void a6xx_llc_deactivate(struct a6xx_gpu *a6xx_gpu)
+{
+	llcc_slice_deactivate(a6xx_gpu->llc_slice);
+	llcc_slice_deactivate(a6xx_gpu->htw_llc_slice);
+}
+
+static void a6xx_llc_activate(struct a6xx_gpu *a6xx_gpu)
+{
+	u32 cntl1_regval = 0;
+
+	if (IS_ERR(a6xx_gpu->llc_mmio))
+		return;
+
+	if (!llcc_slice_activate(a6xx_gpu->llc_slice)) {
+		u32 gpu_scid = llcc_get_slice_id(a6xx_gpu->llc_slice);
+
+		gpu_scid &= 0x1f;
+		cntl1_regval = (gpu_scid << 0) | (gpu_scid << 5) |
+			(gpu_scid << 10) | (gpu_scid << 15) | (gpu_scid << 20);
+	}
+
+	if (!llcc_slice_activate(a6xx_gpu->htw_llc_slice)) {
+		u32 gpuhtw_scid = llcc_get_slice_id(a6xx_gpu->htw_llc_slice);
+
+		gpuhtw_scid &= 0x1f;
+		cntl1_regval |= FIELD_PREP(GENMASK(29, 25), gpuhtw_scid);
+	}
+
+	if (cntl1_regval) {
+		/*
+		 * Program the slice IDs for the various GPU blocks and GPU MMU
+		 * pagetables
+		 */
+		a6xx_llc_write(a6xx_gpu, REG_A6XX_CX_MISC_SYSTEM_CACHE_CNTL_1,
+				cntl1_regval);
+
+		/*
+		 * Program cacheability overrides to not allocate cache lines on
+		 * a write miss
+		 */
+		a6xx_llc_rmw(a6xx_gpu, REG_A6XX_CX_MISC_SYSTEM_CACHE_CNTL_0,
+				0xF, 0x03);
+	}
+}
+
+static void a6xx_llc_slices_destroy(struct a6xx_gpu *a6xx_gpu)
+{
+	llcc_slice_putd(a6xx_gpu->llc_slice);
+	llcc_slice_putd(a6xx_gpu->htw_llc_slice);
+}
+
+static void a6xx_llc_slices_init(struct platform_device *pdev,
+		struct a6xx_gpu *a6xx_gpu)
+{
+	a6xx_gpu->llc_mmio = msm_ioremap(pdev, "cx_mem", "gpu_cx");
+	if (IS_ERR(a6xx_gpu->llc_mmio))
+		return;
+
+	a6xx_gpu->llc_slice = llcc_slice_getd(LLCC_GPU);
+	a6xx_gpu->htw_llc_slice = llcc_slice_getd(LLCC_GPUHTW);
+
+	if (IS_ERR(a6xx_gpu->llc_slice) && IS_ERR(a6xx_gpu->htw_llc_slice))
+		a6xx_gpu->llc_mmio = ERR_PTR(-EINVAL);
+}
+
 static int a6xx_pm_resume(struct msm_gpu *gpu)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
@@ -795,6 +872,8 @@ static int a6xx_pm_resume(struct msm_gpu *gpu)

 	msm_gpu_resume_devfreq(gpu);

+	a6xx_llc_activate(a6xx_gpu);
+
 	return 0;
 }

@@ -803,6 +882,8 @@ static int a6xx_pm_suspend(struct msm_gpu *gpu)
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);

+	a6xx_llc_deactivate(a6xx_gpu);
+
 	devfreq_suspend_device(gpu->devfreq.devfreq);

 	/*
@@ -851,6 +932,7 @@ static void a6xx_destroy(struct msm_gpu *gpu)
 		drm_gem_object_put_unlocked(a6xx_gpu->sqe_bo);
 	}

+	a6xx_llc_slices_destroy(a6xx_gpu);
 	a6xx_gmu_remove(a6xx_gpu);

 	adreno_gpu_cleanup(adreno_gpu);
@@ -881,6 +963,8 @@ static unsigned long a6xx_gpu_busy(struct msm_gpu *gpu)
 static struct msm_gem_address_space *
 a6xx_create_address_space(struct msm_gpu *gpu, struct platform_device *pdev)
 {
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
 	struct iommu_domain *iommu = iommu_domain_alloc(&platform_bus_type);
 	struct msm_gem_address_space *aspace;
 	struct msm_mmu *mmu;
@@ -894,6 +978,20 @@ static unsigned long a6xx_gpu_busy(struct msm_gpu *gpu)
 		return ERR_CAST(mmu);
 	}

+	if (!IS_ERR(a6xx_gpu->llc_slice))
+		mmu->features |= MMU_FEATURE_USE_SYSTEM_CACHE;
+
+	/*
+	 * This allows GPU to set the bus attributes required to use system
+	 * cache on behalf of the iommu page table walker.
+	 */
+	if (!IS_ERR(a6xx_gpu->htw_llc_slice)) {
+		int gpu_htw_llc = 1;
+
+		iommu_domain_set_attr(iommu, DOMAIN_ATTR_QCOM_SYS_CACHE,
+				&gpu_htw_llc);
+	}
+
 	aspace = msm_gem_address_space_create(mmu, "gpu", SZ_16M, 0xffffffff);
 	if (IS_ERR(aspace))
 		mmu->funcs->destroy(mmu);
@@ -948,6 +1046,8 @@ struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
 	adreno_gpu->registers = NULL;
 	adreno_gpu->reg_offsets = a6xx_register_offsets;

+	a6xx_llc_slices_init(pdev, a6xx_gpu);
+
 	ret = adreno_gpu_init(dev, pdev, adreno_gpu, &funcs, 1);
 	if (ret) {
 		a6xx_destroy(&(a6xx_gpu->base.base));
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 7239b8b..9004344 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -21,6 +21,9 @@ struct a6xx_gpu {
 	struct msm_ringbuffer *cur_ring;

 	struct a6xx_gmu gmu;
+	void __iomem *llc_mmio;
+	void *llc_slice;
+	void *htw_llc_slice;
 };

 #define to_a6xx_gpu(x) container_of(x, struct a6xx_gpu, base)
diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index 2ec08daf..3c41c4a 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -37,6 +37,9 @@ static int msm_iommu_map(struct msm_mmu *mmu, uint64_t iova,
 	struct msm_iommu *iommu = to_msm_iommu(mmu);
 	size_t ret;

+	if (mmu->features & MMU_FEATURE_USE_SYSTEM_CACHE)
+		prot |= IOMMU_QCOM_SYS_CACHE;
+
 	ret = iommu_map_sg(iommu->domain, iova, sgt->sgl, sgt->nents, prot);
 	WARN_ON(!ret);

diff --git a/drivers/gpu/drm/msm/msm_mmu.h b/drivers/gpu/drm/msm/msm_mmu.h
index e4029b0..753443c 100644
--- a/drivers/gpu/drm/msm/msm_mmu.h
+++ b/drivers/gpu/drm/msm/msm_mmu.h
@@ -17,11 +17,15 @@ struct msm_mmu_funcs {
 	void (*destroy)(struct msm_mmu *mmu);
 };

+/* MMU features */
+#define MMU_FEATURE_USE_SYSTEM_CACHE (1 << 0)
+
 struct msm_mmu {
 	const struct msm_mmu_funcs *funcs;
 	struct device *dev;
 	int (*handler)(void *arg, unsigned long iova, int flags);
 	void *arg;
+	u32 features;
 };

 static inline void msm_mmu_init(struct msm_mmu *mmu, struct device *dev,
--
1.9.1
