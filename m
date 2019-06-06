Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 989D037A45
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 18:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbfFFQzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 12:55:32 -0400
Received: from 1.mo2.mail-out.ovh.net ([46.105.63.121]:35301 "EHLO
        1.mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728718AbfFFQzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 12:55:31 -0400
X-Greylist: delayed 4548 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Jun 2019 12:55:30 EDT
Received: from player759.ha.ovh.net (unknown [10.109.143.24])
        by mo2.mail-out.ovh.net (Postfix) with ESMTP id 3B97D19BA51
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2019 18:46:58 +0200 (CEST)
Received: from armadeus.com (lfbn-1-7591-179.w90-126.abo.wanadoo.fr [90.126.248.179])
        (Authenticated sender: sebastien.szymanski@armadeus.com)
        by player759.ha.ovh.net (Postfix) with ESMTPSA id 4051B69C160A;
        Thu,  6 Jun 2019 16:46:47 +0000 (UTC)
From:   =?UTF-8?q?S=C3=A9bastien=20Szymanski?= 
        <sebastien.szymanski@armadeus.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?S=C3=A9bastien=20Szymanski?= 
        <sebastien.szymanski@armadeus.com>
Subject: [PATCH 1/1] ARM: dts: imx6ul: Add PXP node
Date:   Thu,  6 Jun 2019 18:46:42 +0200
Message-Id: <20190606164642.11539-1-sebastien.szymanski@armadeus.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 4864450547657430039
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudeggedguddtiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PXP node for i.MX6UL/L SoC.

Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
---
 arch/arm/boot/dts/imx6ul.dtsi  | 9 +++++++++
 arch/arm/boot/dts/imx6ull.dtsi | 6 ++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index f10012de5eb6..a3c005373ae1 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -971,6 +971,15 @@
 				status = "disabled";
 			};
 
+			pxp: pxp@21cc000 {
+				compatible = "fsl,imx6ul-pxp";
+				reg = <0x021cc000 0x4000>;
+				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_PXP>;
+				clock-names = "axi";
+				status = "disabled";
+			};
+
 			qspi: spi@21e0000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
diff --git a/arch/arm/boot/dts/imx6ull.dtsi b/arch/arm/boot/dts/imx6ull.dtsi
index 22e4a307fa59..b017e925bd87 100644
--- a/arch/arm/boot/dts/imx6ull.dtsi
+++ b/arch/arm/boot/dts/imx6ull.dtsi
@@ -34,6 +34,12 @@
 	compatible = "fsl,imx6ull-ocotp", "syscon";
 };
 
+&pxp {
+	compatible = "fsl,imx6ull-pxp";
+	interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+};
+
 &usdhc1 {
 	compatible = "fsl,imx6ull-usdhc", "fsl,imx6sx-usdhc";
 };
-- 
2.19.2

