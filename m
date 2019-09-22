Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE3C0BA335
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2019 18:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388078AbfIVQrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Sep 2019 12:47:20 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:42380 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387583AbfIVQrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 12:47:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 88D6EFB05;
        Sun, 22 Sep 2019 18:47:15 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gPVBPwK00ize; Sun, 22 Sep 2019 18:47:13 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 419BA40154; Sun, 22 Sep 2019 09:47:12 -0700 (PDT)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v6 1/2] dt-bindings: display/bridge: Add binding for NWL mipi dsi host controller
Date:   Sun, 22 Sep 2019 09:47:11 -0700
Message-Id: <3bef8eb6a7dd32406e31c68f39ccde3accb58222.1569170717.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <cover.1569170717.git.agx@sigxcpu.org>
References: <cover.1569170717.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Northwest Logic MIPI DSI IP core can be found in NXPs i.MX8 SoCs.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
Tested-by: Robert Chiras <robert.chiras@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/display/bridge/nwl-dsi.yaml      | 176 ++++++++++++++++++
 1 file changed, 176 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml b/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
new file mode 100644
index 000000000000..31119c7885ff
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
@@ -0,0 +1,176 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/nwl-dsi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Northwest Logic MIPI-DSI controller on i.MX SoCs
+
+maintainers:
+  - Guido Gúnther <agx@sigxcpu.org>
+  - Robert Chiras <robert.chiras@nxp.com>
+
+description: |
+  NWL MIPI-DSI host controller found on i.MX8 platforms. This is a dsi bridge for
+  the SOCs NWL MIPI-DSI host controller.
+
+properties:
+  compatible:
+    const: fsl,imx8mq-nwl-dsi
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  clocks:
+    items:
+      - description: DSI core clock
+      - description: RX_ESC clock (used in escape mode)
+      - description: TX_ESC clock (used in escape mode)
+      - description: PHY_REF clock
+
+  clock-names:
+    items:
+      - const: core
+      - const: rx_esc
+      - const: tx_esc
+      - const: phy_ref
+
+  mux-controls:
+    description:
+      mux controller node to use for operating the input mux
+
+  phys:
+    maxItems: 1
+    description:
+      A phandle to the phy module representing the DPHY
+
+  phy-names:
+    items:
+      - const: dphy
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    items:
+      - description: dsi byte reset line
+      - description: dsi dpi reset line
+      - description: dsi esc reset line
+      - description: dsi pclk reset line
+
+  reset-names:
+    items:
+      - const: byte
+      - const: dpi
+      - const: esc
+      - const: pclk
+
+  ports:
+    type: object
+    description:
+      A node containing DSI input & output port nodes with endpoint
+      definitions as documented in
+      Documentation/devicetree/bindings/graph.txt.
+    properties:
+      port@0:
+        type: object
+        description:
+          Input port node to receive pixel data from the
+          display controller
+
+      port@1:
+        type: object
+        description:
+          DSI output port node to the panel or the next bridge
+          in the chain
+
+      '#address-cells':
+        const: 1
+
+      '#size-cells':
+        const: 0
+
+    required:
+      - '#address-cells'
+      - '#size-cells'
+      - port@0
+      - port@1
+
+    additionalProperties: false
+
+patternProperties:
+  "^panel@[0-9]+$":
+    type: object
+
+required:
+  - '#address-cells'
+  - '#size-cells'
+  - clock-names
+  - clocks
+  - compatible
+  - interrupts
+  - mux-controls
+  - phy-names
+  - phys
+  - ports
+  - reg
+  - reset-names
+  - resets
+
+additionalProperties: false
+
+examples:
+ - |
+
+   mipi_dsi: mipi_dsi@30a00000 {
+              #address-cells = <1>;
+              #size-cells = <0>;
+              compatible = "fsl,imx8mq-nwl-dsi";
+              reg = <0x30A00000 0x300>;
+              clocks = <&clk 163>, <&clk 244>, <&clk 245>, <&clk 164>;
+              clock-names = "core", "rx_esc", "tx_esc", "phy_ref";
+              interrupts = <0 34 4>;
+              mux-controls = <&mux 0>;
+              power-domains = <&pgc_mipi>;
+              resets = <&src 0>, <&src 1>, <&src 2>, <&src 3>;
+              reset-names = "byte", "dpi", "esc", "pclk";
+              phys = <&dphy>;
+              phy-names = "dphy";
+
+              panel@0 {
+                      compatible = "rocktech,jh057n00900";
+                      reg = <0>;
+                      port@0 {
+                           panel_in: endpoint {
+                                     remote-endpoint = <&mipi_dsi_out>;
+                           };
+                      };
+              };
+
+              ports {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+
+                    port@0 {
+                           reg = <0>;
+                           mipi_dsi_in: endpoint {
+                                        remote-endpoint = <&lcdif_mipi_dsi>;
+                           };
+                    };
+                    port@1 {
+                           reg = <1>;
+                           mipi_dsi_out: endpoint {
+                                         remote-endpoint = <&panel_in>;
+                           };
+                    };
+              };
+      };
-- 
2.23.0.rc1

