Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54FD0122B1E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 13:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbfLQMRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 07:17:17 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51791 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727926AbfLQMRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:17:11 -0500
Received: by mail-wm1-f66.google.com with SMTP id d73so2722378wmd.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 04:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bP6qV0Ge4OMghuS4pDxfRI185IDu6wuYLbRLvgY6Moc=;
        b=tX7eVcCe82xuhNC4PtRdC4o19ggzlkpXXKC3ofHdPnMGoIBdtJ+n9h63ySJTmqXnfX
         XcmWluL3sri/Ms32jGrFx3Hhlqwc/BblRQbRgxlHZtxx+jMd58YB+/Nq7GKl99YaXLi9
         xof6rXshHUY34q8W9fYqqHVRUuJfD2mkcs6XshUdzC3lYXhSArJEHUDhht9Ly3Wja5IJ
         hK5Ioh1AoZiPz7q1f+dwc1Mq/aZNn+TTrfW/SoYMcR6vnLvHjAesK5r8xG1SJ82V/Ur9
         223ZaJK29Xg1SvhHeHjgC4hyzjJcr5yNigxGHDIgKaXrxMPBIWvsoOoGppDTKebbwV3E
         SsUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bP6qV0Ge4OMghuS4pDxfRI185IDu6wuYLbRLvgY6Moc=;
        b=V4uOYlr1JsGPPLwinvLKMc06ozRxeF7moKFAJGtPF2Ps/Jv7Az3NC0mTDvHlFR4pWY
         SiIwQ8JfEJef1zJbp1gfTmUnSav+K+66O2LE94ff16P1m+S5qsL0zBZOf3IbphumkLgT
         qCByyTbkARiMls07bFeXRjiSH89t1LKFjuYMiqs0galHolhVR6AT0RjlXRJgGL4n39oZ
         nIfdzdsQJbcP1ICsY42vtOUMLfD8zonoOXNDK0dUKg3hWxqO3D4yNFCdNCrhPfYoRpAa
         X0bxMPXpBNSTj6+N/Z41P/c21WmYBT1IGSh1XdWqDWDLv5LQFlruc1eV7E1AE3FLhbjJ
         afgg==
X-Gm-Message-State: APjAAAXZbFjK33lZvK5oqL9NBPn/8oPy4jHNu9LKwSDvh/49A13Vsc85
        ybpynzK3kq5Hq8rmVOopAUU2Tg==
X-Google-Smtp-Source: APXvYqyhNFRYqA8YEwQyb3kfdFZYXIoOjrycvy9xsHJmwlK1lktGn3t816k2UYMqif/8XJ0kUp+qMQ==
X-Received: by 2002:a05:600c:141:: with SMTP id w1mr5056232wmm.61.1576585030660;
        Tue, 17 Dec 2019 04:17:10 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id f1sm25087270wru.6.2019.12.17.04.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 04:17:10 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh@kernel.org, broonie@kernel.org, lee.jones@linaro.org,
        linus.walleij@linaro.org
Cc:     vinod.koul@linaro.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        spapothi@codeaurora.org, bgoswami@codeaurora.org,
        linux-gpio@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v5 08/11] dt-bindings: gpio: wcd934x: Add bindings for gpio
Date:   Tue, 17 Dec 2019 12:16:39 +0000
Message-Id: <20191217121642.28534-9-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191217121642.28534-1-srinivas.kandagatla@linaro.org>
References: <20191217121642.28534-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm Technologies Inc WCD9340/WCD9341 Audio Codec has integrated
gpio controller to control 5 gpios on the chip. This patch adds
required device tree bindings for it.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/gpio/qcom,wcd934x-gpio.yaml      | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/qcom,wcd934x-gpio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/qcom,wcd934x-gpio.yaml b/Documentation/devicetree/bindings/gpio/qcom,wcd934x-gpio.yaml
new file mode 100644
index 000000000000..32a566ec3558
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/qcom,wcd934x-gpio.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/qcom,wcd934x-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: WCD9340/WCD9341 GPIO controller
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description: |
+  Qualcomm Technologies Inc WCD9340/WCD9341 Audio Codec has integrated
+  gpio controller to control 5 gpios on the chip.
+
+properties:
+  compatible:
+    enum:
+      - qcom,wcd9340-gpio
+      - qcom,wcd9341-gpio
+
+  reg:
+    maxItems: 1
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - gpio-controller
+  - "#gpio-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    wcdgpio: gpio@42 {
+        compatible = "qcom,wcd9340-gpio";
+        reg = <0x042 0x2>;
+        gpio-controller;
+        #gpio-cells = <2>;
+    };
+
+...
-- 
2.21.0

