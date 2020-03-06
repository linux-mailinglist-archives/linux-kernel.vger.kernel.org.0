Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 892A517BFF7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 15:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgCFOMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Mar 2020 09:12:32 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39044 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgCFOMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:12:30 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id D7F48296C97
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>,
        Andrzej Hajda <a.hajda@samsung.com>, megous@megous.com,
        anarsoul@gmail.com, Neil Armstrong <narmstrong@baylibre.com>,
        matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        icenowy@aosc.io, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v3 3/4] dt-bindings: Add ANX7688 HDMI to DP bridge binding
Date:   Fri,  6 Mar 2020 15:12:15 +0100
Message-Id: <20200306141217.423914-3-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200306141217.423914-1-enric.balletbo@collabora.com>
References: <20200306141217.423914-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Boichat <drinkcat@chromium.org>

Add documentation for DT properties supported by the ANX7688 HDMI-DP
converter.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v3:
- Adapt the bridge bindings for the multi-function device.

Changes in v2:
- Improve a bit the descriptions using the info from the datasheet.
- Convert binding to yaml.
- Use dual licensing.

 .../bridge/analogix,anx7688-bridge.yaml       | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/analogix,anx7688-bridge.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,anx7688-bridge.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7688-bridge.yaml
new file mode 100644
index 000000000000..c56da3f39dd8
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7688-bridge.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/analogix,anx7688-bridge.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analogix ANX7688 HDMI to DisplayPort Bridge
+
+maintainers:
+  - Nicolas Boichat <drinkcat@chromium.org>
+  - Enric Balletbo i Serra <enric.balletbo@collabora.com>
+
+description: |
+  The ANX7688 bridge describes the HDMI 2.0 to DisplayPort 1.3 bridge block
+  included in the ANX7688 chip controller. These are meant to be used for
+  controlling display-related signals.
+
+  The node of this device should be under an analogix,anx7866 node. Please refer
+  to Documentation/devicetree/bindings/mfd/analogix,anx7688.yaml for the ANX7688
+  core bindings.
+
+properties:
+  compatible:
+    const: analogix,anx7688-bridge
+
+  ports:
+    type: object
+
+    properties:
+      port@0:
+        type: object
+        description: |
+          Video port for HDMI input
+
+      port@1:
+        type: object
+        description: |
+          Video port for DP output
+
+    required:
+      - port@0
+
+required:
+  - compatible
+  - ports
+
+examples:
+  - |
+    i2c0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        anx7688: anx7688@2c {
+            compatible = "analogix,anx7688";
+            reg = <0x2c>;
+
+            bridge {
+                compatible = "analogix,anx7688-bridge";
+
+                ports {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+
+                    port@0 {
+                        reg = <0>;
+                        anx7688_in: endpoint {
+                            remote-endpoint = <&hdmi0_out>;
+                        };
+                    };
+
+                    port@1 {
+                        reg = <1>;
+                        anx7688_out: endpoint {
+                            remote-endpoint = <&typec0_connector>;
+                       };
+                    };
+                };
+            };
+        };
+    };
-- 
2.25.1

