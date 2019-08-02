Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04B4E7F517
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 12:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405102AbfHBKeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 06:34:08 -0400
Received: from shell.v3.sk ([90.176.6.54]:47568 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404440AbfHBKeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 06:34:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id C018F8053C;
        Fri,  2 Aug 2019 12:34:03 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id XHs5Tdy63-so; Fri,  2 Aug 2019 12:33:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 4845C80536;
        Fri,  2 Aug 2019 12:33:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7EjrHeDa1BlI; Fri,  2 Aug 2019 12:33:40 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 9030C8053D;
        Fri,  2 Aug 2019 12:33:36 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 5/6] ARM: dts: mmp2: specify reg-shift for the UARTs
Date:   Fri,  2 Aug 2019 12:33:25 +0200
Message-Id: <20190802103326.531250-6-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190802103326.531250-1-lkundrak@v3.sk>
References: <20190802103326.531250-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes the 8250_of driver happy. There are two more drivers in the
tree that bind to mrvl,mmp-uart compatibles: pxa and 8250_pxa and
neither of them requires the reg-shift property, assuming it's always 2.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v1:
- Updated the subject to fit the style of the DTS updates
---
 arch/arm/boot/dts/mmp2.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index 68b5470773232..6a2f072c1d0a8 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -214,6 +214,7 @@
 				interrupts =3D <27>;
 				clocks =3D <&soc_clocks MMP2_CLK_UART0>;
 				resets =3D <&soc_clocks MMP2_CLK_UART0>;
+				reg-shift =3D <2>;
 				status =3D "disabled";
 			};
=20
@@ -223,6 +224,7 @@
 				interrupts =3D <28>;
 				clocks =3D <&soc_clocks MMP2_CLK_UART1>;
 				resets =3D <&soc_clocks MMP2_CLK_UART1>;
+				reg-shift =3D <2>;
 				status =3D "disabled";
 			};
=20
@@ -232,6 +234,7 @@
 				interrupts =3D <24>;
 				clocks =3D <&soc_clocks MMP2_CLK_UART2>;
 				resets =3D <&soc_clocks MMP2_CLK_UART2>;
+				reg-shift =3D <2>;
 				status =3D "disabled";
 			};
=20
@@ -241,6 +244,7 @@
 				interrupts =3D <46>;
 				clocks =3D <&soc_clocks MMP2_CLK_UART3>;
 				resets =3D <&soc_clocks MMP2_CLK_UART3>;
+				reg-shift =3D <2>;
 				status =3D "disabled";
 			};
=20
--=20
2.21.0

