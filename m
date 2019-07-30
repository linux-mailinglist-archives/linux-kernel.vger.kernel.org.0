Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B11A7AFFE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 19:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730916AbfG3RaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 13:30:13 -0400
Received: from mxout012.mail.hostpoint.ch ([217.26.49.172]:33250 "EHLO
        mxout012.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730846AbfG3RaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:30:12 -0400
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
        by mxout012.mail.hostpoint.ch with esmtp (Exim 4.92 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1hsVww-000A0b-C3; Tue, 30 Jul 2019 19:30:10 +0200
Received: from [46.140.72.82] (helo=philippe-pc.toradex.int)
        by asmtp013.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1hsVww-000BNr-6k; Tue, 30 Jul 2019 19:30:10 +0200
X-Authenticated-Sender-Id: dev@pschenker.ch
From:   Philippe Schenker <dev@pschenker.ch>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Philippe Schenker <philippe.schenker@toradex.com>
Subject: [RFC PATCH 2/2] ARM: dts: imx6ull: Add phy-supply to fec
Date:   Tue, 30 Jul 2019 19:30:05 +0200
Message-Id: <20190730173006.15823-3-dev@pschenker.ch>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730173006.15823-1-dev@pschenker.ch>
References: <20190730173006.15823-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

This adds the proper phy-supply to the fec. This supply is actually
switched by a clock that is now properly stated. This adds the
advantage to add a delay for that particular regulator that is needed.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

---

 arch/arm/boot/dts/imx6ull-colibri.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi b/arch/arm/boot/dts/imx6ull-colibri.dtsi
index 9ad1da159768..a15f0807e9b0 100644
--- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
@@ -47,6 +47,17 @@
 		states = <1800000 0x1 3300000 0x0>;
 		vin-supply = <&reg_module_3v3>;
 	};
+
+	reg_eth_phy: regulator-eth-phy {
+		compatible = "regulator-fixed";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-name = "eth_phy";
+		regulator-type = "voltage";
+		vin-supply = <&reg_module_3v3>;
+		clocks = <&clks IMX6UL_CLK_ENET2_REF_125M>;
+		startup-delay-us = <150000>;
+	};
 };
 
 &adc1 {
@@ -66,6 +77,7 @@
 	pinctrl-0 = <&pinctrl_enet2>;
 	phy-mode = "rmii";
 	phy-handle = <&ethphy1>;
+	phy-supply = <&reg_eth_phy>;
 	status = "okay";
 
 	mdio {
-- 
2.22.0

