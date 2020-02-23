Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0446C1698FC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2020 18:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbgBWR33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Feb 2020 12:29:29 -0500
Received: from vps.xff.cz ([195.181.215.36]:44468 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727080AbgBWR32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 12:29:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1582478966; bh=z3p4j/I6/eYDYtEmmShKMGzml/S7bFHapqciJWMfdL4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=DAeW3Wz2Wqb3DNXLKpcFl2LG5UH5IZcJUJYZ4gStfDzlmhnvFsdCijXHTg68FvrnM
         8Sgp4ENQWGfOyvgrNwKto8fFqa23crgNcBz0OAMxUTWBMozkWH2SN5e1zWciJjI6yH
         K9Eq1puI7TZ4W75eiOhfh60uEzyzCUMLeJ35/ANw=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Ondrej Jirman <megous@megous.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Georgii Staroselskii <georgii.staroselskii@emlid.com>,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>, Icenowy Zheng <icenowy@aosc.io>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] arm64: dts: sun50i-a64: Add i2c2 pins
Date:   Sun, 23 Feb 2020 18:29:14 +0100
Message-Id: <20200223172916.843379-2-megous@megous.com>
In-Reply-To: <20200223172916.843379-1-megous@megous.com>
References: <20200223172916.843379-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PinePhone needs I2C2 pins description. Add it.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 862b47dc9dc90..0fdf5f400d743 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -671,6 +671,11 @@ i2c1_pins: i2c1-pins {
 				function = "i2c1";
 			};
 
+			i2c2_pins: i2c2-pins {
+				pins = "PE14", "PE15";
+				function = "i2c2";
+			};
+
 			/omit-if-no-ref/
 			lcd_rgb666_pins: lcd-rgb666-pins {
 				pins = "PD0", "PD1", "PD2", "PD3", "PD4",
-- 
2.25.1

