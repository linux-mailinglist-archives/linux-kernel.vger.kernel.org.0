Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C22CB1622AE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 09:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgBRIuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 03:50:51 -0500
Received: from comms.puri.sm ([159.203.221.185]:39802 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbgBRIut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 03:50:49 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 395A9E1137;
        Tue, 18 Feb 2020 00:50:49 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 45fr4mrVkOY8; Tue, 18 Feb 2020 00:50:48 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de
Cc:     linux-imx@nxp.com, Anson.Huang@nxp.com, devicetree@vger.kernel.org,
        kernel@puri.sm, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v2 4/9] arm64: dts: librem5-devkit: allow modem to wake the system from suspend
Date:   Tue, 18 Feb 2020 09:49:37 +0100
Message-Id: <20200218084942.4884-5-martin.kepplinger@puri.sm>
In-Reply-To: <20200218084942.4884-1-martin.kepplinger@puri.sm>
References: <20200218084942.4884-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Angus Ainslie (Purism)" <angus@akkea.ca>

Connect the WoWWAN signal to a gpio key to wake up the system from suspend.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 .../arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
index ec12477d925d..9c81b07f43f3 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -55,6 +55,15 @@
 			wakeup-source;
 			linux,code = <KEY_HP>;
 		};
+
+		wwan_wake {
+			label = "WWAN_WAKE";
+			gpios = <&gpio3 8 GPIO_ACTIVE_LOW>;
+			interrupt-parent = <&gpio3>;
+			interrupts = <8 GPIO_ACTIVE_LOW>;
+			wakeup-source;
+			linux,code = <KEY_PHONE>;
+		};
 	};
 
 	leds {
@@ -574,6 +583,7 @@
 			MX8MQ_IOMUXC_SAI2_RXFS_GPIO4_IO21	0x16
 			MX8MQ_IOMUXC_SAI2_RXC_GPIO4_IO22	0x16
 			MX8MQ_IOMUXC_SAI5_RXC_GPIO3_IO20	0x180  /* HP_DET */
+			MX8MQ_IOMUXC_NAND_DATA02_GPIO3_IO8	0x80   /* nWoWWAN */
 		>;
 	};
 
-- 
2.20.1

