Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE901A5264
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 11:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730863AbfIBJBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 05:01:07 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:23447 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730604AbfIBJBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 05:01:06 -0400
X-UUID: 0b47a5c32ee04aa1b7443138ea4cb7bc-20190902
X-UUID: 0b47a5c32ee04aa1b7443138ea4cb7bc-20190902
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1796880267; Mon, 02 Sep 2019 17:01:01 +0800
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
Subject: [RESEND PATCH v1 3/3] arm64: dts: Add power-domains properity to mfgcfg
Date:   Mon, 2 Sep 2019 17:00:59 +0800
Message-ID: <1567414859-3244-4-git-send-email-weiyi.lu@mediatek.com>
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

mfgcfg clock is under MFG_ASYNC power domain

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index c2749c4..3f948e9 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -388,6 +388,7 @@
 			compatible = "mediatek,mt8183-mfgcfg", "syscon";
 			reg = <0 0x13000000 0 0x1000>;
 			#clock-cells = <1>;
+			power-domains = <&scpsys MT8183_POWER_DOMAIN_MFG_ASYNC>;
 		};
 
 		mmsys: syscon@14000000 {
-- 
1.8.1.1.dirty

