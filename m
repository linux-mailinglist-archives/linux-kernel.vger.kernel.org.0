Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65CBA11627E
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2019 15:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfLHOzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Dec 2019 09:55:36 -0500
Received: from gloria.sntech.de ([185.11.138.130]:33342 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbfLHOz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 09:55:28 -0500
Received: from muedsl-82-207-238-043.citykom.de ([82.207.238.43] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1idxy1-00043q-3y; Sun, 08 Dec 2019 15:55:25 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH 2/3] arm64: dts: rockchip: add the gpu for px30
Date:   Sun,  8 Dec 2019 15:55:07 +0100
Message-Id: <20191208145508.3124-2-heiko@sntech.de>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191208145508.3124-1-heiko@sntech.de>
References: <20191208145508.3124-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

The px30 contains a Mali Bifrost gpu, so add the necessary core node
for it with interrupts and powerdomains.

Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
---
 arch/arm64/boot/dts/rockchip/px30.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index 9a0f77ea4a78..c31423f36192 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -210,6 +210,12 @@ map0 {
 					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 					contribution = <4096>;
 				};
+
+				map1 {
+					trip = <&target>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					contribution = <4096>;
+				};
 			};
 		};
 
@@ -924,6 +930,19 @@ emmc: dwmmc@ff390000 {
 		status = "disabled";
 	};
 
+	gpu: gpu@ff400000 {
+		compatible = "rockchip,px30-mali", "arm,mali-bifrost";
+		reg = <0x0 0xff400000 0x0 0x4000>;
+		interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "job", "mmu", "gpu";
+		clocks = <&cru SCLK_GPU>;
+		#cooling-cells = <2>;
+		power-domains = <&power PX30_PD_GPU>;
+		status = "disabled";
+	};
+
 	vopb: vop@ff460000 {
 		compatible = "rockchip,px30-vop-big";
 		reg = <0x0 0xff460000 0x0 0xefc>;
-- 
2.24.0

