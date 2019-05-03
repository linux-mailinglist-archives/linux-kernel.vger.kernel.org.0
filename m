Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77A2712AF7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 11:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfECJrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 05:47:47 -0400
Received: from hermes.aosc.io ([199.195.250.187]:36975 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbfECJrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 05:47:47 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 0EE74431BF;
        Fri,  3 May 2019 09:47:43 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v2] arm64: dts: allwinner: h6: add PIO VCC bank supplies for Pine H64
Date:   Fri,  3 May 2019 17:47:20 +0800
Message-Id: <20190503094720.21502-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner H6 SoC features tweakable VCC for PC, PD, PG, PL and PM
banks.

This patch adds supplies for these banks except PL bank. PL bank is
where PMIC is attached, and currently if a PMIC regulator is added
for it a dependency loop will happen.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
Changes in v2:
- Added PG/PM banks.

 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index 4802902e128f..9e464d40cbff 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -127,6 +127,12 @@
 	status = "okay";
 };
 
+&pio {
+	vcc-pc-supply = <&reg_bldo2>;
+	vcc-pd-supply = <&reg_cldo1>;
+	vcc-pg-supply = <&reg_aldo1>;
+};
+
 &r_i2c {
 	status = "okay";
 
@@ -247,6 +253,10 @@
 	};
 };
 
+&r_pio {
+	vcc-pm-supply = <&reg_aldo1>;
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_ph_pins>;
-- 
2.18.1

