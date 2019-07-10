Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF256375B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 15:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfGIN60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 09:58:26 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36240 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726060AbfGIN60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 09:58:26 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A9C93614EF8499F1F427;
        Tue,  9 Jul 2019 21:58:22 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Tue, 9 Jul 2019
 21:58:11 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <james.qian.wang@arm.com>, <liviu.dudau@arm.com>,
        <brian.starkey@arm.com>, <airlied@linux.ie>
CC:     <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <daniel@ffwll.ch>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/komeda: remove set but not used variable 'old'
Date:   Tue, 9 Jul 2019 21:58:08 +0800
Message-ID: <20190709135808.56388-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/arm/display/komeda/komeda_plane.c:
 In function komeda_plane_atomic_duplicate_state:
drivers/gpu/drm/arm/display/komeda/komeda_plane.c:161:35:
 warning: variable old set but not used [-Wunused-but-set-variable

It is not used since commit 990dee3aa456 ("drm/komeda:
Computing image enhancer internally")

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_plane.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
index c095af1..c1381ac 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
@@ -158,8 +158,6 @@ static void komeda_plane_reset(struct drm_plane *plane)
 static struct drm_plane_state *
 komeda_plane_atomic_duplicate_state(struct drm_plane *plane)
 {
-	struct komeda_plane_state *new, *old;
-
 	if (WARN_ON(!plane->state))
 		return NULL;
 
@@ -169,8 +167,6 @@ komeda_plane_atomic_duplicate_state(struct drm_plane *plane)
 
 	__drm_atomic_helper_plane_duplicate_state(plane, &new->base);
 
-	old = to_kplane_st(plane->state);
-
 	return &new->base;
 }
 
-- 
2.7.4


