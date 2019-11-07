Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84371F24F2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 03:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732937AbfKGCIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 21:08:15 -0500
Received: from inva021.nxp.com ([92.121.34.21]:43814 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727328AbfKGCIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 21:08:14 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 08ED9200153;
        Thu,  7 Nov 2019 03:08:12 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B2D9520014B;
        Thu,  7 Nov 2019 03:08:05 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id F2EE9402B1;
        Thu,  7 Nov 2019 10:07:57 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        andrew.smirnov@gmail.com, manivannan.sadhasivam@linaro.org,
        marcel.ziswiler@toradex.com, sebastien.szymanski@armadeus.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 2/4] ARM: dts: imx6sll-evk: Add eMMC support
Date:   Thu,  7 Nov 2019 10:06:31 +0800
Message-Id: <1573092393-26885-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573092393-26885-1-git-send-email-Anson.Huang@nxp.com>
References: <1573092393-26885-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6SLL EVK board has eMMC connected on uSDHC2, add support
for it.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No changes.
---
 arch/arm/boot/dts/imx6sll-evk.dts | 67 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sll-evk.dts b/arch/arm/boot/dts/imx6sll-evk.dts
index 3e1d32f..29b284c 100644
--- a/arch/arm/boot/dts/imx6sll-evk.dts
+++ b/arch/arm/boot/dts/imx6sll-evk.dts
@@ -109,6 +109,14 @@
 		enable-active-high;
 	};
 
+	reg_sd2_vmmc: regulator-sd2-vmmc {
+		compatible = "regulator-fixed";
+		regulator-name = "eMMC-VCCQ";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+	};
+
 	reg_sd3_vmmc: regulator-sd3-vmmc {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
@@ -314,6 +322,17 @@
 	status = "okay";
 };
 
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
+	vqmmc-supply = <&reg_sd2_vmmc>;
+	bus-width = <8>;
+	no-removable;
+	status = "okay";
+};
+
 &usdhc3 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc3>;
@@ -403,6 +422,54 @@
 		>;
 	};
 
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX6SLL_PAD_SD2_CMD__SD2_CMD		0x17059
+			MX6SLL_PAD_SD2_CLK__SD2_CLK		0x13059
+			MX6SLL_PAD_SD2_DATA0__SD2_DATA0		0x17059
+			MX6SLL_PAD_SD2_DATA1__SD2_DATA1		0x17059
+			MX6SLL_PAD_SD2_DATA2__SD2_DATA2		0x17059
+			MX6SLL_PAD_SD2_DATA3__SD2_DATA3		0x17059
+			MX6SLL_PAD_SD2_DATA4__SD2_DATA4		0x17059
+			MX6SLL_PAD_SD2_DATA5__SD2_DATA5		0x17059
+			MX6SLL_PAD_SD2_DATA6__SD2_DATA6		0x17059
+			MX6SLL_PAD_SD2_DATA7__SD2_DATA7		0x17059
+			MX6SLL_PAD_GPIO4_IO21__SD2_STROBE	0x413059
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2grp_100mhz {
+		fsl,pins = <
+			MX6SLL_PAD_SD2_CMD__SD2_CMD		0x170b9
+			MX6SLL_PAD_SD2_CLK__SD2_CLK		0x130b9
+			MX6SLL_PAD_SD2_DATA0__SD2_DATA0		0x170b9
+			MX6SLL_PAD_SD2_DATA1__SD2_DATA1		0x170b9
+			MX6SLL_PAD_SD2_DATA2__SD2_DATA2		0x170b9
+			MX6SLL_PAD_SD2_DATA3__SD2_DATA3		0x170b9
+			MX6SLL_PAD_SD2_DATA4__SD2_DATA4		0x170b9
+			MX6SLL_PAD_SD2_DATA5__SD2_DATA5		0x170b9
+			MX6SLL_PAD_SD2_DATA6__SD2_DATA6		0x170b9
+			MX6SLL_PAD_SD2_DATA7__SD2_DATA7		0x170b9
+			MX6SLL_PAD_GPIO4_IO21__SD2_STROBE	0x4130b9
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2grp_200mhz {
+		fsl,pins = <
+			MX6SLL_PAD_SD2_CMD__SD2_CMD		0x170f9
+			MX6SLL_PAD_SD2_CLK__SD2_CLK		0x130f9
+			MX6SLL_PAD_SD2_DATA0__SD2_DATA0		0x170f9
+			MX6SLL_PAD_SD2_DATA1__SD2_DATA1		0x170f9
+			MX6SLL_PAD_SD2_DATA2__SD2_DATA2		0x170f9
+			MX6SLL_PAD_SD2_DATA3__SD2_DATA3		0x170f9
+			MX6SLL_PAD_SD2_DATA4__SD2_DATA4		0x170f9
+			MX6SLL_PAD_SD2_DATA5__SD2_DATA5		0x170f9
+			MX6SLL_PAD_SD2_DATA6__SD2_DATA6		0x170f9
+			MX6SLL_PAD_SD2_DATA7__SD2_DATA7		0x170f9
+			MX6SLL_PAD_GPIO4_IO21__SD2_STROBE	0x4130f9
+		>;
+	};
+
 	pinctrl_usbotg1: usbotg1grp {
 		fsl,pins = <
 			MX6SLL_PAD_EPDC_PWR_COM__USB_OTG1_ID 0x17059
-- 
2.7.4

