Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 247D3E52D3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 19:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731046AbfJYR72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 13:59:28 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42780 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730926AbfJYR72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 13:59:28 -0400
Received: by mail-pg1-f195.google.com with SMTP id f14so2005575pgi.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 10:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6V9eAy/RohgQEVA68KP/vsczzh/tYT69NUQZuToo9f4=;
        b=SedUa1wgJBBopKAyjCiRP6GFJU9zVsE4B+95tJXT23XiXtgvX/WaMtIX/1onoiJWZa
         P1j/KQdRDHVpjOwxdcTACHjq2PdAQqSSh8r7nB6okCHryac3/NKO6BplNpHNku9P5Ui7
         E44aHFSIuR4xcbMAJKGdPZIr75QtQsWLJW0zqgYztIB1HW+vAEUVKzGJjjrfBcM7C7v4
         dUtIDVpREH1ApvCNwYzSiUrVWi1SNhyCfpSW6FNo8oed5b+3tW94VtYabW6QfGX+V2jl
         T6ZUkfgkuKbswpQfP2u7es9qmyaeBAZX65vPkObBQc/tTf5OWv65c0v23cUlKv4QfoWJ
         3sSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6V9eAy/RohgQEVA68KP/vsczzh/tYT69NUQZuToo9f4=;
        b=V6aSRZPeFwNLUCETLCObQmUBaua+W16EH7/Enip97Ne8je3xfa8h6AQ6UZxrZnhh7D
         9XJeEGmwrZqpGtMXC8u1tPi9IQ1x2y9adQtYna+GAyEPHppbCFNakO/WPBPZ7ericBuT
         IY6Yxhq3ozmVKLv56L3o2b0LM5VlK01LivCY+save8Sz2epDG7Vm+w2dF7yMivvkNLtB
         ahyczG7o8tk792byrIzsvzuTRKoVy3cmgzKZG5X0rIt1sDB8QiWyBebeI0C8k4OpV7af
         rhoEOhp2+0YYqVSwv5Utb28Zflflex49hm8Gc5pJsdFm1amaxXZTJ6qmWc4ujjkbpnRT
         J80g==
X-Gm-Message-State: APjAAAUbanQ0KR9Euo4QovCltsJq8TMCewIaW2AjelX0c1f9Dk72fFc5
        SGN4jQTke9EtlJPj1pnZcghf
X-Google-Smtp-Source: APXvYqz3piyw+cOfNWbtwHTeWyr2/cMXnuAPV9qLBZz+W+Tcdvl44tJdS08iO34Vyrxy3OC08OiSCg==
X-Received: by 2002:a63:1f52:: with SMTP id q18mr6010328pgm.35.1572026367191;
        Fri, 25 Oct 2019 10:59:27 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7108:7f86:4131:5b00:9fc5:5eaa])
        by smtp.gmail.com with ESMTPSA id r13sm3430303pfg.3.2019.10.25.10.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 10:59:26 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mchehab@kernel.org, robh+dt@kernel.org, sakari.ailus@iki.fi
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        c.barrett@framos.com, a.brela@framos.com, peter.griffin@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 1/2] dt-bindings: media: i2c: Add IMX296 CMOS sensor binding
Date:   Fri, 25 Oct 2019 23:29:07 +0530
Message-Id: <20191025175908.14260-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191025175908.14260-1-manivannan.sadhasivam@linaro.org>
References: <20191025175908.14260-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML devicetree binding for IMX296 CMOS image sensor.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/media/i2c/imx296.yaml | 98 +++++++++++++++++++
 1 file changed, 98 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/imx296.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/imx296.yaml b/Documentation/devicetree/bindings/media/i2c/imx296.yaml
new file mode 100644
index 000000000000..4e204fd7cf90
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/imx296.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/imx296.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sony IMX296 1/2.8-Inch CMOS Image Sensor
+
+maintainers:
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+description: |-
+  The Sony IMX296 is a 1/2.9-Inch active pixel type CMOS Solid-state image
+  sensor with square pixel array and 1.58 M effective pixels. This chip
+  features a global shutter with variable charge-integration time. It is
+  programmable through I2C and 4-wire interfaces. The sensor output is
+  available via CSI-2 serial data output (1 Lane).
+
+properties:
+  compatible:
+    const: sony,imx296
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    description:
+      Input clock for the sensor.
+    items:
+      - const: mclk
+
+  clock-frequency:
+    description:
+      Frequency of the mclk clock in Hertz.
+    default: 37125000
+
+  vddo-supply:
+    description:
+      Definition of the regulator used as interface power supply.
+    maxItems: 1
+
+  vdda-supply:
+    description:
+      Definition of the regulator used as analog power supply.
+    maxItems: 1
+
+  vddd-supply:
+    description:
+      Definition of the regulator used as digital power supply.
+    maxItems: 1
+
+  reset-gpios:
+    description:
+      The phandle and specifier for the GPIO that controls sensor reset.
+    maxItems: 1
+
+  # See ../video-interfaces.txt for details
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - clock-frequency
+  - vddo-supply
+  - vdda-supply
+  - vddd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    imx296: camera-sensor@1a {
+        compatible = "sony,imx296";
+        reg = <0x1a>;
+        reset-gpios = <&msmgpio 35 GPIO_ACTIVE_LOW>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&camera_rear_default>;
+        clocks = <&gcc 90>;
+        clock-names = "mclk";
+        clock-frequency = <37125000>;
+        vddo-supply = <&camera_vddo_1v8>;
+        vdda-supply = <&camera_vdda_3v3>;
+        vddd-supply = <&camera_vddd_1v2>;
+
+        port {
+            imx296_ep: endpoint {
+                remote-endpoint = <&csiphy0_ep>;
+            };
+        };
+    };
+
+...
-- 
2.17.1

