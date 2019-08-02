Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5D27F516
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 12:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404900AbfHBKeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 06:34:03 -0400
Received: from shell.v3.sk ([90.176.6.54]:47563 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404440AbfHBKd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 06:33:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 392238053E;
        Fri,  2 Aug 2019 12:33:55 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id GTGZmojTwtNJ; Fri,  2 Aug 2019 12:33:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id CC0C3804BF;
        Fri,  2 Aug 2019 12:33:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2YN-mUj7Y7gi; Fri,  2 Aug 2019 12:33:37 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 5E57A8053C;
        Fri,  2 Aug 2019 12:33:36 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 4/6] ARM: dts: mmp2: add camera interfaces
Date:   Fri,  2 Aug 2019 12:33:24 +0200
Message-Id: <20190802103326.531250-5-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190802103326.531250-1-lkundrak@v3.sk>
References: <20190802103326.531250-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Supported by the mmp-camera driver.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/mmp2.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index 21432cb9143f7..68b5470773232 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -170,6 +170,28 @@
 				interrupts =3D <54>;
 				status =3D "disabled";
 			};
+
+			camera0: camera@d420a000 {
+				compatible =3D "marvell,mmp2-ccic";
+				reg =3D <0xd420a000 0x800>;
+				interrupts =3D <42>;
+				clocks =3D <&soc_clocks MMP2_CLK_CCIC0>;
+				clock-names =3D "axi";
+				#clock-cells =3D <0>;
+				clock-output-names =3D "mclk";
+				status =3D "disabled";
+			};
+
+			camera1: camera@d420a800 {
+				compatible =3D "marvell,mmp2-ccic";
+				reg =3D <0xd420a800 0x800>;
+				interrupts =3D <30>;
+				clocks =3D <&soc_clocks MMP2_CLK_CCIC1>;
+				clock-names =3D "axi";
+				#clock-cells =3D <0>;
+				clock-output-names =3D "mclk";
+				status =3D "disabled";
+			};
 		};
=20
 		apb@d4000000 {	/* APB */
--=20
2.21.0

