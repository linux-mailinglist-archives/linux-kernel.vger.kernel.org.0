Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0127B134392
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 14:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgAHNNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 08:13:01 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46031 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgAHNMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 08:12:49 -0500
Received: by mail-wr1-f65.google.com with SMTP id j42so3257591wrj.12;
        Wed, 08 Jan 2020 05:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=St6q5202LZ4WNScNSwJG5KHQgHK6N7FvcWjRsWrSrMk=;
        b=t44lAC4VEPhv2FUv6NZsyfkGeSg4b0veibBNSBMefoVwuYSFMD9PZAxIk8XdL0U+uA
         JzkgAbXdclSPMThsV6GNg4hQlxln68YZ3cq3vrFqLn1LuuKWHTXjxHMVRix1+HEKV72/
         GdX3wpibbcfzUJYR+i/d1Agpr87vxZ/e7krF9p8XYIuLDwXLeLvf0rGLH1y/gVWGGvHL
         /+S8Tcg+hWXRDWZ+oWCXVjemk3a5Gw6KHNygSkm9eTuSQ4ItX01RVKiPLnHROtjq+leJ
         OVjfgFl32sfmT7AopVEpjg5LkoigLscREOj9e7iR2Z79zGme0t8e5ViX9++vJO1yuJXU
         yh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=St6q5202LZ4WNScNSwJG5KHQgHK6N7FvcWjRsWrSrMk=;
        b=PCYFXhEwxVrVk5b/yP4AQaRLT8S86wBrH+osNJzF79s4vIiLYU23rbMIaXj45oYM3X
         U/XwNDALRFRwos+t7Pg6cet+gOE1w9At6G/pAqPU/c416RhyhpGMiIpK7LsFR+uTIE3k
         fDrdlFNz7x/twFQ9yR59VsiLdFa0TF68TORLbNPFwPP8sIwQ3zwBRWu19LATAVpeuYYN
         u17tLcjFQF6Nw3Pyb1IislDA5Lqv4mWTyzsOwKP+nV6n7KOLREb1supfMcxGoEi8TEnv
         B8uqvFjeunSpEHJ1wOD0LjJVtW2oE8j0/p8gnbbeq6+KIZ3UhJy8VuBqCXV4nn09sZkp
         roDg==
X-Gm-Message-State: APjAAAVcfONqFC6c77zKuS3vYUFMgU5nyBdzEW5Q7ILmyhd1wP3OKru3
        hKalcmDVH6ufDtP1lZMPObU=
X-Google-Smtp-Source: APXvYqx40dgOsDZgOrARQvsYerdlaDXzxdk8zr5blSt+XtkGK4gh+Rl/Zkjd5YjLsFiDRkdp5GIqsw==
X-Received: by 2002:adf:ebc6:: with SMTP id v6mr4513898wrn.75.1578489166322;
        Wed, 08 Jan 2020 05:12:46 -0800 (PST)
Received: from localhost.localdomain (p5B3F64F6.dip0.t-ipconnect.de. [91.63.100.246])
        by smtp.gmail.com with ESMTPSA id k82sm3875878wmf.10.2020.01.08.05.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 05:12:45 -0800 (PST)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, mripard@kernel.org,
        shawnguo@kernel.org, heiko@sntech.de, sam@ravnborg.org,
        icenowy@aosc.io, laurent.pinchart@ideasonboard.com,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        davem@davemloft.net, mchehab+samsung@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/4] dt-bindings: regulator: add document bindings for mpq7920
Date:   Wed,  8 Jan 2020 14:12:32 +0100
Message-Id: <20200108131234.24128-3-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200108131234.24128-1-sravanhome@gmail.com>
References: <20200108131234.24128-1-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding information for mpq7920 regulator driver.
Example bindings for mpq7920 are added.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 .../bindings/regulator/mps,mpq7920.yaml       | 202 ++++++++++++++++++
 1 file changed, 202 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml

diff --git a/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml b/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml
new file mode 100644
index 000000000000..598f3ea070c9
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml
@@ -0,0 +1,202 @@
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
+    description: |
+      list of regulators provided by this controller, must be named
+      after their hardware counterparts BUCK[1-4], one LDORTC, and LDO[2-5]
+
+      mps,switch-freq:
+        description: |
+          switching frequency must be one of following corresponding value
+          1.1MHz, 1.65MHz, 2.2MHz, 2.75MHz
+        $ref: "/schemas/types.yaml#/definitions/uint8"
+        enum: [ 0, 1, 2, 3 ]
+        default: 2
+
+      buck1:
+        type: object
+        $ref: "regulator.yaml#"
+        description: |
+          4.5A DC-DC step down converter
+
+        mps,buck-softstart:
+           $ref: "/schemas/types.yaml#/definitions/uint8"
+           enum: [ 0, 1, 2, 3 ]
+           default: 1
+           description: |
+             defines the soft start time of this buck, must be one of the following
+             corresponding values 150us, 300us, 610us, 920us
+
+         mps,buck-phase-delay:
+           $ref: "/schemas/types.yaml#/definitions/uint8"
+           enum: [ 0, 1, 2, 3 ]
+           default: 0
+           description: |
+             defines the phase delay of this buck, must be one of the following
+             corresponding values 0deg, 90deg, 180deg, 270deg
+
+         mps,buck-ovp-disable:
+           type: boolean
+           description: |
+             disables over voltage protection of this buck
+
+      buck2:
+        type: object
+        $ref: "regulator.yaml#"
+        description: |
+          2.5A DC-DC step down converter
+
+        mps,buck-softstart:
+          description: |
+            defines the soft start time of this buck, must be one of the following
+            corresponding values 150us, 300us, 610us, 920us
+          $ref: "/schemas/types.yaml#/definitions/uint8"
+          enum: [ 0, 1, 2, 3 ]
+          default: 1
+
+        mps,buck-phase-delay:
+          description: |
+            defines the phase delay of this buck, must be one of the following
+            corresponding values 0deg, 90deg, 180deg, 270deg
+          $ref: "/schemas/types.yaml#/definitions/uint8"
+          enum: [ 0, 1, 2, 3 ]
+          default: 0
+
+        mps,buck-ovp-disable:
+          description: |
+            disables over voltage protection of this buck
+          type: boolean
+
+      buck3:
+        type: object
+        $ref: "regulator.yaml#"
+        description: |
+          4.5A DC-DC step down converter
+
+        mps,buck-softstart:
+           description: |
+             defines the soft start time of this buck, must be one of the following
+             corresponding values 150us, 300us, 610us, 920us
+           $ref: "/schemas/types.yaml#/definitions/uint8"
+           enum: [ 0, 1, 2, 3 ]
+           default: 1
+
+         mps,buck-phase-delay:
+           description: |
+             defines the phase delay of this buck, must be one of the following
+             corresponding values 0deg, 90deg, 180deg, 270deg
+           $ref: "/schemas/types.yaml#/definitions/uint8"
+           enum: [ 0, 1, 2, 3 ]
+           default: 1
+
+         mps,buck-ovp-disable:
+           description: |
+             disables over voltage protection of this buck
+           type: boolean
+
+      buck4:
+        type: object
+        $ref: "regulator.yaml#"
+        description: |
+          2.5A DC-DC step down converter
+
+        mps,buck-softstart:
+          description: |
+            defines the soft start time of this buck, must be one of the following
+            corresponding values 150us, 300us, 610us, 920us
+          $ref: "/schemas/types.yaml#/definitions/uint8"
+          enum: [ 0, 1, 2, 3 ]
+          default: 1
+
+        mps,buck-phase-delay:
+          description: |
+            defines the phase delay of this buck, must be one of the following
+            corresponding values 0deg, 90deg, 180deg, 270deg
+          $ref: "/schemas/types.yaml#/definitions/uint8"
+          enum: [ 0, 1, 2, 3 ]
+          default: 1
+
+        mps,buck-ovp-disable:
+          description: |
+            disables over voltage protection of this buck
+          type: boolean
+
+      ldortc:
+        $ref: "regulator.yaml#"
+        description: |
+          regulator with 0.65V-3.5875V for RTC, always enabled
+
+      ldo2:
+        $ref: "regulator.yaml#"
+        description: |
+          regulator with 0.65V-3.5875V
+
+      ldo3:
+        $ref: "regulator.yaml#"
+        description: |
+          regulator with 0.65V-3.5875V
+
+      ldo4:
+        $ref: "regulator.yaml#"
+        description: |
+          regulator with 0.65V-3.5875V
+
+      ldo5:
+        $ref: "regulator.yaml#"
+        description: |
+          regulator with 0.65V-3.5875V
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
+            mps,switch-freq = <1>;
+
+            buck1 {
+             regulator-name = "buck1";
+             regulator-min-microvolt = <400000>;
+             regulator-max-microvolt = <3587500>;
+             regulator-min-microamp  = <460000>;
+             regulator-max-microamp  = <7600000>;
+             regulator-boot-on;
+             mps,buck-ovp-disable;
+             mps,buck-phase-delay = <2>;
+             mps,buck-softstart = <1>;
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
2.17.1

