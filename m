Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1344718CAED
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 10:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbgCTJz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 05:55:57 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:58812 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgCTJz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 05:55:57 -0400
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B2ECC504;
        Fri, 20 Mar 2020 10:55:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1584698155;
        bh=nrwMlIbqTrDTZMfFwLJVabf3fTFzIkX1vCUKgBlEUmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jsogXJmnj5QEV4b0WNca7+PJ4cSl6zQNGdiO6ulyINrHIo1g55L6NcFPbvP5sHo06
         O6QP6Uil6lsO/6pahNyp2txZFMPHD+sIo9r+n6rvoPOImyyU3khxHvJY+Fl326oWoJ
         YpgvzZCghQSD0or1fhTPDPsnPmS+w4iCVpCQdQTE=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh@kernel.org>
Cc:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6.1 1/3] dt-bindings: phy: Add DT bindings for Xilinx ZynqMP PSGTR PHY
Date:   Fri, 20 Mar 2020 11:55:45 +0200
Message-Id: <20200320095545.9912-1-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200320095036.GA5193@pendragon.ideasonboard.com>
References: <20200320095036.GA5193@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>

Add DT bindings for the Xilinx ZynqMP PHY. ZynqMP SoCs have a High Speed
Processing System Gigabit Transceiver which provides PHY capabilities to
USB, SATA, PCIE, Display Port and Ehernet SGMII controllers.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
Changes since v6:

- Fixed specification of compatible-dependent xlnx,tx-termination-fix
  property
- Dropped status property from example
- Use 4 spaces to indent example

Changes since v5:

- Document clocks and clock-names properties
- Document resets and reset-names properties
- Replace subnodes with an additional entry in the PHY cells
- Drop lane frequency PHY cell, replaced by reference clock phandle
- Convert bindings to YAML
- Reword the subject line
- Drop Rob's R-b as the bindings have significantly changed
- Drop resets and reset-names properties
---
 .../bindings/phy/xlnx,zynqmp-psgtr.yaml       | 106 ++++++++++++++++++
 include/dt-bindings/phy/phy.h                 |   1 +
 2 files changed, 107 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml

diff --git a/Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml b/Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
new file mode 100644
index 000000000000..b5d661f2813d
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
@@ -0,0 +1,106 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/xlnx,zynqmp-psgtr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx ZynqMP Gigabit Transceiver PHY Device Tree Bindings
+
+maintainers:
+  - Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+
+description: |
+  This binding describes the Xilinx ZynqMP Gigabit Transceiver (GTR) PHY. The
+  GTR provides four lanes and is used by USB, SATA, PCIE, Display port and
+  Ethernet SGMII controllers.
+
+properties:
+  "#phy-cells":
+    const: 4
+    description: |
+      The cells contain the following arguments.
+
+      - description: The GTR lane
+        minimum: 0
+        maximum: 3
+      - description: The PHY type
+        enum:
+          - PHY_TYPE_DP
+          - PHY_TYPE_PCIE
+          - PHY_TYPE_SATA
+          - PHY_TYPE_SGMII
+          - PHY_TYPE_USB
+      - description: The PHY instance
+        minimum: 0
+        maximum: 1 # for DP, SATA or USB
+        maximum: 3 # for PCIE or SGMII
+      - description: The reference clock number
+        minimum: 0
+        maximum: 3
+
+  compatible:
+    enum:
+      - xlnx,zynqmp-psgtr-v1.1
+      - xlnx,zynqmp-psgtr
+
+  clocks:
+    minItems: 1
+    maxItems: 4
+    description: |
+      Clock for each PS_MGTREFCLK[0-3] reference clock input. Unconnected
+      inputs shall not have an entry.
+
+  clock-names:
+    minItems: 1
+    maxItems: 4
+    items:
+      pattern: "^ref[0-3]$"
+
+  reg:
+    items:
+      - description: SERDES registers block
+      - description: SIOU registers block
+
+  reg-names:
+    items:
+      - const: serdes
+      - const: siou
+
+  xlnx,tx-termination-fix:
+    description: |
+      Include this for fixing functional issue with the TX termination
+      resistance in GT, which can be out of spec for the XCZU9EG silicon
+      version.
+    type: boolean
+
+required:
+  - "#phy-cells"
+  - compatible
+  - reg
+  - reg-names
+
+if:
+  properties:
+    compatible:
+      const: xlnx,zynqmp-psgtr-v1.1
+
+then:
+  not:
+    required:
+      - xlnx,tx-termination-fix
+
+additionalProperties: false
+
+examples:
+  - |
+    phy: phy@fd400000 {
+        compatible = "xlnx,zynqmp-psgtr-v1.1";
+        reg = <0x0 0xfd400000 0x0 0x40000>,
+              <0x0 0xfd3d0000 0x0 0x1000>;
+        reg-names = "serdes", "siou";
+        clocks = <&refclks 3>, <&refclks 2>, <&refclks 0>;
+        clock-names = "ref1", "ref2", "ref3";
+        #phy-cells = <4>;
+    };
+
+...
diff --git a/include/dt-bindings/phy/phy.h b/include/dt-bindings/phy/phy.h
index 1f3f866fae7b..f6bc83b66ae9 100644
--- a/include/dt-bindings/phy/phy.h
+++ b/include/dt-bindings/phy/phy.h
@@ -17,5 +17,6 @@
 #define PHY_TYPE_USB3		4
 #define PHY_TYPE_UFS		5
 #define PHY_TYPE_DP		6
+#define PHY_TYPE_SGMII		7
 
 #endif /* _DT_BINDINGS_PHY */
-- 
Regards,

Laurent Pinchart

