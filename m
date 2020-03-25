Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C09219212C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 07:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgCYGfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 02:35:08 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34263 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgCYGfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 02:35:07 -0400
Received: by mail-pg1-f194.google.com with SMTP id d37so170046pgl.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 23:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=siPGNDe+AxSm5pKa/Er1n8oaxWLKO8D7N1OvXW7uO3Y=;
        b=ti42rp27v40CkiayUlokdDmBdSqvmyT2qfiSyfhGv4MdnJXxjQuSV1o5bNlrjvbK5N
         YxAGlcWm2ZnCzGiVmLqBbM++fTanIs1+jQQQPD6p4EgVL/RocrWKeWqNyFI4TW7k8z8L
         dSJrJ3j25FPhQZtIU6+Zhf7l02SG0IHDE4B+oaamj1ZXveCxgrk9nKAnckGiWA5H3wms
         gjjGLtMztVC5W4HuxjYGegw00mREWMavEkOcDzdZwXd++1Pn+hJww3w0ffPYD3ABS+zL
         eEf7gld8nKhNlwH97u5IcTk9MxM6dR6wBvCFRFWlXReyzS8Qxot5WE5/7StUa8yDPwoi
         Rgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=siPGNDe+AxSm5pKa/Er1n8oaxWLKO8D7N1OvXW7uO3Y=;
        b=OBuAHMO9jHMsPn5nF+VsYauj0nhlQqgL35ZbGLkfaklC7ycnfR47OIAaAV1zOLtmuK
         ZsgFIu4TEo9KTXbQ8MuaHgP9NAgxFtjM6Xm7/e+uL48zMOvNUzy5QyUMfbmjSM/84DhI
         +1iIhuOPp1V/6KLYDrq4mxjtGfQhqW12UJBKfHiJoqkdeKen6k7++5WpD7kSoPvixUgc
         0OzX/wNUIL0mZnYuUdG0VZVhjEIpjQTzb3BMxJ+oA4JoNMrkl9YaEqF5THwKJuy5SUme
         jL3ZnuwyLFAyGDItUmXnYGj9DRMq73x566stTj/XZTgNkFD6qwmPkwqVMIJ2TsgjHjAl
         eItA==
X-Gm-Message-State: ANhLgQ2AmfzHSEKUU44s3bQpFjCjIzrcqbGRuVJHyy2SVvwjU20u12fP
        mZxdRopzVfBC0bdHFKOfwa0fNIbG4sM=
X-Google-Smtp-Source: ADFU+vuSlF1tCz/0gmNbN3lD4lor8uE7Ghbaw8r1wnCZY9m1lBu2LVeaoo33nM5iHrT/K9MmyeZGiA==
X-Received: by 2002:a62:648f:: with SMTP id y137mr1832185pfb.199.1585118104267;
        Tue, 24 Mar 2020 23:35:04 -0700 (PDT)
Received: from localhost ([103.195.202.71])
        by smtp.gmail.com with ESMTPSA id 8sm17839049pfv.65.2020.03.24.23.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 23:35:03 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, mka@chromium.org, daniel.lezcano@linaro.org,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: thermal: Add yaml bindings for thermal sensors
Date:   Wed, 25 Mar 2020 12:04:52 +0530
Message-Id: <93466e6c031c0084de09bd6b448556a6c5080880.1585117436.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1585117436.git.amit.kucheria@linaro.org>
References: <cover.1585117436.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of moving the thermal bindings to YAML, split it up into 3
bindings: thermal sensors, cooling devices and thermal zones.

The property #thermal-sensor-cells is required in each device that acts
as a thermal sensor. It is used to uniquely identify the instance of the
thermal sensor inside the system.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 .../bindings/thermal/thermal-sensor.yaml      | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/thermal-sensor.yaml

diff --git a/Documentation/devicetree/bindings/thermal/thermal-sensor.yaml b/Documentation/devicetree/bindings/thermal/thermal-sensor.yaml
new file mode 100644
index 000000000000..920ee7667591
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/thermal-sensor.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0)
+# Copyright 2020 Linaro Ltd.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/thermal-sensor.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Thermal sensor binding
+
+maintainers:
+  - Amit Kucheria <amitk@kernel.org>
+
+description: |
+  Thermal management is achieved in devicetree by describing the sensor hardware
+  and the software abstraction of thermal zones required to take appropriate
+  action to mitigate thermal overloads.
+
+  The following node types are used to completely describe a thermal management
+  system in devicetree:
+   - thermal-sensor: device that measures temperature, has SoC-specific bindings
+   - cooling-device: device used to dissipate heat either passively or artively
+   - thermal-zones: a container of the following node types used to describe all
+     thermal data for the platform
+
+  This binding describes the thermal-sensor.
+
+  Thermal sensor devices provide temperature sensing capabilities on thermal
+  zones. Typical devices are I2C ADC converters and bandgaps. Thermal sensor
+  devices may control one or more internal sensors.
+
+properties:
+  "#thermal-sensor-cells":
+    description:
+      Used to uniquely identify a thermal sensor instance within an IC. Will be
+      0 on sensor nodes with only a single sensor and at least 1 on nodes
+      containing several internal sensors.
+    enum: [0, 1]
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    // Example 1: SDM845 TSENS
+    soc: soc@0 {
+            #address-cells = <2>;
+            #size-cells = <2>;
+
+            /* ... */
+
+            tsens0: thermal-sensor@c263000 {
+                    compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
+                    reg = <0 0x0c263000 0 0x1ff>, /* TM */
+                          <0 0x0c222000 0 0x1ff>; /* SROT */
+                    #qcom,sensors = <13>;
+                    interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>,
+                                 <GIC_SPI 508 IRQ_TYPE_LEVEL_HIGH>;
+                    interrupt-names = "uplow", "critical";
+                    #thermal-sensor-cells = <1>;
+            };
+
+            tsens1: thermal-sensor@c265000 {
+                    compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
+                    reg = <0 0x0c265000 0 0x1ff>, /* TM */
+                          <0 0x0c223000 0 0x1ff>; /* SROT */
+                    #qcom,sensors = <8>;
+                    interrupts = <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH>,
+                                 <GIC_SPI 509 IRQ_TYPE_LEVEL_HIGH>;
+                    interrupt-names = "uplow", "critical";
+                    #thermal-sensor-cells = <1>;
+            };
+    };
+...
-- 
2.20.1

