Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEF114587E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 16:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgAVPNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 10:13:38 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34336 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAVPNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 10:13:37 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dafna)
        with ESMTPSA id 58A6B26067C
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     devicetree@vger.kernel.org
Cc:     myungjoo.ham@samsung.com, cw00.choi@samsung.com,
        robh+dt@kernel.org, mark.rutland@arm.com, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org,
        linux-kernel@vger.kernel.org, dafna.hirschfeld@collabora.com,
        helen.koike@collabora.com, ezequiel@collabora.com,
        kernel@collabora.com, dafna3@gmail.com
Subject: [PATCH] dt-bindings: convert extcon-usbc-cros-ec.txt extcon-usbc-cros-ec.yaml
Date:   Wed, 22 Jan 2020 16:13:13 +0100
Message-Id: <20200122151313.11782-1-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

convert the binding file extcon-usbc-cros-ec.txt to yaml format
This was tested and verified on ARM with:
make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 .../bindings/extcon/extcon-usbc-cros-ec.txt   | 24 -----------
 .../bindings/extcon/extcon-usbc-cros-ec.yaml  | 42 +++++++++++++++++++
 2 files changed, 42 insertions(+), 24 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt
 create mode 100644 Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml

diff --git a/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt b/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt
deleted file mode 100644
index 8e8625c00dfa..000000000000
--- a/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-ChromeOS EC USB Type-C cable and accessories detection
-
-On ChromeOS systems with USB Type C ports, the ChromeOS Embedded Controller is
-able to detect the state of external accessories such as display adapters
-or USB devices when said accessories are attached or detached.
-
-The node for this device must be under a cros-ec node like google,cros-ec-spi
-or google,cros-ec-i2c.
-
-Required properties:
-- compatible:		Should be "google,extcon-usbc-cros-ec".
-- google,usb-port-id:	Specifies the USB port ID to use.
-
-Example:
-	cros-ec@0 {
-		compatible = "google,cros-ec-i2c";
-
-		...
-
-		extcon {
-			compatible = "google,extcon-usbc-cros-ec";
-			google,usb-port-id = <0>;
-		};
-	}
diff --git a/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml b/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
new file mode 100644
index 000000000000..78779831282a
--- /dev/null
+++ b/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/extcon/extcon-usbc-cros-ec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ChromeOS EC USB Type-C cable and accessories detection
+
+maintainers:
+  - MyungJoo Ham <myungjoo.ham@samsung.com>
+  - Chanwoo Choi <cw00.choi@samsung.com>
+
+description: |
+  On ChromeOS systems with USB Type C ports, the ChromeOS Embedded Controller is
+  able to detect the state of external accessories such as display adapters
+  or USB devices when said accessories are attached or detached.
+  The node for this device must be under a cros-ec node like google,cros-ec-spi
+  or google,cros-ec-i2c.
+
+properties:
+  compatible:
+    const: google,extcon-usbc-cros-ec
+
+  google,usb-port-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      the port id
+required:
+  - compatible
+  - google,usb-port-id
+
+additionalProperties: false
+
+examples:
+  - |
+    cros-ec@0 {
+        compatible = "google,cros-ec-i2c";
+        extcon {
+            compatible = "google,extcon-usbc-cros-ec";
+            google,usb-port-id = <0>;
+        };
+    };
-- 
2.17.1

