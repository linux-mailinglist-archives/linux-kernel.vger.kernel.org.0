Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7353B7B72
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2019 16:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732400AbfISOCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Sep 2019 10:02:43 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2740 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732323AbfISOCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 10:02:42 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 118C5FBD00B0B2AFF39B;
        Thu, 19 Sep 2019 22:02:37 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Thu, 19 Sep 2019
 22:02:14 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <David1.Zhou@amd.com>
CC:     <yukuai3@huawei.com>, <zhengbin13@huawei.com>,
        <yi.zhang@huawei.com>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: remove excess function parameter description
Date:   Thu, 19 Sep 2019 22:09:09 +0800
Message-ID: <1568902149-70787-1-git-send-email-yukuai3@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc warning:

drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c:431: warning: Excess function
parameter 'sw' description in 'vcn_v2_5_disable_clock_gating'
drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c:550: warning: Excess function
parameter 'sw' description in 'vcn_v2_5_enable_clock_gating'

Fixes: cbead2bdfcf1 ("drm/amdgpu: add VCN2.5 VCPU start and stop")
Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 395c225..9d778a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -423,7 +423,6 @@ static void vcn_v2_5_mc_resume(struct amdgpu_device *adev)
  * vcn_v2_5_disable_clock_gating - disable VCN clock gating
  *
  * @adev: amdgpu_device pointer
- * @sw: enable SW clock gating
  *
  * Disable clock gating for VCN block
  */
@@ -542,7 +541,6 @@ static void vcn_v2_5_disable_clock_gating(struct amdgpu_device *adev)
  * vcn_v2_5_enable_clock_gating - enable VCN clock gating
  *
  * @adev: amdgpu_device pointer
- * @sw: enable SW clock gating
  *
  * Enable clock gating for VCN block
  */
-- 
2.7.4

