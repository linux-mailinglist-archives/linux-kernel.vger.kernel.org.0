Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA432D614
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 09:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfE2HSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 03:18:54 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46705 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfE2HSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 03:18:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id y11so1003294pfm.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 00:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lfPQaJK4b6PcFs1pATGFmdv3+D6FpEgotdn3n+xpnSo=;
        b=M7RhC9x/89fJXs+K/H6afYRjpW07ij58C9JovMK1gsKLCu1t9dxKU5DYa7Yqb0xHYo
         9jjxyggQhQu2K4o0XpCVy1KbIYXBuX3ortitNmgEczNhBHMLDhczJpiAstGpB3wc0Y7C
         wKe46qsSphda6/YVzrf0hsU6+j0YqHcpKGG/bnpAq2CcXphIdJQoCzQ0CVaLAkghuSDG
         viEMMmtmw0CbtSFBAl7RoXT90gkAviRD1jivPYFkTDT4l2tvR+YwpnImfRmc/Gofw4LI
         e8ZAJEF8wj0BWME5Udk9Gtp5ASduIzyi44FzET6xClsaYvbJgrwbhjNeHK9uStJcQivz
         zNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lfPQaJK4b6PcFs1pATGFmdv3+D6FpEgotdn3n+xpnSo=;
        b=Sz3TOd5phV5URAVJmbd5bohYdlCdO4W59ucy/6zst1QMyrVCnR/n/28ZoFEJ0AtiaL
         x/uDSYw3/YjsULdxBj84gCvp+Pv1PcFJdthslNoaF8ugBF3MXZIzu7RJptfzVno6L+2k
         JyTdq3u+c78zUmYZkub2AaD3zh78JjJQLiyOemi477S9xG36iIXEUBFWP77yDYuyCFi3
         42pQawGqha5AJxc0WaQHdpOGRs6jNkidHMpzAEZ3z7B9rz5HAqbYgqi03JHe0B9jIRlu
         mS/uFihW8ZLgiR9zFMCwGAH9dmElpjNy7gtGotE4OxYf6DB4WHVhR08yw7jcDTJPDZ+d
         P2Qw==
X-Gm-Message-State: APjAAAULjoOScTbBZI4n3oUucICiHmtQYJJ1EI29vRrkbuNWYxdE2BoN
        FNA+jvrm/BuxLXfYlg7ZiXY=
X-Google-Smtp-Source: APXvYqwOkFXvZjxTMa7XfJD9UYwZbQAVrZVJTnhy8paL3sJPyiMYYXu21mQiS9/zRY2lIYCHdhfhtQ==
X-Received: by 2002:a63:2224:: with SMTP id i36mr17923970pgi.70.1559114332873;
        Wed, 29 May 2019 00:18:52 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id y16sm32038938pfo.133.2019.05.29.00.18.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 00:18:52 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ARM: dts: imx6: rdu2: Add node for UCS1002 USB charger chip
Date:   Wed, 29 May 2019 00:18:41 -0700
Message-Id: <20190529071843.24767-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add node for UCS1002 USB charger chip connected to front panel USB and
replace "regulator-fixed" previously used to control VBUS.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---

Changes since [v1]:

    - Added GPIO hog configuration to put UCS1002 into correct mode
      even before its driver takes over. The code for that is taken
      from similar patch from Lucas, so I added his Signed-off-by as
      well.

[v1] lore.kernel.org/r/20190522071227.31488-1-andrew.smirnov@gmail.com

 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 77 +++++++++++++++++++------
 1 file changed, 59 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
index 93be00a60c88..07e21d1e5b4c 100644
--- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
@@ -60,18 +60,6 @@
 		regulator-always-on;
 	};
 
-	reg_5p0v_user_usb: regulator-5p0v-user-usb {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_user_usb>;
-		vin-supply = <&reg_5p0v_main>;
-		regulator-name = "5V_USER_USB";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		gpio = <&gpio3 22 GPIO_ACTIVE_LOW>;
-		startup-delay-us = <1000>;
-	};
-
 	reg_3p3v_pmic: regulator-3p3v-pmic {
 		compatible = "regulator-fixed";
 		vin-supply = <&reg_12p0v>;
@@ -331,6 +319,39 @@
 	};
 };
 
+&gpio3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio3_hog>;
+
+	usb-emulation {
+		gpio-hog;
+		gpios = <19 GPIO_ACTIVE_HIGH>;
+		output-low;
+		line-name = "usb-emulation";
+	};
+
+	usb-mode1 {
+		gpio-hog;
+		gpios = <20 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "usb-mode1";
+	};
+
+	usb-pwr {
+		gpio-hog;
+		gpios = <22 GPIO_ACTIVE_LOW>;
+		output-high;
+		line-name = "usb-pwr-ctrl-en-n";
+	};
+
+	usb-mode2 {
+		gpio-hog;
+		gpios = <23 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "usb-mode2";
+	};
+};
+
 &i2c1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c1>;
@@ -590,6 +611,16 @@
 		status = "disabled";
 	};
 
+	reg_5p0v_user_usb: charger@32 {
+		compatible = "microchip,ucs1002";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ucs1002_pins>;
+		reg = <0x32>;
+		interrupts-extended = <&gpio5 2 IRQ_TYPE_EDGE_BOTH>,
+				      <&gpio3 21 IRQ_TYPE_EDGE_BOTH>;
+		interrupt-names = "a_det", "alert";
+	};
+
 	hpa1: amp@60 {
 		compatible = "ti,tpa6130a2";
 		pinctrl-names = "default";
@@ -935,6 +966,15 @@
 		>;
 	};
 
+	pinctrl_gpio3_hog: gpio3hoggrp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D19__GPIO3_IO19		0x1b0b0
+			MX6QDL_PAD_EIM_D20__GPIO3_IO20		0x1b0b0
+			MX6QDL_PAD_EIM_D22__GPIO3_IO22		0x1b0b0
+			MX6QDL_PAD_EIM_D23__GPIO3_IO23		0x1b0b0
+		>;
+	};
+
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
 			MX6QDL_PAD_CSI0_DAT8__I2C1_SDA		0x4001b8b1
@@ -982,12 +1022,6 @@
 		>;
 	};
 
-	pinctrl_reg_user_usb: usbotggrp {
-		fsl,pins = <
-			MX6QDL_PAD_EIM_D22__GPIO3_IO22		0x40000038
-		>;
-	};
-
 	pinctrl_rmii_phy_irq: phygrp {
 		fsl,pins = <
 			MX6QDL_PAD_EIM_D30__GPIO3_IO30		0x40010000
@@ -1047,6 +1081,13 @@
 		>;
 	};
 
+	pinctrl_ucs1002_pins: ucs1002grp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_A25__GPIO5_IO02  	0x1b0b0
+			MX6QDL_PAD_EIM_D21__GPIO3_IO21  	0x1b0b0
+		>;
+	};
+
 	pinctrl_usdhc2: usdhc2grp {
 		fsl,pins = <
 			MX6QDL_PAD_SD2_CMD__SD2_CMD		0x10059
-- 
2.21.0

