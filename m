Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 227E751DAA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 23:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732699AbfFXV7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 17:59:10 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:43830 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732654AbfFXV7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 17:59:05 -0400
Received: by mail-io1-f48.google.com with SMTP id k20so177364ios.10;
        Mon, 24 Jun 2019 14:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R/fpUXKWtDJj+GJwzBf/JS6ePSNt/GKGHFOmlkyQ0hI=;
        b=Y3teZeTOcCkPlftfST8boyLz5qhlj/MsJVVEn3r3i0iopIz6xFopM4JAQPmD1FE07k
         sVgLp8XF3EuAQRKen94+IcwaiSFs4Xd8OzCu8zmlBu3uL9gOG6j5vpJaqXx2RsUyfYfv
         pSZ9G0Qna7ca88LmoHEflw7HllLxqTmOfctMVvf2n7ZZtp6DmEvPtRfZUcXJbcU1V7B4
         SfZ7l8Yslx78geVhreeIOH1TZxi7i9GjryaNmifMOEfip6ShP+Bjr/iw+1jhz5U09sGY
         Br8OxjmDa1Ic1olnSNEIEk8rv4t97mi1vwxRFBzQNLvfjy723GxbMczfE6XpGszuIQIt
         vEIw==
X-Gm-Message-State: APjAAAV7ZtWR/upH2KKZiefQrj8DBZ7NiVKIsADnvHJVO+aZKPhIGrwh
        xhOnRwtPemjkx04dQa5C3g==
X-Google-Smtp-Source: APXvYqye4h82ObykSV2r4NR1k8C0oZjKP+nNaB80q0l82E7hpJyspmLfGNaE8hn1W5kYJu/hAgaCFA==
X-Received: by 2002:a5d:9703:: with SMTP id h3mr23310932iol.152.1561413544689;
        Mon, 24 Jun 2019 14:59:04 -0700 (PDT)
Received: from localhost.localdomain ([64.188.179.247])
        by smtp.googlemail.com with ESMTPSA id l5sm14717301ioq.83.2019.06.24.14.59.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 14:59:04 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH v2 08/15] dt-bindings: display: Convert raspberrypi,7inch-touchscreen panel to DT schema
Date:   Mon, 24 Jun 2019 15:56:42 -0600
Message-Id: <20190624215649.8939-9-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624215649.8939-1-robh@kernel.org>
References: <20190624215649.8939-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the raspberrypi,7inch-touchscreen panel binding to DT schema.

Cc: Eric Anholt <eric@anholt.net>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../panel/raspberrypi,7inch-touchscreen.txt   | 49 -------------
 .../panel/raspberrypi,7inch-touchscreen.yaml  | 71 +++++++++++++++++++
 2 files changed, 71 insertions(+), 49 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/raspberrypi,7inch-touchscreen.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/raspberrypi,7inch-touchscreen.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/raspberrypi,7inch-touchscreen.txt b/Documentation/devicetree/bindings/display/panel/raspberrypi,7inch-touchscreen.txt
deleted file mode 100644
index e9e19c059260..000000000000
--- a/Documentation/devicetree/bindings/display/panel/raspberrypi,7inch-touchscreen.txt
+++ /dev/null
@@ -1,49 +0,0 @@
-This binding covers the official 7" (800x480) Raspberry Pi touchscreen
-panel.
-
-This DSI panel contains:
-
-- TC358762 DSI->DPI bridge
-- Atmel microcontroller on I2C for power sequencing the DSI bridge and
-  controlling backlight
-- Touchscreen controller on I2C for touch input
-
-and this binding covers the DSI display parts but not its touch input.
-
-Required properties:
-- compatible:	Must be "raspberrypi,7inch-touchscreen-panel"
-- reg:		Must be "45"
-- port:		See panel-common.txt
-
-Example:
-
-dsi1: dsi@7e700000 {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	<...>
-
-	port {
-		dsi_out_port: endpoint {
-			remote-endpoint = <&panel_dsi_port>;
-		};
-	};
-};
-
-i2c_dsi: i2c {
-	compatible = "i2c-gpio";
-	#address-cells = <1>;
-	#size-cells = <0>;
-	gpios = <&gpio 28 0
-		 &gpio 29 0>;
-
-	lcd@45 {
-		compatible = "raspberrypi,7inch-touchscreen-panel";
-		reg = <0x45>;
-
-		port {
-			panel_dsi_port: endpoint {
-				remote-endpoint = <&dsi_out_port>;
-			};
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/display/panel/raspberrypi,7inch-touchscreen.yaml b/Documentation/devicetree/bindings/display/panel/raspberrypi,7inch-touchscreen.yaml
new file mode 100644
index 000000000000..22a083f7bc8e
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/raspberrypi,7inch-touchscreen.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/raspberrypi,7inch-touchscreen.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: The official 7" (800x480) Raspberry Pi touchscreen
+
+maintainers:
+  - Eric Anholt <eric@anholt.net>
+  - Thierry Reding <thierry.reding@gmail.com>
+
+description: |+
+  This DSI panel contains:
+
+  - TC358762 DSI->DPI bridge
+  - Atmel microcontroller on I2C for power sequencing the DSI bridge and
+    controlling backlight
+  - Touchscreen controller on I2C for touch input
+
+  and this binding covers the DSI display parts but not its touch input.
+
+properties:
+  compatible:
+    const: raspberrypi,7inch-touchscreen-panel
+
+  reg:
+    const: 0x45
+
+  port: true
+
+required:
+  - compatible
+  - reg
+  - port
+
+additionalProperties: false
+
+examples:
+  - |+
+    dsi1: dsi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      port {
+        dsi_out_port: endpoint {
+          remote-endpoint = <&panel_dsi_port>;
+        };
+      };
+    };
+
+    i2c_dsi: i2c {
+      compatible = "i2c-gpio";
+      #address-cells = <1>;
+      #size-cells = <0>;
+      scl-gpios = <&gpio 28 0>;
+      sda-gpios = <&gpio 29 0>;
+
+      lcd@45 {
+        compatible = "raspberrypi,7inch-touchscreen-panel";
+        reg = <0x45>;
+
+        port {
+          panel_dsi_port: endpoint {
+            remote-endpoint = <&dsi_out_port>;
+          };
+        };
+      };
+    };
+
+...
-- 
2.20.1

