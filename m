Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1F917F515
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 12:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404724AbfHBKd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 06:33:58 -0400
Received: from shell.v3.sk ([90.176.6.54]:47552 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392160AbfHBKd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 06:33:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 088E98053C;
        Fri,  2 Aug 2019 12:33:54 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id QN9O9-YxYJJv; Fri,  2 Aug 2019 12:33:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id CEFA080540;
        Fri,  2 Aug 2019 12:33:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UR4aRb2y413V; Fri,  2 Aug 2019 12:33:36 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id ECFE98053A;
        Fri,  2 Aug 2019 12:33:35 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 2/6] ARM: dts: mmp2: fix the SPI nodes
Date:   Fri,  2 Aug 2019 12:33:22 +0200
Message-Id: <20190802103326.531250-3-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190802103326.531250-1-lkundrak@v3.sk>
References: <20190802103326.531250-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SPI bus has a single address cell and not size cells.

Also, dtc thinks the SPI nodes are preferrably called "spi" and it is
right to think so.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/mmp2.dtsi | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index 50b6c38b39cc3..e64639ce57a91 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -346,35 +346,43 @@
 				status =3D "disabled";
 			};
=20
-			ssp1: ssp@d4035000 {
+			ssp1: spi@d4035000 {
 				compatible =3D "marvell,mmp2-ssp";
 				reg =3D <0xd4035000 0x1000>;
 				clocks =3D <&soc_clocks MMP2_CLK_SSP0>;
 				interrupts =3D <0>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
 				status =3D "disabled";
 			};
=20
-			ssp2: ssp@d4036000 {
+			ssp2: spi@d4036000 {
 				compatible =3D "marvell,mmp2-ssp";
 				reg =3D <0xd4036000 0x1000>;
 				clocks =3D <&soc_clocks MMP2_CLK_SSP1>;
 				interrupts =3D <1>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
 				status =3D "disabled";
 			};
=20
-			ssp3: ssp@d4037000 {
+			ssp3: spi@d4037000 {
 				compatible =3D "marvell,mmp2-ssp";
 				reg =3D <0xd4037000 0x1000>;
 				clocks =3D <&soc_clocks MMP2_CLK_SSP2>;
 				interrupts =3D <20>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
 				status =3D "disabled";
 			};
=20
-			ssp4: ssp@d4039000 {
+			ssp4: spi@d4039000 {
 				compatible =3D "marvell,mmp2-ssp";
 				reg =3D <0xd4039000 0x1000>;
 				clocks =3D <&soc_clocks MMP2_CLK_SSP3>;
 				interrupts =3D <21>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
 				status =3D "disabled";
 			};
 		};
--=20
2.21.0

