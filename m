Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF03C11DF89
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2019 09:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfLMIe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Dec 2019 03:34:58 -0500
Received: from inva021.nxp.com ([92.121.34.21]:34782 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfLMIe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 03:34:58 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0429A2007E7;
        Fri, 13 Dec 2019 09:34:56 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7BDAC200342;
        Fri, 13 Dec 2019 09:34:51 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 4A465402EE;
        Fri, 13 Dec 2019 16:34:45 +0800 (SGT)
From:   Wen He <wen.he_1@nxp.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Walle <michael@walle.cc>, Li Yang <leoyang.li@nxp.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wen He <wen.he_1@nxp.com>
Subject: [v12 1/2] dt/bindings: clk: Add YAML schemas for LS1028A Display Clock bindings
Date:   Fri, 13 Dec 2019 16:34:01 +0800
Message-Id: <20191213083402.35678-1-wen.he_1@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS1028A has a clock domain PXLCLK0 used for provide pixel clocks to Display
output interface. Add a YAML schema for this.

Signed-off-by: Wen He <wen.he_1@nxp.com>
Signed-off-by: Michael Walle <michael@walle.cc>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/clock/fsl,plldig.yaml | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,plldig.yaml

diff --git a/Documentation/devicetree/bindings/clock/fsl,plldig.yaml b/Documentation/devicetree/bindings/clock/fsl,plldig.yaml
new file mode 100644
index 000000000000..ad37d3273229
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/fsl,plldig.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/clock/fsl,plldig.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP QorIQ Layerscape LS1028A Display PIXEL Clock Binding
+
+maintainers:
+  - Wen He <wen.he_1@nxp.com>
+
+description: |
+  NXP LS1028A has a clock domain PXLCLK0 used for the Display output
+  interface in the display core, as implemented in TSMC CLN28HPM PLL.
+  which generate and offers pixel clocks to Display.
+
+properties:
+  compatible:
+    const: fsl,ls1028a-plldig
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 0
+
+  fsl,vco-hz:
+     description: Optional for VCO frequency of the PLL in Hertz.
+        The VCO frequency of this PLL cannot be changed during runtime
+        only at startup. Therefore, the output frequencies are very
+        limited and might not even closely match the requested frequency.
+        To work around this restriction the user may specify its own
+        desired VCO frequency for the PLL.
+     minimum: 650000000
+     maximum: 1300000000
+     default: 1188000000
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#clock-cells'
+
+examples:
+  # Display PIXEL Clock node:
+  - |
+    dpclk: clock-display@f1f0000 {
+        compatible = "fsl,ls1028a-plldig";
+        reg = <0x0 0xf1f0000 0x0 0xffff>;
+        #clock-cells = <0>;
+        clocks = <&osc_27m>;
+    };
+
+...
-- 
2.17.1

