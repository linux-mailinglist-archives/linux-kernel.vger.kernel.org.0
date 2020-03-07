Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92F8917CFBF
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Mar 2020 20:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgCGTIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Mar 2020 14:08:12 -0500
Received: from [167.172.186.51] ([167.172.186.51]:41972 "EHLO shell.v3.sk"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726174AbgCGTIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 14:08:11 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 1E001E017F;
        Sat,  7 Mar 2020 19:08:27 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id l4bnpwV6ByAt; Sat,  7 Mar 2020 19:08:24 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 81A86E0181;
        Sat,  7 Mar 2020 19:08:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Rstfa48jzV-x; Sat,  7 Mar 2020 19:08:24 +0000 (UTC)
Received: from furthur.lan (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 801B8DFEC0;
        Sat,  7 Mar 2020 19:08:23 +0000 (UTC)
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

