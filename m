Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4045F3096
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 14:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389448AbfKGNwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 08:52:30 -0500
Received: from verein.lst.de ([213.95.11.211]:57503 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389401AbfKGNw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:52:27 -0500
Received: by verein.lst.de (Postfix, from userid 2005)
        id 82A2468C7B; Thu,  7 Nov 2019 14:52:25 +0100 (CET)
In-Reply-To: <20191107135018.0A04068BE1@verein.lst.de>
References: <20191107135018.0A04068BE1@verein.lst.de>
From:   Torsten Duwe <duwe@lst.de>
Date:   Tue, 29 Oct 2019 13:16:57 +0100
Subject: [PATCH v5 7/7] arm64: dts: allwinner: a64: enable ANX6345 bridge on
 Teres-I
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
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
Message-Id: <20191107135225.82A2468C7B@verein.lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Teres-I has an anx6345 bridge connected to the RGB666 LCD output, and
the I2C controlling signals are connected to I2C0 bus.

Enable it in the device tree, and enable the display engine, video mixer
and tcon0 as well.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Torsten Duwe <duwe@suse.de>
---
 .../boot/dts/allwinner/sun50i-a64-teres-i.dts      | 45 ++++++++++++++++++++--
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
index 1069e7012c9c..970415106dcf 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
@@ -100,18 +100,41 @@
 	status = "okay";
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
+		};
+	};
+};
+
+&mixer0 {
+	status = "okay";
 };
 
 &mmc0 {
@@ -319,6 +342,20 @@
 	status = "okay";
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
-- 
2.16.4

