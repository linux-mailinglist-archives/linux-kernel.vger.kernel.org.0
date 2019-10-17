Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD77EDA4E6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 07:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393998AbfJQFGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Oct 2019 01:06:47 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35755 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfJQFGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 01:06:46 -0400
Received: by mail-wm1-f68.google.com with SMTP id y21so1014199wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 22:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BRTzBJT9wxY9zvUPoqtSUKkjTVA4C3pipCSGcwAFYZI=;
        b=SzsvBZ9CUknwuf0SrY/UVQaaoWaC3X+K9qksX1wDIslB/aeKcIhwdN4u0TcOP8qBnI
         k3C8L2EmMO4mhrQtKYSTlXbAxPQyfRwB7kjRsjosJPvTTReyFyBxZQ4wHgXisxSTrny+
         6yLX8u9tSLEUgw/JjgNHrf1ohD1231Xlx0YkPv3H9GCdOkDF67wZsn9Qye+XNh6dZHJb
         s0awQeI8vXn04ruUyUegspbhOZrtQ9uE6GZV5eABpAcSjLjQ24oM6VQkyAXuBwE3205b
         SdgMYJEGFmyqYczWhhjo7I+enFpBnjxCB7UeUwWpxFIznXil0p0TOqbrHKSduFaqcXTX
         AYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BRTzBJT9wxY9zvUPoqtSUKkjTVA4C3pipCSGcwAFYZI=;
        b=giyVLets4/Xz5bo7ltGFvWQLDJtWm0BLGcgoC6XlpY0imeW2qb2OX+ylA6X+45K8Y7
         b5qURBXferAzmYwIrzOxjryVBzMFBrpIrlI4ztPGw28N3MgsNUckedkmdlZuEB3J8vpj
         NV++WpZufQxcHDIm//RosdrAbcip3JdGVJUpnR82DEZI8O3tF1qHLuTLWgE1RmrC3nwC
         0hZtwx99Oynw5sN3AdDMuZdVAZfBKJyhceoA5GHHvWfH6asKJlmBxKvrAczOKE7gwS4a
         Xra5CN2333S46WJBE6yOUEl/qKcKDmh5Z9VYlvBxJKGWfQ4AZx8oWaLpKpC6jn9P7GP8
         WRSg==
X-Gm-Message-State: APjAAAUAxFC3P7HIGXNhuO99Dr4BOf2WivYP9DfV3VhSnkRCffKsctoU
        HwBSsfHA8ZjWFHpjRleSTPAHZw==
X-Google-Smtp-Source: APXvYqx3W0fpmROG2eEQxff4VIENymtQ5SsisOWb5YimJDjwRgmDQr0BvAZ7nF2dqssq4ZCHhe3oBw==
X-Received: by 2002:a1c:a651:: with SMTP id p78mr1061869wme.53.1571288803395;
        Wed, 16 Oct 2019 22:06:43 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id b5sm1010762wmj.18.2019.10.16.22.06.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Oct 2019 22:06:42 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        khilman@baylibre.com, mark.rutland@arm.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 1/4] dt-bindings: crypto: Add DT bindings documentation for amlogic-crypto
Date:   Thu, 17 Oct 2019 05:06:23 +0000
Message-Id: <1571288786-34601-2-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571288786-34601-1-git-send-email-clabbe@baylibre.com>
References: <1571288786-34601-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds documentation for Device-Tree bindings for the
Amlogic GXL cryptographic offloader driver.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../bindings/crypto/amlogic,gxl-crypto.yaml   | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml

diff --git a/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml b/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml
new file mode 100644
index 000000000000..5becc60a0e28
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/crypto/amlogic,gxl-crypto.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic GXL Cryptographic Offloader
+
+maintainers:
+  - Corentin Labbe <clabbe@baylibre.com>
+
+properties:
+  compatible:
+    items:
+    - const: amlogic,gxl-crypto
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: "Interrupt for flow 0"
+      - description: "Interrupt for flow 1"
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
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/gxbb-clkc.h>
+
+    crypto: crypto-engine@c883e000 {
+        compatible = "amlogic,gxl-crypto";
+        reg = <0x0 0xc883e000 0x0 0x36>;
+        interrupts = <GIC_SPI 188 IRQ_TYPE_EDGE_RISING>, <GIC_SPI 189 IRQ_TYPE_EDGE_RISING>;
+        clocks = <&clkc CLKID_BLKMV>;
+        clock-names = "blkmv";
+    };
-- 
2.21.0

