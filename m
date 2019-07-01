Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCF192E6C9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 22:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfE2U4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 16:56:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60616 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfE2U4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 16:56:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DC915618F6; Wed, 29 May 2019 20:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559163376;
        bh=8eb3TT7qBqZKcSLWpPylJf4TCDyFQpG0l2uLmE4Jm3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZFOOvJJHvgpRUhO6cTXunqkO4r/0udV88jqpoSD3I/ylElt6Q8XiBTGTHEAuC6OYb
         rKbBOWjQ+Oj187Il6kCyWS4gszNShKYoOqqf/WUHEWBv8w+x+0OYzdSxLvoGtnDZV4
         NkZuVeonVP+ZHMbRJmqpq9lQOTEtz4dPoFj2mSyc=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0D94761A20;
        Wed, 29 May 2019 20:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559163354;
        bh=8eb3TT7qBqZKcSLWpPylJf4TCDyFQpG0l2uLmE4Jm3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mAEg4epFJbBDBMF194fxxqjbBJO0LX4xNb2jftwJYexCO50YVqtFW9U8a8s7D5CrM
         vzoMy4rYlVnnSKPxekgOfdHQiGQWjIpRy88CIkwaaH5VR4XrNuPSDn4SMR3s4jqR/3
         bRjWLbFdR18Z/JTFd/9C3r3QqqOv0VAaLIgeWE80=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0D94761A20
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     jean-philippe.brucker@arm.com, linux-arm-msm@vger.kernel.org,
        hoegsberg@google.com, dianders@chromium.org,
        Sean Paul <sean@poorly.run>,
        Sharat Masetty <smasetty@codeaurora.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v3 15/16] drm/msm/a6xx: Support per-instance pagetables
Date:   Wed, 29 May 2019 14:54:51 -0600
Message-Id: <1559163292-4792-16-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559163292-4792-1-git-send-email-jcrouse@codeaurora.org>
References: <1559163292-4792-1-git-send-email-jcrouse@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for per-instance pagetables for a6xx targets. Add support
to handle split pagetables and create a new instance if the needed
IOMMU support exists and insert the necessary PM4 commands to trigger
a pagetable switch at the beginning of a user command.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 123 ++++++++++++++++++++++++++++++++--
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h |   1 +
 2 files changed, 120 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 3d70588..1be8bfc 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -12,6 +12,62 @@
 
 #define GPU_PAS_ID 13
 
+static void a6xx_set_pagetable(struct msm_gpu *gpu, struct msm_ringbuffer *ring,
+	struct msm_file_private *ctx)
+{
+	u64 ttbr;
+	u32 asid;
+
+	if (!msm_iommu_get_ptinfo(ctx->aspace->mmu, &ttbr, &asid))
+		return;
+
+	ttbr = ttbr | ((u64) asid) << 48;
+
+	/* Turn off protected mode */
+	OUT_PKT7(ring, CP_SET_PROTECTED_MODE, 1);
+	OUT_RING(ring, 0);
+
+	/* Turn on APIV mode to access critical regions */
+	OUT_PKT4(ring, REG_A6XX_CP_MISC_CNTL, 1);
+	OUT_RING(ring, 1);
+
+	/* Make sure the ME is synchronized before staring the update */
+	OUT_PKT7(ring, CP_WAIT_FOR_ME, 0);
+
+	/* Execute the table update */
+	OUT_PKT7(ring, CP_SMMU_TABLE_UPDATE, 4);
+	OUT_RING(ring, lower_32_bits(ttbr));
+	OUT_RING(ring, upper_32_bits(ttbr));
+	/* CONTEXTIDR is currently unused */
+	OUT_RING(ring, 0);
+	/* CONTEXTBANK is currently unused */
+	OUT_RING(ring, 0);
+
+	/*
+	 * Write the new TTBR0 to the preemption records - this will be used to
+	 * reload the pagetable if the current ring gets preempted out.
+	 */
+	OUT_PKT7(ring, CP_MEM_WRITE, 4);
+	OUT_RING(ring, lower_32_bits(rbmemptr(ring, ttbr0)));
+	OUT_RING(ring, upper_32_bits(rbmemptr(ring, ttbr0)));
+	OUT_RING(ring, lower_32_bits(ttbr));
+	OUT_RING(ring, upper_32_bits(ttbr));
+
+	/* Invalidate the draw state so we start off fresh */
+	OUT_PKT7(ring, CP_SET_DRAW_STATE, 3);
+	OUT_RING(ring, 0x40000);
+	OUT_RING(ring, 1);
+	OUT_RING(ring, 0);
+
+	/* Turn off APRIV */
+	OUT_PKT4(ring, REG_A6XX_CP_MISC_CNTL, 1);
+	OUT_RING(ring, 0);
+
+	/* Turn off protected mode */
+	OUT_PKT7(ring, CP_SET_PROTECTED_MODE, 1);
+	OUT_RING(ring, 1);
+}
+
 static inline bool _a6xx_check_idle(struct msm_gpu *gpu)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
@@ -89,6 +145,8 @@ static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit,
 	struct msm_ringbuffer *ring = submit->ring;
 	unsigned int i;
 
+	a6xx_set_pagetable(gpu, ring, ctx);
+
 	get_stats_counter(ring, REG_A6XX_RBBM_PERFCTR_CP_0_LO,
 		rbmemptr_stats(ring, index, cpcycles_start));
 
@@ -810,21 +868,77 @@ static unsigned long a6xx_gpu_busy(struct msm_gpu *gpu)
 	return (unsigned long)busy_time;
 }
 
+static struct msm_gem_address_space *a6xx_new_address_space(struct msm_gpu *gpu)
+{
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
+	struct msm_gem_address_space *aspace;
+	int ret;
+
+	/* Return the default pagetable if per instance tables don't work */
+	if (!a6xx_gpu->per_instance_tables)
+		return gpu->aspace;
+
+	aspace = msm_gem_address_space_create_instance(&gpu->pdev->dev, "gpu",
+		0x100000000ULL, 0x1ffffffffULL);
+	if (IS_ERR(aspace))
+		return aspace;
+
+	ret = aspace->mmu->funcs->attach(aspace->mmu, NULL, 0);
+	if (ret) {
+		/* -ENODEV means that aux domains aren't supported */
+		if (ret == -ENODEV)
+			return gpu->aspace;
+
+		return ERR_PTR(ret);
+	}
+
+	return aspace;
+}
+
 static struct msm_gem_address_space *
 a6xx_create_address_space(struct msm_gpu *gpu)
 {
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
+	struct device *dev = &gpu->pdev->dev;
 	struct msm_gem_address_space *aspace;
 	struct iommu_domain *iommu;
-	int ret;
+	int ret, val = 1;
+
+	a6xx_gpu->per_instance_tables = false;
 
 	iommu = iommu_domain_alloc(&platform_bus_type);
 	if (!iommu)
 		return ERR_PTR(-ENXIO);
 
-	iommu->geometry.aperture_start = 0x100000000ULL;
-	iommu->geometry.aperture_end = 0x1ffffffffULL;
+	/* Try to enable split pagetables */
+	if (iommu_domain_set_attr(iommu, DOMAIN_ATTR_SPLIT_TABLES, &val)) {
+		/*
+		 * If split pagetables aren't available we won't be able to do
+		 * per-instance pagetables so set up the global va space at our
+		 * susual location
+		 */
+		iommu->geometry.aperture_start = 0x100000000ULL;
+		iommu->geometry.aperture_end = 0x1ffffffffULL;
+	} else {
+		/*
+		 * If split pagetables are available then we might be able to do
+		 * per-instance pagetables. Put the default va-space in TTBR1 to
+		 * prepare
+		 */
+		iommu->geometry.aperture_start = 0xfffffff100000000ULL;
+		iommu->geometry.aperture_end = 0xffffff1ffffffffULL;
+
+		/*
+		 * If both split pagetables and aux domains are supported we can
+		 * do per_instance pagetables
+		 */
+		a6xx_gpu->per_instance_tables =
+			iommu_dev_has_feature(dev, IOMMU_DEV_FEAT_AUX);
+	}
 
-	aspace = msm_gem_address_space_create(&gpu->pdev->dev, iommu, "gpu");
+	aspace = msm_gem_address_space_create(dev, iommu, "gpu");
 	if (IS_ERR(aspace)) {
 		iommu_domain_free(iommu);
 		DRM_DEV_ERROR(gpu->dev->dev, "failed to init mmu: %ld\n",
@@ -865,6 +979,7 @@ static const struct adreno_gpu_funcs funcs = {
 		.gpu_state_put = a6xx_gpu_state_put,
 #endif
 		.create_address_space = a6xx_create_address_space,
+		.new_address_space = a6xx_new_address_space,
 	},
 	.get_timestamp = a6xx_get_timestamp,
 };
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 6439955..b133aaa 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -21,6 +21,7 @@ struct a6xx_gpu {
 	struct msm_ringbuffer *cur_ring;
 
 	struct a6xx_gmu gmu;
+	bool per_instance_tables;
 };
 
 #define to_a6xx_gpu(x) container_of(x, struct a6xx_gpu, base)
-- 
2.7.4

