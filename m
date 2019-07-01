Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C31F3B4B1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2019 14:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390010AbfFJMVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 08:21:38 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:28183 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389572AbfFJMVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 08:21:38 -0400
X-UUID: dc6223ec725d4466b98e191d5e207052-20190610
X-UUID: dc6223ec725d4466b98e191d5e207052-20190610
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 858344451; Mon, 10 Jun 2019 20:21:29 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 10 Jun 2019 20:21:28 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 10 Jun 2019 20:21:27 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yingjoe.chen@mediatek.com>,
        <yong.wu@mediatek.com>, <youlin.pei@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v7 16/21] memory: mtk-smi: Add bus_sel for mt8183
Date:   Mon, 10 Jun 2019 20:17:55 +0800
Message-ID: <1560169080-27134-17-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1560169080-27134-1-git-send-email-yong.wu@mediatek.com>
References: <1560169080-27134-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 2 mmu cells in a M4U HW. we could adjust some larbs entering
mmu0 or mmu1 to balance the bandwidth via the smi-common register
SMI_BUS_SEL(0x220)(Each larb occupy 2 bits).

In mt8183, For better performance, we switch larb1/2/5/7 to enter
mmu1 while the others still keep enter mmu0.

In mt8173 and mt2712, we don't get the performance issue,
Keep its default value(0x0), that means all the larbs enter mmu0.

Note: smi gen1(mt2701/mt7623) don't have this bus_sel.

And, the base of smi-common is completely different with smi_ao_base
of gen1, thus I add new variable for that.

CC: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: Evan Green <evgreen@chromium.org>
---
 drivers/memory/mtk-smi.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 9790801..08cf40d 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -49,6 +49,12 @@
 #define SMI_LARB_NONSEC_CON(id)	(0x380 + ((id) * 4))
 #define F_MMU_EN		BIT(0)
 
+/* SMI COMMON */
+#define SMI_BUS_SEL			0x220
+#define SMI_BUS_LARB_SHIFT(larbid)	((larbid) << 1)
+/* All are MMU0 defaultly. Only specialize mmu1 here. */
+#define F_MMU1_LARB(larbid)		(0x1 << SMI_BUS_LARB_SHIFT(larbid))
+
 enum mtk_smi_gen {
 	MTK_SMI_GEN1,
 	MTK_SMI_GEN2
@@ -57,6 +63,7 @@ enum mtk_smi_gen {
 struct mtk_smi_common_plat {
 	enum mtk_smi_gen gen;
 	bool             has_gals;
+	u32              bus_sel; /* Balance some larbs to enter mmu0 or mmu1 */
 };
 
 struct mtk_smi_larb_gen {
@@ -72,8 +79,8 @@ struct mtk_smi {
 	struct clk			*clk_apb, *clk_smi;
 	struct clk			*clk_gals0, *clk_gals1;
 	struct clk			*clk_async; /*only needed by mt2701*/
-	void __iomem			*smi_ao_base;
-
+	void __iomem			*smi_ao_base; /* only for gen1 */
+	void __iomem			*base;	      /* only for gen2 */
 	const struct mtk_smi_common_plat *plat;
 };
 
@@ -410,6 +417,8 @@ static int __maybe_unused mtk_smi_larb_suspend(struct device *dev)
 static const struct mtk_smi_common_plat mtk_smi_common_mt8183 = {
 	.gen      = MTK_SMI_GEN2,
 	.has_gals = true,
+	.bus_sel  = F_MMU1_LARB(1) | F_MMU1_LARB(2) | F_MMU1_LARB(5) |
+		    F_MMU1_LARB(7),
 };
 
 static const struct of_device_id mtk_smi_common_of_ids[] = {
@@ -482,6 +491,11 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
 		ret = clk_prepare_enable(common->clk_async);
 		if (ret)
 			return ret;
+	} else {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		common->base = devm_ioremap_resource(dev, res);
+		if (IS_ERR(common->base))
+			return PTR_ERR(common->base);
 	}
 	pm_runtime_enable(dev);
 	platform_set_drvdata(pdev, common);
@@ -497,6 +511,7 @@ static int mtk_smi_common_remove(struct platform_device *pdev)
 static int __maybe_unused mtk_smi_common_resume(struct device *dev)
 {
 	struct mtk_smi *common = dev_get_drvdata(dev);
+	u32 bus_sel = common->plat->bus_sel;
 	int ret;
 
 	ret = mtk_smi_clk_enable(common);
@@ -504,6 +519,9 @@ static int __maybe_unused mtk_smi_common_resume(struct device *dev)
 		dev_err(common->dev, "Failed to enable clock(%d).\n", ret);
 		return ret;
 	}
+
+	if (common->plat->gen == MTK_SMI_GEN2 && bus_sel)
+		writel(bus_sel, common->base + SMI_BUS_SEL);
 	return 0;
 }
 
-- 
1.9.1

