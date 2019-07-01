Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 268815668E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 12:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfFZKUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 06:20:52 -0400
Received: from inva021.nxp.com ([92.121.34.21]:34360 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbfFZKUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 06:20:50 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4808C20095C;
        Wed, 26 Jun 2019 12:20:48 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3ADD720094D;
        Wed, 26 Jun 2019 12:20:48 +0200 (CEST)
Received: from fsr-ub1664-120.ea.freescale.net (fsr-ub1664-120.ea.freescale.net [10.171.82.81])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id B90FC205DB;
        Wed, 26 Jun 2019 12:20:47 +0200 (CEST)
From:   Robert Chiras <robert.chiras@nxp.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Robert Chiras <robert.chiras@nxp.com>
Subject: [PATCH v5 1/2] dt-bindings: display: panel: Add support for Raydium RM67191 panel
Date:   Wed, 26 Jun 2019 13:20:19 +0300
Message-Id: <1561544420-15572-2-git-send-email-robert.chiras@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561544420-15572-1-git-send-email-robert.chiras@nxp.com>
References: <1561544420-15572-1-git-send-email-robert.chiras@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings documentation for Raydium RM67191 DSI panel.

Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---
 .../bindings/display/panel/raydium,rm67191.txt     | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/raydium,rm67191.txt

diff --git a/Documentation/devicetree/bindings/display/panel/raydium,rm67191.txt b/Documentation/devicetree/bindings/display/panel/raydium,rm67191.txt
new file mode 100644
index 0000000..1042469
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/raydium,rm67191.txt
@@ -0,0 +1,41 @@
+Raydium RM67171 OLED LCD panel with MIPI-DSI protocol
+
+Required properties:
+- compatible: 		"raydium,rm67191"
+- reg:			virtual channel for MIPI-DSI protocol
+			must be <0>
+- dsi-lanes:		number of DSI lanes to be used
+			must be <3> or <4>
+- port: 		input port node with endpoint definition as
+			defined in Documentation/devicetree/bindings/graph.txt;
+			the input port should be connected to a MIPI-DSI device
+			driver
+
+Optional properties:
+- reset-gpios:		a GPIO spec for the RST_B GPIO pin
+- v3p3-supply:		phandle to 3.3V regulator that powers the VDD_3V3 pin
+- v1p8-supply:		phandle to 1.8V regulator that powers the VDD_1V8 pin
+- width-mm:		see panel-common.txt
+- height-mm:		see panel-common.txt
+- video-mode:		0 - burst-mode
+			1 - non-burst with sync event
+			2 - non-burst with sync pulse
+
+Example:
+
+	panel@0 {
+		compatible = "raydium,rm67191";
+		reg = <0>;
+		pinctrl-0 = <&pinctrl_mipi_dsi_0_1_en>;
+		pinctrl-names = "default";
+		reset-gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
+		dsi-lanes = <4>;
+		width-mm = <68>;
+		height-mm = <121>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&mipi_out>;
+			};
+		};
+	};
-- 
2.7.4

