Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1381ABDD
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2019 12:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfELKtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 May 2019 06:49:03 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:54125 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbfELKtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 06:49:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id D13C2FB05;
        Sun, 12 May 2019 12:48:54 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id exSV5RRusFEc; Sun, 12 May 2019 12:48:52 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 8DB6547B79; Sun, 12 May 2019 12:48:51 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <treding@nvidia.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Hovold <johan@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>, Li Jun <jun.li@nxp.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH v11 1/2] dt-bindings: phy: Add documentation for mixel dphy
Date:   Sun, 12 May 2019 12:48:50 +0200
Message-Id: <b3f171fdbed948074fecb619c242ba427285d98e.1557657814.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1557657814.git.agx@sigxcpu.org>
References: <cover.1557657814.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the MIXEL DPHY IP as found on NXP's i.MX8MQ SoCs.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
 .../bindings/phy/mixel,mipi-dsi-phy.txt       | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt b/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt
new file mode 100644
index 000000000000..9b23407233c0
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt
@@ -0,0 +1,29 @@
+Mixel DSI PHY for i.MX8
+
+The Mixel MIPI-DSI PHY IP block is e.g. found on i.MX8 platforms (along the
+MIPI-DSI IP from Northwest Logic). It represents the physical layer for the
+electrical signals for DSI.
+
+Required properties:
+- compatible: Must be:
+  - "fsl,imx8mq-mipi-dphy"
+- clocks: Must contain an entry for each entry in clock-names.
+- clock-names: Must contain the following entries:
+  - "phy_ref": phandle and specifier referring to the DPHY ref clock
+- reg: the register range of the PHY controller
+- #phy-cells: number of cells in PHY, as defined in
+  Documentation/devicetree/bindings/phy/phy-bindings.txt
+  this must be <0>
+
+Optional properties:
+- power-domains: phandle to power domain
+
+Example:
+	dphy: dphy@30a0030 {
+		compatible = "fsl,imx8mq-mipi-dphy";
+		clocks = <&clk IMX8MQ_CLK_DSI_PHY_REF>;
+		clock-names = "phy_ref";
+		reg = <0x30a00300 0x100>;
+		power-domains = <&pd_mipi0>;
+		#phy-cells = <0>;
+        };
-- 
2.20.1

