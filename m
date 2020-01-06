Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95D09130ED4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 09:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgAFImu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 03:42:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:40320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbgAFImq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 03:42:46 -0500
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6381B2467C;
        Mon,  6 Jan 2020 08:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578300165;
        bh=0EIGPjYZo6FBtZUEJQgirKj6xdjoxrfaE3eT2iKS86s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=unTNw/nHTKzY1uXQZVSWdfnLxW9lfD7nao0e3WVvhzeaa2N4VgILukEnQwHayt+PX
         zD/ZWIdj9j0IDldXXusntoeJxgHzAgLPoFoMdMQMRqZMus1eDGTr7MFBZpjdZZRN3g
         fnjF2/nNcPxDeqdtX1sdwfm7m7K+bGZKKX+9mymk=
Received: by wens.tw (Postfix, from userid 1000)
        id 73CB35FD7D; Mon,  6 Jan 2020 16:42:41 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/7] [DO NOT MERGE] ARM: dts: sun8i-r40: bananapi-m2-ultra: Enable OV5640 camera
Date:   Mon,  6 Jan 2020 16:42:40 +0800
Message-Id: <20200106084240.1076-8-wens@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106084240.1076-1-wens@kernel.org>
References: <20200106084240.1076-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

Bananapi offers a small OV5640 based camera module, attached via an FPC
connector.

Add the related regulator constraints, and hook everything up.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../boot/dts/sun8i-r40-bananapi-m2-ultra.dts  | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
index 42d62d1ba1dc..86183d40c7af 100644
--- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
+++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
@@ -113,6 +113,24 @@ &ahci {
 	status = "okay";
 };
 
+&csi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&csi0_8bits_pins>;
+	status = "okay";
+
+	port {
+		/* Parallel bus endpoint */
+		csi0_from_ov5640: endpoint {
+			remote-endpoint = <&ov5640_to_csi0>;
+			bus-width = <8>;
+			hsync-active = <1>; /* Active high */
+			vsync-active = <1>; /* Active high */
+			data-active = <1>;  /* Active high */
+			pclk-sample = <1>;  /* Rising */
+		};
+	};
+};
+
 &de {
 	status = "okay";
 };
@@ -164,6 +182,37 @@ axp22x: pmic@34 {
 
 #include "axp22x.dtsi"
 
+&i2c4 {
+	status = "okay";
+
+	ov5640: camera@3c {
+		compatible = "ovti,ov5640";
+		reg = <0x3c>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&csi0_mclk_pin>;
+		clocks = <&ccu CLK_CSI0_MCLK>;
+		clock-names = "xclk";
+
+		reset-gpios = <&pio 8 7 GPIO_ACTIVE_LOW>; /* PI7 */
+		powerdown-gpios = <&pio 8 6 GPIO_ACTIVE_HIGH>; /* PI6 */
+		AVDD-supply = <&reg_aldo1>;
+		DOVDD-supply = <&reg_eldo1>;
+		DVDD-supply = <&reg_eldo2>;
+
+		port {
+			ov5640_to_csi0: endpoint {
+				remote-endpoint = <&csi0_from_ov5640>;
+				bus-width = <8>;
+				data-shift = <2>;
+				hsync-active = <1>; /* Active high */
+				vsync-active = <1>; /* Active high */
+				data-active = <1>;  /* Active high */
+				pclk-sample = <1>;  /* Rising */
+			};
+		};
+	};
+};
+
 &mmc0 {
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
@@ -209,6 +258,12 @@ &pio {
 	vcc-pg-supply = <&reg_dldo1>;
 };
 
+&reg_aldo1 {
+	regulator-name = "csi-avdd";
+	regulator-min-microvolt = <2800000>;
+	regulator-max-microvolt = <2800000>;
+};
+
 &reg_aldo2 {
 	regulator-min-microvolt = <2500000>;
 	regulator-max-microvolt = <2500000>;
@@ -289,6 +344,18 @@ &reg_dldo4 {
 	regulator-name = "vdd2v5-sata";
 };
 
+&reg_eldo1 {
+	regulator-name = "csi-iovcc";
+	regulator-min-microvolt = <2800000>;
+	regulator-max-microvolt = <2800000>;
+};
+
+&reg_eldo2 {
+	regulator-name = "csi-dvdd";
+	regulator-min-microvolt = <1500000>;
+	regulator-max-microvolt = <1500000>;
+};
+
 &reg_eldo3 {
 	regulator-min-microvolt = <1200000>;
 	regulator-max-microvolt = <1200000>;
-- 
2.24.1

