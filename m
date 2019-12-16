Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7393111FEA5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 07:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfLPGz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 01:55:58 -0500
Received: from mga12.intel.com ([192.55.52.136]:7948 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbfLPGz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 01:55:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Dec 2019 22:55:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,320,1571727600"; 
   d="scan'208";a="217078894"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga006.jf.intel.com with ESMTP; 15 Dec 2019 22:55:54 -0800
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     p.zabel@pengutronix.de, robh@kernel.org,
        martin.blumenstingl@googlemail.com, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH v5 1/2] dt-bindings: reset: Add YAML schemas for the Intel Reset controller
Date:   Mon, 16 Dec 2019 14:55:41 +0800
Message-Id: <a58894158cba812e6d35df165252772b07c8a0b6.1576202050.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML schemas for the reset controller on Intel
Gateway SoC.

Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes on v5:
	Add Reviewed-by: Rob Herring <robh@kernel.org>
	Rebase patches on v5.5-rc1 kernel

Changes on v4:
	Address Rob review comments
	  Drop oneOf and items for 'compatible'
	  Add maxItems for 'reg' and 'intel,global-reset'

Changes on v3:
	Fix DTC warnings
	Add support to legacy xrx200 SoC
	Change file name to intel,rcu-gw.yaml

 .../devicetree/bindings/reset/intel,rcu-gw.yaml    | 63 ++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml

diff --git a/Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml b/Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml
new file mode 100644
index 000000000000..246dea8a2ec9
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/intel,rcu-gw.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: System Reset Controller on Intel Gateway SoCs
+
+maintainers:
+  - Dilip Kota <eswara.kota@linux.intel.com>
+
+properties:
+  compatible:
+    enum:
+      - intel,rcu-lgm
+      - intel,rcu-xrx200
+
+  reg:
+    description: Reset controller registers.
+    maxItems: 1
+
+  intel,global-reset:
+    description: Global reset register offset and bit offset.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32-array
+      - maxItems: 2
+
+  "#reset-cells":
+    minimum: 2
+    maximum: 3
+    description: |
+      First cell is reset request register offset.
+      Second cell is bit offset in reset request register.
+      Third cell is bit offset in reset status register.
+      For LGM SoC, reset cell count is 2 as bit offset in
+      reset request and reset status registers is same. Whereas
+      3 for legacy SoCs as bit offset differs.
+
+required:
+  - compatible
+  - reg
+  - intel,global-reset
+  - "#reset-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    rcu0: reset-controller@e0000000 {
+        compatible = "intel,rcu-lgm";
+        reg = <0xe0000000 0x20000>;
+        intel,global-reset = <0x10 30>;
+        #reset-cells = <2>;
+    };
+
+    pwm: pwm@e0d00000 {
+        status = "disabled";
+        compatible = "intel,lgm-pwm";
+        reg = <0xe0d00000 0x30>;
+        clocks = <&cgu0 1>;
+        #pwm-cells = <2>;
+        resets = <&rcu0 0x30 21>;
+    };
-- 
2.11.0

