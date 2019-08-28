Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3135A9FBA2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 09:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfH1H1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 03:27:03 -0400
Received: from shell.v3.sk ([90.176.6.54]:40212 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726432AbfH1H1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 03:27:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 2C2D8D8242;
        Wed, 28 Aug 2019 09:26:59 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id tIPPGnGMCsN7; Wed, 28 Aug 2019 09:26:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id C1792D8305;
        Wed, 28 Aug 2019 09:26:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2L3KDr55dI5W; Wed, 28 Aug 2019 09:26:37 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 41643D82F9;
        Wed, 28 Aug 2019 09:26:36 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v3 2/6] ARM: dts: mmp2: fix the SPI nodes
Date:   Wed, 28 Aug 2019 09:26:25 +0200
Message-Id: <20190828072629.285760-3-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190828072629.285760-1-lkundrak@v3.sk>
References: <20190828072629.285760-1-lkundrak@v3.sk>
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
Acked-by: Pavel Machek <pavel@ucw.cz>
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

