Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2A4A1DD2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 16:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbfH2Owl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 10:52:41 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:51287 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728012AbfH2OvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:51:22 -0400
X-UUID: 066d48e35b7f46c98c538c673018e6c1-20190829
X-UUID: 066d48e35b7f46c98c538c673018e6c1-20190829
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 185920290; Thu, 29 Aug 2019 22:51:18 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 29 Aug 2019 22:51:22 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 29 Aug 2019 22:51:22 +0800
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
Subject: [PATCH v5, 17/32] drm/mediatek: add component DITHER
Date:   Thu, 29 Aug 2019 22:50:39 +0800
Message-ID: <1567090254-15566-18-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1567090254-15566-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1567090254-15566-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

This patch add component DITHER

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 32 +++++++++++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |  2 ++
 2 files changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index af8e872..8fea985 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -39,6 +39,12 @@
 #define CCORR_RELAY_MODE			BIT(0)
 #define DISP_CCORR_SIZE				0x0030
 
+#define DISP_DITHER_EN				0x0000
+#define DITHER_EN				BIT(0)
+#define DISP_DITHER_CFG				0x0020
+#define DITHER_RELAY_MODE			BIT(0)
+#define DISP_DITHER_SIZE			0x0030
+
 #define DISP_GAMMA_EN				0x0000
 #define DISP_GAMMA_CFG				0x0020
 #define DISP_GAMMA_SIZE				0x0030
@@ -147,6 +153,24 @@ static void mtk_ccorr_stop(struct mtk_ddp_comp *comp)
 	writel_relaxed(0x0, comp->regs + DISP_CCORR_EN);
 }
 
+static void mtk_dither_config(struct mtk_ddp_comp *comp, unsigned int w,
+			      unsigned int h, unsigned int vrefresh,
+			      unsigned int bpc)
+{
+	writel(h << 16 | w, comp->regs + DISP_DITHER_SIZE);
+	writel(DITHER_RELAY_MODE, comp->regs + DISP_DITHER_CFG);
+}
+
+static void mtk_dither_start(struct mtk_ddp_comp *comp)
+{
+	writel(DITHER_EN, comp->regs + DISP_DITHER_EN);
+}
+
+static void mtk_dither_stop(struct mtk_ddp_comp *comp)
+{
+	writel_relaxed(0x0, comp->regs + DISP_DITHER_EN);
+}
+
 static void mtk_gamma_config(struct mtk_ddp_comp *comp, unsigned int w,
 			     unsigned int h, unsigned int vrefresh,
 			     unsigned int bpc)
@@ -201,6 +225,12 @@ static void mtk_gamma_set(struct mtk_ddp_comp *comp,
 	.stop = mtk_ccorr_stop,
 };
 
+static const struct mtk_ddp_comp_funcs ddp_dither = {
+	.config = mtk_dither_config,
+	.start = mtk_dither_start,
+	.stop = mtk_dither_stop,
+};
+
 static const struct mtk_ddp_comp_funcs ddp_gamma = {
 	.gamma_set = mtk_gamma_set,
 	.config = mtk_gamma_config,
@@ -226,6 +256,7 @@ static void mtk_gamma_set(struct mtk_ddp_comp *comp,
 	[MTK_DISP_CCORR] = "ccorr",
 	[MTK_DISP_AAL] = "aal",
 	[MTK_DISP_GAMMA] = "gamma",
+	[MTK_DISP_DITHER] = "dither",
 	[MTK_DISP_UFOE] = "ufoe",
 	[MTK_DSI] = "dsi",
 	[MTK_DPI] = "dpi",
@@ -248,6 +279,7 @@ struct mtk_ddp_comp_match {
 	[DDP_COMPONENT_CCORR]	= { MTK_DISP_CCORR,	0, &ddp_ccorr },
 	[DDP_COMPONENT_COLOR0]	= { MTK_DISP_COLOR,	0, NULL },
 	[DDP_COMPONENT_COLOR1]	= { MTK_DISP_COLOR,	1, NULL },
+	[DDP_COMPONENT_DITHER]	= { MTK_DISP_DITHER,	0, &ddp_dither },
 	[DDP_COMPONENT_DPI0]	= { MTK_DPI,		0, NULL },
 	[DDP_COMPONENT_DPI1]	= { MTK_DPI,		1, NULL },
 	[DDP_COMPONENT_DSI0]	= { MTK_DSI,		0, NULL },
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
index 962d14a..85e096a 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
@@ -22,6 +22,7 @@ enum mtk_ddp_comp_type {
 	MTK_DISP_WDMA,
 	MTK_DISP_COLOR,
 	MTK_DISP_CCORR,
+	MTK_DISP_DITHER,
 	MTK_DISP_AAL,
 	MTK_DISP_GAMMA,
 	MTK_DISP_UFOE,
@@ -41,6 +42,7 @@ enum mtk_ddp_comp_id {
 	DDP_COMPONENT_CCORR,
 	DDP_COMPONENT_COLOR0,
 	DDP_COMPONENT_COLOR1,
+	DDP_COMPONENT_DITHER,
 	DDP_COMPONENT_DPI0,
 	DDP_COMPONENT_DPI1,
 	DDP_COMPONENT_DSI0,
-- 
1.8.1.1.dirty

