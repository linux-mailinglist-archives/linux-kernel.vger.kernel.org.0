Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8B7DB496C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 10:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388429AbfIQI1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 04:27:22 -0400
Received: from gloria.sntech.de ([185.11.138.130]:46960 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730111AbfIQI1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 04:27:11 -0400
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iA8pJ-0005ZY-Ul; Tue, 17 Sep 2019 10:27:10 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-rockchip@lists.infradead.org,
        christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 10/13] arm64: dts: rockchip: add px30-evb i2c1 devices
Date:   Tue, 17 Sep 2019 10:26:56 +0200
Message-Id: <20190917082659.25549-10-heiko@sntech.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190917082659.25549-1-heiko@sntech.de>
References: <20190917082659.25549-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable i2c1 and adds the devices connected to it.
This includes a magnetometer, goodix-touchscreen and accelerometer.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/px30-evb.dts | 37 +++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30-evb.dts b/arch/arm64/boot/dts/rockchip/px30-evb.dts
index 80524afe94da..1185a314ba4a 100644
--- a/arch/arm64/boot/dts/rockchip/px30-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/px30-evb.dts
@@ -349,6 +349,43 @@
 	};
 };
 
+&i2c1 {
+	status = "okay";
+
+	sensor@d {
+		compatible = "asahi-kasei,ak8963";
+		reg = <0x0d>;
+		gpios = <&gpio0 RK_PB7 GPIO_ACTIVE_HIGH>;
+		vdd-supply = <&vcc3v0_pmu>;
+		mount-matrix = "1", /* x0 */
+			       "0", /* y0 */
+			       "0", /* z0 */
+			       "0", /* x1 */
+			       "1", /* y1 */
+			       "0", /* z1 */
+			       "0", /* x2 */
+			       "0", /* y2 */
+			       "1"; /* z2 */
+	};
+
+	touchscreen@14 {
+		compatible = "goodix,gt1151";
+		reg = <0x14>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PA5 IRQ_TYPE_LEVEL_LOW>;
+		irq-gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
+		VDDIO-supply = <&vcc3v3_lcd>;
+	};
+
+	sensor@4c {
+		compatible = "fsl,mma7660";
+		reg = <0x4c>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PB7 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
 &i2s1_2ch {
 	status = "okay";
 };
-- 
2.20.1

