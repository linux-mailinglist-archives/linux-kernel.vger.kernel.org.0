Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9861A9A32
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 07:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731070AbfIEFwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 01:52:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6674 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725786AbfIEFwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 01:52:23 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1F1967ECF2B97A41596C;
        Thu,  5 Sep 2019 13:52:20 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Thu, 5 Sep 2019 13:52:10 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <Markus.Elfring@web.de>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <David1.Zhou@amd.com>,
        <zhongjiang@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] drm/amdgpu: Remove two redundant null pointer checks
Date:   Thu, 5 Sep 2019 13:49:12 +0800
Message-ID: <1567662552-3583-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions "debugfs_remove" and "kfree" tolerate the passing
of null pointers. Hence it is unnecessary to check such arguments
around the calls. Thus remove the extra condition check at two places.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 5652cc7..cb94627 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1077,8 +1077,7 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 val)
 
 	ttm_bo_unlock_delayed_workqueue(&adev->mman.bdev, resched);
 
-	if (fences)
-		kfree(fences);
+	kfree(fences);
 
 	return 0;
 }
@@ -1103,8 +1102,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 
 void amdgpu_debugfs_preempt_cleanup(struct amdgpu_device *adev)
 {
-	if (adev->debugfs_preempt)
-		debugfs_remove(adev->debugfs_preempt);
+	debugfs_remove(adev->debugfs_preempt);
 }
 
 #else
-- 
1.7.12.4

