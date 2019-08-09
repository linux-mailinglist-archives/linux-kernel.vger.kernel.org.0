Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61F3887605
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 11:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406149AbfHIJcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 05:32:52 -0400
Received: from shell.v3.sk ([90.176.6.54]:51824 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406196AbfHIJcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 05:32:48 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 87AC6D63BA;
        Fri,  9 Aug 2019 11:32:38 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id VxDdHGCR_UcH; Fri,  9 Aug 2019 11:32:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 680BFD63C3;
        Fri,  9 Aug 2019 11:32:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pWZyI9OPRmv1; Fri,  9 Aug 2019 11:32:10 +0200 (CEST)
Received: from furthur.local (ip-37-188-137-236.eurotel.cz [37.188.137.236])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 701B9D63B9;
        Fri,  9 Aug 2019 11:32:09 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 02/19] dt-bindings: arm: mrvl: Document MMP3 compatible string
Date:   Fri,  9 Aug 2019 11:31:41 +0200
Message-Id: <20190809093158.7969-3-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190809093158.7969-1-lkundrak@v3.sk>
References: <20190809093158.7969-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marvel MMP3 is a successor to MMP2, containing similar peripherals with t=
wo
PJ4B cores.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 Documentation/devicetree/bindings/arm/mrvl/mrvl.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mrvl/mrvl.txt b/Docume=
ntation/devicetree/bindings/arm/mrvl/mrvl.txt
index 951687528efb0..66e1e1414245b 100644
--- a/Documentation/devicetree/bindings/arm/mrvl/mrvl.txt
+++ b/Documentation/devicetree/bindings/arm/mrvl/mrvl.txt
@@ -12,3 +12,7 @@ Required root node properties:
 MMP2 Brownstone Board
 Required root node properties:
 	- compatible =3D "mrvl,mmp2-brownstone", "mrvl,mmp2";
+
+MMP3 SoC
+Required root node properties:
+	- compatible =3D "marvell,mmp3";
--=20
2.21.0

