Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18EC474BFE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 12:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391048AbfGYKnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 06:43:12 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40856 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390816AbfGYKnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 06:43:10 -0400
Received: by mail-lf1-f66.google.com with SMTP id b17so34194308lff.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 03:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g1WczPtOCOQXnt3Wx/wOQkCZbBrZjrn9x6sFyhVYPzI=;
        b=YRuXsYU1PxEaj/wYsUphuXMEJhfOsEF8lNjvb04BtAaEJiGFNZYB0/MjC4vypMKN9c
         m92tRl2wSNmikQC1z/diPIKaw2xmF5khLMywDDJSOdY1OJQXC5FuW55QRtQVICgZ1Gl/
         7GjPzH3qFctzv7+8ErMcEdMwpcEBa2gPCxVVTAlP8jd8NZa9nrh0c2fVVH+Sw7jRgTt3
         RDqH1cncC3Tvh1Q1oxxb4JwcKDXUPnVYiZCRgfpBselwWE19hhCPNOVQVpHHtH05Y70A
         IqIQCTIOFCbSpLeODUDczDDp92OZorc+toPYxx4UQem7dWbgJbYSPPqiyjeMNxYzmUvX
         9QQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g1WczPtOCOQXnt3Wx/wOQkCZbBrZjrn9x6sFyhVYPzI=;
        b=ay9W4y6Gg03UM4FKDMffgUIudldBXCofcdxreHD/AdrtqY1JPFSYUEkBA72y3hPjpx
         NplEncacfyQo5sWNRki5cboNNLmWrMJ+g35FmIASyKABEIHBEdxsGWprAa80O7oFWTTa
         HUzGqovAZgN1qK2SUh7DAuuBDPwAasvcEaYKd57V3cNIIjpmBfMcOVANBNZIPIWDwybG
         K8Jbqy0x4AtEWLflxs1SwLeFxMrCHrn6GtUSDTTUvfJnNrMNXsudsZWeUaQiuDFzxoAV
         xoNqtc7e+tMWCMttP6COJRrV3FrnY/+Mx1wbjMgs06Rug2qg0YIYHjwwKdRiJNwiwt6r
         DPmw==
X-Gm-Message-State: APjAAAWDsFWMht/M/EGNfIz3vl8LhopoABCuXID+edSsFj43L/x2nZrS
        RL3XW7OpLaDYvCRNYj31JLDKRA==
X-Google-Smtp-Source: APXvYqzlYM5YqOM0wZ6YcVar/FadCXNZJx0rXt146YtLh1Z9l80+vBpXLCAmmh9F8kXlZOOEKM3JKw==
X-Received: by 2002:ac2:4ace:: with SMTP id m14mr6280459lfp.99.1564051388390;
        Thu, 25 Jul 2019 03:43:08 -0700 (PDT)
Received: from localhost.localdomain (ua-83-226-44-230.bbcust.telenor.se. [83.226.44.230])
        by smtp.gmail.com with ESMTPSA id 63sm9139580ljs.84.2019.07.25.03.43.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 03:43:07 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        sboyd@kernel.org, vireshk@kernel.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, Niklas Cassel <niklas.cassel@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/14] arm64: dts: qcom: qcs404: Add CPR and populate OPP table
Date:   Thu, 25 Jul 2019 12:41:40 +0200
Message-Id: <20190725104144.22924-13-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190725104144.22924-1-niklas.cassel@linaro.org>
References: <20190725104144.22924-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CPR and populate OPP table.

Co-developed-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
Changes since V1:
-Removed opp-hz from CPR OPP table.

 arch/arm64/boot/dts/qcom/qcs404.dtsi | 142 +++++++++++++++++++++++++--
 1 file changed, 134 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index ff9198740431..5519422b762d 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -38,7 +38,8 @@
 			#cooling-cells = <2>;
 			clocks = <&apcs_glb>;
 			operating-points-v2 = <&cpu_opp_table>;
-			cpu-supply = <&pms405_s3>;
+			power-domains = <&cprpd>;
+			power-domain-names = "cpr";
 		};
 
 		CPU1: cpu@101 {
@@ -51,7 +52,8 @@
 			#cooling-cells = <2>;
 			clocks = <&apcs_glb>;
 			operating-points-v2 = <&cpu_opp_table>;
-			cpu-supply = <&pms405_s3>;
+			power-domains = <&cprpd>;
+			power-domain-names = "cpr";
 		};
 
 		CPU2: cpu@102 {
@@ -64,7 +66,8 @@
 			#cooling-cells = <2>;
 			clocks = <&apcs_glb>;
 			operating-points-v2 = <&cpu_opp_table>;
-			cpu-supply = <&pms405_s3>;
+			power-domains = <&cprpd>;
+			power-domain-names = "cpr";
 		};
 
 		CPU3: cpu@103 {
@@ -77,7 +80,8 @@
 			#cooling-cells = <2>;
 			clocks = <&apcs_glb>;
 			operating-points-v2 = <&cpu_opp_table>;
-			cpu-supply = <&pms405_s3>;
+			power-domains = <&cprpd>;
+			power-domain-names = "cpr";
 		};
 
 		L2_0: l2-cache {
@@ -101,20 +105,37 @@
 	};
 
 	cpu_opp_table: cpu-opp-table {
-		compatible = "operating-points-v2";
+		compatible = "operating-points-v2-kryo-cpu";
 		opp-shared;
 
 		opp-1094400000 {
 			opp-hz = /bits/ 64 <1094400000>;
-			opp-microvolt = <1224000 1224000 1224000>;
+			required-opps = <&cpr_opp1>;
 		};
 		opp-1248000000 {
 			opp-hz = /bits/ 64 <1248000000>;
-			opp-microvolt = <1288000 1288000 1288000>;
+			required-opps = <&cpr_opp2>;
 		};
 		opp-1401600000 {
 			opp-hz = /bits/ 64 <1401600000>;
-			opp-microvolt = <1384000 1384000 1384000>;
+			required-opps = <&cpr_opp3>;
+		};
+	};
+
+	cpr_opp_table: cpr-opp-table {
+		compatible = "operating-points-v2-qcom-level";
+
+		cpr_opp1: opp1 {
+			opp-level = <1>;
+			qcom,opp-fuse-level = <1>;
+		};
+		cpr_opp2: opp2 {
+			opp-level = <2>;
+			qcom,opp-fuse-level = <2>;
+		};
+		cpr_opp3: opp3 {
+			opp-level = <3>;
+			qcom,opp-fuse-level = <3>;
 		};
 	};
 
@@ -294,6 +315,62 @@
 			tsens_caldata: caldata@d0 {
 				reg = <0x1f8 0x14>;
 			};
+			cpr_efuse_speedbin: speedbin@13c {
+				reg = <0x13c 0x4>;
+				bits = <2 3>;
+			};
+			cpr_efuse_quot_offset1: qoffset1@231 {
+				reg = <0x231 0x4>;
+				bits = <4 7>;
+			};
+			cpr_efuse_quot_offset2: qoffset2@232 {
+				reg = <0x232 0x4>;
+				bits = <3 7>;
+			};
+			cpr_efuse_quot_offset3: qoffset3@233 {
+				reg = <0x233 0x4>;
+				bits = <2 7>;
+			};
+			cpr_efuse_init_voltage1: ivoltage1@229 {
+				reg = <0x229 0x4>;
+				bits = <4 6>;
+			};
+			cpr_efuse_init_voltage2: ivoltage2@22a {
+				reg = <0x22a 0x4>;
+				bits = <2 6>;
+			};
+			cpr_efuse_init_voltage3: ivoltage3@22b {
+				reg = <0x22b 0x4>;
+				bits = <0 6>;
+			};
+			cpr_efuse_quot1: quot1@22b {
+				reg = <0x22b 0x4>;
+				bits = <6 12>;
+			};
+			cpr_efuse_quot2: quot2@22d {
+				reg = <0x22d 0x4>;
+				bits = <2 12>;
+			};
+			cpr_efuse_quot3: quot3@230 {
+				reg = <0x230 0x4>;
+				bits = <0 12>;
+			};
+			cpr_efuse_ring1: ring1@228 {
+				reg = <0x228 0x4>;
+				bits = <0 3>;
+			};
+			cpr_efuse_ring2: ring2@228 {
+				reg = <0x228 0x4>;
+				bits = <4 3>;
+			};
+			cpr_efuse_ring3: ring3@229 {
+				reg = <0x229 0x4>;
+				bits = <0 3>;
+			};
+			cpr_efuse_revision: revision@218 {
+				reg = <0x218 0x4>;
+				bits = <3 3>;
+			};
 		};
 
 		rng: rng@e3000 {
@@ -901,6 +978,55 @@
 			clock-names = "xo";
 		};
 
+		cprpd: cpr@b018000 {
+			compatible = "qcom,qcs404-cpr", "qcom,cpr";
+			reg = <0x0b018000 0x1000>;
+			interrupts = <0 15 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&xo_board>;
+			clock-names = "ref";
+			vdd-apc-supply = <&pms405_s3>;
+			#power-domain-cells = <0>;
+			operating-points-v2 = <&cpr_opp_table>;
+			acc-syscon = <&tcsr>;
+
+			nvmem-cells = <&cpr_efuse_quot_offset1>,
+				<&cpr_efuse_quot_offset2>,
+				<&cpr_efuse_quot_offset3>,
+				<&cpr_efuse_init_voltage1>,
+				<&cpr_efuse_init_voltage2>,
+				<&cpr_efuse_init_voltage3>,
+				<&cpr_efuse_quot1>,
+				<&cpr_efuse_quot2>,
+				<&cpr_efuse_quot3>,
+				<&cpr_efuse_ring1>,
+				<&cpr_efuse_ring2>,
+				<&cpr_efuse_ring3>,
+				<&cpr_efuse_revision>;
+			nvmem-cell-names = "cpr_quotient_offset1",
+				"cpr_quotient_offset2",
+				"cpr_quotient_offset3",
+				"cpr_init_voltage1",
+				"cpr_init_voltage2",
+				"cpr_init_voltage3",
+				"cpr_quotient1",
+				"cpr_quotient2",
+				"cpr_quotient3",
+				"cpr_ring_osc1",
+				"cpr_ring_osc2",
+				"cpr_ring_osc3",
+				"cpr_fuse_revision";
+
+			qcom,cpr-timer-delay-us = <5000>;
+			qcom,cpr-timer-cons-up = <0>;
+			qcom,cpr-timer-cons-down = <2>;
+			qcom,cpr-up-threshold = <1>;
+			qcom,cpr-down-threshold = <3>;
+			qcom,cpr-idle-clocks = <15>;
+			qcom,cpr-gcnt-us = <1>;
+			qcom,vdd-apc-step-up-limit = <1>;
+			qcom,vdd-apc-step-down-limit = <1>;
+		};
+
 		timer@b120000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.21.0

