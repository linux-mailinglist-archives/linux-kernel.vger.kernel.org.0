Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91F68A526A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 11:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730893AbfIBJBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 05:01:10 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:23447 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730805AbfIBJBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 05:01:08 -0400
X-UUID: bf31f31b85de45fea7022ecff2476d1c-20190902
X-UUID: bf31f31b85de45fea7022ecff2476d1c-20190902
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1425359082; Mon, 02 Sep 2019 17:01:02 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 2 Sep 2019 17:01:02 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 2 Sep 2019 17:01:02 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>
CC:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [RESEND PATCH v1 2/3] clk: mediatek: Runtime PM support for MT8183 mcucfg clock provider
Date:   Mon, 2 Sep 2019 17:00:58 +0800
Message-ID: <1567414859-3244-3-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1567414859-3244-1-git-send-email-weiyi.lu@mediatek.com>
References: <1567414859-3244-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 06FB24C120DB573E0C1FC9AF69C5EFE04ED9455100930063B6AE6F55424DE8B82000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the runtime PM support and forward the struct device pointer for
registration of MT8183 mcucfg clocks.

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 drivers/clk/mediatek/clk-mt8183-mfgcfg.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8183-mfgcfg.c b/drivers/clk/mediatek/clk-mt8183-mfgcfg.c
index 99a6b02..37b4162 100644
--- a/drivers/clk/mediatek/clk-mt8183-mfgcfg.c
+++ b/drivers/clk/mediatek/clk-mt8183-mfgcfg.c
@@ -5,6 +5,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 
 #include "clk-mtk.h"
 #include "clk-gate.h"
@@ -30,10 +31,12 @@ static int clk_mt8183_mfg_probe(struct platform_device *pdev)
 	struct clk_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 
+	pm_runtime_enable(&pdev->dev);
+
 	clk_data = mtk_alloc_clk_data(CLK_MFG_NR_CLK);
 
-	mtk_clk_register_gates(node, mfg_clks, ARRAY_SIZE(mfg_clks),
-			clk_data);
+	mtk_clk_register_gates_with_dev(node, mfg_clks, ARRAY_SIZE(mfg_clks),
+			clk_data, &pdev->dev);
 
 	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
 }
-- 
1.8.1.1.dirty

