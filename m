Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23679A5269
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 11:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730884AbfIBJBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 05:01:09 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:40166 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730780AbfIBJBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 05:01:08 -0400
X-UUID: 9022956ace814d299a2f3309fa1d6df8-20190902
X-UUID: 9022956ace814d299a2f3309fa1d6df8-20190902
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2052743259; Mon, 02 Sep 2019 17:01:01 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
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
Subject: [RESEND PATCH v1 1/3] clk: mediatek: Register clock gate with device
Date:   Mon, 2 Sep 2019 17:00:57 +0800
Message-ID: <1567414859-3244-2-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1567414859-3244-1-git-send-email-weiyi.lu@mediatek.com>
References: <1567414859-3244-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow those clocks under a power domain to do the runtime pm operation
by forwarding the struct device pointer from clock provider.

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 drivers/clk/mediatek/clk-gate.c |  5 +++--
 drivers/clk/mediatek/clk-gate.h |  3 ++-
 drivers/clk/mediatek/clk-mtk.c  | 16 +++++++++++++---
 drivers/clk/mediatek/clk-mtk.h  |  5 +++++
 4 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-gate.c
index 803bf0a..a35cf0b 100644
--- a/drivers/clk/mediatek/clk-gate.c
+++ b/drivers/clk/mediatek/clk-gate.c
@@ -150,7 +150,8 @@ struct clk *mtk_clk_register_gate(
 		int sta_ofs,
 		u8 bit,
 		const struct clk_ops *ops,
-		unsigned long flags)
+		unsigned long flags,
+		struct device *dev)
 {
 	struct mtk_clk_gate *cg;
 	struct clk *clk;
@@ -174,7 +175,7 @@ struct clk *mtk_clk_register_gate(
 
 	cg->hw.init = &init;
 
-	clk = clk_register(NULL, &cg->hw);
+	clk = clk_register(dev, &cg->hw);
 	if (IS_ERR(clk))
 		kfree(cg);
 
diff --git a/drivers/clk/mediatek/clk-gate.h b/drivers/clk/mediatek/clk-gate.h
index e05c736..3c3329e 100644
--- a/drivers/clk/mediatek/clk-gate.h
+++ b/drivers/clk/mediatek/clk-gate.h
@@ -40,7 +40,8 @@ struct clk *mtk_clk_register_gate(
 		int sta_ofs,
 		u8 bit,
 		const struct clk_ops *ops,
-		unsigned long flags);
+		unsigned long flags,
+		struct device *dev);
 
 #define GATE_MTK_FLAGS(_id, _name, _parent, _regs, _shift,	\
 			_ops, _flags) {				\
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index d28790c..cec1c8a 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -12,6 +12,7 @@
 #include <linux/delay.h>
 #include <linux/clkdev.h>
 #include <linux/mfd/syscon.h>
+#include <linux/device.h>
 
 #include "clk-mtk.h"
 #include "clk-gate.h"
@@ -93,9 +94,10 @@ void mtk_clk_register_factors(const struct mtk_fixed_factor *clks,
 	}
 }
 
-int mtk_clk_register_gates(struct device_node *node,
+int mtk_clk_register_gates_with_dev(struct device_node *node,
 		const struct mtk_gate *clks,
-		int num, struct clk_onecell_data *clk_data)
+		int num, struct clk_onecell_data *clk_data,
+		struct device *dev)
 {
 	int i;
 	struct clk *clk;
@@ -122,7 +124,7 @@ int mtk_clk_register_gates(struct device_node *node,
 				gate->regs->set_ofs,
 				gate->regs->clr_ofs,
 				gate->regs->sta_ofs,
-				gate->shift, gate->ops, gate->flags);
+				gate->shift, gate->ops, gate->flags, dev);
 
 		if (IS_ERR(clk)) {
 			pr_err("Failed to register clk %s: %ld\n",
@@ -136,6 +138,14 @@ int mtk_clk_register_gates(struct device_node *node,
 	return 0;
 }
 
+int mtk_clk_register_gates(struct device_node *node,
+		const struct mtk_gate *clks,
+		int num, struct clk_onecell_data *clk_data)
+{
+	return mtk_clk_register_gates_with_dev(node,
+		clks, num, clk_data, NULL);
+}
+
 struct clk *mtk_clk_register_composite(const struct mtk_composite *mc,
 		void __iomem *base, spinlock_t *lock)
 {
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 733a11d..0f8ada7 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -169,6 +169,11 @@ int mtk_clk_register_gates(struct device_node *node,
 			const struct mtk_gate *clks, int num,
 			struct clk_onecell_data *clk_data);
 
+int mtk_clk_register_gates_with_dev(struct device_node *node,
+		const struct mtk_gate *clks,
+		int num, struct clk_onecell_data *clk_data,
+		struct device *dev);
+
 struct mtk_clk_divider {
 	int id;
 	const char *name;
-- 
1.8.1.1.dirty

