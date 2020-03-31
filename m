Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 578BD19A1C5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 00:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731400AbgCaWT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 18:19:28 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:35759 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbgCaWT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 18:19:27 -0400
Received: by mail-wm1-f50.google.com with SMTP id i19so4914105wmb.0;
        Tue, 31 Mar 2020 15:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ds23RDty3T9KSp1T//1bKmXLBRBBOLQ6ILYzvtVdGuk=;
        b=JnZSrG5F5VxVOID/GcMMqbbDsp0b1MhMuDcg5NweOEJFWsDJEBAatOfpp7QcuBMkjr
         x3I+ruB8JVxsqAKYTmDEOmV4qPvrm6rr77Kl5JaCQLoKyXdaROYLfb2N/l6oxv6nk4zd
         ec1XSjWVdRPdjjnE6XVkGoQ9bQJ1rw6VU3SPb6Yy0zUN9QMQoqUfrL6lJw8LeY4cfWhD
         inop3C721f1KZ+yp1q0gLjTHTCD/ScjusEZgqztj+HyCQA3AYmtva4wSqgNcrGDfXGg1
         H6K/Qfy/TE9cSfIUDOdB3yEbU7YPUH8A/kPRF+3plMMz2mdakdsb5KZLluejGnu0MPh9
         WB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ds23RDty3T9KSp1T//1bKmXLBRBBOLQ6ILYzvtVdGuk=;
        b=s7SdT4C1wUD9pdqEkva1bN5vAAPkRw90Ym0KcriNnBfzQJnlF36utHjqkHKk0s+clx
         F8cJndIQXtnJvI6fQSLkBvW34okNhVDyueNs4wyiwt3IIyJcK8vUsvWQjlNKQgmb/0Oq
         ncNKhQ0+u7g5/ty60S/ZJRU6K6OCOmsOErsRYqW10nrPGr1gtC7hRRYxR/qxi0J2CSb0
         HoSpZp5Wg3BTZ8fWvUUtvjxasUhT5mQcEQ261NV0ZhVZCGRH7f9wLnyC6X3w+TeJmFC6
         lYvhFHyfuEly+ewjWjIHZx2gX5nPlnQab0frUQ4ry7aw1+rQV146xf1+ILJvtvVCsrz8
         OxLA==
X-Gm-Message-State: AGi0PuZ3w2d+chyEDoG1aSjclN/d6gVjUQQ74HrRjsZCPUhlWsNtu/aw
        /HPoaFvqgZSdY1r82mHmnWc6h9BC
X-Google-Smtp-Source: APiQypLvIXhyM0GM+aXQrH9bKvr4KR84LDMhfMuhXKfnfD9y6yp26GsBKEAZJB9HbSc5XtUZe4axbw==
X-Received: by 2002:a1c:2404:: with SMTP id k4mr960116wmk.87.1585693165024;
        Tue, 31 Mar 2020 15:19:25 -0700 (PDT)
Received: from localhost (p200300E41F4A9B0076D02BFFFE273F51.dip0.t-ipconnect.de. [2003:e4:1f4a:9b00:76d0:2bff:fe27:3f51])
        by smtp.gmail.com with ESMTPSA id i8sm190833wrb.41.2020.03.31.15.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 15:19:23 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] dt-bindings: timer: Add bindings for NVIDIA Tegra186 timers
Date:   Wed,  1 Apr 2020 00:19:08 +0200
Message-Id: <20200331221914.2966407-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200331221914.2966407-1-thierry.reding@gmail.com>
References: <20200331221914.2966407-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The NVIDIA Tegra186 SoC contains an IP block that provides a register
interface for ten timers with a 29-bit counter that can generate one-
shot, periodic or watchdog interrupts.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- add required properties section
- add additionalProperties: false
- do not show status in example

 .../bindings/timer/nvidia,tegra186-timer.yaml | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra186-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/nvidia,tegra186-timer.yaml b/Documentation/devicetree/bindings/timer/nvidia,tegra186-timer.yaml
new file mode 100644
index 000000000000..d722cd267bf9
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/nvidia,tegra186-timer.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/nvidia,tegra186-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra186 timers
+
+maintainers:
+  - Thierry Reding <thierry.reding@gmail.com>
+  - Jonathan Hunter <jonathanh@nvidia.com>
+
+description: |
+  The Tegra186 timer provides ten 29-bit timer counters and one 32-bit TSC
+  (timestamp counter). The timers run at either a fixed 1 MHz clock rate
+  derived from the oscillator clock. Each timer can be programmed to raise
+  one-shot, periodic, or watchdog interrupts.
+
+properties:
+  compatible:
+    oneOf:
+      - description: NVIDIA Tegra186
+        items:
+          - const: nvidia,tegra186-timer
+
+      - description: NVIDIA Tegra194
+        items:
+          - const: nvidia,tegra194-timer
+          - const: nvidia,tegra186-timer
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 10
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    timer@3010000 {
+        compatible = "nvidia,tegra186-timer";
+        reg = <0x03010000 0x000e0000>;
+        interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+    };
-- 
2.24.1

