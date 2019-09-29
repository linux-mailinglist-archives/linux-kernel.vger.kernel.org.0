Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 503CAC1474
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2019 14:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbfI2McA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Sep 2019 08:32:00 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46142 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725937AbfI2McA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 08:32:00 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 71EBBF3A29CA4E61AEAA;
        Sun, 29 Sep 2019 20:31:57 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Sun, 29 Sep 2019
 20:31:49 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <yukuai3@huawei.com>, <zhengbin13@huawei.com>,
        <yi.zhang@huawei.com>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/amdgpu: remove set but not used variable 'pipe'
Date:   Sun, 29 Sep 2019 20:38:43 +0800
Message-ID: <1569760723-119944-1-git-send-email-yukuai3@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

rivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c: In function
‘amdgpu_gfx_graphics_queue_acquire’:
drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:234:16: warning:
variable ‘pipe’ set but not used [-Wunused-but-set-variable]

It is never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index f9bef31..c1035a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -231,12 +231,10 @@ void amdgpu_gfx_compute_queue_acquire(struct amdgpu_device *adev)
 
 void amdgpu_gfx_graphics_queue_acquire(struct amdgpu_device *adev)
 {
-	int i, queue, pipe, me;
+	int i, queue, me;
 
 	for (i = 0; i < AMDGPU_MAX_GFX_QUEUES; ++i) {
 		queue = i % adev->gfx.me.num_queue_per_pipe;
-		pipe = (i / adev->gfx.me.num_queue_per_pipe)
-			% adev->gfx.me.num_pipe_per_me;
 		me = (i / adev->gfx.me.num_queue_per_pipe)
 		      / adev->gfx.me.num_pipe_per_me;
 
-- 
2.7.4

