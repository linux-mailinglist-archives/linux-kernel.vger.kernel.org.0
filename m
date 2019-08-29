Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D42B0A1D80
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 16:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfH2OpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 10:45:06 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34237 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbfH2OpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:45:04 -0400
Received: by mail-wm1-f65.google.com with SMTP id y135so2242698wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 07:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OsA55jIDaNgAH1vvyh0xdmywvQzO6o3al1haxSh/eEQ=;
        b=lj2nkTEUwlAQr++xsHh4QmO1G++imUGRPr8Z/Xp168dQ+Y81aJ0yHYLia18C2Dd4sr
         qTpvlGvuyO9GKE4/chLCzYDgDbiRxfIWMAlpSSKlf5UFwf6+RkiK2Gt1b3dzKL7CLAsK
         P4kOQ6Uy0Kx+4VS522Q4CAw8xoCnvqLIj8khrICmHCuXmtcr+oM7+UpTzWRnklCPz+ll
         niAAKs2X9ubeUmNVv3wxbM74AVhIxHZqkk2KJJcoSInKnx9bnrCZD7VHaC9f0jhWV72F
         /FuEP22zatZtVQYxOx9QzraMzHQbqBGKT8rb9/BbCZVVJkRx2wfWjolfQfYT/09ex6+a
         nvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OsA55jIDaNgAH1vvyh0xdmywvQzO6o3al1haxSh/eEQ=;
        b=InSl2LJAus47oMYb2Pig5+k/oY1uap+Ox4lNYNAejzoM+zsBMFTngqhjsiT/lYLD8/
         ebm2FshYFk2O5WSfTVKSTwo0d0rsrF0tBpb76ZUAPdefFgCsXzIyC8/Pqd3Zcfm+4wYK
         OfwZUjD0TVjPWIb4EtF8B99BfQgG4T6ogmTb7Fd/mx/c9+mPqIFeOB5pAn82EIP2Vp/P
         M+TKoZPK826nEzrtcCu3x8Kfi/OZvMG830BQjjwr1bNzTmLY/lmRZkdEWl4jFa1cfYGo
         Oto5YxHzFtBqWzakL2p29SMCLJIFvOnCoI73kPvxIa30t2siERePfetKHybv41sSxp8Q
         XXMQ==
X-Gm-Message-State: APjAAAVgM3gT0mNP3lYmyvYCZcDugopJ7ZwLb3amWsYdaoHujpEMmBzI
        Bd5ygj4ThTzsYFAQO5FGwDjNfg==
X-Google-Smtp-Source: APXvYqyYqpYs64DzlBCGY3T1d6Ds7TkrQjopqVx9DZ36xCeOR+R7yJn6ENhx+NAGqMVgfNrmXNZ0Rg==
X-Received: by 2002:a7b:ce95:: with SMTP id q21mr11872242wmj.31.1567089902842;
        Thu, 29 Aug 2019 07:45:02 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id p7sm3923492wmh.38.2019.08.29.07.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 07:45:02 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, robh+dt@kernel.org, vkoul@kernel.org
Cc:     spapothi@codeaurora.org, bgoswami@codeaurora.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v5 3/4] dt-bindings: ASoC: Add WSA881x bindings
Date:   Thu, 29 Aug 2019 15:44:41 +0100
Message-Id: <20190829144442.6210-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190829144442.6210-1-srinivas.kandagatla@linaro.org>
References: <20190829144442.6210-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds bindings for WSA8810/WSA8815 Class-D Smart Speaker
Amplifier. This Amplifier also has a simple thermal sensor for
over temperature and speaker protection.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/sound/qcom,wsa881x.yaml          | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml b/Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml
new file mode 100644
index 000000000000..7a486c024732
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/qcom,wsa881x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bindings for Qualcomm WSA8810/WSA8815 Class-D Smart Speaker Amplifier
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description: |
+  WSA8810 is a class-D smart speaker amplifier and WSA8815
+  is a high-output power class-D smart speaker amplifier.
+  Their primary operating mode uses a SoundWire digital audio
+  interface. This binding is for SoundWire interface.
+
+properties:
+  compatible:
+    const: "sdw10217201000"
+
+  reg:
+    maxItems: 1
+
+  powerdown-gpios:
+    description: GPIO spec for Powerdown/Shutdown line to use
+    maxItems: 1
+
+  '#thermal-sensor-cells':
+    const: 0
+
+examples:
+  - |
+    speaker@0,1 {
+        compatible = "sdw10217201000";
+        reg = <0 1>;
+        powerdown-gpios = <&wcdpinctrl 2 0>;
+        #thermal-sensor-cells = <0>;
+    };
+
+...
-- 
2.21.0

