Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBEF222430
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2019 19:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbfERRKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 May 2019 13:10:07 -0400
Received: from mail.z3ntu.xyz ([128.199.32.197]:60024 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729163AbfERRKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 13:10:07 -0400
Received: from g550jk.homerouter.cpe (212095005231.public.telering.at [212.95.5.231])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 4A07DC147C;
        Sat, 18 May 2019 17:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1558199405; bh=FrH7jafPPMb3d3QsM5GUNETkT+mDzL06CRsGVetE7/U=;
        h=From:To:Cc:Subject:Date;
        b=y/XiqCbTDJfCnWqF8t2QCkInxIgxN8I+NrBj23LcCj5VU+pf4+jt0wM0A4fbCzKgu
         0h9MU3iEsBYrMkmY0CKdxdATFIvFU9gL8S0SIbhIuS+fk2wjoen7oXDWRC/LdjWkS0
         bCgOmx2WHFkeTTYNhFHY5ne2MAiK8QCmEiPI0eIg=
From:   Luca Weiss <luca@z3ntu.xyz>
Cc:     Luca Weiss <luca@z3ntu.xyz>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] arm64: dts: allwinner: a64: Add lradc node
Date:   Sat, 18 May 2019 19:09:30 +0200
Message-Id: <20190518170929.24789-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node describing the KEYADC on the A64.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 7734f70e1057..dc1bf8c1afb5 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -704,6 +704,13 @@
 			status = "disabled";
 		};
 
+		lradc: lradc@1c21800 {
+			compatible = "allwinner,sun4i-a10-lradc-keys";
+			reg = <0x01c21800 0x100>;
+			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
 		i2s0: i2s@1c22000 {
 			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun50i-a64-i2s",
-- 
2.21.0

