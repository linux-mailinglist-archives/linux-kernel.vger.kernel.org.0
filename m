Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1981D160ED7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 10:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgBQJhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 04:37:21 -0500
Received: from inva020.nxp.com ([92.121.34.13]:51748 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728833AbgBQJhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 04:37:20 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 69E571A2B0F;
        Mon, 17 Feb 2020 10:37:19 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B1BC51A2B29;
        Mon, 17 Feb 2020 10:37:13 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id A842D4031F;
        Mon, 17 Feb 2020 17:37:06 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V3 7/7] ARM: dts: imx6sx-udoo-neo: Use new pin names with DCE/DTE for UART pins
Date:   Mon, 17 Feb 2020 17:31:26 +0800
Message-Id: <1581931886-12173-7-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581931886-12173-1-git-send-email-Anson.Huang@nxp.com>
References: <1581931886-12173-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new pin names containing DCE/DTE for UART RX/TX/RTS/CTS pins, this
is to distinguish the DCE/DTE functions.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Uwe Kleine-K枚nig <u.kleine-koenig@pengutronix.de>
---
No change.
---
 arch/arm/boot/dts/imx6sx-udoo-neo.dtsi | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi b/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
index 25d4aa9..ee64565 100644
--- a/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
+++ b/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
@@ -235,28 +235,28 @@
 
 	pinctrl_uart1: uart1grp {
 		fsl,pins =
-			<MX6SX_PAD_GPIO1_IO04__UART1_TX		0x1b0b1>,
-			<MX6SX_PAD_GPIO1_IO05__UART1_RX		0x1b0b1>;
+			<MX6SX_PAD_GPIO1_IO04__UART1_DCE_TX	0x1b0b1>,
+			<MX6SX_PAD_GPIO1_IO05__UART1_DCE_RX	0x1b0b1>;
 	};
 
 	pinctrl_uart2: uart2grp {
 		fsl,pins =
-			<MX6SX_PAD_GPIO1_IO06__UART2_TX		0x1b0b1>,
-			<MX6SX_PAD_GPIO1_IO07__UART2_RX		0x1b0b1>;
+			<MX6SX_PAD_GPIO1_IO06__UART2_DCE_TX	0x1b0b1>,
+			<MX6SX_PAD_GPIO1_IO07__UART2_DCE_RX	0x1b0b1>;
 	};
 
 	pinctrl_uart3: uart3grp {
 		fsl,pins =
-			<MX6SX_PAD_SD3_DATA4__UART3_RX          0x13059>,
-			<MX6SX_PAD_SD3_DATA5__UART3_TX          0x13059>,
-			<MX6SX_PAD_SD3_DATA6__UART3_RTS_B       0x13059>,
-			<MX6SX_PAD_SD3_DATA7__UART3_CTS_B       0x13059>;
+			<MX6SX_PAD_SD3_DATA4__UART3_DCE_RX	0x13059>,
+			<MX6SX_PAD_SD3_DATA5__UART3_DCE_TX	0x13059>,
+			<MX6SX_PAD_SD3_DATA6__UART3_DCE_RTS	0x13059>,
+			<MX6SX_PAD_SD3_DATA7__UART3_DCE_CTS	0x13059>;
 	};
 
 	pinctrl_uart5: uart5grp {
 		fsl,pins =
-			<MX6SX_PAD_SD4_DATA4__UART5_RX		0x1b0b1>,
-			<MX6SX_PAD_SD4_DATA5__UART5_TX		0x1b0b1>;
+			<MX6SX_PAD_SD4_DATA4__UART5_DCE_RX	0x1b0b1>,
+			<MX6SX_PAD_SD4_DATA5__UART5_DCE_TX	0x1b0b1>;
 	};
 
 	pinctrl_uart6: uart6grp {
@@ -265,10 +265,10 @@
 			<MX6SX_PAD_CSI_DATA01__UART6_DSR_B	0x1b0b1>,
 			<MX6SX_PAD_CSI_DATA02__UART6_DTR_B	0x1b0b1>,
 			<MX6SX_PAD_CSI_DATA03__UART6_DCD_B	0x1b0b1>,
-			<MX6SX_PAD_CSI_DATA04__UART6_RX		0x1b0b1>,
-			<MX6SX_PAD_CSI_DATA05__UART6_TX		0x1b0b1>,
-			<MX6SX_PAD_CSI_DATA06__UART6_RTS_B	0x1b0b1>,
-			<MX6SX_PAD_CSI_DATA07__UART6_CTS_B	0x1b0b1>;
+			<MX6SX_PAD_CSI_DATA04__UART6_DCE_RX	0x1b0b1>,
+			<MX6SX_PAD_CSI_DATA05__UART6_DCE_TX	0x1b0b1>,
+			<MX6SX_PAD_CSI_DATA06__UART6_DCE_RTS	0x1b0b1>,
+			<MX6SX_PAD_CSI_DATA07__UART6_DCE_CTS	0x1b0b1>;
 	};
 
 	pinctrl_otg1_reg: otg1grp {
-- 
2.7.4

