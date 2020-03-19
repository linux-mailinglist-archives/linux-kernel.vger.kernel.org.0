Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 369BE18AC82
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 06:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbgCSF50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 01:57:26 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36731 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgCSF50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 01:57:26 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jEoAh-0000e1-EN; Thu, 19 Mar 2020 06:56:47 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jEoAZ-0001zw-VI; Thu, 19 Mar 2020 06:56:39 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        David Jander <david@protonic.nl>, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v2 5/5] ARM: dts: add Protonic RVT board
Date:   Thu, 19 Mar 2020 06:56:36 +0100
Message-Id: <20200319055636.7573-6-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200319055636.7573-1-o.rempel@pengutronix.de>
References: <20200319055636.7573-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Protonic RVT is an internal development platform for a wireless ISObus
Virtual Terminal based on COTS tablets, and the predecessor of the WD2
platform.

Signed-off-by: David Jander <david@protonic.nl>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 .../devicetree/bindings/arm/fsl.yaml          |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/imx6dl-prtrvt.dts           | 108 ++++++++++++++++++
 3 files changed, 110 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-prtrvt.dts

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 424be1edf005..2e8a03ef5c95 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -168,6 +168,7 @@ properties:
               - emtrion,emcon-mx6-avari   # emCON-MX6S or emCON-MX6DL SoM on Avari Base
               - fsl,imx6dl-sabreauto      # i.MX6 DualLite/Solo SABRE Automotive Board
               - fsl,imx6dl-sabresd        # i.MX6 DualLite SABRE Smart Device Board
+              - prt,prtrvt                # Protonic RVT board
               - prt,prtvt7                # Protonic VT7 board
               - technologic,imx6dl-ts4900
               - technologic,imx6dl-ts7970
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e53abe1de259..afaccc9bc645 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -446,6 +446,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6dl-nitrogen6x.dtb \
 	imx6dl-phytec-mira-rdk-nand.dtb \
 	imx6dl-phytec-pbab01.dtb \
+	imx6dl-prtrvt.dtb \
 	imx6dl-prtvt7.dtb \
 	imx6dl-rex-basic.dtb \
 	imx6dl-riotboard.dtb \
diff --git a/arch/arm/boot/dts/imx6dl-prtrvt.dts b/arch/arm/boot/dts/imx6dl-prtrvt.dts
new file mode 100644
index 000000000000..fddc91b5a113
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-prtrvt.dts
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) 2014 Protonic Holland
+ */
+
+/dts-v1/;
+#include "imx6dl.dtsi"
+#include "imx6qdl-prti6q.dtsi"
+
+/ {
+	model = "Protonic RVT board";
+	compatible = "prt,prtrvt", "fsl,imx6dl";
+
+	memory@10000000 {
+		device_type = "memory";
+		reg = <0x10000000 0x10000000>;
+	};
+};
+
+&iomuxc {
+	prti6q {
+		pinctrl_hog: hoggrp {
+			fsl,pins = <
+				/* SGTL5000 sys_mclk */
+				MX6QDL_PAD_CSI0_MCLK__CCM_CLKO1	0x030b0
+				/* CAN1_SR + CAN2_SR GPIO outputs */
+				MX6QDL_PAD_KEY_COL3__GPIO4_IO12	0x13070
+				MX6QDL_PAD_KEY_ROW3__GPIO4_IO13	0x13070
+
+				/* CAN1_TERM */
+				MX6QDL_PAD_GPIO_0__GPIO1_IO00	0x1b0b0
+				/* ITU656_nRESET */
+				MX6QDL_PAD_GPIO_2__GPIO1_IO02	0x1b0b0
+
+				/* HW revision detect */
+				/* REV_ID0 */
+				MX6QDL_PAD_SD4_DAT0__GPIO2_IO08 0x1b0b0
+				/* REV_ID1 */
+				MX6QDL_PAD_SD4_DAT1__GPIO2_IO09 0x1b0b0
+				/* REV_ID2 */
+				MX6QDL_PAD_SD4_DAT2__GPIO2_IO10 0x1b0b0
+				/* REV_ID3 */
+				MX6QDL_PAD_SD4_DAT3__GPIO2_IO11 0x1b0b0
+				/* REV_ID4 */
+				MX6QDL_PAD_SD4_DAT4__GPIO2_IO12 0x1b0b0
+			>;
+		};
+
+		pinctrl_leds: ledsgrp {
+			fsl,pins = <
+				/* DEBUG0 */
+				MX6QDL_PAD_GPIO_8__GPIO1_IO08	0x1b0b0
+			>;
+		};
+
+		pinctrl_usbotg: usbotggrp {
+			fsl,pins = <
+				/* Not connected */
+				MX6QDL_PAD_EIM_D21__USB_OTG_OC	0x1b0b0
+				/* power enable, high active */
+				MX6QDL_PAD_EIM_D22__GPIO3_IO22  0x1b0b0
+			>;
+		};
+	};
+};
+
+&i2c3 {
+	rtc: pcf8563@51 {
+		compatible = "nxp,pcf8563";
+		reg = <0x51>;
+	};
+};
+
+&pwm1 {
+	status = "disabled";
+};
+
+&ssi1 {
+	status = "disabled";
+};
+
+&uart2 {
+	status = "disabled";
+};
+
+&uart5 {
+	status = "disabled";
+};
+
+&usbh1 {
+	status = "disabled";
+};
+
+&can2 {
+	status = "disabled";
+};
+
+&vpu {
+	status = "disabled";
+};
+
+&audmux {
+	status = "disabled";
+};
+
+&ipu1 {
+	status = "disabled";
+};
-- 
2.25.1

