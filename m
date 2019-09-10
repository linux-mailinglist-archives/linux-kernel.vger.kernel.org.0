Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F195AE28A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 05:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392832AbfIJD0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Sep 2019 23:26:37 -0400
Received: from inva020.nxp.com ([92.121.34.13]:33586 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728598AbfIJD0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 23:26:36 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A15AF1A0869;
        Tue, 10 Sep 2019 05:26:35 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 46C9E1A0454;
        Tue, 10 Sep 2019 05:26:30 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 71BA5402BF;
        Tue, 10 Sep 2019 11:26:23 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/2] arm64: dts: imx8mn: Enable cpu-idle driver
Date:   Tue, 10 Sep 2019 11:25:18 -0400
Message-Id: <1568129118-31114-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568129118-31114-1-git-send-email-Anson.Huang@nxp.com>
References: <1568129118-31114-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable i.MX8MN cpu-idle using generic ARM cpu-idle driver, 2 states
are supported, details as below:

root@imx8mnevk:~# cat /sys/devices/system/cpu/cpu0/cpuidle/state0/name
WFI
root@imx8mnevk:~# cat /sys/devices/system/cpu/cpu0/cpuidle/state0/usage
3098
root@imx8mnevk:~# cat /sys/devices/system/cpu/cpu0/cpuidle/state1/name
cpu-pd-wait
root@imx8mnevk:~# cat /sys/devices/system/cpu/cpu0/cpuidle/state1/usage
3078

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 0166f8c..e4efe8d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -43,6 +43,19 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		idle-states {
+			entry-method = "psci";
+
+			cpu_pd_wait: cpu-pd-wait {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x0010033>;
+				local-timer-stop;
+				entry-latency-us = <1000>;
+				exit-latency-us = <700>;
+				min-residency-us = <2700>;
+			};
+		};
+
 		A53_0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
@@ -54,6 +67,7 @@
 			operating-points-v2 = <&a53_opp_table>;
 			nvmem-cells = <&cpu_speed_grade>;
 			nvmem-cell-names = "speed_grade";
+			cpu-idle-states = <&cpu_pd_wait>;
 		};
 
 		A53_1: cpu@1 {
@@ -65,6 +79,7 @@
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
 			operating-points-v2 = <&a53_opp_table>;
+			cpu-idle-states = <&cpu_pd_wait>;
 		};
 
 		A53_2: cpu@2 {
@@ -76,6 +91,7 @@
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
 			operating-points-v2 = <&a53_opp_table>;
+			cpu-idle-states = <&cpu_pd_wait>;
 		};
 
 		A53_3: cpu@3 {
@@ -87,6 +103,7 @@
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
 			operating-points-v2 = <&a53_opp_table>;
+			cpu-idle-states = <&cpu_pd_wait>;
 		};
 
 		A53_L2: l2-cache0 {
-- 
2.7.4

