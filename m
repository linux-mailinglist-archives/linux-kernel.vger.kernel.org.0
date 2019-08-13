Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED6C48B132
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 09:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfHMHgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 03:36:08 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:30516 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727534AbfHMHgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 03:36:08 -0400
X-UUID: f8670a268ace423fbf1e2c423b10ba10-20190813
X-UUID: f8670a268ace423fbf1e2c423b10ba10-20190813
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 1421947788; Tue, 13 Aug 2019 15:36:03 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 13 Aug 2019 15:36:00 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 13 Aug 2019 15:36:00 +0800
From:   Biao Huang <biao.huang@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <yt.shen@mediatek.com>,
        <biao.huang@mediatek.com>, <jianguo.zhang@mediatek.com>
Subject: [PATCH] arm64: dts: mt2712: add ethernet device node
Date:   Tue, 13 Aug 2019 15:35:42 +0800
Message-ID: <20190813073542.6569-1-biao.huang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add device node for mt2712 ethernet.

Signed-off-by: Biao Huang <biao.huang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt2712-evb.dts | 69 +++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi   | 65 +++++++++++++++++++
 2 files changed, 134 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt2712-evb.dts b/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
index 1353dad2f53c..3118f96706d9 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
@@ -107,7 +107,76 @@
 	proc-supply = <&cpus_fixed_vproc1>;
 };
 
+&eth {
+	phy-mode ="rgmii-rxid";
+	phy-handle = <&ethernet_phy0>;
+	mediatek,tx-delay-ps = <1530>;
+	snps,reset-gpio = <&pio 87 GPIO_ACTIVE_LOW>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&eth_default>;
+	pinctrl-1 = <&eth_sleep>;
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		ethernet_phy0: ethernet-phy@5 {
+			compatible = "ethernet-phy-id0243.0d90";
+			reg = <0x5>;
+		};
+	};
+};
+
 &pio {
+	eth_default: eth_default {
+		tx_pins {
+			pinmux = <MT2712_PIN_71_GBE_TXD3__FUNC_GBE_TXD3>,
+				 <MT2712_PIN_72_GBE_TXD2__FUNC_GBE_TXD2>,
+				 <MT2712_PIN_73_GBE_TXD1__FUNC_GBE_TXD1>,
+				 <MT2712_PIN_74_GBE_TXD0__FUNC_GBE_TXD0>,
+				 <MT2712_PIN_75_GBE_TXC__FUNC_GBE_TXC>,
+				 <MT2712_PIN_76_GBE_TXEN__FUNC_GBE_TXEN>;
+			drive-strength = <MTK_DRIVE_8mA>;
+		};
+		rx_pins {
+			pinmux = <MT2712_PIN_78_GBE_RXD3__FUNC_GBE_RXD3>,
+				 <MT2712_PIN_79_GBE_RXD2__FUNC_GBE_RXD2>,
+				 <MT2712_PIN_80_GBE_RXD1__FUNC_GBE_RXD1>,
+				 <MT2712_PIN_81_GBE_RXD0__FUNC_GBE_RXD0>,
+				 <MT2712_PIN_82_GBE_RXDV__FUNC_GBE_RXDV>,
+				 <MT2712_PIN_84_GBE_RXC__FUNC_GBE_RXC>;
+		};
+		mdio_pins {
+			pinmux = <MT2712_PIN_85_GBE_MDC__FUNC_GBE_MDC>,
+				 <MT2712_PIN_86_GBE_MDIO__FUNC_GBE_MDIO>;
+			drive-strength = <MTK_DRIVE_8mA>;
+		};
+	};
+
+	eth_sleep: eth_sleep {
+		tx_pins {
+			pinmux = <MT2712_PIN_71_GBE_TXD3__FUNC_GPIO71>,
+				 <MT2712_PIN_72_GBE_TXD2__FUNC_GPIO72>,
+				 <MT2712_PIN_73_GBE_TXD1__FUNC_GPIO73>,
+				 <MT2712_PIN_74_GBE_TXD0__FUNC_GPIO74>,
+				 <MT2712_PIN_75_GBE_TXC__FUNC_GPIO75>,
+				 <MT2712_PIN_76_GBE_TXEN__FUNC_GPIO76>;
+		};
+		rx_pins {
+			pinmux = <MT2712_PIN_78_GBE_RXD3__FUNC_GPIO78>,
+				 <MT2712_PIN_79_GBE_RXD2__FUNC_GPIO79>,
+				 <MT2712_PIN_80_GBE_RXD1__FUNC_GPIO80>,
+				 <MT2712_PIN_81_GBE_RXD0__FUNC_GPIO81>,
+				 <MT2712_PIN_82_GBE_RXDV__FUNC_GPIO82>,
+				 <MT2712_PIN_84_GBE_RXC__FUNC_GPIO84>;
+		};
+		mdio_pins {
+			pinmux = <MT2712_PIN_85_GBE_MDC__FUNC_GPIO85>,
+				 <MT2712_PIN_86_GBE_MDIO__FUNC_GPIO86>;
+		};
+	};
+
 	usb0_id_pins_float: usb0_iddig {
 		pins_iddig {
 			pinmux = <MT2712_PIN_12_IDDIG_P0__FUNC_IDDIG_A>;
diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
index 43307bad3f0d..b2edec20c8da 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
@@ -632,6 +632,71 @@
 		status = "disabled";
 	};
 
+	stmmac_axi_setup: stmmac-axi-config {
+		snps,wr_osr_lmt = <0x7>;
+		snps,rd_osr_lmt = <0x7>;
+		snps,blen = <0 0 0 0 16 8 4>;
+	};
+
+	mtl_rx_setup: rx-queues-config {
+		snps,rx-queues-to-use = <1>;
+		snps,rx-sched-sp;
+		queue0 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x0>;
+			snps,priority = <0x0>;
+		};
+	};
+
+	mtl_tx_setup: tx-queues-config {
+		snps,tx-queues-to-use = <3>;
+		snps,tx-sched-wrr;
+		queue0 {
+			snps,weight = <0x10>;
+			snps,dcb-algorithm;
+			snps,priority = <0x0>;
+		};
+		queue1 {
+			snps,weight = <0x11>;
+			snps,dcb-algorithm;
+			snps,priority = <0x1>;
+		};
+		queue2 {
+			snps,weight = <0x12>;
+			snps,dcb-algorithm;
+			snps,priority = <0x2>;
+		};
+	};
+
+	eth: ethernet@1101c000 {
+		compatible = "mediatek,mt2712-gmac";
+		reg = <0 0x1101c000 0 0x1300>;
+		interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "macirq";
+		mac-address = [00 55 7b b5 7d f7];
+		clock-names = "axi",
+			      "apb",
+			      "mac_main",
+			      "ptp_ref";
+		clocks = <&pericfg CLK_PERI_GMAC>,
+			 <&pericfg CLK_PERI_GMAC_PCLK>,
+			 <&topckgen CLK_TOP_ETHER_125M_SEL>,
+			 <&topckgen CLK_TOP_ETHER_50M_SEL>;
+		assigned-clocks = <&topckgen CLK_TOP_ETHER_125M_SEL>,
+				  <&topckgen CLK_TOP_ETHER_50M_SEL>;
+		assigned-clock-parents = <&topckgen CLK_TOP_ETHERPLL_125M>,
+					 <&topckgen CLK_TOP_APLL1_D3>;
+		power-domains = <&scpsys MT2712_POWER_DOMAIN_AUDIO>;
+		mediatek,pericfg = <&pericfg>;
+		snps,axi-config = <&stmmac_axi_setup>;
+		snps,mtl-rx-config = <&mtl_rx_setup>;
+		snps,mtl-tx-config = <&mtl_tx_setup>;
+		snps,txpbl = <1>;
+		snps,rxpbl = <1>;
+		clk_csr = <0>;
+		status = "disabled";
+	};
+
 	mmc0: mmc@11230000 {
 		compatible = "mediatek,mt2712-mmc";
 		reg = <0 0x11230000 0 0x1000>;
-- 
2.18.0

