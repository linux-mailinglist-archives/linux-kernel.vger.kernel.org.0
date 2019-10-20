Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC840DDEAA
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2019 15:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfJTNmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Oct 2019 09:42:33 -0400
Received: from vps.xff.cz ([195.181.215.36]:52574 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbfJTNmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 09:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1571578951; bh=h4J7KFQapQWjRwMMa+Q2cRD0P8kG4K/9cQRm/b5HHnQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Sr+bIfZyaJ4sTS/2FZC+LKnzMqIF6Wg4O+iT121liaIdH9LvxF3eIU1rrGRVcvzWO
         BQM34AnljVaFATVoFPUD1o37TzYEOUVy7U7M9xf/F6UNRIeQ2/4PU018P0C/b94Vcp
         XaerfWkcwSrymJUXdKJ2KrXa63ErNsNzZKpFXaY8=
From:   megous@megous.com
To:     linux-sunxi@googlegroups.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Ondrej Jirman <megous@megous.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/4] dt-bindings: Add bindings for USB3 phy on Allwinner H6
Date:   Sun, 20 Oct 2019 15:42:26 +0200
Message-Id: <20191020134229.1216351-2-megous@megous.com>
In-Reply-To: <20191020134229.1216351-1-megous@megous.com>
References: <20191020134229.1216351-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

The new Allwinner H6 SoC contains a USB3 PHY that is wired to the
external USB3 pins of the SoC.

Add a device tree binding for the PHY.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 .../phy/allwinner,sun50i-h6-usb3-phy.yaml     | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/allwinner,sun50i-h6-usb3-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/allwinner,sun50i-h6-usb3-phy.yaml b/Documentation/devicetree/bindings/phy/allwinner,sun50i-h6-usb3-phy.yaml
new file mode 100644
index 000000000000..2fdc890748db
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/allwinner,sun50i-h6-usb3-phy.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2019 Ondrej Jirman <megous@megous.com>
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/phy/allwinner,sun50i-h6-usb3-phy.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Allwinner sun50i USB3 PHY
+
+maintainers:
+  - Ondrej Jirman <megous@megous.com>
+
+properties:
+  compatible:
+    enum:
+      - allwinner,sun50i-h6-usb3-phy
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  "#phy-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - resets
+  - "#phy-cells"
+
+examples:
+  - |
+    #include <dt-bindings/clock/sun50i-h6-ccu.h>
+    #include <dt-bindings/reset/sun50i-h6-ccu.h>
+    phy@5210000 {
+          compatible = "allwinner,sun50i-h6-usb3-phy";
+          reg = <0x5210000 0x10000>;
+          clocks = <&ccu CLK_USB_PHY1>;
+          resets = <&ccu RST_USB_PHY1>;
+          #phy-cells = <0>;
+    };
-- 
2.23.0

