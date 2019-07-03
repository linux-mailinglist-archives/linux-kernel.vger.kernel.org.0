Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 059495C6CD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 03:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfGBBxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 21:53:15 -0400
Received: from inva020.nxp.com ([92.121.34.13]:55826 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbfGBBxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 21:53:15 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E56EE1A01F8;
        Tue,  2 Jul 2019 03:53:12 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D3DF71A0B0B;
        Tue,  2 Jul 2019 03:53:02 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id CFDB9402D9;
        Tue,  2 Jul 2019 09:52:50 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        leonard.crestez@nxp.com, viresh.kumar@linaro.org, ping.bai@nxp.com,
        daniel.baluta@nxp.com, l.stach@pengutronix.de, abel.vesa@nxp.com,
        andrew.smirnov@gmail.com, angus@akkea.ca, ccaione@baylibre.com,
        agx@sigxcpu.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/2] arm64: dts: imx8mq: Add gpio-ranges property
Date:   Tue,  2 Jul 2019 09:43:59 +0800
Message-Id: <20190702014400.33554-1-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

Add "gpio-ranges" property to establish connections between GPIOs
and PINs on i.MX8MQ pinctrl driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 477c523..3187428 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -287,6 +287,7 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				gpio-ranges = <&iomuxc 0 10 30>;
 			};
 
 			gpio2: gpio@30210000 {
@@ -299,6 +300,7 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				gpio-ranges = <&iomuxc 0 40 21>;
 			};
 
 			gpio3: gpio@30220000 {
@@ -311,6 +313,7 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				gpio-ranges = <&iomuxc 0 61 26>;
 			};
 
 			gpio4: gpio@30230000 {
@@ -323,6 +326,7 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				gpio-ranges = <&iomuxc 0 87 32>;
 			};
 
 			gpio5: gpio@30240000 {
@@ -335,6 +339,7 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				gpio-ranges = <&iomuxc 0 119 30>;
 			};
 
 			tmu: tmu@30260000 {
-- 
2.7.4

