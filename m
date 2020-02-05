Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27B881532E5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 15:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgBEOa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 09:30:56 -0500
Received: from comms.puri.sm ([159.203.221.185]:48784 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbgBEOaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 09:30:55 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id AC3C0E0306;
        Wed,  5 Feb 2020 06:30:54 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3OcR6_nSxRbw; Wed,  5 Feb 2020 06:30:54 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, Anson.Huang@nxp.com, devicetree@vger.kernel.org,
        kernel@puri.sm, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH v1 01/12] arm64: dts: librem5-devkit: add sai2 and sai6 pinctrl definitions
Date:   Wed,  5 Feb 2020 15:29:52 +0100
Message-Id: <20200205143003.28408-2-martin.kepplinger@puri.sm>
In-Reply-To: <20200205143003.28408-1-martin.kepplinger@puri.sm>
References: <20200205143003.28408-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Angus Ainslie (Purism)" <angus@akkea.ca>

Add missing sai2 and sai6 audio interface pinctrl definitions for the
Librem 5 devkit.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 .../dts/freescale/imx8mq-librem5-devkit.dts   | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
index 764a4cb4e125..9702db69d3ed 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -555,6 +555,25 @@
 		>;
 	};
 
+	pinctrl_sai2: sai2grp {
+		fsl,pins = <
+		MX8MQ_IOMUXC_SAI2_TXFS_SAI2_TX_SYNC	0xd6
+		MX8MQ_IOMUXC_SAI2_TXC_SAI2_TX_BCLK	0xd6
+		MX8MQ_IOMUXC_SAI2_TXD0_SAI2_TX_DATA0	0xd6
+		MX8MQ_IOMUXC_SAI2_RXD0_SAI2_RX_DATA0	0xd6
+		MX8MQ_IOMUXC_SAI2_MCLK_SAI2_MCLK	0xd6
+		>;
+	};
+
+	pinctrl_sai6: sai6grp {
+		fsl,pins = <
+		MX8MQ_IOMUXC_SAI1_RXD5_SAI6_RX_DATA0	0xd6
+		MX8MQ_IOMUXC_SAI1_RXD6_SAI6_RX_SYNC	0xd6
+		MX8MQ_IOMUXC_SAI1_TXD4_SAI6_RX_BCLK     0xd6
+		MX8MQ_IOMUXC_SAI1_TXD5_SAI6_TX_DATA0	0xd6
+		>;
+	};
+
 	pinctrl_typec: typecgrp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_NAND_DATA06_GPIO3_IO12		0x16
-- 
2.20.1

