Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5FF17DAF0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 09:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgCIIci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 04:32:38 -0400
Received: from v6.sk ([167.172.42.174]:34270 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbgCIIch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 04:32:37 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id D65DC60FF8;
        Mon,  9 Mar 2020 08:32:35 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Rob Herring <robh@kernel.org>
Subject: [RESEND PATCH v2 2/3] dt-bindings: display: Add Chrontel CH7033 Video Encoder binding
Date:   Sat,  7 Mar 2020 20:07:59 +0100
Message-Id: <20200307190800.142658-3-lkundrak@v3.sk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200307190800.142658-1-lkundrak@v3.sk>
References: <20200307190800.142658-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding document for the Chrontel CH7033 VGA/DVI/HDMI Encoder.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Reviewed-by: Rob Herring <robh@kernel.org>

---
Changes since v1:
- Dual licensed with BSD-2-Clause
- Collected Rob's reviewed-by tag

 .../display/bridge/chrontel,ch7033.yaml       | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/chro=
ntel,ch7033.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/chrontel,ch=
7033.yaml b/Documentation/devicetree/bindings/display/bridge/chrontel,ch7=
033.yaml
new file mode 100644
index 0000000000000..dc97f34fbfe0f
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/chrontel,ch7033.ya=
ml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2019 Lubomir Rintel <lkundrak@v3.sk>
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/chrontel,ch7033.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Chrontel CH7033 Video Encoder Device Tree Bindings
+
+maintainers:
+  - Lubomir Rintel <lkundrak@v3.sk>
+
+properties:
+  compatible:
+    const: chrontel,ch7033
+
+  reg:
+    maxItems: 1
+    description: I2C address of the device
+
+  ports:
+    type: object
+
+    properties:
+      port@0:
+        type: object
+        description: |
+          Video port for RGB input.
+
+      port@1:
+        type: object
+        description: |
+          DVI port, should be connected to a node compatible with the
+          dvi-connector binding.
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - reg
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    dvi-connector {
+        compatible =3D "dvi-connector";
+        ddc-i2c-bus =3D <&twsi5>;
+        hpd-gpios =3D <&gpio 62 GPIO_ACTIVE_LOW>;
+        digital;
+        analog;
+
+        port {
+            dvi_in: endpoint {
+                remote-endpoint =3D <&encoder_out>;
+            };
+        };
+    };
+
+    vga-dvi-encoder@76 {
+        compatible =3D "chrontel,ch7033";
+        reg =3D <0x76>;
+
+        ports {
+            #address-cells =3D <1>;
+            #size-cells =3D <0>;
+
+            port@0 {
+                reg =3D <0>;
+                endpoint {
+                    remote-endpoint =3D <&lcd0_rgb_out>;
+                };
+            };
+
+            encoder_out: port@1 {
+                reg =3D <1>;
+                endpoint {
+                    remote-endpoint =3D <&dvi_in>;
+                };
+            };
+
+        };
+    };
--=20
2.24.1


