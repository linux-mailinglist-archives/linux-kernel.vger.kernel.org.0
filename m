Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D43666F4D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2019 14:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfGLMzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jul 2019 08:55:32 -0400
Received: from mail.savoirfairelinux.com ([208.88.110.44]:37914 "EHLO
        mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfGLMzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:55:32 -0400
X-Greylist: delayed 597 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jul 2019 08:55:31 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.savoirfairelinux.com (Postfix) with ESMTP id 04D2B9C01BD;
        Fri, 12 Jul 2019 08:45:33 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
        by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 1UOPf-CcN0wq; Fri, 12 Jul 2019 08:45:32 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.savoirfairelinux.com (Postfix) with ESMTP id 5A6009C019E;
        Fri, 12 Jul 2019 08:45:32 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
        by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 895H-f0LM7Ys; Fri, 12 Jul 2019 08:45:32 -0400 (EDT)
Received: from localhost.localdomain (lfbn-1-1474-163.w86-253.abo.wanadoo.fr [86.253.99.163])
        by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 0EA2F9C01BD;
        Fri, 12 Jul 2019 08:45:30 -0400 (EDT)
From:   Gilles DOFFE <gilles.doffe@savoirfairelinux.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     linux-imx@nxp.com, festevam@gmail.com, kernel@pengutronix.de,
        s.hauer@pengutronix.de, shawnguo@kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org
Subject: [PATCH] arm: dts: imx6qdl: add gpio expander pca9535
Date:   Fri, 12 Jul 2019 14:45:22 +0200
Message-Id: <20190712124522.571-1-gilles.doffe@savoirfairelinux.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pca9535 gpio expander is present on the Rex baseboard, but missing
from the dtsi.

Add the new gpio controller and the associated interrupt line
MX6QDL_PAD_NANDF_CS3__GPIO6_IO16.

Signed-off-by: Gilles DOFFE <gilles.doffe@savoirfairelinux.com>
---
 arch/arm/boot/dts/imx6qdl-rex.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-rex.dtsi b/arch/arm/boot/dts/imx6q=
dl-rex.dtsi
index 97f1659144ea..d5324c6761c1 100644
--- a/arch/arm/boot/dts/imx6qdl-rex.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-rex.dtsi
@@ -136,6 +136,19 @@
 		compatible =3D "atmel,24c02";
 		reg =3D <0x57>;
 	};
+
+	gpio8: pca9535@27 {
+		compatible =3D "nxp,pca9535";
+		reg =3D <0x27>;
+		gpio-controller;
+		#gpio-cells =3D <2>;
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_pca9535>;
+		interrupt-parent =3D <&gpio6>;
+		interrupts =3D <16 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+		#interrupt-cells =3D <2>;
+	};
 };
=20
 &i2c3 {
@@ -237,6 +250,12 @@
 			>;
 		};
=20
+		pinctrl_pca9535: pca9535 {
+			fsl,pins =3D <
+				MX6QDL_PAD_NANDF_CS3__GPIO6_IO16	0x00017059
+		   >;
+		};
+
 		pinctrl_uart1: uart1grp {
 			fsl,pins =3D <
 				MX6QDL_PAD_CSI0_DAT10__UART1_TX_DATA	0x1b0b1
--=20
2.19.1

