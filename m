Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBAE4D1A3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 17:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732021AbfFTPHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 11:07:42 -0400
Received: from shell.v3.sk ([90.176.6.54]:51654 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726649AbfFTPHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 11:07:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 0F851CC535;
        Thu, 20 Jun 2019 17:07:37 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id x_DnkKbfHN_v; Thu, 20 Jun 2019 17:07:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 4F836CC360;
        Thu, 20 Jun 2019 17:07:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id G5jCZypA0uo0; Thu, 20 Jun 2019 17:07:27 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 602F1CC535;
        Thu, 20 Jun 2019 17:07:27 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 3/5] ARM: dts: mmp2: rename the USB PHY node
Date:   Thu, 20 Jun 2019 17:07:22 +0200
Message-Id: <20190620150724.1406757-4-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190620150724.1406757-1-lkundrak@v3.sk>
References: <20190620150724.1406757-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This device is not an OTG phy, it's a regular USB HS phy. Follow the
generic node name recommendation, and rename it to "usb-phy".

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/mmp2.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index e64639ce57a9..21432cb9143f 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -117,7 +117,7 @@
 				mrvl,intc-nr-irqs =3D <2>;
 			};
=20
-			usb_otg_phy0: usb-otg-phy@d4207000 {
+			usb_phy0: usb-phy@d4207000 {
 				compatible =3D "marvell,mmp2-usb-phy";
 				reg =3D <0xd4207000 0x40>;
 				#phy-cells =3D <0>;
@@ -130,7 +130,7 @@
 				interrupts =3D <44>;
 				clocks =3D <&soc_clocks MMP2_CLK_USB>;
 				clock-names =3D "USBCLK";
-				phys =3D <&usb_otg_phy0>;
+				phys =3D <&usb_phy0>;
 				phy-names =3D "usb";
 				status =3D "disabled";
 			};
--=20
2.21.0

