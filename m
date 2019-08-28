Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B250D9FBA1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 09:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfH1H1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 03:27:02 -0400
Received: from shell.v3.sk ([90.176.6.54]:40204 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbfH1H1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 03:27:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 7F081D823E;
        Wed, 28 Aug 2019 09:26:57 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id NPPAuXlhHiZd; Wed, 28 Aug 2019 09:26:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 46F1ED8242;
        Wed, 28 Aug 2019 09:26:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8OUWhc4gu0Xh; Wed, 28 Aug 2019 09:26:37 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id AC164D82FA;
        Wed, 28 Aug 2019 09:26:36 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v3 4/6] ARM: dts: mmp2: add camera interfaces
Date:   Wed, 28 Aug 2019 09:26:27 +0200
Message-Id: <20190828072629.285760-5-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190828072629.285760-1-lkundrak@v3.sk>
References: <20190828072629.285760-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Supported by the mmp-camera driver.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>
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

