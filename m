Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55941E4F2C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 16:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438690AbfJYOdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 10:33:12 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43121 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbfJYOdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 10:33:11 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so2578566wrr.10;
        Fri, 25 Oct 2019 07:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KGiMJW/6P3cnUhB4JrbHZgX1QIfc96w6Xat8RH1XNVg=;
        b=alucOV4vUEvggzS1eI0kxbI5TkYw4knLudcurVGQ8/dRND3z8Tout0msr6rYuE0ceu
         1xmkWOVyE8QtcW2f/OETC2x3tbjlgY1g1L1xT/HImJdkbu+gIC7c9rRMaCeVKekow55Q
         4VtCdbCtAmYJTqEiUrOoct1dCxxz3gmZz7Na0pkjzgGdKzaMER57KZNUE5TxZzY/s0XU
         QqBZlGyLHbnh0mTr81ZNZFq1oRUWGKEmv5nEDg7P3qg3hovrstMDvWDjQDTK8Ly8VDLV
         F8Fdp5yetecGE+2kPM9x0NM75l/bxD3nk7v8g+8kzX6CKvvGZYgab4ci8pCph/1ZK16B
         0TMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KGiMJW/6P3cnUhB4JrbHZgX1QIfc96w6Xat8RH1XNVg=;
        b=uU8uqy3mJ09ZKIBPAIh2GyT9Zj8qMLfc3ASz/t3b5eDRWhjKm0T9lfgK6kg1DKhUKr
         r3DNZB2bine9X9aeol4KTLOSsEKqqyh2UNdH/AGoSmCKWYZzzhLmsFA4+LHaOyhtQBgK
         7CpKkB7FRULHlKQeglH8+EPpPesgr96Alig9fii2qAP4Q02AofPvxeGeQwX4h6LXioMV
         zmlLMoOrENKLMkglrAf0UTZZJSsTW1bhz2jOlIJ+FRMeDKoUJDqcV3gvaKiMtUk/Wahj
         G2/mjK4fWuVhZiyqOY1RAvbcP0eO/9RAqFx/olGXKFPpdU0rVPk3v/ekQRzVCvqaWRXd
         1Xcw==
X-Gm-Message-State: APjAAAXZXMyz6WYdGjVPTGfgnRSMRnT5e4G5OvHju+wPdvFpv1mLdxFK
        fCU9/kE88Ru38c65grHxIWU=
X-Google-Smtp-Source: APXvYqwdNmnPoI1aDfrbDo5svOKCrwjtWB42cBkCY42Ea0zNfgJYgtDPiVT+rOg6CHerph2EIfQpbQ==
X-Received: by 2002:a5d:4f91:: with SMTP id d17mr3423123wru.184.1572013989370;
        Fri, 25 Oct 2019 07:33:09 -0700 (PDT)
Received: from furher.auvence.co ([92.103.174.138])
        by smtp.gmail.com with ESMTPSA id h17sm2079971wmb.33.2019.10.25.07.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 07:33:08 -0700 (PDT)
From:   Joris Offouga <offougajoris@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Fabio Estevam <festevam@gmail.com>,
        Otavio Salvador <otavio@ossystems.com.br>,
        Joris Offouga <offougajoris@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V2] ARM: dts: imx7d-pico: Add LCD support
Date:   Fri, 25 Oct 2019 16:32:58 +0200
Message-Id: <20191025143258.27757-1-offougajoris@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <festevam@gmail.com>

Add support for the VXT VL050-8048NT-C01 panel connected through
the 24 bit parallel LCDIF interface.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
Signed-off-by: Joris Offouga <offougajoris@gmail.com>
---
 Changes v1 -> v2
 	change "From:" Joris Offouga to Fabio Estevam
	set Joris Offouga signed-off to the last one

 arch/arm/boot/dts/imx7d-pico.dtsi | 83 +++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-pico.dtsi b/arch/arm/boot/dts/imx7d-pico.dtsi
index 6f50ebf31a0a..6814d4288e2e 100644
--- a/arch/arm/boot/dts/imx7d-pico.dtsi
+++ b/arch/arm/boot/dts/imx7d-pico.dtsi
@@ -69,6 +69,37 @@
 		clocks = <&clks IMX7D_CLKO2_ROOT_DIV>;
 		clock-names = "ext_clock";
 	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_backlight>;
+		pwms = <&pwm4 0 50000 0>;
+		brightness-levels = <0 36 72 108 144 180 216 255>;
+		default-brightness-level = <6>;
+		status = "okay";
+	};
+
+	reg_lcd_3v3: regulator-lcd-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "lcd-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio1 6 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	panel {
+		compatible = "vxt,vl050-8048nt-c01";
+		backlight = <&backlight>;
+		power-supply = <&reg_lcd_3v3>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&display_out>;
+			};
+		};
+	};
 };
 
 &clks {
@@ -230,6 +261,18 @@
 	};
 };
 
+&lcdif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lcdif>;
+	status = "okay";
+
+	port {
+		display_out: endpoint {
+			remote-endpoint = <&panel_in>;
+		};
+	};
+};
+
 &sai1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sai1>;
@@ -349,6 +392,12 @@
 };
 
 &iomuxc {
+	pinctrl_backlight: backlight {
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO11__PWM4_OUT		0x0
+		>;
+	};
+
 	pinctrl_ecspi3: ecspi3grp {
 		fsl,pins = <
 			MX7D_PAD_I2C1_SCL__ECSPI3_MISO		0x2
@@ -413,6 +462,40 @@
 		>;
 	};
 
+	pinctrl_lcdif: lcdifgrp {
+		fsl,pins = <
+			MX7D_PAD_LCD_DATA00__LCD_DATA0		0x79
+			MX7D_PAD_LCD_DATA01__LCD_DATA1		0x79
+			MX7D_PAD_LCD_DATA02__LCD_DATA2		0x79
+			MX7D_PAD_LCD_DATA03__LCD_DATA3		0x79
+			MX7D_PAD_LCD_DATA04__LCD_DATA4		0x79
+			MX7D_PAD_LCD_DATA05__LCD_DATA5		0x79
+			MX7D_PAD_LCD_DATA06__LCD_DATA6		0x79
+			MX7D_PAD_LCD_DATA07__LCD_DATA7		0x79
+			MX7D_PAD_LCD_DATA08__LCD_DATA8		0x79
+			MX7D_PAD_LCD_DATA09__LCD_DATA9		0x79
+			MX7D_PAD_LCD_DATA10__LCD_DATA10		0x79
+			MX7D_PAD_LCD_DATA11__LCD_DATA11		0x79
+			MX7D_PAD_LCD_DATA12__LCD_DATA12		0x79
+			MX7D_PAD_LCD_DATA13__LCD_DATA13		0x79
+			MX7D_PAD_LCD_DATA14__LCD_DATA14		0x79
+			MX7D_PAD_LCD_DATA15__LCD_DATA15		0x79
+			MX7D_PAD_LCD_DATA16__LCD_DATA16		0x79
+			MX7D_PAD_LCD_DATA17__LCD_DATA17		0x79
+			MX7D_PAD_LCD_DATA18__LCD_DATA18		0x79
+			MX7D_PAD_LCD_DATA19__LCD_DATA19		0x79
+			MX7D_PAD_LCD_DATA20__LCD_DATA20		0x79
+			MX7D_PAD_LCD_DATA21__LCD_DATA21		0x79
+			MX7D_PAD_LCD_DATA22__LCD_DATA22		0x79
+			MX7D_PAD_LCD_DATA23__LCD_DATA23		0x79
+			MX7D_PAD_LCD_CLK__LCD_CLK		0x79
+			MX7D_PAD_LCD_ENABLE__LCD_ENABLE		0x78
+			MX7D_PAD_LCD_VSYNC__LCD_VSYNC		0x78
+			MX7D_PAD_LCD_HSYNC__LCD_HSYNC		0x78
+			MX7D_PAD_LCD_RESET__GPIO3_IO4		0x14
+		>;
+	};
+
 	pinctrl_pwm1: pwm1 {
 		fsl,pins = <
 			MX7D_PAD_GPIO1_IO08__PWM1_OUT   0x7f
-- 
2.17.1

