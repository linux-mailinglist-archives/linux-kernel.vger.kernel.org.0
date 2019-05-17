Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F12721348
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 06:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfEQE4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 00:56:16 -0400
Received: from inva021.nxp.com ([92.121.34.21]:45868 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbfEQE4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 00:56:16 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1FE9C200015;
        Fri, 17 May 2019 06:56:14 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 61AA9200005;
        Fri, 17 May 2019 06:56:10 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 7596E40250;
        Fri, 17 May 2019 12:56:05 +0800 (SGT)
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH v2] arm64: dts: ls1028a: Fix CPU idle fail.
Date:   Fri, 17 May 2019 12:57:53 +0800
Message-Id: <20190517045753.3709-1-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PSCI spec define 1st parameter's bit 16 of function CPU_SUSPEND to
indicate CPU State Type: 0 for standby, 1 for power down. In this
case, we want to select standby for CPU idle feature. But current
setting wrongly select power down and cause CPU SUSPEND fail every
time. Need this fix.

Fixes: 8897f3255c9c ("arm64: dts: Add support for NXP LS1028A SoC")
Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index b045812..bf7f845 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -28,7 +28,7 @@
 			enable-method = "psci";
 			clocks = <&clockgen 1 0>;
 			next-level-cache = <&l2>;
-			cpu-idle-states = <&CPU_PH20>;
+			cpu-idle-states = <&CPU_PW20>;
 		};
 
 		cpu1: cpu@1 {
@@ -38,7 +38,7 @@
 			enable-method = "psci";
 			clocks = <&clockgen 1 0>;
 			next-level-cache = <&l2>;
-			cpu-idle-states = <&CPU_PH20>;
+			cpu-idle-states = <&CPU_PW20>;
 		};
 
 		l2: l2-cache {
@@ -53,13 +53,13 @@
 		 */
 		entry-method = "arm,psci";
 
-		CPU_PH20: cpu-ph20 {
-			compatible = "arm,idle-state";
-			idle-state-name = "PH20";
-			arm,psci-suspend-param = <0x00010000>;
-			entry-latency-us = <1000>;
-			exit-latency-us = <1000>;
-			min-residency-us = <3000>;
+		CPU_PW20: cpu-pw20 {
+			  compatible = "arm,idle-state";
+			  idle-state-name = "PW20";
+			  arm,psci-suspend-param = <0x0>;
+			  entry-latency-us = <2000>;
+			  exit-latency-us = <2000>;
+			  min-residency-us = <6000>;
 		};
 	};
 
-- 
1.7.1

