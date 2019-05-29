Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFEEF2DB37
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 12:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfE2K5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 06:57:19 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44773 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbfE2K5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 06:57:17 -0400
Received: by mail-pl1-f195.google.com with SMTP id c5so898549pll.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 03:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6DwmkLGpJZpkcPw0XMVVDkf1y0K009QPRSW8hUfXBRY=;
        b=VFu9w0hD1Ourpd8eMMh8PYNciyswgOS1KtrgHUdk0KAmbBdup7r3OzJtKsKMtdN0BH
         5AS3DuAId2PTW+ttuh2IAHVuA7mZ2XxF6MgB1mm9oABWptM+8bobX3Dwxul01VlpKDoS
         gSnWhBuTO1Skk4JqIA12yvsaam3Xpv9pnZMN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6DwmkLGpJZpkcPw0XMVVDkf1y0K009QPRSW8hUfXBRY=;
        b=XI9pEwsuZtp0EqoBIDj2st1XRTG+le8vIZNF/bDdFXcs4yOcrEQ8AsCWdmKJJtBcQs
         KJhZ0EZvXeMx4P79GItG9Y4LJB6tccL/DXzeZr6MH2r7W+bdKVWssjGGnn/3TAWfEopf
         DttddjjtpgMhFEqfC/WryM7QP/lsL01bsFb5lw75fDFw3Zc1nuUZ5JdE0OpFGNjWXuql
         BfgrNITNzk3mcmZvAXS4BpDkKv9TEWM6X+ITvdb7WyGneoIcfaqdh0cK43qViJDV3yDy
         WKWv/3FDhNbXfI5rul2wc4pnSJ9rwdJnIY8v5OC1LtPhp4Jp1g2zS76MiXo1R//ZjH9y
         jCQg==
X-Gm-Message-State: APjAAAXCBmbsFIZW/DiqCbNvX5pDNAvfYiK/t+VB2Pu5qFQzUdN7KOcE
        YU9iLHuuHub6yJc1hhNqy+tJwA==
X-Google-Smtp-Source: APXvYqwygLxq0inFrDqP1GBEA4oJIXO+O1N08+R0LPi1oqe2Amq7V89w6a/dgny0hRfvq1CVA26PnA==
X-Received: by 2002:a17:902:20eb:: with SMTP id v40mr15879742plg.239.1559127437024;
        Wed, 29 May 2019 03:57:17 -0700 (PDT)
Received: from localhost.localdomain ([49.206.202.218])
        by smtp.gmail.com with ESMTPSA id 184sm18974479pfa.48.2019.05.29.03.57.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 03:57:16 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-amarula@amarulasolutions.com,
        Sergey Suloev <ssuloev@orpaltech.com>,
        Ryan Pannell <ryan@osukl.com>, bshah@mykolab.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [DO NOT MERGE] [PATCH v9 8/9] arm64: dts: allwinner: a64-pine64-lts: Enable Feiyang FY07024DI26A30-D DSI panel
Date:   Wed, 29 May 2019 16:26:14 +0530
Message-Id: <20190529105615.14027-9-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190529105615.14027-1-jagan@amarulasolutions.com>
References: <20190529105615.14027-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Feiyang FY07024DI26A30-D MIPI_DSI panel is desiged to attach with
DSI connector on pine64 boards, enable the same for pine64 LTS.

DSI panel connected via board DSI port with,
- DLDO1 as VCC-DSI supply
- DC1SW as AVDD supply
- DLDO2 as DVDD supply
- PD24 gpio for reset pin
- PH10 gpio for backlight enable pin

Tested-by: Merlijn Wajer <merlijn@wizzup.org>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../allwinner/sun50i-a64-sopine-baseboard.dts | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
index e6fb9683f213..51b0cf71c3d4 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
@@ -46,6 +46,7 @@
 /dts-v1/;
 
 #include "sun50i-a64-sopine.dtsi"
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "SoPine with baseboard";
@@ -61,6 +62,14 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&r_pwm 0 50000 PWM_POLARITY_INVERTED>;
+		brightness-levels = <1 2 4 8 16 32 64 128 255>;
+		default-brightness-level = <8>;
+		enable-gpios = <&pio 7 10 GPIO_ACTIVE_HIGH>; /* LCD-BL-EN: PH10 */
+	};
+
 	hdmi-connector {
 		compatible = "hdmi-connector";
 		type = "a";
@@ -104,6 +113,24 @@
 	status = "okay";
 };
 
+&dphy {
+	status = "okay";
+};
+
+&dsi {
+	vcc-dsi-supply = <&reg_dldo1>;		/* VCC-DSI */
+	status = "okay";
+
+	panel@0 {
+		compatible = "feiyang,fy07024di26a30d";
+		reg = <0>;
+		avdd-supply = <&reg_dc1sw>;	/* VCC-LCD */
+		dvdd-supply = <&reg_dldo2>;	/* VCC-MIPI */
+		reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* LCD-RST: PD24 */
+		backlight = <&backlight>;
+	};
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -184,6 +211,10 @@
 	vcc-hdmi-supply = <&reg_dldo1>;
 };
 
+&r_pwm {
+	status = "okay";
+};
+
 &sound {
 	simple-audio-card,aux-devs = <&codec_analog>;
 	simple-audio-card,widgets = "Microphone", "Microphone Jack",
-- 
2.18.0.321.gffc6fa0e3

