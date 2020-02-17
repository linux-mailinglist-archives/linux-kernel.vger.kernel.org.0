Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFD831610FE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 12:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbgBQLTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 06:19:37 -0500
Received: from inva021.nxp.com ([92.121.34.21]:48748 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729535AbgBQLTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 06:19:34 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 92CBF202B92;
        Mon, 17 Feb 2020 12:19:33 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DBEA1202B9B;
        Mon, 17 Feb 2020 12:19:27 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 3370B402ED;
        Mon, 17 Feb 2020 19:19:21 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V3 RESEND 6/7] ARM: dts: imx6sx-softing-vining-2000: Use new pin names with DCE/DTE for UART pins
Date:   Mon, 17 Feb 2020 19:13:40 +0800
Message-Id: <1581938021-16259-6-git-send-email-Anson.Huang@nxp.com>
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
 arch/arm/boot/dts/imx6sx-softing-vining-2000.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sx-softing-vining-2000.dts b/arch/arm/boot/dts/imx6sx-softing-vining-2000.dts
index 28563f2..61c7e72 100644
--- a/arch/arm/boot/dts/imx6sx-softing-vining-2000.dts
+++ b/arch/arm/boot/dts/imx6sx-softing-vining-2000.dts
@@ -384,15 +384,15 @@
 
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
-			MX6SX_PAD_GPIO1_IO04__UART1_TX		0x1b0b1
-			MX6SX_PAD_GPIO1_IO05__UART1_RX		0x1b0b1
+			MX6SX_PAD_GPIO1_IO04__UART1_DCE_TX	0x1b0b1
+			MX6SX_PAD_GPIO1_IO05__UART1_DCE_RX	0x1b0b1
 		>;
 	};
 
 	pinctrl_uart2: uart2grp {
 		fsl,pins = <
-			MX6SX_PAD_GPIO1_IO06__UART2_TX		0x1b0b1
-			MX6SX_PAD_GPIO1_IO07__UART2_RX		0x1b0b1
+			MX6SX_PAD_GPIO1_IO06__UART2_DCE_TX	0x1b0b1
+			MX6SX_PAD_GPIO1_IO07__UART2_DCE_RX	0x1b0b1
 		>;
 	};
 
-- 
2.7.4

