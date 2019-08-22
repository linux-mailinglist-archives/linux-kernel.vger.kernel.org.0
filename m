Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5BC9A3ED
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 01:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfHVXiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 19:38:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37589 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfHVXiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 19:38:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id z11so6948917wrt.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 16:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v9d/d2yrBEqMxyVUvtC9u6negI/GjvLEoHxmexWbzCs=;
        b=iY8KkGny6S220CBXX2T7jx7aefiA/Vv9UW3QwrB0vE6NsZzkssDjbQ/bqISsNMr80C
         snZNROcyoPxTJANixCShBxYCPwef2G1XRNNnRwPt8FPSQ41rPrMwgvRmDASB4zORtAqS
         155MxZU4FDxfhEGlHROWjCInOdhNnTflCdjMCad8pLYGlL8BwJi0tqMo41esglBi5nq9
         yULUr3pC02vNc+AvLIBxF9pEpinv+p6LyRSfr0Ur1JgCbnVw5GMa+JdDTIolnEmog9f/
         z62M3Zu8A9AVIhyYo5xGPz94gKkhGTVQHyShMCSKbpGZxJ1UwbVMFXabe4ulvStXytel
         IR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v9d/d2yrBEqMxyVUvtC9u6negI/GjvLEoHxmexWbzCs=;
        b=s+umzxRIvkbq5aLfbjIDzHHhGinjbzcVdjFKW3Pnm5OEkdqFuyhx0pnjR7HTiEDO4M
         WHJS9/fbR8me0kes++1nLdJHqhwuNNryZWzJATq5lLlKiOIo8Dt6A6517FfH/JwR/5z+
         3p0RX5Vy/+0A5SCJeAs7Kp97KQ2mW3ccYbc8FvIMfZywpefN1Z6bQRHUIqfQBEZ5pt/F
         gcdaneHHWAgJ1v4CUOHtYGs1k36eeEXGhuXTlOCfGKswaillIDncvxewwgmmLCqtPzxy
         UqxByZG/wy8gRxAmSJcmcQBMEpzgRWjjnrYK5AcXwjjHMMZHPnch5SeW8skDobEkjJ+u
         31Bw==
X-Gm-Message-State: APjAAAXKtdzQb8gGdjg5RCY27k9dou3tPNkWFdjT2FdGr+8JU+LUiVGq
        qWHAhmhvHTgrppP6U2t99vVuKQ==
X-Google-Smtp-Source: APXvYqwMxr4euoSdw6tZMAdlKkFkMJJqaYyCS3rH1/SXz/TqB1Qdw0hIvcFUY+AWWGrgVadPjNubyg==
X-Received: by 2002:adf:d088:: with SMTP id y8mr1279072wrh.181.1566517101130;
        Thu, 22 Aug 2019 16:38:21 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id f134sm1705157wmg.20.2019.08.22.16.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 16:38:20 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, robh+dt@kernel.org, vkoul@kernel.org
Cc:     spapothi@codeaurora.org, bgoswami@codeaurora.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH v4 1/4] dt-bindings: soundwire: add slave bindings
Date:   Fri, 23 Aug 2019 00:37:56 +0100
Message-Id: <20190822233759.12663-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822233759.12663-1-srinivas.kandagatla@linaro.org>
References: <20190822233759.12663-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds bindings for Soundwire Slave devices that includes how
SoundWire enumeration address and Link ID are used to represented in
SoundWire slave device tree nodes.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../soundwire/soundwire-controller.yaml       | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml

diff --git a/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml b/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml
new file mode 100644
index 000000000000..91aa6c6d6266
--- /dev/null
+++ b/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soundwire/soundwire-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SoundWire Controller Generic Binding
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description: |
+  SoundWire busses can be described with a node for the SoundWire controller
+  device and a set of child nodes for each SoundWire slave on the bus.
+
+properties:
+  $nodename:
+    pattern: "^soundwire(@.*|-[0-9a-f])*$"
+
+  "#address-cells":
+    const: 2
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^.*@[0-9a-f]+$":
+    type: object
+
+    properties:
+      compatible:
+      pattern: "^sdw[0-9][0-9a-f]{4}[0-9a-f]{4}[0-9a-f]{2}$"
+      description:
+	  Is the textual representation of SoundWire Enumeration
+	  address. compatible string should contain SoundWire Version ID,
+	  Manufacturer ID, Part ID and Class ID in order and shall be in
+	  lower-case hexadecimal with leading zeroes.
+	  Valid sizes of these fields are
+	  Version ID is 1 nibble, number '0x1' represents SoundWire 1.0
+	  and '0x2' represents SoundWire 1.1 and so on.
+	  MFD is 4 nibbles
+	  PID is 4 nibbles
+	  CID is 2 nibbles
+	  More Information on detail of encoding of these fields can be
+	  found in MIPI Alliance DisCo & SoundWire 1.0 Specifications.
+
+      reg:
+        maxItems: 1
+        description:
+          Instance ID and Link ID of SoundWire Device Address.
+
+    required:
+      - compatible
+      - reg
+
+examples:
+  - |
+    soundwire@c2d0000 {
+        #address-cells = <2>;
+        #size-cells = <0>;
+        compatible = "qcom,soundwire-v1.5.0";
+        reg = <0x0c2d0000 0x2000>;
+
+        speaker@1 {
+            compatible = "sdw10217201000";
+            reg = <1 0>;
+        };
+
+        speaker@2 {
+            compatible = "sdw10217201000";
+            reg = <2 0>;
+        };
+    };
+
+...
-- 
2.21.0

