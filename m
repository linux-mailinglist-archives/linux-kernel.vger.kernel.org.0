Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E49131691EA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2020 22:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgBVVkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Feb 2020 16:40:43 -0500
Received: from vps.xff.cz ([195.181.215.36]:33162 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbgBVVkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 16:40:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1582407641; bh=n/YtLfVCyVXP+mWFkjUYJqHKw++vxYLHzIOxG9EZXdk=;
        h=From:To:Cc:Subject:Date:From;
        b=RjHT6V8Y3pQ/ti1xfG4/iXH8NMgav6xPA3+JxLk3YvGktporIz9WQpFCv19WxjZVC
         HEP/J7wFIlJcvilXiKreH08mktTYOQdOg3UhFAOUcfFgHGiJZU6DUbdDPnMDV1XunT
         3nMEFY7iuo7gjqTNAgtayVqgaA8YCev5RZ4KO6Uw=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com
Cc:     Ondrej Jirman <megous@megous.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ARM: dts: sun8i-a83t: Add thermal trip points/cooling maps
Date:   Sat, 22 Feb 2020 22:40:39 +0100
Message-Id: <20200222214039.209426-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables passive cooling by down-regulating CPU voltage
and frequency.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 60 +++++++++++++++++++++++++++----
 1 file changed, 54 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 74ac7ee9383cf..53c2b6a836f27 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -72,7 +72,7 @@ cpu0: cpu@0 {
 			#cooling-cells = <2>;
 		};
 
-		cpu@1 {
+		cpu1: cpu@1 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			clocks = <&ccu CLK_C0CPUX>;
@@ -83,7 +83,7 @@ cpu@1 {
 			#cooling-cells = <2>;
 		};
 
-		cpu@2 {
+		cpu2: cpu@2 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			clocks = <&ccu CLK_C0CPUX>;
@@ -94,7 +94,7 @@ cpu@2 {
 			#cooling-cells = <2>;
 		};
 
-		cpu@3 {
+		cpu3: cpu@3 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			clocks = <&ccu CLK_C0CPUX>;
@@ -116,7 +116,7 @@ cpu100: cpu@100 {
 			#cooling-cells = <2>;
 		};
 
-		cpu@101 {
+		cpu101: cpu@101 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			clocks = <&ccu CLK_C1CPUX>;
@@ -127,7 +127,7 @@ cpu@101 {
 			#cooling-cells = <2>;
 		};
 
-		cpu@102 {
+		cpu102: cpu@102 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			clocks = <&ccu CLK_C1CPUX>;
@@ -138,7 +138,7 @@ cpu@102 {
 			#cooling-cells = <2>;
 		};
 
-		cpu@103 {
+		cpu103: cpu@103 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			clocks = <&ccu CLK_C1CPUX>;
@@ -1188,12 +1188,60 @@ cpu0_thermal: cpu0-thermal {
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			thermal-sensors = <&ths 0>;
+
+			trips {
+				cpu0_hot: cpu-hot {
+					temperature = <80000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu0_very_hot: cpu-very-hot {
+					temperature = <100000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				cpu-hot-limit {
+					trip = <&cpu0_hot>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		cpu1_thermal: cpu1-thermal {
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			thermal-sensors = <&ths 1>;
+
+			trips {
+				cpu1_hot: cpu-hot {
+					temperature = <80000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu1_very_hot: cpu-very-hot {
+					temperature = <100000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				cpu-hot-limit {
+					trip = <&cpu1_hot>;
+					cooling-device = <&cpu100 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu101 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu102 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu103 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpu_thermal: gpu-thermal {
-- 
2.25.1

