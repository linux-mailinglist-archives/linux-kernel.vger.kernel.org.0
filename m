Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9735F17407D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 20:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgB1TqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 14:46:17 -0500
Received: from lists.gateworks.com ([108.161.130.12]:55899 "EHLO
        lists.gateworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB1TqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 14:46:17 -0500
Received: from 68-189-91-139.static.snlo.ca.charter.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by lists.gateworks.com with esmtp (Exim 4.82)
        (envelope-from <tharvey@gateworks.com>)
        id 1j7lbO-0005Rf-VP; Fri, 28 Feb 2020 19:47:15 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] ARM: dts: imx6qdl-gw5910: add CC1352 UART
Date:   Fri, 28 Feb 2020 11:46:07 -0800
Message-Id: <1582919167-28690-1-git-send-email-tharvey@gateworks.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GW5910-C revision adds a TI CC1352 connected to IMX UART4

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/boot/dts/imx6qdl-gw5910.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-gw5910.dtsi b/arch/arm/boot/dts/imx6qdl-gw5910.dtsi
index be1af74..30fe47f 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5910.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5910.dtsi
@@ -220,6 +220,14 @@
 	status = "okay";
 };
 
+/* cc1352 */
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
 /* Sterling-LWB Bluetooth */
 &uart4 {
 	pinctrl-names = "default";
@@ -411,6 +419,23 @@
 		>;
 	};
 
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D24__UART3_TX_DATA	0x1b0b1
+			MX6QDL_PAD_EIM_D25__UART3_RX_DATA	0x1b0b1
+			MX6QDL_PAD_EIM_D23__UART3_RTS_B		0x1b0b1
+			MX6QDL_PAD_EIM_D31__UART3_CTS_B		0x1b0b1
+			MX6QDL_PAD_EIM_A25__GPIO5_IO02		0x4001b0b1 /* DIO20 */
+			MX6QDL_PAD_DISP0_DAT11__GPIO5_IO05	0x4001b0b1 /* DIO14 */
+			MX6QDL_PAD_DISP0_DAT12__GPIO5_IO06	0x4001b0b1 /* DIO15 */
+			MX6QDL_PAD_DISP0_DAT14__GPIO5_IO08	0x1b0b1 /* TMS */
+			MX6QDL_PAD_DISP0_DAT15__GPIO5_IO09	0x1b0b1 /* TCK */
+			MX6QDL_PAD_DISP0_DAT16__GPIO5_IO10	0x1b0b1 /* TDO */
+			MX6QDL_PAD_DISP0_DAT17__GPIO5_IO11	0x1b0b1 /* TDI */
+			MX6QDL_PAD_DISP0_DAT23__GPIO5_IO17	0x4001b0b1 /* RST# */
+		>;
+	};
+
 	pinctrl_uart4: uart4grp {
 		fsl,pins = <
 			MX6QDL_PAD_CSI0_DAT12__UART4_TX_DATA	0x1b0b1
-- 
2.7.4

