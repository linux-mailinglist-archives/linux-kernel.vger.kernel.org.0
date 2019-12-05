Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89350114890
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 22:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730060AbfLEVQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 16:16:07 -0500
Received: from 68-189-91-139.static.snlo.ca.charter.com ([68.189.91.139]:54726
        "EHLO rjones.pdc.gateworks.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729799AbfLEVQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 16:16:07 -0500
X-Greylist: delayed 454 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Dec 2019 16:16:06 EST
Received: by rjones.pdc.gateworks.com (Postfix, from userid 1002)
        id E78791A4350C; Thu,  5 Dec 2019 13:10:49 -0800 (PST)
From:   Robert Jones <rjones@gateworks.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Tim Harvey <tharvey@gateworks.com>,
        Robert Jones <rjones@gateworks.com>
Subject: [PATCH] ARM: dts: imx: ventana: add fxos8700 on gateworks boards
Date:   Thu,  5 Dec 2019 13:10:48 -0800
Message-Id: <20191205211048.21278-1-rjones@gateworks.com>
X-Mailer: git-send-email 2.9.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add fxos8700 iio imu entries for Gateworks ventana SBCs.

Signed-off-by: Robert Jones <rjones@gateworks.com>
---
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi | 5 +++++
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi | 5 +++++
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi | 5 +++++
 3 files changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index 1a9a9d9..2d7d01e 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -313,6 +313,11 @@
 		interrupts = <12 2>;
 		wakeup-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
 	};
+
+	fxos8700@1e {
+		compatible = "nxp,fxos8700";
+		reg = <0x1e>;
+	};
 };
 
 &ldb {
diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
index 54b2bea..bf1a2c6 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -304,6 +304,11 @@
 		interrupts = <11 2>;
 		wakeup-gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
 	};
+
+	fxos8700@1e {
+		compatible = "nxp,fxos8700";
+		reg = <0x1e>;
+	};
 };
 
 &ldb {
diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index 1b6c133..d9e09a9 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -361,6 +361,11 @@
 		interrupts = <12 2>;
 		wakeup-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
 	};
+
+	fxos8700@1e {
+		compatible = "nxp,fxos8700";
+		reg = <0x1e>;
+	};
 };
 
 &ldb {
-- 
2.9.2

