Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD57812A080
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Dec 2019 12:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfLXL2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Dec 2019 06:28:21 -0500
Received: from gloria.sntech.de ([185.11.138.130]:47188 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbfLXL2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 06:28:21 -0500
Received: from [46.183.103.17] (helo=phil.sntech)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1ijiMH-00033e-6p; Tue, 24 Dec 2019 12:28:16 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     dri-devel@lists.freedesktop.org
Cc:     thierry.reding@gmail.com, sam@ravnborg.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com, heiko@sntech.de,
        maxime@cerno.tech,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v4 2/3] dt-bindings: display: panel: Add binding document for Leadtek LTK500HD1829
Date:   Tue, 24 Dec 2019 12:26:40 +0100
Message-Id: <20191224112641.30647-2-heiko@sntech.de>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191224112641.30647-1-heiko@sntech.de>
References: <20191224112641.30647-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

The LTK500HD1829 is a 5.0" 720x1280 DSI display.

changes in v2:
- fix id (Maxime)
- drop port (Maxime)

Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
---
 .../display/panel/leadtek,ltk500hd1829.yaml   | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/leadtek,ltk500hd1829.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/leadtek,ltk500hd1829.yaml b/Documentation/devicetree/bindings/display/panel/leadtek,ltk500hd1829.yaml
new file mode 100644
index 000000000000..123869533a5e
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/leadtek,ltk500hd1829.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/leadtek,ltk500hd1829.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Leadtek LTK500HD1829 5.0in 720x1280 DSI panel
+
+maintainers:
+  - Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: leadtek,ltk500hd1829
+  reg: true
+  backlight: true
+  reset-gpios: true
+  iovcc-supply:
+     description: regulator that supplies the iovcc voltage
+  vcc-supply:
+     description: regulator that supplies the vcc voltage
+
+required:
+  - compatible
+  - reg
+  - backlight
+  - iovcc-supply
+  - vcc-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    dsi@ff450000 {
+        panel@0 {
+            compatible = "leadtek,ltk500hd1829";
+            reg = <0>;
+            backlight = <&backlight>;
+            iovcc-supply = <&vcc_1v8>;
+            vcc-supply = <&vcc_2v8>;
+        };
+    };
+
+...
-- 
2.24.0

