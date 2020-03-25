Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95FBA19323C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 21:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbgCYU7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 16:59:32 -0400
Received: from smtp-out.xnet.cz ([178.217.244.18]:26052 "EHLO smtp-out.xnet.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727253AbgCYU7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 16:59:31 -0400
Received: from meh.true.cz (meh.true.cz [108.61.167.218])
        (Authenticated sender: petr@true.cz)
        by smtp-out.xnet.cz (Postfix) with ESMTPSA id EFC7349FA;
        Wed, 25 Mar 2020 21:59:28 +0100 (CET)
Received: by meh.true.cz (OpenSMTPD) with ESMTP id cc5d5bd2;
        Wed, 25 Mar 2020 21:59:14 +0100 (CET)
From:   =?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     =?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: allwinner: a64: olinuxino: add user red LED
Date:   Wed, 25 Mar 2020 21:59:24 +0100
Message-Id: <20200325205924.30736-1-ynezz@true.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a red LED marked as `GPIO_LED1` on the silkscreen and connected
to PE17 by default. So lets add this missing bit in the current hardware
description.

Signed-off-by: Petr Štetiar <ynezz@true.cz>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
index 6dfafa1c879b..b9f90e19c035 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
@@ -32,6 +32,15 @@
 		};
 	};
 
+	leds {
+		compatible = "gpio-leds";
+
+		user {
+			label = "a64-olinuxino:red:user";
+			gpios = <&pio 4 17 GPIO_ACTIVE_HIGH>; /* PE17 */
+		};
+	};
+
 	reg_usb1_vbus: usb1-vbus {
 		compatible = "regulator-fixed";
 		regulator-name = "usb1-vbus";
