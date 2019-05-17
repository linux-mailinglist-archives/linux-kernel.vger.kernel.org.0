Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4A2421AC4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 17:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbfEQPjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 11:39:14 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40131 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728632AbfEQPjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 11:39:14 -0400
Received: by mail-oi1-f195.google.com with SMTP id r136so5469510oie.7;
        Fri, 17 May 2019 08:39:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ZJFnqXbbMGfRed5Kn6WC0h6J8lD9JCwinWKItAWlBw=;
        b=KhIip3aJvBEDTJK3ncrNOoA9aB/AwbQ861etmlhAWqq94ktlSF3r2b/QHTt91EFOdY
         EoeYLVEDkBPmyRYdWN858EOXMJ0Tsi4beiWm5gXtBZ0/EIZZRhmcntdUoXAfIZZH4JEw
         D7NtokIh5Y9PzYbnMkUrXMQTziAvuLOw82sNs7NrASdjYkFsglECJBDikpE/04wiKves
         WL+eq80lWuoc2XHrkNG4nY3rfXSUVc/IeWdwD57U2kq5xgTFXUYo/VWrUsU9Ytzt6ceJ
         pt0vvuMctuSB49DHLVlCMgWuuvPmRTggliBPN9hA9og5sC8lJ9/ULO08LA+7vz0Qd0JH
         zlFw==
X-Gm-Message-State: APjAAAUfrGLJaygxun4/TkouzIc7v3DfWXQdJs+407HjStmMZQ4EhqKv
        UIjephy3eqB9CU0lXWXdfYpApFo=
X-Google-Smtp-Source: APXvYqwuuPC7HYh3fwL49BJeBz1+HW7LCTzBgIKuSMxc/RINra91W4qveSKa7ogrzB/6mLxO9Jgssg==
X-Received: by 2002:aca:fd45:: with SMTP id b66mr15188097oii.157.1558107552707;
        Fri, 17 May 2019 08:39:12 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id 41sm3172439otm.6.2019.05.17.08.39.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 17 May 2019 08:39:12 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3] dt-bindings: arm: Convert Atmel board/soc bindings to json-schema
Date:   Fri, 17 May 2019 10:39:11 -0500
Message-Id: <20190517153911.19545-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Atmel SoC bindings to DT schema format using json-schema.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
v3:
- correct maintainers

 .../devicetree/bindings/arm/atmel-at91.txt    |  72 ----------
 .../devicetree/bindings/arm/atmel-at91.yaml   | 133 ++++++++++++++++++
 2 files changed, 133 insertions(+), 72 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/atmel-at91.txt
 create mode 100644 Documentation/devicetree/bindings/arm/atmel-at91.yaml

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.txt b/Documentation/devicetree/bindings/arm/atmel-at91.txt
deleted file mode 100644
index 4bf1b4da7659..000000000000
--- a/Documentation/devicetree/bindings/arm/atmel-at91.txt
+++ /dev/null
@@ -1,72 +0,0 @@
-Atmel AT91 device tree bindings.
-================================
-
-Boards with a SoC of the Atmel AT91 or SMART family shall have the following
-properties:
-
-Required root node properties:
-compatible: must be one of:
- * "atmel,at91rm9200"
-
- * "atmel,at91sam9" for SoCs using an ARM926EJ-S core, shall be extended with
-   the specific SoC family or compatible:
-    o "atmel,at91sam9260"
-    o "atmel,at91sam9261"
-    o "atmel,at91sam9263"
-    o "atmel,at91sam9x5" for the 5 series, shall be extended with the specific
-      SoC compatible:
-       - "atmel,at91sam9g15"
-       - "atmel,at91sam9g25"
-       - "atmel,at91sam9g35"
-       - "atmel,at91sam9x25"
-       - "atmel,at91sam9x35"
-    o "atmel,at91sam9g20"
-    o "atmel,at91sam9g45"
-    o "atmel,at91sam9n12"
-    o "atmel,at91sam9rl"
-    o "atmel,at91sam9xe"
- * "atmel,sama5" for SoCs using a Cortex-A5, shall be extended with the specific
-   SoC family:
-    o "atmel,sama5d2" shall be extended with the specific SoC compatible:
-       - "atmel,sama5d27"
-    o "atmel,sama5d3" shall be extended with the specific SoC compatible:
-       - "atmel,sama5d31"
-       - "atmel,sama5d33"
-       - "atmel,sama5d34"
-       - "atmel,sama5d35"
-       - "atmel,sama5d36"
-    o "atmel,sama5d4" shall be extended with the specific SoC compatible:
-       - "atmel,sama5d41"
-       - "atmel,sama5d42"
-       - "atmel,sama5d43"
-       - "atmel,sama5d44"
-
- * "atmel,samv7" for MCUs using a Cortex-M7, shall be extended with the specific
-   SoC family:
-    o "atmel,sams70" shall be extended with the specific MCU compatible:
-       - "atmel,sams70j19"
-       - "atmel,sams70j20"
-       - "atmel,sams70j21"
-       - "atmel,sams70n19"
-       - "atmel,sams70n20"
-       - "atmel,sams70n21"
-       - "atmel,sams70q19"
-       - "atmel,sams70q20"
-       - "atmel,sams70q21"
-    o "atmel,samv70" shall be extended with the specific MCU compatible:
-       - "atmel,samv70j19"
-       - "atmel,samv70j20"
-       - "atmel,samv70n19"
-       - "atmel,samv70n20"
-       - "atmel,samv70q19"
-       - "atmel,samv70q20"
-    o "atmel,samv71" shall be extended with the specific MCU compatible:
-       - "atmel,samv71j19"
-       - "atmel,samv71j20"
-       - "atmel,samv71j21"
-       - "atmel,samv71n19"
-       - "atmel,samv71n20"
-       - "atmel,samv71n21"
-       - "atmel,samv71q19"
-       - "atmel,samv71q20"
-       - "atmel,samv71q21"
diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
new file mode 100644
index 000000000000..7cc1d6c7af55
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
@@ -0,0 +1,133 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/atmel-at91.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel AT91 device tree bindings.
+
+maintainers:
+  - Alexandre Belloni <alexandre.belloni@bootlin.com>
+  - Ludovic Desroches <ludovic.desroches@microchip.com>
+
+description: |
+  Boards with a SoC of the Atmel AT91 or SMART family shall have the following
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - items:
+          - const: atmel,at91rm9200
+      - items:
+          - enum:
+              - olimex,sam9-l9260
+          - enum:
+              - atmel,at91sam9260
+              - atmel,at91sam9261
+              - atmel,at91sam9263
+              - atmel,at91sam9g20
+              - atmel,at91sam9g45
+              - atmel,at91sam9n12
+              - atmel,at91sam9rl
+              - atmel,at91sam9xe
+          - const: atmel,at91sam9
+
+      - items:
+          - enum:
+              - atmel,at91sam9g15
+              - atmel,at91sam9g25
+              - atmel,at91sam9g35
+              - atmel,at91sam9x25
+              - atmel,at91sam9x35
+          - const: atmel,at91sam9x5
+          - const: atmel,at91sam9
+
+      - items:
+          - const: atmel,sama5d27
+          - const: atmel,sama5d2
+          - const: atmel,sama5
+
+      - description: Nattis v2 board with Natte v2 power board
+        items:
+          - const: axentia,nattis-2
+          - const: axentia,natte-2
+          - const: axentia,linea
+          - const: atmel,sama5d31
+          - const: atmel,sama5d3
+          - const: atmel,sama5
+
+      - description: TSE-850 v3 board
+        items:
+          - const: axentia,tse850v3
+          - const: axentia,linea
+          - const: atmel,sama5d31
+          - const: atmel,sama5d3
+          - const: atmel,sama5
+
+      - items:
+          - const: axentia,linea
+          - const: atmel,sama5d31
+          - const: atmel,sama5d3
+          - const: atmel,sama5
+
+      - items:
+          - enum:
+              - atmel,sama5d31
+              - atmel,sama5d33
+              - atmel,sama5d34
+              - atmel,sama5d35
+              - atmel,sama5d36
+          - const: atmel,sama5d3
+          - const: atmel,sama5
+
+      - items:
+          - enum:
+              - atmel,sama5d41
+              - atmel,sama5d42
+              - atmel,sama5d43
+              - atmel,sama5d44
+          - const: atmel,sama5d4
+          - const: atmel,sama5
+
+      - items:
+          - enum:
+              - atmel,sams70j19
+              - atmel,sams70j20
+              - atmel,sams70j21
+              - atmel,sams70n19
+              - atmel,sams70n20
+              - atmel,sams70n21
+              - atmel,sams70q19
+              - atmel,sams70q20
+              - atmel,sams70q21
+          - const: atmel,sams70
+          - const: atmel,samv7
+
+      - items:
+          - enum:
+              - atmel,samv70j19
+              - atmel,samv70j20
+              - atmel,samv70n19
+              - atmel,samv70n20
+              - atmel,samv70q19
+              - atmel,samv70q20
+          - const: atmel,samv70
+          - const: atmel,samv7
+
+      - items:
+          - enum:
+              - atmel,samv71j19
+              - atmel,samv71j20
+              - atmel,samv71j21
+              - atmel,samv71n19
+              - atmel,samv71n20
+              - atmel,samv71n21
+              - atmel,samv71q19
+              - atmel,samv71q20
+              - atmel,samv71q21
+          - const: atmel,samv71
+          - const: atmel,samv7
+
+...
-- 
2.20.1

