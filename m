Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE271970F1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 00:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbgC2WyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Mar 2020 18:54:00 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:31109 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729281AbgC2Wx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 18:53:58 -0400
X-UUID: d370c5f1c69d415590d318d9d8aab34d-20200330
X-UUID: d370c5f1c69d415590d318d9d8aab34d-20200330
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@kernel.org>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 13965590; Mon, 30 Mar 2020 06:53:43 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 30 Mar 2020 06:53:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 30 Mar 2020 06:53:42 +0800
From:   Ryder Lee <ryder.lee@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] arm64: dts: mt7622: add built-in Wi-Fi device nodes
Date:   Mon, 30 Mar 2020 06:53:40 +0800
Message-ID: <315346e1d6fa00e5a0d7a8216982bf723af8e985.1584862530.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryder Lee <ryder.lee@mediatek.com>

This enables built-in 802.11n Wi-Fi support. It's 2.4GHz only.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts     |  4 ++++
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts          |  4 ++++
 arch/arm64/boot/dts/mediatek/mt7622.dtsi              | 11 +++++++++++
 3 files changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
index 83e10591e0e5..d174ad214857 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
@@ -543,3 +543,7 @@
 	pinctrl-0 = <&watchdog_pins>;
 	status = "okay";
 };
+
+&wmac {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
index 3f783348c66a..0b4de627f96e 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
@@ -506,3 +506,7 @@
 	pinctrl-0 = <&watchdog_pins>;
 	status = "okay";
 };
+
+&wmac {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index dac51e98204c..03b14a5ab7f3 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -699,6 +699,17 @@
 		status = "disabled";
 	};
 
+	wmac: wmac@18000000 {
+		compatible = "mediatek,mt7622-wmac";
+		reg = <0 0x18000000 0 0x100000>;
+		interrupts = <GIC_SPI 211 IRQ_TYPE_LEVEL_LOW>;
+
+		mediatek,infracfg = <&infracfg>;
+		status = "disabled";
+
+		power-domains = <&scpsys MT7622_POWER_DOMAIN_WB>;
+	};
+
 	ssusbsys: ssusbsys@1a000000 {
 		compatible = "mediatek,mt7622-ssusbsys",
 			     "syscon";
-- 
2.18.0

