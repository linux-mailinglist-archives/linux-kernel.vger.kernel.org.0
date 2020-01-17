Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03E5E1402B4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 05:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbgAQEBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 23:01:08 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:55550 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726853AbgAQEBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 23:01:07 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3BD1FB86331D151CD4CD;
        Fri, 17 Jan 2020 12:01:05 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Fri, 17 Jan 2020
 12:00:54 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <bskeggs@redhat.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <lyude@redhat.com>, <alexander.deucher@amd.com>, <sam@ravnborg.org>
CC:     <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/nouveau/kms/nv50: remove set but not unused variable 'nv_connector'
Date:   Fri, 17 Jan 2020 11:36:42 +0800
Message-ID: <20200117033642.50656-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/gpu/drm/nouveau/dispnv50/disp.c: In function nv50_pior_enable:
drivers/gpu/drm/nouveau/dispnv50/disp.c:1672:28: warning:
 variable nv_connector set but not used [-Wunused-but-set-variable]

commit ac2d9275f371 ("drm/nouveau/kms/nv50-: Store the
bpc we're using in nv50_head_atom") left behind this.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 5fabe2b..a82b354 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1669,7 +1669,6 @@ nv50_pior_enable(struct drm_encoder *encoder)
 {
 	struct nouveau_encoder *nv_encoder = nouveau_encoder(encoder);
 	struct nouveau_crtc *nv_crtc = nouveau_crtc(encoder->crtc);
-	struct nouveau_connector *nv_connector;
 	struct nv50_head_atom *asyh = nv50_head_atom(nv_crtc->base.state);
 	struct nv50_core *core = nv50_disp(encoder->dev)->core;
 	u8 owner = 1 << nv_crtc->index;
@@ -1677,7 +1676,6 @@ nv50_pior_enable(struct drm_encoder *encoder)
 
 	nv50_outp_acquire(nv_encoder);
 
-	nv_connector = nouveau_encoder_connector_get(nv_encoder);
 	switch (asyh->or.bpc) {
 	case 10: asyh->or.depth = 0x6; break;
 	case  8: asyh->or.depth = 0x5; break;
-- 
2.7.4


