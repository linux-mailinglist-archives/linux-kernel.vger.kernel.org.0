Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 829F9192F8F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 18:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgCYRnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 13:43:24 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:14582 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727887AbgCYRnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 13:43:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585158202; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=FxQstoFPP1Qfd1VW2GuV0A7jVekKn/42g76oHq7LPFw=; b=vE2wZ7X1N31ZV/NsT4ln9Sg9nbMDCBHfZ2Eh85b3tQ0X2lhcwP+f9M5c3lWh+mGPVOW4yadu
 1fGOWqjll6etlJ46RpdLrrg2wwC9Wrtgg8L5whFlvqk32Mbf0uxU9Boa/Z0i6R3jpjg1kdNa
 d4eKNZZomozmRDMogUFOi4lB+OE=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7b9830.7fb8371f6928-smtp-out-n01;
 Wed, 25 Mar 2020 17:43:12 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 87594C4478F; Wed, 25 Mar 2020 17:43:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from wcheng-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6163CC433F2;
        Wed, 25 Mar 2020 17:43:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6163CC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wcheng@codeaurora.org
From:   Wesley Cheng <wcheng@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com, p.zabel@pengutronix.de
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Wesley Cheng <wcheng@codeaurora.org>
Subject: [PATCH v3 1/4] dt-bindings: phy: Add binding for qcom,usb-hs-7nm
Date:   Wed, 25 Mar 2020 10:43:01 -0700
Message-Id: <1585158184-5907-2-git-send-email-wcheng@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1585158184-5907-1-git-send-email-wcheng@codeaurora.org>
References: <1585158184-5907-1-git-send-email-wcheng@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This binding shows the descriptions and properties for the
7nm Synopsis HS USB PHY used on QCOM platforms.

Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/phy/qcom,usb-hs-7nm.yaml   | 76 ++++++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,usb-hs-7nm.yaml

diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-hs-7nm.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-hs-7nm.yaml
new file mode 100644
index 0000000..7292e27
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom,usb-hs-7nm.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/phy/qcom,usb-hs-7nm.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm Synopsys 7nm High-Speed USB PHY
+
+maintainers:
+  - Wesley Cheng <wcheng@codeaurora.org>
+
+description: |
+  Qualcomm Hi-Speed 7nm USB PHY
+
+properties:
+  compatible:
+    enum:
+      - qcom,usb-snps-hs-7nm-phy
+      - qcom,sm8150-usb-hs-phy
+
+  reg:
+    maxItems: 1
+
+  "#phy-cells":
+    const: 0
+
+  clocks:
+    items:
+      - description: rpmhcc ref clock
+
+  clock-names:
+    items:
+      - const: ref
+
+  resets:
+    items:
+      - description: PHY core reset
+
+  vdda-pll-supply:
+    description: phandle to the regulator VDD supply node.
+
+  vdda18-supply:
+    description: phandle to the regulator 1.8V supply node.
+
+  vdda33-supply:
+    description: phandle to the regulator 3.3V supply node.
+
+required:
+  - compatible
+  - reg
+  - "#phy-cells"
+  - clocks
+  - clock-names
+  - resets
+  - vdda-pll-supply
+  - vdda18-supply
+  - vdda33-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/clock/qcom,gcc-sm8150.h>
+    usb_1_hsphy: phy@88e2000 {
+        compatible = "qcom,sm8150-usb-hs-phy";
+        reg = <0 0x088e2000 0 0x400>;
+        status = "disabled";
+        #phy-cells = <0>;
+
+        clocks = <&rpmhcc RPMH_CXO_CLK>;
+        clock-names = "ref";
+
+        resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
+    };
+...
\ No newline at end of file
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
