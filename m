Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9127C11081
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 02:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfEBAOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 20:14:16 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38338 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfEBAOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 20:14:12 -0400
Received: by mail-pf1-f194.google.com with SMTP id 10so218768pfo.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 17:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CZXd7bu50ce7AYprUctVcayYE5p6uwU2diY6OgRXDUc=;
        b=z6pk+eo55Wg0ynWzV3ZjcdA3Kid/IP7lJfz5fI+cAMGRt9sxRkZqxePj/p9SIQ1ZpB
         K0qHCExH9cT74vIlKSsYEbRshW+UoIvljUHl2kisgiK6qExYWTdKxCdhtaQiFhcHSZwn
         jFLmE2mFOOd9uf30TUsLOgZJOKczb1GFrt6dUH0gBFjwVGUrylLvepSaQLiJG7orwdyJ
         tWmnlZmiFTav9N7NjtUubSBOvYK7yFWL+pmIF2jKP431HfYXZDtmAcnRpIjnsqbqqXdx
         Lh45qFk+Gndgkm1qw9FgDomCeVlcWvkiTJLkKVBId/RyeDgAzwG1wgZ1d1lCBPPWtnXq
         EMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CZXd7bu50ce7AYprUctVcayYE5p6uwU2diY6OgRXDUc=;
        b=iVTfOMxm+KMAOsPLTnkI4LSkTmWiBTHnw3Lnj9aFwc4nGSM3aDldxUEzslg/KQ9lOP
         KFAgioyfMpp/vvbAO9G5ZROQr6vJGtjmGevhuOAoCt6xVzm9JefaAnLPZzsQehO+X1co
         dKVzouuk4LD5JT17oLna4C6DMtfhOZ8jmGVaLG+edgBbtjB49K2DmOEC1P+ZUXrHnVfW
         ZVOZzt66Ln2f6pmeTMTqij3cyTmT6puZahUmVu3eAUjDkh3PVKxHKwNUKrLh6YVsaa4S
         F5hEtLVj96m4lTnOBraYJb1azA0ZVpmJmCtsUkRZqmdD82l6sd/cdv2sMdZvE+8WHuT5
         sJlw==
X-Gm-Message-State: APjAAAURHc9WkjCg2Gp8fGLIcoOa5TzucglUh6VCKTm5pfdvyvtru+mr
        HYfxq+BzaNpdMqaTZBFu6zkFXA==
X-Google-Smtp-Source: APXvYqy62m1OzKj5XM5bSXOmiuRFVcx1Ud9cAHEZC0ysdFyQ7V7XYLm46o1ioGRhjieAxI2CZ5Sr8g==
X-Received: by 2002:a63:dd02:: with SMTP id t2mr830810pgg.434.1556756051785;
        Wed, 01 May 2019 17:14:11 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z9sm2329695pga.92.2019.05.01.17.14.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 17:14:10 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: phy: Add binding for Qualcomm PCIe2 PHY
Date:   Wed,  1 May 2019 17:14:05 -0700
Message-Id: <20190502001406.10431-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190502001406.10431-1-bjorn.andersson@linaro.org>
References: <20190502001406.10431-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm PCIe2 PHY is a Synopsys based PCIe PHY found in a number of
Qualcomm platforms, add a binding to describe this.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
- Add #clock-cells

 .../bindings/phy/qcom-pcie2-phy.txt           | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom-pcie2-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/qcom-pcie2-phy.txt b/Documentation/devicetree/bindings/phy/qcom-pcie2-phy.txt
new file mode 100644
index 000000000000..30064253f290
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom-pcie2-phy.txt
@@ -0,0 +1,42 @@
+Qualcomm PCIe2 PHY controller
+=============================
+
+The Qualcomm PCIe2 PHY is a Synopsys based phy found in a number of Qualcomm
+platforms.
+
+Required properties:
+ - compatible: compatible list, should be:
+	       "qcom,qcs404-pcie2-phy", "qcom,pcie2-phy"
+
+ - reg: offset and length of the PHY register set.
+ - #phy-cells: must be 0.
+
+ - clocks: a clock-specifier pair for the "pipe" clock
+
+ - vdda-vp-supply: phandle to low voltage regulator
+ - vdda-vph-supply: phandle to high voltage regulator
+
+ - resets: reset-specifier pairs for the "phy" and "pipe" resets
+ - reset-names: list of resets, should contain:
+		"phy" and "pipe"
+
+ - clock-output-names: name of the outgoing clock signal from the PHY PLL
+ - #clock-cells: must be 0
+
+Example:
+ phy@7786000 {
+	compatible = "qcom,qcs404-pcie2-phy", "qcom,pcie2-phy";
+	reg = <0x07786000 0xb8>;
+
+	clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
+	resets = <&gcc GCC_PCIEPHY_0_PHY_BCR>,
+	         <&gcc GCC_PCIE_0_PIPE_ARES>;
+	reset-names = "phy", "pipe";
+
+	vdda-vp-supply = <&vreg_l3_1p05>;
+	vdda-vph-supply = <&vreg_l5_1p8>;
+
+	clock-output-names = "pcie_0_pipe_clk";
+	#clock-cells = <0>;
+	#phy-cells = <0>;
+ };
-- 
2.18.0

