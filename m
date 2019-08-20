Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A35D9676B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 19:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730531AbfHTRZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 13:25:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:48424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730473AbfHTRZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 13:25:24 -0400
Received: from localhost.localdomain (unknown [106.201.62.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E428D2064A;
        Tue, 20 Aug 2019 17:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566321923;
        bh=eEIuYGPYKoFY8PlSL+W/d5xaw2PcBLUCYliqwJfiS6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SzGDu3gJtIjCYRv0dvYbMMlav2zSQClc5s7XWxDuHs2B3xy08PiX5017RJ9NH/mEi
         wMBgeQMbYkOGFl9KA6EBwiMyuQ8aXrqlk2Jr+q9LTqiwqgoy9xzcy+N2XzxWT+OEFJ
         wXFgZD+aAxvF3Ve/b5/n09jI9seOtDYzJBFNNd+c=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/8] arm64: dts: qcom: pm8150: Add base dts file
Date:   Tue, 20 Aug 2019 22:53:44 +0530
Message-Id: <20190820172351.24145-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190820172351.24145-1-vkoul@kernel.org>
References: <20190820172351.24145-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add base DTS file for pm8150 along with GPIOs, power-on, rtc and vadc
nodes

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/pm8150.dtsi | 97 ++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pm8150.dtsi

diff --git a/arch/arm64/boot/dts/qcom/pm8150.dtsi b/arch/arm64/boot/dts/qcom/pm8150.dtsi
new file mode 100644
index 000000000000..b6e304748a57
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pm8150.dtsi
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2017-2019, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2019, Linaro Limited
+ */
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
+#include <dt-bindings/iio/qcom,spmi-vadc.h>
+
+&spmi_bus {
+	pm8150_0: pmic@0 {
+		compatible = "qcom,pm8150", "qcom,spmi-pmic";
+		reg = <0x0 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pon: power-on@800 {
+			compatible = "qcom,pm8916-pon";
+			reg = <0x0800>;
+			pwrkey {
+				compatible = "qcom,pm8941-pwrkey";
+				interrupts = <0x0 0x8 0x0 IRQ_TYPE_EDGE_BOTH>;
+				debounce = <15625>;
+				bias-pull-up;
+				linux,code = <KEY_POWER>;
+
+				status = "disabled";
+			};
+		};
+
+		pm8150_adc: adc@3100 {
+			compatible = "qcom,spmi-adc5";
+			reg = <0x3100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#io-channel-cells = <1>;
+			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
+
+			status = "disabled";
+
+			ref-gnd@0 {
+				reg = <ADC5_REF_GND>;
+				qcom,pre-scaling = <1 1>;
+				label = "ref_gnd";
+			};
+
+			vref-1p25@1 {
+				reg = <ADC5_1P25VREF>;
+				qcom,pre-scaling = <1 1>;
+				label = "vref_1p25";
+			};
+
+			die-temp@6 {
+				reg = <ADC5_DIE_TEMP>;
+				qcom,pre-scaling = <1 1>;
+				label = "die_temp";
+			};
+		};
+
+		rtc@6000 {
+			compatible = "qcom,pm8941-rtc";
+			reg = <0x6000>;
+			reg-names = "rtc", "alarm";
+			interrupts = <0x0 0x61 0x1 IRQ_TYPE_NONE>;
+
+			status = "disabled";
+		};
+
+		pm8150_gpios: gpio@c000 {
+			compatible = "qcom,pm8150-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupts = <0x0 0xc0 0x0 IRQ_TYPE_NONE>,
+				     <0x0 0xc1 0x0 IRQ_TYPE_NONE>,
+				     <0x0 0xc2 0x0 IRQ_TYPE_NONE>,
+				     <0x0 0xc3 0x0 IRQ_TYPE_NONE>,
+				     <0x0 0xc4 0x0 IRQ_TYPE_NONE>,
+				     <0x0 0xc5 0x0 IRQ_TYPE_NONE>,
+				     <0x0 0xc6 0x0 IRQ_TYPE_NONE>,
+				     <0x0 0xc7 0x0 IRQ_TYPE_NONE>,
+				     <0x0 0xc8 0x0 IRQ_TYPE_NONE>,
+				     <0x0 0xc9 0x0 IRQ_TYPE_NONE>,
+				     <0x0 0xca 0x0 IRQ_TYPE_NONE>,
+				     <0x0 0xcb 0x0 IRQ_TYPE_NONE>;
+		};
+	};
+
+	pmic@1 {
+		compatible = "qcom,pm8150", "qcom,spmi-pmic";
+		reg = <0x1 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+};
-- 
2.20.1

