Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB782764B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 08:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfEWGy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 02:54:29 -0400
Received: from verein.lst.de ([213.95.11.211]:44441 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728420AbfEWGy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 02:54:28 -0400
Received: by newverein.lst.de (Postfix, from userid 2005)
        id BB60F68B20; Thu, 23 May 2019 08:54:04 +0200 (CEST)
From:   Torsten Duwe <duwe@lst.de>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Harald Geyer <harald@ccbib.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] arm64: dts: allwinner: a64: enable ANX6345 bridge on Teres-I
References: <20190523065013.2719D68B05@newverein.lst.de>
Message-Id: <20190523065404.BB60F68B20@newverein.lst.de>
Date:   Thu, 23 May 2019 08:54:04 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <icenowy@aosc.io>

Teres-I has an anx6345 bridge connected to the RGB666 LCD output, and
the I2C controlling signals are connected to I2C0 bus. eDP output goes
to an Innolux N116BGE panel.

Enable it in the device tree.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Torsten Duwe <duwe@suse.de>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts |   65 +++++++++++++++++--
 1 file changed, 61 insertions(+), 4 deletions(-)

--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
@@ -65,6 +65,21 @@
 		};
 	};
 
+	panel: panel {
+		compatible ="innolux,n116bge", "simple-panel";
+		status = "okay";
+		power-supply = <&reg_dcdc1>;
+		backlight = <&backlight>;
+
+		ports {
+			panel_in: port {
+				panel_in_edp: endpoint {
+					remote-endpoint = <&anx6345_out>;
+				};
+			};
+		};
+	};
+
 	reg_usb1_vbus: usb1-vbus {
 		compatible = "regulator-fixed";
 		regulator-name = "usb1-vbus";
@@ -81,20 +96,48 @@
 	};
 };
 
+&de {
+	status = "okay";
+};
+
 &ehci1 {
 	status = "okay";
 };
 
 
-/* The ANX6345 eDP-bridge is on i2c0. There is no linux (mainline)
- * driver for this chip at the moment, the bootloader initializes it.
- * However it can be accessed with the i2c-dev driver from user space.
- */
 &i2c0 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
+
+	anx6345: anx6345@38 {
+		compatible = "analogix,anx6345";
+		reg = <0x38>;
+		reset-gpios = <&pio 3 24 GPIO_ACTIVE_LOW>; /* PD24 */
+		dvdd25-supply = <&reg_dldo2>;
+		dvdd12-supply = <&reg_dldo3>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				anx6345_in: endpoint {
+					remote-endpoint = <&tcon0_out_anx6345>;
+				};
+			};
+			port@1 {
+				anx6345_out: endpoint {
+					remote-endpoint = <&panel_in_edp>;
+				};
+			};
+		};
+	};
+};
+
+&mixer0 {
+	status = "okay";
 };
 
 &mmc0 {
@@ -279,6 +322,20 @@
 	vcc-hdmi-supply = <&reg_dldo1>;
 };
 
+&tcon0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&lcd_rgb666_pins>;
+
+	status = "okay";
+};
+
+&tcon0_out {
+	tcon0_out_anx6345: endpoint@0 {
+		reg = <0>;
+		remote-endpoint = <&anx6345_in>;
+	};
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pb_pins>;
