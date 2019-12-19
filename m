Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFB94126EB0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 21:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfLSUVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 15:21:53 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.171]:11294 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfLSUVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 15:21:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1576786906;
        s=strato-dkim-0002; d=gerhold.net;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=HAbd9d4NTDF2e/QveCagzTM33lrIAhUfv351iriFU0E=;
        b=RQa5TSbO0TIAMR7K/dIx0L2qgf1rq/2ochS5vhwV+8iPff9LOWjcMyFaFPzsbNNXSX
        l43SOBlA7tP5IT1r13SGbHActVNUHyCkrbNCbE0M0DgxtnKe5TmuX37dor8eEc7M4xLT
        EUwq9jstQwFZH8a/Rhh6YHUCHBbxiHXaypcuSwSjSY/HQf28i4gSMN2eeUgGwqof8V7f
        lATVm8oBETt25tqnam0m7frao2hi8PZODRzWfsw/67hzx7jYadF59I1CWQdjnu2VpPDQ
        +QTTl/rXKVPnMSAjJwVNPz+ke6kz4To295hy+p33uDwnXz/fRqpQ2AuOosqoQp6ISizm
        73LA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQrEOHTIXtszvsxM1"
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 46.1.1 AUTH)
        with ESMTPSA id f021e2vBJKLj3ZF
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 19 Dec 2019 21:21:45 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 7/9] ARM: dts: ux500: samsung-golden: Add WiFi
Date:   Thu, 19 Dec 2019 21:20:50 +0100
Message-Id: <20191219202052.19039-8-stephan@gerhold.net>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219202052.19039-1-stephan@gerhold.net>
References: <20191219202052.19039-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

samsung-golden uses a BCM4334 WiFi+BT combo chip, connected to SDIO.
It is supported by the brcmfmac driver in mainline,
so we only need to set up the device tree to make it work correctly.

Note: brcmfmac requires (proprietary) firmware + a device-specific
NVRAM file. Both can be extracted from the stock Android system
used on samsung-golden:
  - /system/etc/wifi/bcmdhd_sta.bin_b2   -> /lib/firmware/brcm/brcmfmac4334-sdio.bin
  - /system/etc/wifi/nvram_net.txt_GPIO4 -> /lib/firmware/brcm/brcmfmac4334-sdio.samsung,golden.txt

brcmfmac4334-sdio.bin from linux-firmware also seems to work,
but results in occasional errors for some reason.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 .../arm/boot/dts/ste-ux500-samsung-golden.dts | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm/boot/dts/ste-ux500-samsung-golden.dts b/arch/arm/boot/dts/ste-ux500-samsung-golden.dts
index e75a425d177e..d22b2879c46a 100644
--- a/arch/arm/boot/dts/ste-ux500-samsung-golden.dts
+++ b/arch/arm/boot/dts/ste-ux500-samsung-golden.dts
@@ -64,9 +64,27 @@ sdi1_per2@80118000 {
 			non-removable;
 			cap-sd-highspeed;
 
+			vmmc-supply = <&wl_reg_on>;
+
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&mc1_a_2_default>;
 			pinctrl-1 = <&mc1_a_2_sleep>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			wifi@1 {
+				compatible = "brcm,bcm4329-fmac";
+				reg = <1>;
+
+				/* GPIO216 (WLAN_HOST_WAKE) */
+				interrupt-parent = <&gpio6>;
+				interrupts = <24 IRQ_TYPE_EDGE_FALLING>;
+				interrupt-names = "host-wake";
+
+				pinctrl-names = "default";
+				pinctrl-0 = <&wlan_default>;
+			};
 		};
 
 		/* eMMC */
@@ -290,6 +308,28 @@ sd_level_translator: regulator-sd-level-translator {
 		pinctrl-names = "default";
 		pinctrl-0 = <&sd_level_translator_default>;
 	};
+
+	/*
+	 * WL_REG_ON takes WLAN out of reset and enables the internal regulators.
+	 * The voltage specified here is only used to determine the OCR mask,
+	 * the BCM chip is actually connected directly to VBAT.
+	 */
+	wl_reg_on: regulator-wl-reg-on {
+		compatible = "regulator-fixed";
+
+		regulator-name = "wl-reg-on";
+		regulator-min-microvolt = <3000000>;
+		regulator-max-microvolt = <3000000>;
+
+		startup-delay-us = <100000>;
+
+		/* GPIO215 (WLAN_EN) */
+		gpio = <&gpio6 23 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&wlan_en_default>;
+	};
 };
 
 &pinctrl {
@@ -340,6 +380,22 @@ golden_cfg1 {
 		};
 	};
 
+	wlan {
+		wlan_default: wlan_default {
+			golden_cfg1 {
+				pins = "GPIO216_AG12";	/* WLAN_HOST_WAKE */
+				ste,config = <&gpio_in_pd>;
+			};
+		};
+
+		wlan_en_default: wlan_en_default {
+			golden_cfg1 {
+				pins = "GPIO215_AH13";	/* WLAN_EN */
+				ste,config = <&gpio_out_lo>;
+			};
+		};
+	};
+
 	vibrator {
 		vibrator_default: vibrator_default {
 			golden_cfg1 {
-- 
2.24.1

