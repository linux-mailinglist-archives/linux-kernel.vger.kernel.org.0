Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D58C535BBA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 13:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbfFELpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jun 2019 07:45:14 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:7123 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727816AbfFELoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 07:44:04 -0400
X-UUID: 0e95e89091ce4746a67411bab00b16fb-20190605
X-UUID: 0e95e89091ce4746a67411bab00b16fb-20190605
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 530520526; Wed, 05 Jun 2019 19:43:57 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 5 Jun 2019 19:43:55 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 5 Jun 2019 19:43:55 +0800
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
Subject: [PATCH v3, 22/27] drm/mediatek: distinguish ovl and ovl_2l by layer_nr
Date:   Wed, 5 Jun 2019 19:43:01 +0800
Message-ID: <1559734986-7379-23-git-send-email-yongqiang.niu@mediatek.com>
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

distinguish ovl and ovl_2l by layer_nr when get comp
id

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index b5a9907..63072d1 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -327,7 +327,12 @@ static int mtk_disp_ovl_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	comp_id = mtk_ddp_comp_get_id(dev->of_node, MTK_DISP_OVL);
+	priv->data = of_device_get_match_data(dev);
+
+	comp_id = mtk_ddp_comp_get_id(dev->of_node,
+				      priv->data->layer_nr == 4 ?
+				      MTK_DISP_OVL :
+				      MTK_DISP_OVL_2L);
 	if (comp_id < 0) {
 		dev_err(dev, "Failed to identify by alias: %d\n", comp_id);
 		return comp_id;
@@ -340,8 +345,6 @@ static int mtk_disp_ovl_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	priv->data = of_device_get_match_data(dev);
-
 	platform_set_drvdata(pdev, priv);
 
 	ret = devm_request_irq(dev, irq, mtk_disp_ovl_irq_handler,
-- 
1.8.1.1.dirty

