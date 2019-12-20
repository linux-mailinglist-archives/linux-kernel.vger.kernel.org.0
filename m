Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54D2112784B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 10:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfLTJf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Dec 2019 04:35:27 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:52180 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727205AbfLTJf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 04:35:27 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7D9E1552C1D1377195F9;
        Fri, 20 Dec 2019 17:35:21 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Fri, 20 Dec 2019 17:35:19 +0800
From:   Ma Feng <mafeng.ma@huawei.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/amdgpu: Remove unneeded variable 'ret' in navi10_ih.c
Date:   Fri, 20 Dec 2019 17:36:08 +0800
Message-ID: <1576834568-82874-1-git-send-email-mafeng.ma@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccicheck warning:

drivers/gpu/drm/amd/amdgpu/navi10_ih.c:113:5-8: Unneeded variable: "ret". Return "0" on line 182

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ma Feng <mafeng.ma@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index 9af7356..f737ce4 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -110,7 +110,6 @@ static uint32_t navi10_ih_rb_cntl(struct amdgpu_ih_ring *ih, uint32_t ih_rb_cntl
 static int navi10_ih_irq_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ih_ring *ih = &adev->irq.ih;
-	int ret = 0;
 	u32 ih_rb_cntl, ih_doorbell_rtpr, ih_chicken;
 	u32 tmp;

@@ -179,7 +178,7 @@ static int navi10_ih_irq_init(struct amdgpu_device *adev)
 	/* enable interrupts */
 	navi10_ih_enable_interrupts(adev);

-	return ret;
+	return 0;
 }

 /**
--
2.6.2

