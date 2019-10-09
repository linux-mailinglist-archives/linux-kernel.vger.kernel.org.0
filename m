Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2CB1D089F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 09:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbfJIHmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 03:42:00 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:38741 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729950AbfJIHlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 03:41:40 -0400
X-UUID: 1b6e318af6404982a2e6504952685a6c-20191009
X-UUID: 1b6e318af6404982a2e6504952685a6c-20191009
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1610248188; Wed, 09 Oct 2019 15:41:23 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 9 Oct 2019 15:41:16 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 9 Oct 2019 15:41:14 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [RESEND PATCH v3 08/11] phy: phy-mtk-tphy: make the ref clock optional
Date:   Wed, 9 Oct 2019 15:40:31 +0800
Message-ID: <1570606834-5644-8-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1570606834-5644-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1570606834-5644-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 1C65D6FD0659F5550E83F6CC314F1FB4EB89ADE14C21697BE96212FB7A0394692000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes the reference clock of USB3 PHY comes from oscillator
directly, and no need refer to a fixed-clock in DTS anymore
if make it optional.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2~3: no changes
---
 drivers/phy/mediatek/phy-mtk-tphy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
index 4a2dc92f10f5..96c62e3a3300 100644
--- a/drivers/phy/mediatek/phy-mtk-tphy.c
+++ b/drivers/phy/mediatek/phy-mtk-tphy.c
@@ -1182,7 +1182,7 @@ static int mtk_tphy_probe(struct platform_device *pdev)
 		if (tphy->u3phya_ref)
 			continue;
 
-		instance->ref_clk = devm_clk_get(&phy->dev, "ref");
+		instance->ref_clk = devm_clk_get_optional(&phy->dev, "ref");
 		if (IS_ERR(instance->ref_clk)) {
 			dev_err(dev, "failed to get ref_clk(id-%d)\n", port);
 			retval = PTR_ERR(instance->ref_clk);
-- 
2.23.0

