Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDC989FBF3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 09:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfH1HfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 03:35:20 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:45153 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726395AbfH1HfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 03:35:19 -0400
X-UUID: 9b742425ff6241cd89ad9afadc695588-20190828
X-UUID: 9b742425ff6241cd89ad9afadc695588-20190828
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1884125678; Wed, 28 Aug 2019 15:34:40 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 28 Aug 2019 15:34:45 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 28 Aug 2019 15:34:44 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/7] usb: mtk-xhci: support ip-sleep wakeup for MT8183
Date:   Wed, 28 Aug 2019 15:34:28 +0800
Message-ID: <1566977671-22191-5-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1566977671-22191-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1566977671-22191-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 3E76496D948A34D0FB0F9D8D4E935CFC13EE2BE8EA6B56F920518B44536F2D7B2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support USB wakeup by ip-sleep mode for MT8183, it's similar to
MT8173

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: no changes
---
 drivers/usb/host/xhci-mtk.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index 026fe18972d3..4b59f2978954 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -57,6 +57,12 @@
 #define CTRL_U2_FORCE_PLL_STB	BIT(28)
 
 /* usb remote wakeup registers in syscon */
+/* mt8183 etc */
+#define PERI_WK_CTRL0	0x20
+#define WC0_IS_C(x)	(((x) & 0xf) << 28)  /* cycle debounce */
+#define WC0_IS_EN	BIT(12)
+#define WC0_IS_P	BIT(6)  /* polarity for ip sleep */
+
 /* mt8173 etc */
 #define PERI_WK_CTRL1	0x4
 #define WC1_IS_C(x)	(((x) & 0xf) << 26)  /* cycle debounce */
@@ -69,7 +75,8 @@
 #define SSC_SPM_INT_EN		BIT(1)
 
 enum ssusb_uwk_vers {
-	SSUSB_UWK_V1 = 1,
+	SSUSB_UWK_V0 = 0,
+	SSUSB_UWK_V1,
 	SSUSB_UWK_V2,
 };
 
@@ -282,6 +289,11 @@ static void usb_wakeup_ip_sleep_set(struct xhci_hcd_mtk *mtk, bool enable)
 	u32 reg, msk, val;
 
 	switch (mtk->uwk_vers) {
+	case SSUSB_UWK_V0:
+		reg = mtk->uwk_reg_base + PERI_WK_CTRL0;
+		msk = WC0_IS_EN | WC0_IS_C(0xf) | WC0_IS_P;
+		val = enable ? (WC0_IS_EN | WC0_IS_C(0x8)) : 0;
+		break;
 	case SSUSB_UWK_V1:
 		reg = mtk->uwk_reg_base + PERI_WK_CTRL1;
 		msk = WC1_IS_EN | WC1_IS_C(0xf) | WC1_IS_P;
-- 
2.23.0

