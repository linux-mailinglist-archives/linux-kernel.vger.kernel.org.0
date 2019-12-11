Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E45D11A468
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 07:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbfLKGTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 01:19:54 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36942 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfLKGTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 01:19:54 -0500
Received: by mail-pg1-f195.google.com with SMTP id q127so10251050pga.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 22:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5SzZg/Any9b15PYJNx4TC/3Ha5cPQwIvnngJiL/O6D4=;
        b=F9nIloV3mkfv1BWp4npou4P6BtwgDkiffAbTsdiUkTmBcHM/KBFN58cVt+AMC4V8xS
         EAtttKKXOtsz9hji7eGv+2L61RmSt+L/GOvR0AmDuMjRiqHdL24NpwSqf5AKFEBLj9mL
         j/glY6I+kVN+ezQ23A2VtUe6jlGtYhFQjGA+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5SzZg/Any9b15PYJNx4TC/3Ha5cPQwIvnngJiL/O6D4=;
        b=mjhV3K9TdPgX2eWBEeSXkFrBuWwATrfqfkDpu1ZEGtpXPkZ5Hk6Vu+VglGkrQ8pnto
         KKG8qkxy+pRMQqFVrObidhxNWX6r8LdS/XuLfpEikXp5d2pUAONzfqyX5ByoLCzt52Cg
         TmsnswFt6IDv477fw8K8+FMDXf/4f/80FV2CgXSAei4kkIAnyXlxCMTftQFjmfABwAe7
         m0wKDKg+M2FWERO+oanVkLexLIsy3EWGcG1R/1m1gp2HA884e1fsawIB53i6YDor3qdg
         6ByQN0wxs2focdnc0li2e4yYQEkD19h4sGbFZw4HJ046Izi3Bv2UUo5kQ5zTbTgeuolL
         DfiA==
X-Gm-Message-State: APjAAAWcCpQ06gdeftVmJHx0Vuqpj8wf9T29MV3aWkGtVfg6mSBSs/65
        C93PMglVwrjObHrUu7eChjeuDw==
X-Google-Smtp-Source: APXvYqwq5ql9gkBVGJtQCkgVSEUeNJ/97XFaS3CTKAxAX61qj+67JfQL5hpgXLD4RlP2wt4YbE8eUQ==
X-Received: by 2002:a63:220b:: with SMTP id i11mr2311164pgi.50.1576045193287;
        Tue, 10 Dec 2019 22:19:53 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id h5sm1225579pfk.30.2019.12.10.22.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 22:19:52 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        p.zabel@pengutronix.de,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RESEND 3/4] dt-bindings: drm/bridge: Add GPIO display mux binding
Date:   Wed, 11 Dec 2019 14:19:10 +0800
Message-Id: <20191211061911.238393-4-hsinyi@chromium.org>
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
In-Reply-To: <20191211061911.238393-1-hsinyi@chromium.org>
References: <20191211061911.238393-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Boichat <drinkcat@chromium.org>

Add bindings for Generic GPIO mux driver.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
Change from RFC to v1:
- txt to yaml
---
 .../bindings/display/bridge/gpio-mux.yaml     | 89 +++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/gpio-mux.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/gpio-mux.yaml b/Documentation/devicetree/bindings/display/bridge/gpio-mux.yaml
new file mode 100644
index 000000000000..cef098749066
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/gpio-mux.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/gpio-mux.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic display mux (1 input, 2 outputs)
+
+maintainers:
+  - Nicolas Boichat <drinkcat@chromium.org>
+
+description: |
+  This bindings describes a simple display (e.g. HDMI) mux, that has 1
+  input, and 2 outputs. The mux status is controlled by hardware, and
+  its status is read back using a GPIO.
+
+properties:
+  compatible:
+    const: gpio-display-mux
+
+  detect-gpios:
+    maxItems: 1
+    description: GPIO that indicates the active output
+
+  ports:
+    type: object
+
+    properties:
+      port@0:
+        type: object
+        description: |
+          Video port for input.
+
+      port@1:
+        type: object
+        description: |
+          2 video ports for output.
+          The reg value in the endpoints matches the GPIO status: when
+          GPIO is asserted, endpoint with reg value <1> is selected.
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - detect-gpios
+  - ports
+
+examples:
+  - |
+    hdmi_mux: hdmi_mux {
+      compatible = "gpio-display-mux";
+      status = "okay";
+      detect-gpios = <&pio 36 GPIO_ACTIVE_HIGH>;
+      pinctrl-names = "default";
+      pinctrl-0 = <&hdmi_mux_pins>;
+      ddc-i2c-bus = <&hdmiddc0>;
+
+      ports {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        port@0 { /* input */
+          reg = <0>;
+
+          hdmi_mux_in: endpoint {
+            remote-endpoint = <&hdmi0_out>;
+          };
+        };
+
+        port@1 { /* output */
+          reg = <1>;
+
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          hdmi_mux_out_anx: endpoint@0 {
+            reg = <0>;
+            remote-endpoint = <&anx7688_in>;
+          };
+
+          hdmi_mux_out_hdmi: endpoint@1 {
+            reg = <1>;
+            remote-endpoint = <&hdmi_connector_in>;
+          };
+        };
+      };
+    };
-- 
2.24.0.525.g8f36a354ae-goog

