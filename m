Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D29BC168955
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 22:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbgBUV2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 16:28:10 -0500
Received: from lists.gateworks.com ([108.161.130.12]:52676 "EHLO
        lists.gateworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgBUV2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 16:28:09 -0500
Received: from 68-189-91-139.static.snlo.ca.charter.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by lists.gateworks.com with esmtp (Exim 4.82)
        (envelope-from <tharvey@gateworks.com>)
        id 1j5Fr4-00018b-QR; Fri, 21 Feb 2020 21:29:02 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Lee Jones <lee.jones@linaro.org>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Jones <rjones@gateworks.com>
Cc:     Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v4 1/3] dt-bindings: mfd: Add Gateworks System Controller bindings
Date:   Fri, 21 Feb 2020 13:27:54 -0800
Message-Id: <1582320476-1098-2-git-send-email-tharvey@gateworks.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582320476-1098-1-git-send-email-tharvey@gateworks.com>
References: <1582320476-1098-1-git-send-email-tharvey@gateworks.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds documentation of device-tree bindings for the
Gateworks System Controller (GSC).

Signed-off-by: Tim Harvey <tharvey@gateworks.com>

v4:
 - move to using pwm<n>_auto_point<m>_{pwm,temp} for FAN PWM
 - remove unncessary resolution/scaling properties for ADCs
 - update to yaml
 - remove watchdog

v3:
 - replaced _ with -
 - remove input bindings
 - added full description of hwmon
 - fix unit address of hwmon child nodes

update dts

Signed-off-by: Tim Harvey <tharvey@gateworks.com>

merge with binding doc
---
 .../devicetree/bindings/mfd/gateworks-gsc.yaml     | 156 +++++++++++++++++++++
 1 file changed, 156 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml

diff --git a/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml b/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
new file mode 100644
index 00000000..314dc7d
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
@@ -0,0 +1,156 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/gateworks-gsc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Gateworks System Controller multi-function device
+
+description: |
+  The GSC is a Multifunction I2C slave device with the following submodules:
+   - Watchdog Timer
+   - GPIO
+   - Pushbutton controller
+   - Hardware Monitore with ADC's for temperature and voltage rails and
+     fan controller
+
+maintainers:
+  - Tim Harvey <tharvey@gateworks.com>
+  - Robert Jones <rjones@gateworks.com>
+
+properties:
+  $nodename:
+    pattern: "gsc@[0-9a-f]{1,2}"
+  compatible:
+    const: gw,gsc
+
+  reg:
+    description:
+      I2C device address.
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 1
+    description:
+      The IRQ number.
+
+  hwmon:
+    description:
+      Optional Hardware Monitoring module.
+
+    properties:
+      compatible:
+        const: "gw,gsc-hwmon"
+
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+      gw,fan-base:
+        description:
+          The fan controller base address
+
+      patternProperties:
+        "^adc@[0-2]$":
+          type: object
+          description: |
+            Properties for a single ADC which can report cooked values
+            (ie temperature sensor based on thermister), raw values
+            (ie voltage rail with a pre-scaling resistor divider).
+
+          properties:
+            reg:
+              description:
+                Register of the ADC.
+              minimum: 0
+              maximum: 255
+
+           label: true
+             description:
+               Name of the ADC input.
+
+           type:
+             description: |
+               temperature in C*10 (temperature),
+               pre-scaled voltage value (voltage),
+               or scaled based on an optional resistor divider and optional
+               offset (voltage-raw)
+             enum:
+               - temperature
+               - voltage
+               - voltage-raw
+
+           gw,voltage-divider:
+             description: |
+               An array of two integers containing the resistor
+               values R1 and R2 of the optinal resistor divider on a raw ADC.
+
+           gw,voltage-offset:
+             description: |
+               A positive uV voltage offset to apply to a raw ADC
+               (ie to compensate for a diode drop).
+
+           required:
+             - compatible
+             - reg
+             - label
+             - type
+
+    required:
+      - compatible
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-parent
+  - #interrupt-cells
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        gsc@20 {
+            compatible = "gw,gsc";
+            reg = <0x20>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <4 GPIO_ACTIVE_LOW>;
+            interrupt-controller;
+            #interrupt-cells = <1>;
+
+            hwmon {
+                compatible = "gw,gsc-hwmon";
+                #address-cells = <1>;
+                #size-cells = <0>;
+                gw,fan-base = <0x2c>;
+
+                adc@0 { /* A0: Board Temperature */
+                    type = "temperature";
+                    reg = <0x00>;
+                    label = "temp";
+                };
+
+                adc@2 { /* A1: Input Voltage (raw ADC) */
+                    type = "voltage-raw";
+                    reg = <0x02>;
+                    label = "vdd_vin";
+                    gw,voltage-divider = <22100 1000>;
+                    gw,voltage-offset = <800000>;
+                };
+
+                adc@b { /* A2: Battery voltage */
+                    type = "voltage";
+                    reg = <0x0b>;
+                    label = "vdd_bat";
+                };
+            };
+        };
-- 
2.7.4

