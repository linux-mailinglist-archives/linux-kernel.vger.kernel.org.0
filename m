Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A38051DD3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 00:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732613AbfFXV67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 17:58:59 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33266 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732583AbfFXV64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 17:58:56 -0400
Received: by mail-io1-f68.google.com with SMTP id u13so1057547iop.0;
        Mon, 24 Jun 2019 14:58:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ID9V3N/+8SxVffaUkEE/O3htUObL21XTrwW4Ch4Bw6U=;
        b=hFoxIIL2RP+FlheHQx87hTuknTfH9kE/x0HcaMdppL/As0lxP7Rc+zP7OYQ28+3qE4
         o/9Ly/+Ngv0G9O06Ix85BzaRXhiFjtJzo6jr3GQGrrFquZEKrgW+cNxA8kjjSu6P6vcf
         HkdtRrBTm0vi4J8tpcpb159579mY5ncu0WG821fVvS1/W+U4SYpFO3lyX2HmI/zAhbFd
         suRVJVL6U0eDDh7f7OXWzFiDo9MDHQdbsZNMrWvwaWWRJguOg/DTo2iq/wxETuu8WWF7
         vrfbpsvvzxsSsUmFZMa0EktG8tgC2V4rPNCiZJmRp8vwxdkynNhncKFR3EdbKXhWfm8a
         6WaA==
X-Gm-Message-State: APjAAAVUFfhT06wCnG+2hvAoKpOO+1GXI0eQB0wn9vCUJKLj/HRt6znk
        iMB1LK2kWxz5QuHRomQkWw==
X-Google-Smtp-Source: APXvYqwrrM+5eKTpDs0epXOjo5zR4SKKZjfmShWHVkqU/6dEkxoDvOZlRvIl0m/QhA1JVEUxypBUTw==
X-Received: by 2002:a6b:f910:: with SMTP id j16mr17965933iog.256.1561413535021;
        Mon, 24 Jun 2019 14:58:55 -0700 (PDT)
Received: from localhost.localdomain ([64.188.179.247])
        by smtp.googlemail.com with ESMTPSA id l5sm14717301ioq.83.2019.06.24.14.58.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 14:58:54 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH v2 02/15] dt-bindings: display: Convert common panel bindings to DT schema
Date:   Mon, 24 Jun 2019 15:56:36 -0600
Message-Id: <20190624215649.8939-3-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624215649.8939-1-robh@kernel.org>
References: <20190624215649.8939-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the common panel bindings to DT schema consolidating scattered
definitions to a single schema file.

The 'simple-panel' binding just a collection of properties and not a
complete binding itself. All of the 'simple-panel' properties are
covered by the panel-common.txt binding with the exception of the
'no-hpd' property, so add that to the schema.

As there are lots of references to simple-panel.txt, just keep the file
with a reference to common.yaml for now until all the bindings are
converted.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org
Acked-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>
Reviewed-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../display/panel/arm,versatile-tft-panel.txt |   2 +-
 .../bindings/display/panel/panel-common.txt   | 101 ------------
 .../bindings/display/panel/panel-common.yaml  | 149 ++++++++++++++++++
 .../bindings/display/panel/panel.txt          |   4 -
 .../bindings/display/panel/simple-panel.txt   |  29 +---
 5 files changed, 151 insertions(+), 134 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/panel-common.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/panel-common.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/panel/panel.txt

diff --git a/Documentation/devicetree/bindings/display/panel/arm,versatile-tft-panel.txt b/Documentation/devicetree/bindings/display/panel/arm,versatile-tft-panel.txt
index 248141c3c7e3..0601a9e34703 100644
--- a/Documentation/devicetree/bindings/display/panel/arm,versatile-tft-panel.txt
+++ b/Documentation/devicetree/bindings/display/panel/arm,versatile-tft-panel.txt
@@ -10,7 +10,7 @@ Required properties:
 - compatible: should be "arm,versatile-tft-panel"
 
 Required subnodes:
-- port: see display/panel/panel-common.txt, graph.txt
+- port: see display/panel/panel-common.yaml, graph.txt
 
 
 Example:
diff --git a/Documentation/devicetree/bindings/display/panel/panel-common.txt b/Documentation/devicetree/bindings/display/panel/panel-common.txt
deleted file mode 100644
index 5d2519af4bb5..000000000000
--- a/Documentation/devicetree/bindings/display/panel/panel-common.txt
+++ /dev/null
@@ -1,101 +0,0 @@
-Common Properties for Display Panel
-===================================
-
-This document defines device tree properties common to several classes of
-display panels. It doesn't constitue a device tree binding specification by
-itself but is meant to be referenced by device tree bindings.
-
-When referenced from panel device tree bindings the properties defined in this
-document are defined as follows. The panel device tree bindings are
-responsible for defining whether each property is required or optional.
-
-
-Descriptive Properties
-----------------------
-
-- width-mm,
-- height-mm: The width-mm and height-mm specify the width and height of the
-  physical area where images are displayed. These properties are expressed in
-  millimeters and rounded to the closest unit.
-
-- label: The label property specifies a symbolic name for the panel as a
-  string suitable for use by humans. It typically contains a name inscribed on
-  the system (e.g. as an affixed label) or specified in the system's
-  documentation (e.g. in the user's manual).
-
-  If no such name exists, and unless the property is mandatory according to
-  device tree bindings, it shall rather be omitted than constructed of
-  non-descriptive information. For instance an LCD panel in a system that
-  contains a single panel shall not be labelled "LCD" if that name is not
-  inscribed on the system or used in a descriptive fashion in system
-  documentation.
-
-
-Display Timings
----------------
-
-- panel-timing: Most display panels are restricted to a single resolution and
-  require specific display timings. The panel-timing subnode expresses those
-  timings as specified in the timing subnode section of the display timing
-  bindings defined in
-  Documentation/devicetree/bindings/display/panel/display-timing.txt.
-
-
-Connectivity
-------------
-
-- ports: Panels receive video data through one or multiple connections. While
-  the nature of those connections is specific to the panel type, the
-  connectivity is expressed in a standard fashion using ports as specified in
-  the device graph bindings defined in
-  Documentation/devicetree/bindings/graph.txt.
-
-- ddc-i2c-bus: Some panels expose EDID information through an I2C-compatible
-  bus such as DDC2 or E-DDC. For such panels the ddc-i2c-bus contains a
-  phandle to the system I2C controller connected to that bus.
-
-
-Control I/Os
-------------
-
-Many display panels can be controlled through pins driven by GPIOs. The nature
-and timing of those control signals are device-specific and left for panel
-device tree bindings to specify. The following GPIO specifiers can however be
-used for panels that implement compatible control signals.
-
-- enable-gpios: Specifier for a GPIO connected to the panel enable control
-  signal. The enable signal is active high and enables operation of the panel.
-  This property can also be used for panels implementing an active low power
-  down signal, which is a negated version of the enable signal. Active low
-  enable signals (or active high power down signals) can be supported by
-  inverting the GPIO specifier polarity flag.
-
-  Note that the enable signal control panel operation only and must not be
-  confused with a backlight enable signal.
-
-- reset-gpios: Specifier for a GPIO coonnected to the panel reset control
-  signal. The reset signal is active low and resets the panel internal logic
-  while active. Active high reset signals can be supported by inverting the
-  GPIO specifier polarity flag.
-
-Power
------
-
-- power-supply: display panels require power to be supplied. While several
-  panels need more than one power supply with panel-specific constraints
-  governing the order and timings of the power supplies, in many cases a single
-  power supply is sufficient, either because the panel has a single power rail,
-  or because all its power rails can be driven by the same supply. In that case
-  the power-supply property specifies the supply powering the panel as a phandle
-  to a regulator.
-
-Backlight
----------
-
-Most display panels include a backlight. Some of them also include a backlight
-controller exposed through a control bus such as I2C or DSI. Others expose
-backlight control through GPIO, PWM or other signals connected to an external
-backlight controller.
-
-- backlight: For panels whose backlight is controlled by an external backlight
-  controller, this property contains a phandle that references the controller.
diff --git a/Documentation/devicetree/bindings/display/panel/panel-common.yaml b/Documentation/devicetree/bindings/display/panel/panel-common.yaml
new file mode 100644
index 000000000000..ef8d8cdfcede
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/panel-common.yaml
@@ -0,0 +1,149 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/panel-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common Properties for Display Panels
+
+maintainers:
+  - Thierry Reding <thierry.reding@gmail.com>
+  - Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
+
+description: |
+  This document defines device tree properties common to several classes of
+  display panels. It doesn't constitue a device tree binding specification by
+  itself but is meant to be referenced by device tree bindings.
+
+  When referenced from panel device tree bindings the properties defined in this
+  document are defined as follows. The panel device tree bindings are
+  responsible for defining whether each property is required or optional.
+
+properties:
+  # Descriptive Properties
+  width-mm:
+    description:
+      Specifies the width of the physical area where images are displayed. This
+      property is expressed in millimeters and rounded to the closest unit.
+
+  height-mm:
+    description:
+      Specifies the height of the physical area where images are displayed. This
+      property is expressed in millimeters and rounded to the closest unit.
+
+  label:
+    description: |
+      The label property specifies a symbolic name for the panel as a
+      string suitable for use by humans. It typically contains a name inscribed
+      on the system (e.g. as an affixed label) or specified in the system's
+      documentation (e.g. in the user's manual).
+
+      If no such name exists, and unless the property is mandatory according to
+      device tree bindings, it shall rather be omitted than constructed of
+      non-descriptive information. For instance an LCD panel in a system that
+      contains a single panel shall not be labelled "LCD" if that name is not
+      inscribed on the system or used in a descriptive fashion in system
+      documentation.
+
+  rotation:
+    description:
+      Display rotation in degrees counter clockwise (0,90,180,270)
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - enum: [ 0, 90, 180, 270 ]
+
+  # Display Timings
+  panel-timing:
+    type: object
+    description:
+      Most display panels are restricted to a single resolution and
+      require specific display timings. The panel-timing subnode expresses those
+      timings as specified in the timing subnode section of the display timing
+      bindings defined in
+      Documentation/devicetree/bindings/display/panel/display-timing.txt.
+
+  # Connectivity
+  port:
+    type: object
+
+  ports:
+    type: object
+    description:
+      Panels receive video data through one or multiple connections. While
+      the nature of those connections is specific to the panel type, the
+      connectivity is expressed in a standard fashion using ports as specified
+      in the device graph bindings defined in
+      Documentation/devicetree/bindings/graph.txt.
+
+  ddc-i2c-bus:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Some panels expose EDID information through an I2C-compatible
+      bus such as DDC2 or E-DDC. For such panels the ddc-i2c-bus contains a
+      phandle to the system I2C controller connected to that bus.
+
+  no-hpd:
+    type: boolean
+    description:
+      This panel is supposed to communicate that it's ready via HPD
+      (hot plug detect) signal, but the signal isn't hooked up so we should
+      hardcode the max delay from the panel spec when powering up the panel.
+
+  # Control I/Os
+
+  # Many display panels can be controlled through pins driven by GPIOs. The nature
+  # and timing of those control signals are device-specific and left for panel
+  # device tree bindings to specify. The following GPIO specifiers can however be
+  # used for panels that implement compatible control signals.
+
+  enable-gpios:
+    maxItems: 1
+    description: |
+      Specifier for a GPIO connected to the panel enable control signal. The
+      enable signal is active high and enables operation of the panel. This
+      property can also be used for panels implementing an active low power down
+      signal, which is a negated version of the enable signal. Active low enable
+      signals (or active high power down signals) can be supported by inverting
+      the GPIO specifier polarity flag.
+
+      Note that the enable signal control panel operation only and must not be
+      confused with a backlight enable signal.
+
+  reset-gpios:
+    maxItems: 1
+    description:
+      Specifier for a GPIO connected to the panel reset control signal.
+      The reset signal is active low and resets the panel internal logic
+      while active. Active high reset signals can be supported by inverting the
+      GPIO specifier polarity flag.
+
+  # Power
+  power-supply:
+    description:
+      Display panels require power to be supplied. While several panels need
+      more than one power supply with panel-specific constraints governing the
+      order and timings of the power supplies, in many cases a single power
+      supply is sufficient, either because the panel has a single power rail, or
+      because all its power rails can be driven by the same supply. In that case
+      the power-supply property specifies the supply powering the panel as a
+      phandle to a regulator.
+
+  # Backlight
+
+  # Most display panels include a backlight. Some of them also include a backlight
+  # controller exposed through a control bus such as I2C or DSI. Others expose
+  # backlight control through GPIO, PWM or other signals connected to an external
+  # backlight controller.
+
+  backlight:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      For panels whose backlight is controlled by an external backlight
+      controller, this property contains a phandle that references the
+      controller.
+
+dependencies:
+  width-mm: [ height-mm ]
+  height-mm: [ width-mm ]
+
+...
diff --git a/Documentation/devicetree/bindings/display/panel/panel.txt b/Documentation/devicetree/bindings/display/panel/panel.txt
deleted file mode 100644
index e2e6867852b8..000000000000
--- a/Documentation/devicetree/bindings/display/panel/panel.txt
+++ /dev/null
@@ -1,4 +0,0 @@
-Common display properties
--------------------------
-
-- rotation:	Display rotation in degrees counter clockwise (0,90,180,270)
diff --git a/Documentation/devicetree/bindings/display/panel/simple-panel.txt b/Documentation/devicetree/bindings/display/panel/simple-panel.txt
index b2b872c710f2..e11208fb7da8 100644
--- a/Documentation/devicetree/bindings/display/panel/simple-panel.txt
+++ b/Documentation/devicetree/bindings/display/panel/simple-panel.txt
@@ -1,28 +1 @@
-Simple display panel
-====================
-
-panel node
-----------
-
-Required properties:
-- power-supply: See panel-common.txt
-
-Optional properties:
-- ddc-i2c-bus: phandle of an I2C controller used for DDC EDID probing
-- enable-gpios: GPIO pin to enable or disable the panel
-- backlight: phandle of the backlight device attached to the panel
-- no-hpd: This panel is supposed to communicate that it's ready via HPD
-  (hot plug detect) signal, but the signal isn't hooked up so we should
-  hardcode the max delay from the panel spec when powering up the panel.
-
-Example:
-
-	panel: panel {
-		compatible = "cptt,claa101wb01";
-		ddc-i2c-bus = <&panelddc>;
-
-		power-supply = <&vdd_pnl_reg>;
-		enable-gpios = <&gpio 90 0>;
-
-		backlight = <&backlight>;
-	};
+See panel-common.yaml in this directory.
-- 
2.20.1

