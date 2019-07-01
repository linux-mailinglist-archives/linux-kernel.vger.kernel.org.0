Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA62119EFC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2019 16:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbfEJOUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 May 2019 10:20:51 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:48950 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727891AbfEJOUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 10:20:48 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4AE1mfQ025399;
        Fri, 10 May 2019 16:20:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version : content-type
 : content-transfer-encoding; s=STMicroelectronics;
 bh=/XRL/cLbUyuiOX7oZ//xMTlD4EbxIiDLjZE+ThQcnls=;
 b=PTQbnLjW+4cIwTlZRJQ7M0JJ7VWQbIjead4RnKIdGrVSe9FJJQ8PnLpnJSm/Qr32Czxg
 hgrSy9SitxnMH9jMvP0ClqBFdU2LVSPBfYufiyTj24AyQQ4NrGs5dWtTt4b2qcJlfIYt
 TPzmiyWddvuHizI++YI5XvYZj1ytzxVnKHzWs2oryLmk2vK0+8bmlMLqK4isEMLICTKM
 uUdjt+CCaOXjHzT/F4Anv9raBFZIU622NfqrtAdW5KXuFgMtA1/06K868iJleupRSndk
 S91rnNrtYH73E1HpwdqAfSbFHYAZn8Kzdf/kq6U+KWpmStGDdfMVFIAej9vaukOhGKr7 Xw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2scfv2s5w5-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 10 May 2019 16:20:35 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 958323D;
        Fri, 10 May 2019 14:20:33 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 754F5113A;
        Fri, 10 May 2019 14:20:33 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 10 May
 2019 16:20:33 +0200
Received: from localhost (10.201.23.97) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 10 May 2019 16:20:32
 +0200
From:   =?UTF-8?q?Yannick=20Fertr=C3=A9?= <yannick.fertre@st.com>
To:     Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/5] ARM: dts: stm32: move fixe regulators reg11 & reg18
Date:   Fri, 10 May 2019 16:20:22 +0200
Message-ID: <1557498023-10766-5-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557498023-10766-1-git-send-email-yannick.fertre@st.com>
References: <1557498023-10766-1-git-send-email-yannick.fertre@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.23.97]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-09_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move regulators reg11 & reg18 from device-tree files stm32mp157c-ed1.dts
& stm32mp157c-dk2.dts to file stm32mp157c.dtsi.

Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
---
 arch/arm/boot/dts/stm32mp157c-dk2.dts |  8 --------
 arch/arm/boot/dts/stm32mp157c-ed1.dts | 16 ----------------
 arch/arm/boot/dts/stm32mp157c.dtsi    | 16 ++++++++++++++++
 3 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp157c-dk2.dts b/arch/arm/boot/dts/stm32mp157c-dk2.dts
index 20ea601..020ea0f 100644
--- a/arch/arm/boot/dts/stm32mp157c-dk2.dts
+++ b/arch/arm/boot/dts/stm32mp157c-dk2.dts
@@ -11,14 +11,6 @@
 / {
 	model = "STMicroelectronics STM32MP157C-DK2 Discovery Board";
 	compatible = "st,stm32mp157c-dk2", "st,stm32mp157";
-
-	reg18: reg18 {
-		compatible = "regulator-fixed";
-		regulator-name = "reg18";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		regulator-always-on;
-	};
 };
 
 &dsi {
diff --git a/arch/arm/boot/dts/stm32mp157c-ed1.dts b/arch/arm/boot/dts/stm32mp157c-ed1.dts
index 62a8c78..f41189c 100644
--- a/arch/arm/boot/dts/stm32mp157c-ed1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ed1.dts
@@ -27,22 +27,6 @@
 		serial0 = &uart4;
 	};
 
-	reg11: reg11 {
-		compatible = "regulator-fixed";
-		regulator-name = "reg11";
-		regulator-min-microvolt = <1100000>;
-		regulator-max-microvolt = <1100000>;
-		regulator-always-on;
-	};
-
-	reg18: reg18 {
-		compatible = "regulator-fixed";
-		regulator-name = "reg18";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		regulator-always-on;
-	};
-
 	sd_switch: regulator-sd_switch {
 		compatible = "regulator-gpio";
 		regulator-name = "sd_switch";
diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index 6b14f1e..aaac51cd 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -11,6 +11,22 @@
 	#address-cells = <1>;
 	#size-cells = <1>;
 
+	reg11: reg11 {
+		compatible = "regulator-fixed";
+		regulator-name = "reg11";
+		regulator-min-microvolt = <1100000>;
+		regulator-max-microvolt = <1100000>;
+		regulator-always-on;
+	};
+
+	reg18: reg18 {
+		compatible = "regulator-fixed";
+		regulator-name = "reg18";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.7.4

