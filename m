Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5729C83602
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 17:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387557AbfHFP55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 11:57:57 -0400
Received: from vps.xff.cz ([195.181.215.36]:55450 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387527AbfHFP5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 11:57:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1565107072; bh=hF73OcLMSBQTt85tuavHzM/b80WjbO/5pa+6hf7Ij0Q=;
        h=From:To:Cc:Subject:Date:References:From;
        b=L32f2mT8XPQVCjlNq+xzSMAm+p1moJpligfxrFrnmeGmNpQDjL751AvS62z1xm8iX
         PpnbV0LiMXIP2NkYYb7qaGz8kr4Fy2DtLlFbT5Q35ejNCy3rNU+c4BL4oc8MAEEIr0
         5Kv974GSt2ff+5OPqmAtHCq4WIwHHXRF7Uv4CR/s=
From:   megous@megous.com
To:     linux-sunxi@googlegroups.com,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Jernej=20=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     Ondrej Jirman <megous@megous.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 4/4] arm64: dts: allwinner: orange-pi-3: Enable HDMI output
Date:   Tue,  6 Aug 2019 17:57:43 +0200
Message-Id: <20190806155744.10263-5-megous@megous.com>
In-Reply-To: <20190806155744.10263-1-megous@megous.com>
References: <20190806155744.10263-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

Orange Pi 3 has a DDC_CEC_EN signal connected to PH2, that enables the DDC
I2C bus voltage shifter. Before EDID can be read, we need to pull PH2 high.
This is realized by the ddc-en-gpios property.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 .../dts/allwinner/sun50i-h6-orangepi-3.dts    | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
index 2c6807b74ff6..01bb1bafe284 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
@@ -22,6 +22,18 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	connector {
+		compatible = "hdmi-connector";
+		ddc-en-gpios = <&pio 7 2 GPIO_ACTIVE_HIGH>; /* PH2 */
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -72,6 +84,10 @@
 	cpu-supply = <&reg_dcdca>;
 };
 
+&de {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -91,6 +107,16 @@
 	status = "okay";
 };
 
+&hdmi {
+	status = "okay";
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
 &mdio {
 	ext_rgmii_phy: ethernet-phy@1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
-- 
2.22.0

