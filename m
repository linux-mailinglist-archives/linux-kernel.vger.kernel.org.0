Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06A49144A2A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 04:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbgAVDEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 22:04:11 -0500
Received: from mail-pg1-f169.google.com ([209.85.215.169]:39664 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729012AbgAVDEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 22:04:11 -0500
Received: by mail-pg1-f169.google.com with SMTP id 4so2655420pgd.6;
        Tue, 21 Jan 2020 19:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0SgiOt+hWDrUJ2H9rOs1JAEu1IZXM2ocd/78f9wvQ84=;
        b=koV50QBVgySF3KMuXhQQ8bnc58nCFKyNTB8MtrYnAnkRYio8FIb4MKQh1iygOsf0nB
         4bnoeHg7P9pKsKhxsMvDnWGrG23omrL1gdxZrC77/enZAFs6gbav5PTjJAnghtOZyFQi
         PWJCUDj402i2bDZPFq5wUHIEHtXk8EpXSsBSUw/8hwbGopZ1NqMIZp9DlBR69JfO6ceD
         h8WVraiBDyM6c5uc//+Q6MmSNeTYCdEWf+CFUWzPltGqUKqr4x+JCI+9Ma/MriTpHFZW
         W7YRtq02mAqRHZCAmn4QhaIstcyY0p1isn8P5Wj3PrvLB/bF2UzeX3g0PdLWTvrfo3ra
         dbRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0SgiOt+hWDrUJ2H9rOs1JAEu1IZXM2ocd/78f9wvQ84=;
        b=c97TM8diauLrm7hQ/XGwBL0UPImRpJGIpTdiYICMisGDS8VqELkWAxZG7YMzoOfzBG
         plWbqvHfHsNl9idkf9jL+vr1PVQhc/HqURZuWesqsS5Xz0LSePewxBIOj9iSvOlyXuz3
         FkSSKIOso4TBaNZpK/z0IrA7Sx95SWQMF3DX1ojWvYVKT0XxW2k5sF0YoqSu++tdqV66
         ViiTBatpLlFnzmfrB6G9f4Q2Cw9c6qTjP+Tjgkupq8O7tTXftI9L5tfBgL7mS+oGKivp
         UYMzV//rTvnLhQoPFpkFAOZ5M3q1im431MUkAbMrPH/Ycuajub3oiBjQK5uHbf++Ip/d
         kt9g==
X-Gm-Message-State: APjAAAVTK+IAXr4DhHlJ9WAbCckG6FjofCiXXJ4y3sIbzXA6ZZktd/tI
        nSBQNi1TYHFbx7Vodgr+L1o=
X-Google-Smtp-Source: APXvYqxF0WrvM/zRnaFp42yrhqYqywcqAB4hi/5/ov0YcbddGVknBeQa7auqxAbtMthg87SOwiel8g==
X-Received: by 2002:aa7:9aeb:: with SMTP id y11mr637332pfp.63.1579662250728;
        Tue, 21 Jan 2020 19:04:10 -0800 (PST)
Received: from localhost.localdomain (S0106d80d17472dbd.wp.shawcable.net. [24.79.253.190])
        by smtp.gmail.com with ESMTPSA id w123sm45129850pfb.167.2020.01.21.19.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 19:04:10 -0800 (PST)
From:   jassisinghbrar@gmail.com
To:     balbi@kernel.org, gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mark.rutland@arm.com, masami.hiramatsu@linaro.org
Cc:     devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: max3421-udc: add dt bindings for MAX3420 UDC
Date:   Tue, 21 Jan 2020 21:04:07 -0600
Message-Id: <20200122030407.7525-1-jassisinghbrar@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200122030136.7300-1-jassisinghbrar@gmail.com>
References: <20200122030136.7300-1-jassisinghbrar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jassi Brar <jaswinder.singh@linaro.org>

Add YAML dt bindings for Maxim MAX3420 UDC controller.

Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/usb/maxim,max3420-udc.yaml       | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/maxim,max3420-udc.yaml

diff --git a/Documentation/devicetree/bindings/usb/maxim,max3420-udc.yaml b/Documentation/devicetree/bindings/usb/maxim,max3420-udc.yaml
new file mode 100644
index 000000000000..4241d38d5864
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/maxim,max3420-udc.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/maxim,max3420-udc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MAXIM MAX3420/1 USB Peripheral Controller
+
+maintainers:
+  - Jassi Brar <jaswinder.singh@linaro.org>
+
+description: |
+  The controller provices USB2.0 compliant FullSpeed peripheral
+  implementation over the SPI interface.
+
+  Specifications about the part can be found at:
+    http://datasheets.maximintegrated.com/en/ds/MAX3420E.pdf
+
+properties:
+  compatible:
+    enum:
+      - maxim,max3420-udc
+      - maxim,max3421-udc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: usb irq from max3420
+      - description: vbus detection irq
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    items:
+      - const: udc
+      - const: vbus
+    minItems: 1
+    maxItems: 2
+
+  spi-max-frequency:
+    maximum: 26000000
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+
+additionalProperties: false
+
+examples:
+  - |
+      #include <dt-bindings/gpio/gpio.h>
+      #include <dt-bindings/interrupt-controller/irq.h>
+      spi0 {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            udc@0 {
+                  compatible = "maxim,max3420-udc";
+                  reg = <0>;
+                  interrupt-parent = <&gpio>;
+                  interrupts = <0 IRQ_TYPE_EDGE_FALLING>, <10 IRQ_TYPE_EDGE_BOTH>;
+                  interrupt-names = "udc", "vbus";
+                  spi-max-frequency = <12500000>;
+            };
+      };
-- 
2.20.1

