Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDA6123E1F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 04:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfLRDua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 22:50:30 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7706 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726561AbfLRDua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 22:50:30 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DBD97CB89925F0697028;
        Wed, 18 Dec 2019 11:50:28 +0800 (CST)
Received: from huawei.com (10.175.127.16) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Wed, 18 Dec 2019
 11:50:18 +0800
From:   Pan Zhang <zhangpan26@huawei.com>
To:     <zhangpan26@huawei.com>, <hushiyuan@huawei.com>,
        <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <ray.huang@amd.com>, <irmoy.das@amd.com>, <sam@ravnborg.org>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] gpu: drm: dead code elimination
Date:   Wed, 18 Dec 2019 11:50:00 +0800
Message-ID: <1576641000-14772-1-git-send-email-zhangpan26@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.127.16]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this set adds support for removal of gpu drm dead code.

patch2:
`num_entries` is a data of unsigned type(compilers always treat as unsigned int) and SIZE_MAX == ~0,

so there is a impossible condition:
'(num_entries > ((~0) - 56) / 72) => (max(0-u32) > 256204778801521549)'.

Signed-off-by: Pan Zhang <zhangpan26@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
index 85b0515..10a7f30 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
@@ -71,10 +71,6 @@ int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
 	unsigned i;
 	int r;
 
-	if (num_entries > (SIZE_MAX - sizeof(struct amdgpu_bo_list))
-				/ sizeof(struct amdgpu_bo_list_entry))
-		return -EINVAL;
-
 	size = sizeof(struct amdgpu_bo_list);
 	size += num_entries * sizeof(struct amdgpu_bo_list_entry);
 	list = kvmalloc(size, GFP_KERNEL);
-- 
2.7.4

