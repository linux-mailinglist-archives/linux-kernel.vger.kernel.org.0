Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6E3E34C64
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 17:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbfFDPkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 11:40:49 -0400
Received: from vps.xff.cz ([195.181.215.36]:36234 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727422AbfFDPks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 11:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1559662847; bh=ixO4OiS3QbgO7fFYohnpcpN7u8/7cH3Nz5L9p88LaWk=;
        h=From:To:Cc:Subject:Date:From;
        b=JdK3vq0qTtY0P1vh2J2iPVNVrt6oX1xCuB9PL2mWwwSoNsb/fzedpXZT8zeiSK5XC
         k6+m8i4vso6+HoTDxtS5OQCxRZqbbJuDIqxRmtlRS47msA6xOSbiU+GszvUCwGnmc1
         lOPJQI7X4rdtx9nWEjSzxZg7BOwHUFABmGzG2SAY=
From:   megous@megous.com
To:     linux-sunxi@googlegroups.com
Cc:     Ondrej Jirman <megous@megous.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support),
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] clk: sunxi-ng: sun50i-h6-r: Fix incorrect W1 clock gate register
Date:   Tue,  4 Jun 2019 17:40:36 +0200
Message-Id: <20190604154036.23211-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

The current code defines W1 clock gate to be at 0x1cc, overlaying it
with the IR gate.

Clock gate for r-apb1-w1 is at 0x1ec. This fixes issues with IR receiver
causing interrupt floods on H6 (because interrupt flags can't be cleared,
due to IR module's bus being disabled).

Signed-off-by: Ondrej Jirman <megous@megous.com>
Fixes: b7c7b05065aa77ae ("clk: sunxi-ng: add support for H6 PRCM CCU")
---
 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
index 27554eaf6929..8d05d4f1f8a1 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
@@ -104,7 +104,7 @@ static SUNXI_CCU_GATE(r_apb2_i2c_clk,	"r-apb2-i2c",	"r-apb2",
 static SUNXI_CCU_GATE(r_apb1_ir_clk,	"r-apb1-ir",	"r-apb1",
 		      0x1cc, BIT(0), 0);
 static SUNXI_CCU_GATE(r_apb1_w1_clk,	"r-apb1-w1",	"r-apb1",
-		      0x1cc, BIT(0), 0);
+		      0x1ec, BIT(0), 0);
 
 /* Information of IR(RX) mod clock is gathered from BSP source code */
 static const char * const r_mod0_default_parents[] = { "osc32k", "osc24M" };
-- 
2.21.0

