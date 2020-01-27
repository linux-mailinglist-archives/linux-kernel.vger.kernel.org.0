Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3E1714A9D0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 19:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgA0SbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 13:31:18 -0500
Received: from foss.arm.com ([217.140.110.172]:48120 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbgA0SbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 13:31:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFC5930E;
        Mon, 27 Jan 2020 10:31:16 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C58A3F67D;
        Mon, 27 Jan 2020 10:31:16 -0800 (PST)
Date:   Mon, 27 Jan 2020 18:31:14 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     broonie@kernel.org, devicetree@vger.kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, mark.rutland@arm.com,
        robh+dt@kernel.org, sravanhome@gmail.com
Subject: Applied "dt-bindings: regulator: add document bindings for mpq7920" to the regulator tree
In-Reply-To: <20200123215338.11109-1-sravanhome@gmail.com>
Message-Id: <applied-20200123215338.11109-1-sravanhome@gmail.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   dt-bindings: regulator: add document bindings for mpq7920

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.6

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 44e9b3446423164dd04f58a5f9efd988c4d5e84b Mon Sep 17 00:00:00 2001
From: Saravanan Sekar <sravanhome@gmail.com>
Date: Thu, 23 Jan 2020 22:53:38 +0100
Subject: [PATCH] dt-bindings: regulator: add document bindings for mpq7920

Add device tree binding information for mpq7920 regulator driver.
Example bindings for mpq7920 are added.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20200123215338.11109-1-sravanhome@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/regulator/mps,mpq7920.yaml       | 121 ++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml

diff --git a/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml b/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml
new file mode 100644
index 000000000000..a682af0dc67e
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml
@@ -0,0 +1,121 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/mps,mpq7920.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Monolithic Power System MPQ7920 PMIC
+
+maintainers:
+  - Saravanan Sekar <sravanhome@gmail.com>
+
+properties:
+  $nodename:
+    pattern: "pmic@[0-9a-f]{1,2}"
+  compatible:
+    enum:
+      - mps,mpq7920
+
+  reg:
+    maxItems: 1
+
+  regulators:
+    type: object
+    allOf:
+      - $ref: regulator.yaml#
+    description: |
+      list of regulators provided by this controller, must be named
+      after their hardware counterparts BUCK[1-4], one LDORTC, and LDO[2-5]
+
+    properties:
+      mps,switch-freq:
+        allOf:
+          - $ref: "/schemas/types.yaml#/definitions/uint8"
+        enum: [ 0, 1, 2, 3 ]
+        default: 2
+        description: |
+          switching frequency must be one of following corresponding value
+          1.1MHz, 1.65MHz, 2.2MHz, 2.75MHz
+
+    patternProperties:
+      "^ldo[1-4]$":
+        type: object
+        allOf:
+          - $ref: regulator.yaml#
+
+      "^ldortc$":
+        type: object
+        allOf:
+          - $ref: regulator.yaml#
+
+      "^buck[1-4]$":
+        type: object
+        allOf:
+          - $ref: regulator.yaml#
+
+        properties:
+          mps,buck-softstart:
+            allOf:
+              - $ref: "/schemas/types.yaml#/definitions/uint8"
+            enum: [ 0, 1, 2, 3 ]
+            description: |
+              defines the soft start time of this buck, must be one of the following
+              corresponding values 150us, 300us, 610us, 920us
+
+          mps,buck-phase-delay:
+            allOf:
+              - $ref: "/schemas/types.yaml#/definitions/uint8"
+            enum: [ 0, 1, 2, 3 ]
+            description: |
+              defines the phase delay of this buck, must be one of the following
+              corresponding values 0deg, 90deg, 180deg, 270deg
+
+          mps,buck-ovp-disable:
+            type: boolean
+            description: |
+              disables over voltage protection of this buck
+
+      additionalProperties: false
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - regulators
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@69 {
+          compatible = "mps,mpq7920";
+          reg = <0x69>;
+
+          regulators {
+            mps,switch-freq = /bits/ 8 <1>;
+
+            buck1 {
+             regulator-name = "buck1";
+             regulator-min-microvolt = <400000>;
+             regulator-max-microvolt = <3587500>;
+             regulator-min-microamp  = <460000>;
+             regulator-max-microamp  = <7600000>;
+             regulator-boot-on;
+             mps,buck-ovp-disable;
+             mps,buck-phase-delay = /bits/ 8 <2>;
+             mps,buck-softstart = /bits/ 8 <1>;
+            };
+
+            ldo2 {
+             regulator-name = "ldo2";
+             regulator-min-microvolt = <650000>;
+             regulator-max-microvolt = <3587500>;
+            };
+         };
+       };
+     };
+...
-- 
2.20.1

