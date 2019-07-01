Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E65D18260
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 00:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbfEHWnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 18:43:20 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35631 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728628AbfEHWnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 18:43:18 -0400
Received: by mail-pf1-f193.google.com with SMTP id t87so206669pfa.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 15:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=//ssDyBln8BZY58d4oo5/19E/yt+2bcgiGBzlLV+nkQ=;
        b=uhHHCW87uoh9FemCtLvCqAn2AgbXyLLX8glrL4kGvwOSPT6R2bvf0TwHuwK8cR1M0l
         KRAYk/vKdhHSuRy0tu898oONu6ook8MAr24SB13BHsnKTZ673MVQtUar5JipYBha8jmX
         6VrshbBXKVgXKOKRgxN6pG4bglEsWPMyIkFNv4GHcGQIwAx5aVbjI4XNlZAw2+KDVmhE
         AJKIRLfjwuRdM7HygkRRE/Jp5q3c8uNJwFridduBbyAaxWPDPy0fzwk+XLQZtemKr7Pm
         kdMQvXYNdw8D7BOtDKDs7tnforEMDaC2XgGh1XSGFnpY1+fdzxWI+Vv19buatSnXJFQM
         +nAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=//ssDyBln8BZY58d4oo5/19E/yt+2bcgiGBzlLV+nkQ=;
        b=Td+PJDo6evt58chrXUMT2F+BtnwNx+OfQQtm7XZQl9Bei+D/3nAk5fu3C5k5LpN/Oy
         N9v34FFmHwSB0/H/qiugwPBfRkRdEkk4NZeTMfgiEu3Q3PnssJLCZSJzD9STKcp2Gg52
         Ot6pw2ysQ3GWWKK5TU8tA2dgFHNYfE5ZWJ1bJ52Di5gw/EbIjl2PSwJVJ+KNQr5z2Tt2
         rWTMb4Fy6mbREoy7c64ADmfsaonAQLZ11Woft6k0wFzl5JqrNQVa87y1hbeMwr6+xHj3
         FTUWjmRuSziEIw7LMFOFwVCThKWo7pryIFDgtSjC75JCoFLXs7Do6bpUdfOEbVVSEYrs
         TM2w==
X-Gm-Message-State: APjAAAX+Ys5GgDWyrCkxQD8UOTKniq7UWarZDX+PFFRz6CaszrvozuPc
        +v/X2P9hVRtYOVH4VWP7dYrIIlEORwo=
X-Google-Smtp-Source: APXvYqzRqpM4/hyzBO6sHXupAo83Putj6RvoE9HT65iqbET34bEFFMWWh0B13NNHeMSR6395VQKK/w==
X-Received: by 2002:a65:5c82:: with SMTP id a2mr866049pgt.378.1557355397036;
        Wed, 08 May 2019 15:43:17 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 25sm320494pfo.145.2019.05.08.15.43.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 15:43:16 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] arm64: dts: qcom: qcs404-evb: Enable PCIe
Date:   Wed,  8 May 2019 15:43:09 -0700
Message-Id: <20190508224309.5744-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190508224309.5744-1-bjorn.andersson@linaro.org>
References: <20190508224309.5744-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the PCIe PHY and controller found on the QCS404 EVB.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v3:
- Split single patch, no functional change

 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 26 ++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
index 2c3127167e3c..d1108a6abd0a 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2018, Linaro Limited
 
+#include <dt-bindings/gpio/gpio.h>
 #include "qcs404.dtsi"
 #include "pms405.dtsi"
 
@@ -68,6 +69,22 @@
 	};
 };
 
+&pcie {
+	status = "ok";
+
+	perst-gpio = <&tlmm 43 GPIO_ACTIVE_LOW>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&perst_state>;
+};
+
+&pcie_phy {
+	status = "ok";
+
+	vdda-vp-supply = <&vreg_l3_1p05>;
+	vdda-vph-supply = <&vreg_l5_1p8>;
+};
+
 &remoteproc_adsp {
 	status = "ok";
 };
@@ -184,6 +201,15 @@
 };
 
 &tlmm {
+	perst_state: perst {
+		pins = "gpio43";
+		function = "gpio";
+
+		drive-strength = <2>;
+		bias-disable;
+		output-low;
+	};
+
 	sdc1_on: sdc1-on {
 		clk {
 			pins = "sdc1_clk";
-- 
2.18.0

