Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 189BD9D46B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 18:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733277AbfHZQsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 12:48:30 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52327 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733203AbfHZQsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 12:48:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id o4so195170wmh.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 09:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CwwDn1F3isDHLADadg552cZsZttuc4BOXuvwzE9t/LA=;
        b=TTHn8SMVljztzBzglxHx98EIyz6v1F8+VDebWt/WipPeUwGjbJshFubBgEsd+OKiUl
         epgN2CoPgMuJJvk6zp1VMRXJgjs5x17jpOBS3cxricda51pnALca4j3Ai0OrlB3DCLJB
         thNGGnRCFu91t/jkHmHGfs2hDQusecj5fI4zd7Ce6XQJ9ZDOFJCshGDcfdJuLEjN9c2z
         3O9UdukcFw8G+mnUsunt4yPiOXV2nPNDHiFqiGEXMQr2E13o/cBqMuMmchfC5ZDVm7bX
         JRLLhJyz1R1nn/yl4CVHelQSi/cv+6mUFTSdfUD/JkjGkExo8dNDRGadRdcIPBjq2d0N
         R4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CwwDn1F3isDHLADadg552cZsZttuc4BOXuvwzE9t/LA=;
        b=QiNA7WQrtjUnQxGjk64zbuhSXRnQe0lU2/p9f/LJH9wUNJ8IvW8qt/2e9XDLM7UK4h
         iE6IquHGiVXMqCuuyVRdzIOl14lzrR+EKskJSPtFmHbCxExp6qlCZm/75uQXQWzsUZVI
         U1yfh3/9EBuq1eSgy+K75iy+D68ukOcgG38A2n0wQJIabu/LMWYz/BCLRN+m8dJyCK50
         TIsQ+HhDN9/juJzsI/wyRezBdEFL6wtIeyYUdEM5QsxZMaf05q7hIOXovXxYnh5aLzEK
         SMooblK5IMdrGfkYeAIuC6S4OCXWxdYePTZgsEtlmaRas+wEGvtYOb1lTy+FFtNUZnnA
         4gPA==
X-Gm-Message-State: APjAAAXbf0w5RECFCV58mmdgJ6a1QTIFFFcVekMpjB0Sa9VG/ct7+snn
        431hcN5uLY5MI4WuVXCl88ikGg==
X-Google-Smtp-Source: APXvYqxMmtG0EPA5/X3QeG/mAzh8hfdzyuz0llb1Wpg7+/GlL66wbHzhphOb5HXu528UYCy4D2QElw==
X-Received: by 2002:a7b:c775:: with SMTP id x21mr23809437wmk.90.1566838094268;
        Mon, 26 Aug 2019 09:48:14 -0700 (PDT)
Received: from localhost.localdomain (124.red-83-36-179.dynamicip.rima-tde.net. [83.36.179.124])
        by smtp.gmail.com with ESMTPSA id o14sm21800076wrg.64.2019.08.26.09.48.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Aug 2019 09:48:13 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, agross@kernel.org, mark.rutland@arm.com
Cc:     niklas.cassel@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] arm64: dts: qcom: qcs404: Add DVFS support
Date:   Mon, 26 Aug 2019 18:48:06 +0200
Message-Id: <20190826164807.7028-5-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190826164807.7028-1-jorge.ramirez-ortiz@linaro.org>
References: <20190826164807.7028-1-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support dynamic voltage and frequency scaling on qcs404.

CPUFreq will soon be superseded by Core Power Reduction (CPR, a form
of Adaptive Voltage Scaling found on some Qualcomm SoCs like the
qcs404).

Due to the CPR upstreaming already being in progress - and some
commits already merged -  the following commit will need to be
reverted to enable CPUFreq support

   Author: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
   Date:   Thu Jul 25 12:41:36 2019 +0200
       cpufreq: Add qcs404 to cpufreq-dt-platdev blacklist

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 31 ++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 34360b2d3e0d..e425e54e1af9 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -36,6 +36,10 @@
 			cpu-idle-states = <&CPU_SLEEP_0>;
 			next-level-cache = <&L2_0>;
 			#cooling-cells = <2>;
+			clocks = <&apcs_glb>;
+			operating-points-v2 = <&cpu_opp_table>;
+			cpu-supply = <&pms405_s3>;
+
 		};
 
 		CPU1: cpu@101 {
@@ -46,6 +50,9 @@
 			cpu-idle-states = <&CPU_SLEEP_0>;
 			next-level-cache = <&L2_0>;
 			#cooling-cells = <2>;
+			clocks = <&apcs_glb>;
+			operating-points-v2 = <&cpu_opp_table>;
+			cpu-supply = <&pms405_s3>;
 		};
 
 		CPU2: cpu@102 {
@@ -56,6 +63,9 @@
 			cpu-idle-states = <&CPU_SLEEP_0>;
 			next-level-cache = <&L2_0>;
 			#cooling-cells = <2>;
+			clocks = <&apcs_glb>;
+			operating-points-v2 = <&cpu_opp_table>;
+			cpu-supply = <&pms405_s3>;
 		};
 
 		CPU3: cpu@103 {
@@ -66,6 +76,9 @@
 			cpu-idle-states = <&CPU_SLEEP_0>;
 			next-level-cache = <&L2_0>;
 			#cooling-cells = <2>;
+			clocks = <&apcs_glb>;
+			operating-points-v2 = <&cpu_opp_table>;
+			cpu-supply = <&pms405_s3>;
 		};
 
 		L2_0: l2-cache {
@@ -88,6 +101,24 @@
 		};
 	};
 
+	cpu_opp_table: cpu-opp-table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-1094400000 {
+			opp-hz = /bits/ 64 <1094400000>;
+			opp-microvolt = <1224000 1224000 1224000>;
+		};
+		opp-1248000000 {
+			opp-hz = /bits/ 64 <1248000000>;
+			opp-microvolt = <1288000 1288000 1288000>;
+		};
+		opp-1401600000 {
+			opp-hz = /bits/ 64 <1401600000>;
+			opp-microvolt = <1384000 1384000 1384000>;
+		};
+	};
+
 	firmware {
 		scm: scm {
 			compatible = "qcom,scm-qcs404", "qcom,scm";
-- 
2.22.0

