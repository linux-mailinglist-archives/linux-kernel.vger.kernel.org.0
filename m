Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8F411FC38
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 01:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfLPAcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Dec 2019 19:32:32 -0500
Received: from gloria.sntech.de ([185.11.138.130]:50708 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbfLPAcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 19:32:24 -0500
Received: from ip5f5a5f74.dynamic.kabel-deutschland.de ([95.90.95.116] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1igeJ6-0004oF-NW; Mon, 16 Dec 2019 01:32:16 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     dri-devel@lists.freedesktop.org
Cc:     thierry.reding@gmail.com, sam@ravnborg.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, heiko@sntech.de,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH v2 2/3] dt-bindings: display: panel: Add binding document for Xinpeng XPP055C272
Date:   Mon, 16 Dec 2019 01:32:05 +0100
Message-Id: <20191216003206.6672-2-heiko@sntech.de>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191216003206.6672-1-heiko@sntech.de>
References: <20191216003206.6672-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

The XPP055C272 is a 5.5" 720x1280 DSI display.

changes in v2:
- add size info into binding title (Sam)
- add more required properties (Sam)

Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---
 .../display/panel/xinpeng,xpp055c272.yaml     | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/xinpeng,xpp055c272.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/xinpeng,xpp055c272.yaml b/Documentation/devicetree/bindings/display/panel/xinpeng,xpp055c272.yaml
new file mode 100644
index 000000000000..2d0fc97d735c
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/xinpeng,xpp055c272.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/sony,acx424akp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xinpeng XPP055C272 5.5in 720x1280 DSI panel
+
+maintainers:
+  - Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: xinpeng,xpp055c272
+  reg: true
+  backlight: true
+  port: true
+  reset-gpios: true
+  iovcc-supply:
+     description: regulator that supplies the iovcc voltage
+  vci-supply:
+     description: regulator that supplies the vci voltage
+
+required:
+  - compatible
+  - reg
+  - backlight
+  - iovcc-supply
+  - vci-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    dsi@ff450000 {
+        panel@0 {
+            compatible = "xinpeng,xpp055c272";
+            reg = <0>;
+            backlight = <&backlight>;
+            iovcc-supply = <&vcc_1v8>;
+            vci-supply = <&vcc3v3_lcd>;
+        };
+    };
+
+...
-- 
2.24.0

