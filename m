Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E64E7A1DB7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 16:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbfH2Ovv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 10:51:51 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:62839 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728455AbfH2Ovj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:51:39 -0400
X-UUID: 00371b3ec8d140f1b46d48f203b43a5f-20190829
X-UUID: 00371b3ec8d140f1b46d48f203b43a5f-20190829
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1950337178; Thu, 29 Aug 2019 22:51:33 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 29 Aug 2019 22:51:27 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 29 Aug 2019 22:51:26 +0800
From:   <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v5, 22/32] drm/mediatek: add ovl0/ovl_2l0 usecase
Date:   Thu, 29 Aug 2019 22:50:44 +0800
Message-ID: <1567090254-15566-23-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1567090254-15566-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1567090254-15566-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E301AC070BEDDEB5B8A49B91D83DAE0C260EEF9D36A18ACB76C8DD5C4BD0FE812000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

This patch add ovl0/ovl_2l0 usecase
in ovl->ovl_2l0 direct link usecase:
1. the crtc support layer number will 4+2
2. ovl_2l0 background color input select ovl0 when crtc init
and disable it when crtc finish
3. config ovl_2l0 layer, if crtc config layer number is
bigger than ovl0 support layers(max is 4)

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 38 +++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index c63ff2b..b55970a 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -270,6 +270,15 @@ static int mtk_crtc_ddp_hw_init(struct mtk_drm_crtc *mtk_crtc)
 
 	for (i = 0; i < mtk_crtc->ddp_comp_nr; i++) {
 		struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[i];
+		enum mtk_ddp_comp_id prev;
+
+		if (i > 0)
+			prev = mtk_crtc->ddp_comp[i - 1]->id;
+		else
+			prev = DDP_COMPONENT_ID_MAX;
+
+		if (prev == DDP_COMPONENT_OVL0)
+			mtk_ddp_comp_bgclr_in_on(comp);
 
 		mtk_ddp_comp_config(comp, width, height, vrefresh, bpc);
 		mtk_ddp_comp_start(comp);
@@ -279,9 +288,18 @@ static int mtk_crtc_ddp_hw_init(struct mtk_drm_crtc *mtk_crtc)
 	for (i = 0; i < mtk_crtc->layer_nr; i++) {
 		struct drm_plane *plane = &mtk_crtc->planes[i];
 		struct mtk_plane_state *plane_state;
+		struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[0];
+		unsigned int comp_layer_nr = mtk_ddp_comp_layer_nr(comp);
+		unsigned int local_layer;
 
 		plane_state = to_mtk_plane_state(plane->state);
-		mtk_ddp_comp_layer_config(mtk_crtc->ddp_comp[0], i,
+
+		if (i >= comp_layer_nr) {
+			comp = mtk_crtc->ddp_comp[1];
+			local_layer = i - comp_layer_nr;
+		} else
+			local_layer = i;
+		mtk_ddp_comp_layer_config(comp, local_layer,
 					  plane_state);
 	}
 
@@ -307,6 +325,7 @@ static void mtk_crtc_ddp_hw_fini(struct mtk_drm_crtc *mtk_crtc)
 					   mtk_crtc->ddp_comp[i]->id);
 	mtk_disp_mutex_disable(mtk_crtc->mutex);
 	for (i = 0; i < mtk_crtc->ddp_comp_nr - 1; i++) {
+		mtk_ddp_comp_bgclr_in_off(mtk_crtc->ddp_comp[i]);
 		mtk_ddp_remove_comp_from_path(mtk_crtc->config_regs,
 					      mtk_crtc->mmsys_reg_data,
 					      mtk_crtc->ddp_comp[i]->id,
@@ -327,6 +346,8 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crtc)
 	struct mtk_crtc_state *state = to_mtk_crtc_state(mtk_crtc->base.state);
 	struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[0];
 	unsigned int i;
+	unsigned int comp_layer_nr = mtk_ddp_comp_layer_nr(comp);
+	unsigned int local_layer;
 
 	/*
 	 * TODO: instead of updating the registers here, we should prepare
@@ -349,7 +370,14 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crtc)
 			plane_state = to_mtk_plane_state(plane->state);
 
 			if (plane_state->pending.config) {
-				mtk_ddp_comp_layer_config(comp, i, plane_state);
+				if (i >= comp_layer_nr) {
+					comp = mtk_crtc->ddp_comp[1];
+					local_layer = i - comp_layer_nr;
+				} else
+					local_layer = i;
+
+				mtk_ddp_comp_layer_config(comp, local_layer,
+							  plane_state);
 				plane_state->pending.config = false;
 			}
 		}
@@ -572,6 +600,12 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
 	}
 
 	mtk_crtc->layer_nr = mtk_ddp_comp_layer_nr(mtk_crtc->ddp_comp[0]);
+	if (mtk_crtc->ddp_comp_nr > 1) {
+		struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[1];
+
+		if (comp->funcs->bgclr_in_on)
+			mtk_crtc->layer_nr += mtk_ddp_comp_layer_nr(comp);
+	}
 	mtk_crtc->planes = devm_kcalloc(dev, mtk_crtc->layer_nr,
 					sizeof(struct drm_plane),
 					GFP_KERNEL);
-- 
1.8.1.1.dirty

