Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E95435BA2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 13:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfFELof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jun 2019 07:44:35 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:12287 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727882AbfFELoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 07:44:12 -0400
X-UUID: 0d9c16dd5943426783345f622b4e8f32-20190605
X-UUID: 0d9c16dd5943426783345f622b4e8f32-20190605
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1308283880; Wed, 05 Jun 2019 19:43:54 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 5 Jun 2019 19:43:53 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 5 Jun 2019 19:43:52 +0800
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
Subject: [PATCH v3, 19/27] drm/mediatek: add function to background color input select for ovl/ovl_2l direct link
Date:   Wed, 5 Jun 2019 19:42:58 +0800
Message-ID: <1559734986-7379-20-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1559734986-7379-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1559734986-7379-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

This patch add function to background color input select for ovl/ovl_2l direct link
for ovl/ovl_2l direct link usecase, we need set background color
input select for these hardware.
this is preparation patch for ovl/ovl_2l usecase

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
index 158c1e5..aa1e183 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
@@ -92,6 +92,9 @@ struct mtk_ddp_comp_funcs {
 			     struct mtk_plane_state *state);
 	void (*gamma_set)(struct mtk_ddp_comp *comp,
 			  struct drm_crtc_state *state);
+	void (*bgclr_in_on)(struct mtk_ddp_comp *comp,
+			    enum mtk_ddp_comp_id prev);
+	void (*bgclr_in_off)(struct mtk_ddp_comp *comp);
 };
 
 struct mtk_ddp_comp {
@@ -173,6 +176,19 @@ static inline void mtk_ddp_gamma_set(struct mtk_ddp_comp *comp,
 		comp->funcs->gamma_set(comp, state);
 }
 
+static inline void mtk_ddp_comp_bgclr_in_on(struct mtk_ddp_comp *comp,
+					    enum mtk_ddp_comp_id prev)
+{
+	if (comp->funcs && comp->funcs->bgclr_in_on)
+		comp->funcs->bgclr_in_on(comp, prev);
+}
+
+static inline void mtk_ddp_comp_bgclr_in_off(struct mtk_ddp_comp *comp)
+{
+	if (comp->funcs && comp->funcs->bgclr_in_off)
+		comp->funcs->bgclr_in_off(comp);
+}
+
 int mtk_ddp_comp_get_id(struct device_node *node,
 			enum mtk_ddp_comp_type comp_type);
 int mtk_ddp_comp_init(struct device *dev, struct device_node *comp_node,
-- 
1.8.1.1.dirty

