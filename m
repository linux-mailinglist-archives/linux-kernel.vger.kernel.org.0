Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 890FB97B99
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 15:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbfHUN4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 09:56:47 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:27570 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728980AbfHUN4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 09:56:46 -0400
X-UUID: 70ece07494564a868c827a66c6cc4892-20190821
X-UUID: 70ece07494564a868c827a66c6cc4892-20190821
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 493570354; Wed, 21 Aug 2019 21:56:38 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 21 Aug 2019 21:56:37 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 21 Aug 2019 21:56:36 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, Matthias Kaehlcke <mka@chromium.org>,
        <cui.zhang@mediatek.com>, <chao.hao@mediatek.com>,
        <ming-fan.chen@mediatek.com>
Subject: [PATCH v10 16/23] memory: mtk-smi: Add gals support
Date:   Wed, 21 Aug 2019 21:53:19 +0800
Message-ID: <1566395606-7975-17-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1566395606-7975-1-git-send-email-yong.wu@mediatek.com>
References: <1566395606-7975-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some SoCs like mt8183, SMI add GALS(Global Async Local Sync) module
which can help synchronize for the modules in different clock frequency.
It can be seen as a "asynchronous fifo". This is a example diagram:

            M4U
             |
         ----------
         |        |
     gals0-rx   gals1-rx
         |        |
         |        |
     gals0-tx   gals1-tx
         |        |
        ------------
         SMI Common
        ------------
             |
  +-----+--------+-----+- ...
  |     |        |     |
  |  gals-rx  gals-rx  |
  |     |        |     |
  |     |        |     |
  |  gals-tx  gals-tx  |
  |     |        |     |
larb1 larb2   larb3  larb4

GALS only help transfer the command/data while it doesn't have the
configuring register, thus it has the special "smi" clock and doesn't
have the "apb" clock. From the diagram above, we add "gals0" and
"gals1" clocks for smi-common and add a "gals" clock for smi-larb.

This patch adds gals clock supporting in the SMI. Note that some larbs
may still don't have the "gals" clock like larb1 and larb4 above.

This is also a preparing patch for mt8183 which has GALS.

CC: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 drivers/memory/mtk-smi.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 47df7d0..53bd379 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -48,6 +48,7 @@ enum mtk_smi_gen {
 
 struct mtk_smi_common_plat {
 	enum mtk_smi_gen gen;
+	bool             has_gals;
 };
 
 struct mtk_smi_larb_gen {
@@ -55,11 +56,13 @@ struct mtk_smi_larb_gen {
 	int port_in_larb[MTK_LARB_NR_MAX + 1];
 	void (*config_port)(struct device *);
 	unsigned int			larb_direct_to_common_mask;
+	bool				has_gals;
 };
 
 struct mtk_smi {
 	struct device			*dev;
 	struct clk			*clk_apb, *clk_smi;
+	struct clk			*clk_gals0, *clk_gals1;
 	struct clk			*clk_async; /*only needed by mt2701*/
 	void __iomem			*smi_ao_base;
 
@@ -91,8 +94,20 @@ static int mtk_smi_enable(const struct mtk_smi *smi)
 	if (ret)
 		goto err_disable_apb;
 
+	ret = clk_prepare_enable(smi->clk_gals0);
+	if (ret)
+		goto err_disable_smi;
+
+	ret = clk_prepare_enable(smi->clk_gals1);
+	if (ret)
+		goto err_disable_gals0;
+
 	return 0;
 
+err_disable_gals0:
+	clk_disable_unprepare(smi->clk_gals0);
+err_disable_smi:
+	clk_disable_unprepare(smi->clk_smi);
 err_disable_apb:
 	clk_disable_unprepare(smi->clk_apb);
 err_put_pm:
@@ -102,6 +117,8 @@ static int mtk_smi_enable(const struct mtk_smi *smi)
 
 static void mtk_smi_disable(const struct mtk_smi *smi)
 {
+	clk_disable_unprepare(smi->clk_gals1);
+	clk_disable_unprepare(smi->clk_gals0);
 	clk_disable_unprepare(smi->clk_smi);
 	clk_disable_unprepare(smi->clk_apb);
 	pm_runtime_put_sync(smi->dev);
@@ -302,6 +319,15 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
 	larb->smi.clk_smi = devm_clk_get(dev, "smi");
 	if (IS_ERR(larb->smi.clk_smi))
 		return PTR_ERR(larb->smi.clk_smi);
+
+	if (larb->larb_gen->has_gals) {
+		/* The larbs may still haven't gals even if the SoC support.*/
+		larb->smi.clk_gals0 = devm_clk_get(dev, "gals");
+		if (PTR_ERR(larb->smi.clk_gals0) == -ENOENT)
+			larb->smi.clk_gals0 = NULL;
+		else if (IS_ERR(larb->smi.clk_gals0))
+			return PTR_ERR(larb->smi.clk_gals0);
+	}
 	larb->smi.dev = dev;
 
 	if (larb->larb_gen->need_larbid) {
@@ -394,6 +420,16 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
 	if (IS_ERR(common->clk_smi))
 		return PTR_ERR(common->clk_smi);
 
+	if (common->plat->has_gals) {
+		common->clk_gals0 = devm_clk_get(dev, "gals0");
+		if (IS_ERR(common->clk_gals0))
+			return PTR_ERR(common->clk_gals0);
+
+		common->clk_gals1 = devm_clk_get(dev, "gals1");
+		if (IS_ERR(common->clk_gals1))
+			return PTR_ERR(common->clk_gals1);
+	}
+
 	/*
 	 * for mtk smi gen 1, we need to get the ao(always on) base to config
 	 * m4u port, and we need to enable the aync clock for transform the smi
-- 
1.9.1

