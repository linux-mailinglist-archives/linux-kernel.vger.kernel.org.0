Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAC14F348
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2019 04:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfFVC42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 22:56:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18662 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726049AbfFVC42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 22:56:28 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0B1AB4389754AB1163D6;
        Sat, 22 Jun 2019 10:56:21 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Sat, 22 Jun 2019 10:56:12 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <David1.Zhou@amd.com>
CC:     <kernel-janitors@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, Mao Wenan <maowenan@huawei.com>
Subject: [PATCH -next] drm/amdgpu: remove set but not used variables 'ret'
Date:   Sat, 22 Jun 2019 11:03:14 +0800
Message-ID: <20190622030314.169640-1-maowenan@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c: In function ‘amdgpu_pmu_init’:
drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c:249:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
  int ret = 0;
      ^

It is never used since introduction in 9c7c85f7ea1f ("drm/amdgpu: add pmu counters")

Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
index 0e6dba9..0bf4dd9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
@@ -246,12 +246,10 @@ static int init_pmu_by_type(struct amdgpu_device *adev,
 /* init amdgpu_pmu */
 int amdgpu_pmu_init(struct amdgpu_device *adev)
 {
-	int ret = 0;
-
 	switch (adev->asic_type) {
 	case CHIP_VEGA20:
 		/* init df */
-		ret = init_pmu_by_type(adev, df_v3_6_attr_groups,
+		init_pmu_by_type(adev, df_v3_6_attr_groups,
 				       "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,
 				       DF_V3_6_MAX_COUNTERS);
 
-- 
2.7.4

