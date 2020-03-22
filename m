Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD21418E9CD
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Mar 2020 16:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgCVPnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Mar 2020 11:43:13 -0400
Received: from foss.arm.com ([217.140.110.172]:41070 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgCVPnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 11:43:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C1DBFEC;
        Sun, 22 Mar 2020 08:43:12 -0700 (PDT)
Received: from ssg-dev-vb.arm.com (unknown [10.57.20.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EFDDE3F52E;
        Sun, 22 Mar 2020 08:43:06 -0700 (PDT)
From:   Hadar Gat <hadar.gat@arm.com>
To:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Ofir Drang <ofir.drang@arm.com>, Hadar Gat <hadar.gat@arm.com>
Subject: [PATCH v5 1/3] dt-bindings: add device tree binding for Arm CryptoCell trng engine
Date:   Sun, 22 Mar 2020 17:31:23 +0200
Message-Id: <1584891085-8963-2-git-send-email-hadar.gat@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584891085-8963-1-git-send-email-hadar.gat@arm.com>
References: <1584891085-8963-1-git-send-email-hadar.gat@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Arm CryptoCell is a hardware security engine. This patch adds DT
bindings for its TRNG (True Random Number Generator) engine.

Signed-off-by: Hadar Gat <hadar.gat@arm.com>
---
 .../devicetree/bindings/rng/arm-cctrng.yaml        | 55 ++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rng/arm-cctrng.yaml

diff --git a/Documentation/devicetree/bindings/rng/arm-cctrng.yaml b/Documentation/devicetree/bindings/rng/arm-cctrng.yaml
new file mode 100644
index 0000000..7f70e4b
--- /dev/null
+++ b/Documentation/devicetree/bindings/rng/arm-cctrng.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rng/arm-cctrng.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Arm TrustZone CryptoCell TRNG engine
+
+maintainers:
+  - Hadar Gat <hadar.gat@arm.com>
+
+description: |+
+  Arm TrustZone CryptoCell TRNG (True Random Number Generator) engine.
+
+properties:
+  compatible:
+    enum:
+      - arm,cryptocell-713-trng
+      - arm,cryptocell-703-trng
+
+  interrupts:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+  arm,rosc-ratio:
+    description:
+      Arm TrustZone CryptoCell TRNG engine has 4 ring oscillators.
+      Sampling ratio values for these 4 ring oscillators. (from calibration)
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32-array
+      - items:
+          minItems: 4
+          maxItems: 4
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - interrupts
+  - reg
+  - arm,rosc-ratio
+
+additionalProperties: false
+
+examples:
+  - |
+    arm_cctrng: rng@60000000 {
+        compatible = "arm,cryptocell-713-trng";
+        interrupts = <0 29 4>;
+        reg = <0x60000000 0x10000>;
+        arm,rosc-ratio = <5000 1000 500 0>;
+    };
-- 
2.7.4

