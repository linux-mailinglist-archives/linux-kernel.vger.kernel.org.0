Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13703F153B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 12:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbfKFLgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 06:36:33 -0500
Received: from mail-m975.mail.163.com ([123.126.97.5]:59232 "EHLO
        mail-m975.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfKFLgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 06:36:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=F4q0FT2QSt1liFQffl
        wBI53D3683D+4jI0WVjJIt4Q4=; b=GzL/nCfaJzTBgm6GWc2L91x4ApX8RAJYYH
        N9bX9EhgzwymsNzGnWX/pEhPWn2bg1NfI/Q4HC29oVJcPh+2YUHeh/5G1e0F6LA6
        MEdcQSO5UGGMxc7A9kRfur/9GXqKfK4tOF1gCpg6NnExGbNUZXbm9zIzwDyBqWMh
        2wJKw5Gf0=
Received: from localhost.localdomain (unknown [202.112.113.212])
        by smtp5 (Coremail) with SMTP id HdxpCgDnQnkRsMJdNnV9KA--.131S3;
        Wed, 06 Nov 2019 19:35:48 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
        David1.Zhou@amd.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>
Subject: [PATCH v2] drm/amdgpu: fix double reference dropping
Date:   Wed,  6 Nov 2019 19:35:43 +0800
Message-Id: <1573040143-25820-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: HdxpCgDnQnkRsMJdNnV9KA--.131S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7urW8Wry8Kr15Zw48Zw1rtFb_yoW8GFWkpF
        WxGw1UKrWDZF10934UA3W0qF98Kw13XFyrKF47Ca95uan8JF98JF95trWkWFyDCFZ2va92
        v39FyrW3uan8KF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UaFAXUUUUU=
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/1tbiNhRlclWBhKyp4wAAsD
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reference to object fence is dropped at the end of the loop.
However, it is dropped again outside the loop. The reference can be
dropped immediately after calling dma_fence_wait() in the loop and
thus the dropping operation outside the loop can be removed.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
v2: fix the bug in a more concise way
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
index 649e68c4479b..d1495e1c9289 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
@@ -33,7 +33,7 @@ static int amdgpu_benchmark_do_move(struct amdgpu_device *adev, unsigned size,
 {
 	unsigned long start_jiffies;
 	unsigned long end_jiffies;
-	struct dma_fence *fence = NULL;
+	struct dma_fence *fence;
 	int i, r;
 
 	start_jiffies = jiffies;
@@ -44,16 +44,14 @@ static int amdgpu_benchmark_do_move(struct amdgpu_device *adev, unsigned size,
 		if (r)
 			goto exit_do_move;
 		r = dma_fence_wait(fence, false);
+		dma_fence_put(fence);
 		if (r)
 			goto exit_do_move;
-		dma_fence_put(fence);
 	}
 	end_jiffies = jiffies;
 	r = jiffies_to_msecs(end_jiffies - start_jiffies);
 
 exit_do_move:
-	if (fence)
-		dma_fence_put(fence);
 	return r;
 }
 
-- 
2.7.4

