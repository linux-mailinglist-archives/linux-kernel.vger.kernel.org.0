Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77D0113B8C5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 06:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgAOFJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 00:09:00 -0500
Received: from inva020.nxp.com ([92.121.34.13]:55552 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbgAOFJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 00:09:00 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A172A1A0583;
        Wed, 15 Jan 2020 06:08:58 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A18F41A0088;
        Wed, 15 Jan 2020 06:08:52 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 2E5EE402AF;
        Wed, 15 Jan 2020 13:08:45 +0800 (SGT)
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     maz@kernel.org, jason@lakedaemon.net, tglx@linutronix.de,
        robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        fugang.duan@nxp.com, Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V5 1/2] dt-bindings/irq: add binding for NXP INTMUX interrupt multiplexer
Date:   Wed, 15 Jan 2020 13:04:23 +0800
Message-Id: <1579064664-16452-2-git-send-email-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579064664-16452-1-git-send-email-qiangqing.zhang@nxp.com>
References: <1579064664-16452-1-git-send-email-qiangqing.zhang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the DT bindings for the NXP INTMUX interrupt multiplexer
for i.MX8 family SoCs.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 .../interrupt-controller/fsl,intmux.yaml      | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.yaml
new file mode 100644
index 000000000000..ea351bad8902
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/fsl,intmux.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale INTMUX interrupt multiplexer
+
+maintainers:
+  - Joakim Zhang <qiangqing.zhang@nxp.com>
+
+properties:
+  compatible:
+    const: fsl,imx-intmux
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 8
+    description: |
+      Should contain the parent interrupt lines (up to 8) used to multiplex
+      the input interrupts.
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+    description: |
+      The 1st cell is hw interrupt number, the 2nd cell is channel index.
+
+  clocks:
+    description: ipg clock.
+
+  clock-names:
+    const: ipg
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+  - '#interrupt-cells'
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    interrupt-controller@37400000 {
+        compatible = "fsl,imx-intmux";
+        reg = <0x37400000 0x1000>;
+        interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        clocks = <&clk IMX8QM_CM40_IPG_CLK>;
+        clock-names = "ipg";
+    };
-- 
2.17.1

