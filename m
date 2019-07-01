Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76634259D7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 23:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbfEUVUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 17:20:34 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41300 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfEUVUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 17:20:34 -0400
Received: by mail-oi1-f194.google.com with SMTP id y10so13955922oia.8;
        Tue, 21 May 2019 14:20:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fxtV4j3Q3Ky7PduprSpIqVhzl5TQa+DoL0eC6ro0dg4=;
        b=E6CF+AM3oUtW6AcomyqlKdu/8wHVO6syMU7XEx769fS7y2s19LS3NbYJfKt4S93PF4
         hOyFVCRujtQzhgz/paTtu1U7YgIbKrO4rjCAoJrvCia2vhzTuwP0x8Ncdjg00NtyrRoR
         NECmR1npzQZscLP1wa5zQdQQUfBev1xYjmjXffcHSPOaBnGL4bsqPdaPXu2wgEAGw115
         tBRDYyMTUr1i+Toyagc9sUYX26iJuxDibumedqUstU6k0SxXIxsf0bkKF1BbQehj8/E7
         tdk0GS+hm/BD5hSqiDesNV9It5voJnLH5AQDmpQWr0S2UfpqcY0lHlBy6MWTapmgELPy
         tMNg==
X-Gm-Message-State: APjAAAWWXo8tMMTBDS8D+zgb6DkFDwJJCUSMlJpQUhNyu4ew1sZwRSc6
        reQvLNk1yj11oXsBJ8C6qQ==
X-Google-Smtp-Source: APXvYqwGwhSWmGQBV3MG3m3Oq4R5KNDZW35iz0Y1UF+c10ZuTVr+f+t0QWBao8Dui7aq23ThwmPrLA==
X-Received: by 2002:aca:c450:: with SMTP id u77mr4702738oif.119.1558473633149;
        Tue, 21 May 2019 14:20:33 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id y3sm7510534oto.58.2019.05.21.14.20.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 21 May 2019 14:20:32 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH 1/3] dt-bindings: regulator: Convert regulator binding to json-schema
Date:   Tue, 21 May 2019 16:20:29 -0500
Message-Id: <20190521212031.12982-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the common regulator binding to DT schema format. Note that all
the properties with standard unit suffixes have type checks already, so
only a description is necessary.

As fixed-regulator has already been converted, update the references in
it. Otherwise, keep regulator.txt with a reference to the schema to
avoid a bunch of treewide updates. regulator.txt can be removed when all
the regulator bindings are converted.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/regulator/fixed-regulator.yaml   |   5 +-
 .../bindings/regulator/regulator.txt          | 140 +-----------
 .../bindings/regulator/regulator.yaml         | 200 ++++++++++++++++++
 3 files changed, 205 insertions(+), 140 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml b/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
index d289c2f7455a..a650b457085d 100644
--- a/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
@@ -12,10 +12,13 @@ maintainers:
 
 description:
   Any property defined as part of the core regulator binding, defined in
-  regulator.txt, can also be used. However a fixed voltage regulator is
+  regulator.yaml, can also be used. However a fixed voltage regulator is
   expected to have the regulator-min-microvolt and regulator-max-microvolt
   to be the same.
 
+allOf:
+  - $ref: "regulator.yaml#"
+
 properties:
   compatible:
     const: regulator-fixed
diff --git a/Documentation/devicetree/bindings/regulator/regulator.txt b/Documentation/devicetree/bindings/regulator/regulator.txt
index 0a3f087d5844..487ccd8370b3 100644
--- a/Documentation/devicetree/bindings/regulator/regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/regulator.txt
@@ -1,139 +1 @@
-Voltage/Current Regulators
-
-Optional properties:
-- regulator-name: A string used as a descriptive name for regulator outputs
-- regulator-min-microvolt: smallest voltage consumers may set
-- regulator-max-microvolt: largest voltage consumers may set
-- regulator-microvolt-offset: Offset applied to voltages to compensate for voltage drops
-- regulator-min-microamp: smallest current consumers may set
-- regulator-max-microamp: largest current consumers may set
-- regulator-input-current-limit-microamp: maximum input current regulator allows
-- regulator-always-on: boolean, regulator should never be disabled
-- regulator-boot-on: bootloader/firmware enabled regulator
-- regulator-allow-bypass: allow the regulator to go into bypass mode
-- regulator-allow-set-load: allow the regulator performance level to be configured
-- <name>-supply: phandle to the parent supply/regulator node
-- regulator-ramp-delay: ramp delay for regulator(in uV/us)
-  For hardware which supports disabling ramp rate, it should be explicitly
-  initialised to zero (regulator-ramp-delay = <0>) for disabling ramp delay.
-- regulator-enable-ramp-delay: The time taken, in microseconds, for the supply
-  rail to reach the target voltage, plus/minus whatever tolerance the board
-  design requires. This property describes the total system ramp time
-  required due to the combination of internal ramping of the regulator itself,
-  and board design issues such as trace capacitance and load on the supply.
-- regulator-settling-time-us: Settling time, in microseconds, for voltage
-  change if regulator have the constant time for any level voltage change.
-  This is useful when regulator have exponential voltage change.
-- regulator-settling-time-up-us: Settling time, in microseconds, for voltage
-  increase if the regulator needs a constant time to settle after voltage
-  increases of any level. This is useful for regulators with exponential
-  voltage changes.
-- regulator-settling-time-down-us: Settling time, in microseconds, for voltage
-  decrease if the regulator needs a constant time to settle after voltage
-  decreases of any level. This is useful for regulators with exponential
-  voltage changes.
-- regulator-soft-start: Enable soft start so that voltage ramps slowly
-- regulator-state-standby sub-root node for Standby mode
-  : equivalent with standby Linux sleep state, which provides energy savings
-  with a relatively quick transition back time.
-- regulator-state-mem sub-root node for Suspend-to-RAM mode
-  : suspend to memory, the device goes to sleep, but all data stored in memory,
-  only some external interrupt can wake the device.
-- regulator-state-disk sub-root node for Suspend-to-DISK mode
-  : suspend to disk, this state operates similarly to Suspend-to-RAM,
-  but includes a final step of writing memory contents to disk.
-- regulator-state-[mem/disk/standby] node has following common properties:
-	- regulator-on-in-suspend: regulator should be on in suspend state.
-	- regulator-off-in-suspend: regulator should be off in suspend state.
-	- regulator-suspend-min-microvolt: minimum voltage may be set in
-	  suspend state.
-	- regulator-suspend-max-microvolt: maximum voltage may be set in
-	  suspend state.
-	- regulator-suspend-microvolt: the default voltage which regulator
-	  would be set in suspend. This property is now deprecated, instead
-	  setting voltage for suspend mode via the API which regulator
-	  driver provides is recommended.
-	- regulator-changeable-in-suspend: whether the default voltage and
-	  the regulator on/off in suspend can be changed in runtime.
-	- regulator-mode: operating mode in the given suspend state.
-	  The set of possible operating modes depends on the capabilities of
-	  every hardware so the valid modes are documented on each regulator
-	  device tree binding document.
-- regulator-initial-mode: initial operating mode. The set of possible operating
-  modes depends on the capabilities of every hardware so each device binding
-  documentation explains which values the regulator supports.
-- regulator-allowed-modes: list of operating modes that software is allowed to
-  configure for the regulator at run-time.  Elements may be specified in any
-  order.  The set of possible operating modes depends on the capabilities of
-  every hardware so each device binding document explains which values the
-  regulator supports.
-- regulator-system-load: Load in uA present on regulator that is not captured by
-  any consumer request.
-- regulator-pull-down: Enable pull down resistor when the regulator is disabled.
-- regulator-over-current-protection: Enable over current protection.
-- regulator-active-discharge: tristate, enable/disable active discharge of
-  regulators. The values are:
-	0: Disable active discharge.
-	1: Enable active discharge.
-	Absence of this property will leave configuration to default.
-- regulator-coupled-with: Regulators with which the regulator
-  is coupled. The linkage is 2-way - all coupled regulators should be linked
-  with each other. A regulator should not be coupled with its supplier.
-- regulator-coupled-max-spread: Array of maximum spread between voltages of
-  coupled regulators in microvolts, each value in the array relates to the
-  corresponding couple specified by the regulator-coupled-with property.
-- regulator-max-step-microvolt: Maximum difference between current and target
-  voltages that can be changed safely in a single step.
-
-Deprecated properties:
-- regulator-compatible: If a regulator chip contains multiple
-  regulators, and if the chip's binding contains a child node that
-  describes each regulator, then this property indicates which regulator
-  this child node is intended to configure. If this property is missing,
-  the node's name will be used instead.
-
-Example:
-
-	xyzreg: regulator@0 {
-		regulator-min-microvolt = <1000000>;
-		regulator-max-microvolt = <2500000>;
-		regulator-always-on;
-		vin-supply = <&vin>;
-
-		regulator-state-mem {
-			regulator-on-in-suspend;
-		};
-	};
-
-Regulator Consumers:
-Consumer nodes can reference one or more of its supplies/
-regulators using the below bindings.
-
-- <name>-supply: phandle to the regulator node
-
-These are the same bindings that a regulator in the above
-example used to reference its own supply, in which case
-its just seen as a special case of a regulator being a
-consumer itself.
-
-Example of a consumer device node (mmc) referencing two
-regulators (twl_reg1 and twl_reg2),
-
-	twl_reg1: regulator@0 {
-		...
-		...
-		...
-	};
-
-	twl_reg2: regulator@1 {
-		...
-		...
-		...
-	};
-
-	mmc: mmc@0 {
-		...
-		...
-		vmmc-supply = <&twl_reg1>;
-		vmmcaux-supply = <&twl_reg2>;
-	};
+This file has moved to regulator.yaml.
diff --git a/Documentation/devicetree/bindings/regulator/regulator.yaml b/Documentation/devicetree/bindings/regulator/regulator.yaml
new file mode 100644
index 000000000000..02c3043ce419
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/regulator.yaml
@@ -0,0 +1,200 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Voltage/Current Regulators
+
+maintainers:
+  - Liam Girdwood <lgirdwood@gmail.com>
+  - Mark Brown <broonie@kernel.org>
+
+properties:
+  regulator-name:
+    description: A string used as a descriptive name for regulator outputs
+    $ref: "/schemas/types.yaml#/definitions/string"
+
+  regulator-min-microvolt:
+    description: smallest voltage consumers may set
+
+  regulator-max-microvolt:
+    description: largest voltage consumers may set
+
+  regulator-microvolt-offset:
+    description: Offset applied to voltages to compensate for voltage drops
+
+  regulator-min-microamp:
+    description: smallest current consumers may set
+
+  regulator-max-microamp:
+    description: largest current consumers may set
+
+  regulator-input-current-limit-microamp:
+    description: maximum input current regulator allows
+
+  regulator-always-on:
+    description: boolean, regulator should never be disabled
+    type: boolean
+
+  regulator-boot-on:
+    description: bootloader/firmware enabled regulator
+    type: boolean
+
+  regulator-allow-bypass:
+    description: allow the regulator to go into bypass mode
+    type: boolean
+
+  regulator-allow-set-load:
+    description: allow the regulator performance level to be configured
+    type: boolean
+
+  regulator-ramp-delay:
+    description: ramp delay for regulator(in uV/us) For hardware which supports
+      disabling ramp rate, it should be explicitly initialised to zero (regulator-ramp-delay
+      = <0>) for disabling ramp delay.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+
+  regulator-enable-ramp-delay:
+    description: The time taken, in microseconds, for the supply rail to
+      reach the target voltage, plus/minus whatever tolerance the board
+      design requires. This property describes the total system ramp time
+      required due to the combination of internal ramping of the regulator
+      itself, and board design issues such as trace capacitance and load
+      on the supply.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+
+  regulator-settling-time-us:
+    description: Settling time, in microseconds, for voltage change if regulator
+      have the constant time for any level voltage change. This is useful
+      when regulator have exponential voltage change.
+
+  regulator-settling-time-up-us:
+    description: Settling time, in microseconds, for voltage increase if
+      the regulator needs a constant time to settle after voltage increases
+      of any level. This is useful for regulators with exponential voltage
+      changes.
+
+  regulator-settling-time-down-us:
+    description: Settling time, in microseconds, for voltage decrease if
+      the regulator needs a constant time to settle after voltage decreases
+      of any level. This is useful for regulators with exponential voltage
+      changes.
+
+  regulator-soft-start:
+    description: Enable soft start so that voltage ramps slowly
+    type: boolean
+
+  regulator-initial-mode:
+    description: initial operating mode. The set of possible operating modes
+      depends on the capabilities of every hardware so each device binding
+      documentation explains which values the regulator supports.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+
+  regulator-allowed-modes:
+    description: list of operating modes that software is allowed to configure
+      for the regulator at run-time.  Elements may be specified in any order.
+      The set of possible operating modes depends on the capabilities of
+      every hardware so each device binding document explains which values
+      the regulator supports.
+    $ref: "/schemas/types.yaml#/definitions/uint32-array"
+
+  regulator-system-load:
+    description: Load in uA present on regulator that is not captured by
+      any consumer request.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+
+  regulator-pull-down:
+    description: Enable pull down resistor when the regulator is disabled.
+    type: boolean
+
+  regulator-over-current-protection:
+    description: Enable over current protection.
+    type: boolean
+
+  regulator-active-discharge:
+    description: |
+      tristate, enable/disable active discharge of regulators. The values are:
+      0: Disable active discharge.
+      1: Enable active discharge.
+      Absence of this property will leave configuration to default.
+    allOf:
+      - $ref: "/schemas/types.yaml#/definitions/uint32"
+      - enum: [ 0, 1 ]
+
+  regulator-coupled-with:
+    description: Regulators with which the regulator is coupled. The linkage
+      is 2-way - all coupled regulators should be linked with each other.
+      A regulator should not be coupled with its supplier.
+    $ref: "/schemas/types.yaml#/definitions/phandle-array"
+
+  regulator-coupled-max-spread:
+    description: Array of maximum spread between voltages of coupled regulators
+      in microvolts, each value in the array relates to the corresponding
+      couple specified by the regulator-coupled-with property.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+
+  regulator-max-step-microvolt:
+    description: Maximum difference between current and target voltages
+      that can be changed safely in a single step.
+
+patternProperties:
+  ".*-supply$":
+    description: Input supply phandle(s) for this node
+
+  regulator-state-(standby|mem|disk):
+    type: object
+    description:
+      sub-nodes for regulator state in Standby, Suspend-to-RAM, and
+      Suspend-to-DISK modes. Equivalent with standby, mem, and disk Linux
+      sleep states.
+
+    properties:
+      regulator-on-in-suspend:
+        description: regulator should be on in suspend state.
+        type: boolean
+
+      regulator-off-in-suspend:
+        description: regulator should be off in suspend state.
+        type: boolean
+
+      regulator-suspend-min-microvolt:
+        description: minimum voltage may be set in suspend state.
+
+      regulator-suspend-max-microvolt:
+        description: maximum voltage may be set in suspend state.
+
+      regulator-suspend-microvolt:
+        description: the default voltage which regulator would be set in
+          suspend. This property is now deprecated, instead setting voltage
+          for suspend mode via the API which regulator driver provides is
+          recommended.
+
+      regulator-changeable-in-suspend:
+        description: whether the default voltage and the regulator on/off
+          in suspend can be changed in runtime.
+        type: boolean
+
+      regulator-mode:
+        description: operating mode in the given suspend state. The set
+          of possible operating modes depends on the capabilities of every
+          hardware so the valid modes are documented on each regulator device
+          tree binding document.
+        $ref: "/schemas/types.yaml#/definitions/uint32"
+
+    additionalProperties: false
+
+examples:
+  - |
+    xyzreg: regulator@0 {
+      regulator-min-microvolt = <1000000>;
+      regulator-max-microvolt = <2500000>;
+      regulator-always-on;
+      vin-supply = <&vin>;
+
+      regulator-state-mem {
+        regulator-on-in-suspend;
+      };
+    };
+
+...
-- 
2.20.1

