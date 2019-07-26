Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F48077164
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 20:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388080AbfGZSlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 14:41:14 -0400
Received: from mailoutvs11.siol.net ([185.57.226.202]:54841 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388035AbfGZSlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 14:41:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id A51F8523041;
        Fri, 26 Jul 2019 20:41:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id vwG4zhWBUSbu; Fri, 26 Jul 2019 20:41:08 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 686A0523044;
        Fri, 26 Jul 2019 20:41:08 +0200 (CEST)
Received: from localhost.localdomain (cpe-194-152-11-237.cable.triera.net [194.152.11.237])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 1CB6F523041;
        Fri, 26 Jul 2019 20:41:06 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     thierry.reding@gmail.com, mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 6/6] arm64: dts: allwinner: h6: Add PWM node
Date:   Fri, 26 Jul 2019 20:40:45 +0200
Message-Id: <20190726184045.14669-7-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726184045.14669-1-jernej.skrabec@siol.net>
References: <20190726184045.14669-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner H6 PWM is similar to that in A20 except that it has additional
bus clock and reset line.

Note that first PWM channel is connected to output pin and second
channel is used internally, as a clock source to AC200 co-packaged chip.
This means that any combination of these two channels can be used and
thus it doesn't make sense to add pinctrl nodes at this point.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/bo=
ot/dts/allwinner/sun50i-h6.dtsi
index e8bed58e7246..c1abd805cfdc 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -229,6 +229,16 @@
 			status =3D "disabled";
 		};
=20
+		pwm: pwm@300a000 {
+			compatible =3D "allwinner,sun50i-h6-pwm";
+			reg =3D <0x0300a000 0x400>;
+			clocks =3D <&osc24M>, <&ccu CLK_BUS_PWM>;
+			clock-names =3D "pwm", "bus";
+			resets =3D <&ccu RST_BUS_PWM>;
+			#pwm-cells =3D <3>;
+			status =3D "disabled";
+		};
+
 		pio: pinctrl@300b000 {
 			compatible =3D "allwinner,sun50i-h6-pinctrl";
 			reg =3D <0x0300b000 0x400>;
--=20
2.22.0

