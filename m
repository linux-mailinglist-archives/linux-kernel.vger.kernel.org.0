Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC432DD546
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2019 01:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732292AbfJRXUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 19:20:53 -0400
Received: from 68-189-91-139.static.snlo.ca.charter.com ([68.189.91.139]:46842
        "EHLO rjones.pdc.gateworks.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729068AbfJRXUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 19:20:53 -0400
Received: by rjones.pdc.gateworks.com (Postfix, from userid 1002)
        id 0A7141A434C2; Fri, 18 Oct 2019 16:20:51 -0700 (PDT)
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
        Robert Jones <rjones@gateworks.com>
Subject: [PATCH] ARM: dt: add fxos8700 on gateworks boards
Date:   Fri, 18 Oct 2019 16:20:49 -0700
Message-Id: <20191018232049.4045-1-rjones@gateworks.com>
X-Mailer: git-send-email 2.9.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add fxos8700 iio imu entries for Gateworks SBCs.

Signed-off-by: Robert Jones <rjones@gateworks.com>
---
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi | 5 +++++
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi | 5 +++++
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi | 5 +++++
 3 files changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index 1a9a9d9..ffc4449 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -306,6 +306,11 @@
 		VDDIO-supply = <&reg_3p3v>;
 	};
 
+	fxos8700@1e {
+		compatible = "nxp,fxos8700";
+		reg = <0x1e>;
+	};
+
 	touchscreen: egalax_ts@4 {
 		compatible = "eeti,egalax_ts";
 		reg = <0x04>;
diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
index 54b2bea..ebbd1c8 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -297,6 +297,11 @@
 		VDDIO-supply = <&reg_3p3v>;
 	};
 
+	fxos8700@1e {
+		compatible = "nxp,fxos8700";
+		reg = <0x1e>;
+	};
+
 	touchscreen: egalax_ts@4 {
 		compatible = "eeti,egalax_ts";
 		reg = <0x04>;
diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index 1b6c133..67d4725 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -354,6 +354,11 @@
 		VDDIO-supply = <&reg_3p3v>;
 	};
 
+	fxos8700@1e {
+		compatible = "nxp,fxos8700";
+		reg = <0x1e>;
+	};
+
 	touchscreen: egalax_ts@4 {
 		compatible = "eeti,egalax_ts";
 		reg = <0x04>;
-- 
2.9.2

