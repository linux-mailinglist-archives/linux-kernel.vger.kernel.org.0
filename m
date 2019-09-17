Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D17EFB4B2E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 11:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbfIQJpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 05:45:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60226 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfIQJpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 05:45:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 775C161214; Tue, 17 Sep 2019 09:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568713517;
        bh=2ZoZPGp6TrTJsyWDAG4gSuhc3HDH7PoyV7j6zp5uBGA=;
        h=From:To:Cc:Subject:Date:From;
        b=FBd2Phq5zt/90ZGP0lNqM/6aGEM2o2BB+x5yEBNQpRaTVkLD1dzZEy4D268BYRR3w
         1Nc2rc0JK5YQlKgAKkziqkteHTq7fcKJKkYuP8XHhq6mN1zLyqEZX0Kkn8sE0BS2MK
         yo+nKCRGLwk3fuGWxQnG/lFEAd86/5t/1Qt8i+z8=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from blr-ubuntu-311.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 52BDD60271;
        Tue, 17 Sep 2019 09:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568713515;
        bh=2ZoZPGp6TrTJsyWDAG4gSuhc3HDH7PoyV7j6zp5uBGA=;
        h=From:To:Cc:Subject:Date:From;
        b=JCAcIa4uTwA2AkHjeKL/MrMfK4vgVowesIuTMJN+t5rpGDjuvRI6uFQZ1aRL8SZJf
         YE89rkHROwnk4Oiyu+kGfsdgx66j2LZWZqQdRDc+3xUtngFBn7SoXpDMoswVUiXUlv
         OGcvDi0XOY9nt+lSZU0YjO6c9t/WaF5wConRLFes=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 52BDD60271
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Stephen Boyd <swboyd@chromium.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        bjorn.andersson@linaro.org, Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCHv6 0/3] QCOM smmu-500 wait-for-safe handling for sdm845
Date:   Tue, 17 Sep 2019 15:15:01 +0530
Message-Id: <cover.1568712606.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previous version of the patches are at [1]:

QCOM's implementation of smmu-500 on sdm845 adds a hardware logic called
wait-for-safe. This logic helps in meeting the invalidation requirements
from 'real-time clients', such as display and camera. This wait-for-safe
logic ensures that the invalidations happen after getting an ack from these
devices.
In this patch-series we are disabling this wait-for-safe logic from the
arm-smmu driver's probe as with this enabled the hardware tries to
throttle invalidations from 'non-real-time clients', such as USB and UFS.

For detailed information please refer to patch [3/4] in this series.
I have included the device tree patch too in this series for someone who
would like to test out this. Here's a branch [2] that gets display on MTP
SDM845 device.

This patch series is inspired from downstream work to handle under-performance
issues on real-time clients on sdm845. In downstream we add separate page table
ops to handle TLB maintenance and toggle wait-for-safe in tlb_sync call so that
achieve required performance for display and camera [3, 4].

Changes since v5:
 * Addressed Robin's comments and removed unwanted header file.

Changes since v4:
 * Addressed Stephen's comments.
 * Moved QCOM specific implementation to arm-smmu-qcom.c as per Robin's suggestion.

Changes since v3:
 * Based on arm-smmu implementation cleanup series [5] by Robin Murphy which is
   already merged in Will's tree [6].
 * Implemented the sdm845 specific reset hook which does arm_smmu_device_reset()
   followed by making SCM call to disable the wait-for-safe logic.
 * Removed depedency for SCM call on any dt flag. We invariably try to disable
   the wait-for-safe logic on sdm845. The platforms such as mtp845, and db845
   that implement handlers for this particular SCM call should be able disable
   wait-for-safe logic.
   Other platforms such as cheza don't enable the wait-for-safe logic at all
   from their bootloaders. So there's no need to disable the same.
 * No change in SCM call patches 1 & 2.

Changes since v2:
 * Dropped the patch to add atomic io_read/write scm API.
 * Removed support for any separate page table ops to handle wait-for-safe.
   Currently just disabling this wait-for-safe logic from arm_smmu_device_probe()
   to achieve performance on USB/UFS on sdm845.
 * Added a device tree patch to add smmu option for fw-implemented support
   for SCM call to take care of SAFE toggling.

Changes since v1:
 * Addressed Will and Robin's comments:
    - Dropped the patch[4] that forked out __arm_smmu_tlb_inv_range_nosync(),
      and __arm_smmu_tlb_sync().
    - Cleaned up the errata patch further to use downstream polling mechanism
      for tlb sync.
 * No change in SCM call patches - patches 1 to 3.

[1] https://lore.kernel.org/patchwork/cover/1127798/ 
[2] https://github.com/vivekgautam1/linux/tree/v5.2-rc4/sdm845-display-working
[3] https://source.codeaurora.org/quic/la/kernel/msm-4.9/commit/drivers/iommu/arm-smmu.c?h=CogSystems-msm-49/msm-4.9&id=da765c6c75266b38191b38ef086274943f353ea7
[4] https://source.codeaurora.org/quic/la/kernel/msm-4.9/commit/drivers/iommu/arm-smmu.c?h=CogSystems-msm-49/msm-4.9&id=8696005aaaf745de68f57793c1a534a34345c30a
[5] https://patchwork.kernel.org/patch/11096265/
[6] https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/

Vivek Gautam (3):
  firmware: qcom_scm-64: Add atomic version of qcom_scm_call
  firmware/qcom_scm: Add scm call to handle smmu errata
  iommu: arm-smmu-impl: Add sdm845 implementation hook

 drivers/firmware/qcom_scm-32.c |   5 ++
 drivers/firmware/qcom_scm-64.c | 152 +++++++++++++++++++++++----------
 drivers/firmware/qcom_scm.c    |   6 ++
 drivers/firmware/qcom_scm.h    |   5 ++
 drivers/iommu/Makefile         |   2 +-
 drivers/iommu/arm-smmu-impl.c  |   6 +-
 drivers/iommu/arm-smmu-qcom.c  |  51 +++++++++++
 drivers/iommu/arm-smmu.h       |   3 +
 include/linux/qcom_scm.h       |   2 +
 9 files changed, 185 insertions(+), 47 deletions(-)
 create mode 100644 drivers/iommu/arm-smmu-qcom.c

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

