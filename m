Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E47901610FA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 12:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbgBQLTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 06:19:35 -0500
Received: from inva020.nxp.com ([92.121.34.13]:57090 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729556AbgBQLTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 06:19:34 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 02ED41A2CCC;
        Mon, 17 Feb 2020 12:19:33 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4B4851A1592;
        Mon, 17 Feb 2020 12:19:27 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 364E3402E6;
        Mon, 17 Feb 2020 19:19:20 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V3 RESEND 5/7] ARM: dts: imx6sx-sdb: Use new pin names with DCE/DTE for UART pins
Date:   Mon, 17 Feb 2020 19:13:39 +0800
Message-Id: <1581938021-16259-5-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581938021-16259-1-git-send-email-Anson.Huang@nxp.com>
References: <1581938021-16259-1-git-send-email-Anson.Huang@nxp.com>
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
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
No change.
---
 arch/arm/boot/dts/imx6sx-sdb.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sx-sdb.dtsi b/arch/arm/boot/dts/imx6sx-sdb.dtsi
index f6972de..3e5fb72 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dtsi
+++ b/arch/arm/boot/dts/imx6sx-sdb.dtsi
@@ -564,17 +564,17 @@
 
 		pinctrl_uart1: uart1grp {
 			fsl,pins = <
-				MX6SX_PAD_GPIO1_IO04__UART1_TX		0x1b0b1
-				MX6SX_PAD_GPIO1_IO05__UART1_RX		0x1b0b1
+				MX6SX_PAD_GPIO1_IO04__UART1_DCE_TX	0x1b0b1
+				MX6SX_PAD_GPIO1_IO05__UART1_DCE_RX	0x1b0b1
 			>;
 		};
 
 		pinctrl_uart5: uart5grp {
 			fsl,pins = <
-				MX6SX_PAD_KEY_ROW3__UART5_RX		0x1b0b1
-				MX6SX_PAD_KEY_COL3__UART5_TX		0x1b0b1
-				MX6SX_PAD_KEY_ROW2__UART5_CTS_B		0x1b0b1
-				MX6SX_PAD_KEY_COL2__UART5_RTS_B		0x1b0b1
+				MX6SX_PAD_KEY_ROW3__UART5_DCE_RX	0x1b0b1
+				MX6SX_PAD_KEY_COL3__UART5_DCE_TX	0x1b0b1
+				MX6SX_PAD_KEY_ROW2__UART5_DCE_CTS	0x1b0b1
+				MX6SX_PAD_KEY_COL2__UART5_DCE_RTS	0x1b0b1
 			>;
 		};
 
-- 
2.7.4

