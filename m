Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAE2320C9D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 18:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfEPQKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 12:10:51 -0400
Received: from mailoutvs7.siol.net ([185.57.226.198]:37940 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726715AbfEPQKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 12:10:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 933F1521DFA;
        Thu, 16 May 2019 18:10:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id R4UBf8dj79kQ; Thu, 16 May 2019 18:10:48 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 46AA8522084;
        Thu, 16 May 2019 18:10:48 +0200 (CEST)
Received: from localhost.localdomain (cpe-86-58-52-202.static.triera.net [86.58.52.202])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id BEFCC521DFA;
        Thu, 16 May 2019 18:10:46 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: sun8i-h3: Fix wifi in Beelink X2 DT
Date:   Thu, 16 May 2019 18:10:39 +0200
Message-Id: <20190516161039.18534-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mmc1 node where wifi module is connected doesn't have properly defined
power supplies so wifi module is never powered up. Fix that by
specifying additional power supplies.

Additionally, this STB may have either Realtek or Broadcom based wifi
module. One based on Broadcom module also needs external clock to work
properly. Fix that by adding clock property to wifi_pwrseq node.

Fixes: e582b47a9252 ("ARM: dts: sun8i-h3: Add dts for the Beelink X2 STB"=
)
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts b/arch/arm/boot/dt=
s/sun8i-h3-beelink-x2.dts
index 6277f13f3eb3..6a0ac85b4616 100644
--- a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
@@ -89,7 +89,10 @@
=20
 	wifi_pwrseq: wifi_pwrseq {
 		compatible =3D "mmc-pwrseq-simple";
+		pinctrl-names =3D "default";
 		reset-gpios =3D <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
+		clocks =3D <&rtc 1>;
+		clock-names =3D "ext_clock";
 	};
=20
 	sound_spdif {
@@ -155,6 +158,8 @@
=20
 &mmc1 {
 	vmmc-supply =3D <&reg_vcc3v3>;
+	vqmmc-supply =3D <&reg_vcc3v3>;
+	mmc-pwrseq =3D <&wifi_pwrseq>;
 	bus-width =3D <4>;
 	non-removable;
 	status =3D "okay";
--=20
2.21.0

