Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 427F013A403
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 10:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgANJnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 04:43:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:35420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbgANJnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 04:43:01 -0500
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AF052084D;
        Tue, 14 Jan 2020 09:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578994980;
        bh=ZY32olhBC9Vu8GoFnoJlyKFKyLmpEDns5sByfyxWduo=;
        h=From:To:Cc:Subject:Date:From;
        b=J0meMBCO3EIcNZcCnTo3GjEw6jIjd/3BjqmkWnaw4uxOrcVNa27MEziWkOR6idYlY
         fukBMrgtxqNzPUPw1yUafxPOgrX/CUbMLrp1qe+DZHx6tAUmFR/a4RtlEq1WLVXWnW
         r+dv808jcPRdMXdnJvGTpLhxqpEmRnjm+2fsvM1o=
Received: by wens.tw (Postfix, from userid 1000)
        id 1F57B5FC9E; Tue, 14 Jan 2020 17:42:58 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: sun8i: a83t: Fix incorrect clk and reset macros for EMAC device
Date:   Tue, 14 Jan 2020 17:42:52 +0800
Message-Id: <20200114094252.8908-1-wens@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

When the raw numbers used for clk and reset indices in the EMAC device
node were converted to the new macros, the order of the clk and reset
properties was overlooked, and thus the incorrect macros were used.
This results in the EMAC being non-responsive, as well as an oops due
to incorrect usage of the reset control.

Correct the macro types, and also reorder the clk and reset properties
to match all the other device nodes.

Fixes: 765866edb16a ("ARM: dts: sunxi: Use macros for references to CCU clocks")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Error on my part. Hope no one was affected for too long.

---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 74ac7ee9383c..e7b9bef1be6b 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -1006,10 +1006,10 @@ emac: ethernet@1c30000 {
 			reg = <0x01c30000 0x104>;
 			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
-			resets = <&ccu CLK_BUS_EMAC>;
-			reset-names = "stmmaceth";
-			clocks = <&ccu RST_BUS_EMAC>;
+			clocks = <&ccu CLK_BUS_EMAC>;
 			clock-names = "stmmaceth";
+			resets = <&ccu RST_BUS_EMAC>;
+			reset-names = "stmmaceth";
 			status = "disabled";
 
 			mdio: mdio {
-- 
2.24.1

