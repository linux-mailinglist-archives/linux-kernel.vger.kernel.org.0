Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD658E8F6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 12:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbfHOK0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 06:26:10 -0400
Received: from inva020.nxp.com ([92.121.34.13]:36320 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbfHOK0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 06:26:10 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B5F951A01AD;
        Thu, 15 Aug 2019 12:26:07 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 413DA1A0275;
        Thu, 15 Aug 2019 12:26:02 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 44AF8402D7;
        Thu, 15 Aug 2019 18:25:55 +0800 (SGT)
From:   Wen He <wen.he_1@nxp.com>
To:     linux-devel@linux.nxdi.nxp.com, Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     leoyang.li@nxp.com, liviu.dudau@arm.com, Wen He <wen.he_1@nxp.com>
Subject: [v2 1/3] dt/bindings: clk: Add YAML schemas for LS1028A Display Clock bindings
Date:   Thu, 15 Aug 2019 18:16:11 +0800
Message-Id: <20190815101613.22872-1-wen.he_1@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS1028A has a clock domain PXLCLK0 used for provide pixel clocks to Display
output interface. Add a YAML schema for this.

Signed-off-by: Wen He <wen.he_1@nxp.com>
---
change in v2:
        - Convert bindings to YAML format

 .../devicetree/bindings/clock/fsl,plldig.yaml | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,plldig.yaml

diff --git a/Documentation/devicetree/bindings/clock/fsl,plldig.yaml b/Documentation/devicetree/bindings/clock/fsl,plldig.yaml
new file mode 100644
index 000000000000..32274e94aafc
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/fsl,plldig.yaml
@@ -0,0 +1,43 @@
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

