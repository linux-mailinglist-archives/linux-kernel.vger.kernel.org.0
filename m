Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF897582B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 21:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfGYTnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 15:43:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45659 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfGYTnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 15:43:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id f9so51944879wre.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 12:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=71zYLXTlisczUvOPC0g8GNny5+TtCvKfT2pyo6fGJ9c=;
        b=py8c1rPUaxb6LfpTZULVE5wEow4Ig/y0vI4laAKs1jK5qDuf2LJkdKobWT+rg7RI7m
         wFUYFn/E+DZ2sQq6mKRDo1naRmF9pJp1AYYe56I8ZIgodq/kNB9sYjOhuoXLu6L99noU
         hhAWFcc/bYt1E0IT9Pthq2bsOgk6Uo1SiCeVPtH3PhTYqKvkEVPIAF+4UJ+XjXNFb4oz
         stpVoUdeEuLMF/TLEjzWK9aYjKt4Hw6H4SAJbWPBpNybsXEc3NyEwjq2sZGwdVG+5RLk
         ia4Mkj9ZTsUju+cKbPNSiBaWdlmz/E+GZkjEGsPdT+XnLEII7hsOIJSxgi0stAOm3hvD
         XI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=71zYLXTlisczUvOPC0g8GNny5+TtCvKfT2pyo6fGJ9c=;
        b=ffZX18hGmiozqfeRln8+BylHKDcR2LHyCPvECKgZ8+GB0HopKHl3qbOtrZXlv54yWF
         YwRTbEfoFen3/7FtGqYoObV3DFNh8lLLt0xLz3gJSWqgSG19xIElasyHboFsZODaDBgM
         Lo9cppodV5gm5oy9oypMjhTn2bdxzYxTRKzuVUPPawIbgapWscPw9iDDhQTBAmCDqc0y
         4vXSsdq6b/Y9DlpEpDmwTiXga8C64mlWNUZQ8rproUqY0aXMkeqBiuhooFwLkblOYBIO
         1QZXjEPCR2/W7RgXcN/MIsWDvPBa4PfcMY/iAsJo9NylHkGdmXoEEwcaEqvu4yIHJjHo
         u7Yw==
X-Gm-Message-State: APjAAAXVj1D4Zf/vhUuuf7nl6SyKIKZ28jPq0Ai3J001UcPtJyBDaoDP
        Es0Ef0sG3hSdkaUOFhcyERL5Zw==
X-Google-Smtp-Source: APXvYqw72jesc7xJzzreRGaFI1bWXggNaMx7Vpt35ZvVydkI9rJHOxhJjt0/7QZNpnnjlbQp3BNJdw==
X-Received: by 2002:adf:f08f:: with SMTP id n15mr13801539wro.213.1564083787509;
        Thu, 25 Jul 2019 12:43:07 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id y16sm103410662wrg.85.2019.07.25.12.43.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jul 2019 12:43:06 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        khilman@baylibre.com, mark.rutland@arm.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, baylibre-upstreaming@groups.io,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 1/4] dt-bindings: crypto: Add DT bindings documentation for amlogic-crypto
Date:   Thu, 25 Jul 2019 19:42:53 +0000
Message-Id: <1564083776-20540-2-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564083776-20540-1-git-send-email-clabbe@baylibre.com>
References: <1564083776-20540-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds documentation for Device-Tree bindings for the
Amlogic GXL cryptographic offloader driver.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../bindings/crypto/amlogic-gxl-crypto.yaml   | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/amlogic-gxl-crypto.yaml

diff --git a/Documentation/devicetree/bindings/crypto/amlogic-gxl-crypto.yaml b/Documentation/devicetree/bindings/crypto/amlogic-gxl-crypto.yaml
new file mode 100644
index 000000000000..41265e57c00b
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/amlogic-gxl-crypto.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/crypto/amlogic-gxl-crypto.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic GXL Cryptographic Offloader
+
+maintainers:
+  - Corentin Labbe <clabbe@baylibre.com>
+
+properties:
+  compatible:
+    oneOf:
+      - const: amlogic,gxl-crypto
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: blkmv
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+examples:
+  - |
+    crypto: crypto@c883e000 {
+        compatible = "amlogic,gxl-crypto";
+        reg = <0x0 0xc883e000 0x0 0x36>;
+        interrupts = <GIC_SPI 188 IRQ_TYPE_EDGE_RISING>,
+            <GIC_SPI 189 IRQ_TYPE_EDGE_RISING>;
+        clocks = <&clkc CLKID_BLKMV>;
+        clock-names = "blkmv";
+    };
-- 
2.21.0

