Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E34DB1371D9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 16:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbgAJPxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 10:53:55 -0500
Received: from hermes.aosc.io ([199.195.250.187]:48756 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728367AbgAJPxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 10:53:54 -0500
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id AD79446EFC;
        Fri, 10 Jan 2020 15:53:46 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 2/5] dt-bindings: panel: add Feixin K101 IM2BA02 MIPI-DSI panel
Date:   Fri, 10 Jan 2020 23:52:22 +0800
Message-Id: <20200110155225.1051749-3-icenowy@aosc.io>
In-Reply-To: <20200110155225.1051749-1-icenowy@aosc.io>
References: <20200110155225.1051749-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aosc.io; s=dkim;
        t=1578671633;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:in-reply-to:references;
        bh=z5doQufRXnQT5L4o4+thcACLlpA/uKfmmktXJZpePJk=;
        b=jxqLBstjTsy4JyM4ofvrsBDqc9fIHbbUL4VKzx57QgeQIzto6Oc202p6dTD6GDeDdCOR2v
        LELUX2m/wri/B4Rq3WorrVoophvrQNWUBf3qxDBarGlojSp8z1W+Gk/IUGlc7NHZ1v5zS4
        xmqsYWDb/dlSm+8taLY0SNmEHtXSN0c=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Feixin K101 IM2BA02 is a 10.1" 800x1280 4-lane MIPI-DSI panel.

Add device tree binding for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 .../display/panel/feixin,k101-im2ba02.yaml    | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/feixin,k101-im2ba02.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/feixin,k101-im2ba02.yaml b/Documentation/devicetree/bindings/display/panel/feixin,k101-im2ba02.yaml
new file mode 100644
index 000000000000..7176d14893ff
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/feixin,k101-im2ba02.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/feixin,k101-im2ba02.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Feixin K101 IM2BA02 10.1" MIPI-DSI LCD panel
+
+maintainers:
+  - Icenowy Zheng <icenowy@aosc.io>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: feixin,k101-im2ba02
+  reg: true
+  backlight: true
+  reset-gpios: true
+  avdd-supply:
+     description: regulator that supplies the AVDD voltage
+  dvdd-supply:
+     description: regulator that supplies the DVDD voltage
+  cvdd-supply:
+     description: regulator that supplies the CVDD voltage
+
+required:
+  - compatible
+  - reg
+  - backlight
+  - avdd-supply
+  - dvdd-supply
+  - cvdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    &dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        panel@0 {
+            compatible = "feixin,k101-im2ba02";
+            reg = <0>;
+            avdd-supply = <&reg_dc1sw>;
+            dvdd-supply = <&reg_dc1sw>;
+            cvdd-supply = <&reg_ldo_io1>;
+            reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>;
+            backlight = <&backlight>;
+        };
+    };
+
+...
-- 
2.23.0

