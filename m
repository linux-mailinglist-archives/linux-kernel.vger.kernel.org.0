Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 089127F513
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 12:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404187AbfHBKdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 06:33:55 -0400
Received: from shell.v3.sk ([90.176.6.54]:47540 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392125AbfHBKdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 06:33:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id B71E18053B;
        Fri,  2 Aug 2019 12:33:49 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Qj26uncj_VDW; Fri,  2 Aug 2019 12:33:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 10CD180541;
        Fri,  2 Aug 2019 12:33:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mK-mJL9V8DJO; Fri,  2 Aug 2019 12:33:36 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id B0D4D80538;
        Fri,  2 Aug 2019 12:33:35 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 1/6] ARM: dts: mmp2: trivial whitespace fix
Date:   Fri,  2 Aug 2019 12:33:21 +0200
Message-Id: <20190802103326.531250-2-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190802103326.531250-1-lkundrak@v3.sk>
References: <20190802103326.531250-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A missing space before a curly brace.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/mmp2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index b6f40743e07b0..50b6c38b39cc3 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -379,7 +379,7 @@
 			};
 		};
=20
-		soc_clocks: clocks{
+		soc_clocks: clocks {
 			compatible =3D "marvell,mmp2-clock";
 			reg =3D <0xd4050000 0x1000>,
 			      <0xd4282800 0x400>,
--=20
2.21.0

