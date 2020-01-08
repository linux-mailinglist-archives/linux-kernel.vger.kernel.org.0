Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83ED9134E6B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 22:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbgAHVIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 16:08:31 -0500
Received: from o1.b.az.sendgrid.net ([208.117.55.133]:64649 "EHLO
        o1.b.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgAHVHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 16:07:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:in-reply-to:references:to:cc:content-type:
        content-transfer-encoding;
        s=001; bh=mikxWY2WrXrZaeo3Sy9pZz4F5Xpp8LK8RWbT2pvPkS8=;
        b=c5Zi1M/iQ2ds2zT20WYGa11guG+zfdVtMAe+CAkmqtjzemb3wjvXrWi1zmpmS9MAG5QK
        8uNN63l+wgABhSq0edDU+iAi94G4bM9kYwsOSK29F8qljjGNGLcHLVaNrsiQAFNJEhcTHW
        rAi9ZBJnHh/16U3/uitUJe2uKJ2tR6LMc=
Received: by filterdrecv-p3mdw1-56c97568b5-q2ks7 with SMTP id filterdrecv-p3mdw1-56c97568b5-q2ks7-18-5E1644A4-35
        2020-01-08 21:07:48.439329 +0000 UTC m=+1974281.571208866
Received: from bionic.localdomain (unknown [98.128.173.80])
        by ismtpd0005p1lon1.sendgrid.net (SG) with ESMTP id udtq48_xRBOkOOBGcfZLrA
        Wed, 08 Jan 2020 21:07:48.244 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 03/14] phy/rockchip: inno-hdmi: remove unused no_c from
 rk3328 recalc_rate
Date:   Wed, 08 Jan 2020 21:07:48 +0000 (UTC)
Message-Id: <20200108210740.28769-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200108210740.28769-1-jonas@kwiboo.se>
References: <20200108210740.28769-1-jonas@kwiboo.se>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h9ysraDeTlvkeU=2FTa?=
 =?us-ascii?Q?=2F88pEB13iGtDbQ9qBh5gCDeW=2FIlYWIRb34k9xBj?=
 =?us-ascii?Q?hxE2oG2UH0lhwzjkeTUZnOOhuz86tZ7U8TamQF3?=
 =?us-ascii?Q?hxiNe515Q4MkVT380PJnTtiMMjY=2FMj2OMozx6rg?=
 =?us-ascii?Q?=2Fl+prqRloISpO=2FMEfl61f3YkmV4uQaxcT9fsu3n?=
 =?us-ascii?Q?O9wWrRoFqOUOJ3T0TDUVg=3D=3D?=
To:     Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>
Cc:     Jonas Karlman <jonas@kwiboo.se>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Zheng Yang <zhengyang@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

no_c is not used in any calculation, lets remove it.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
index 093d2334e8cd..06db69c8373e 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
@@ -714,7 +714,7 @@ unsigned long inno_hdmi_phy_rk3328_clk_recalc_rate(struct clk_hw *hw,
 {
 	struct inno_hdmi_phy *inno = to_inno_hdmi_phy(hw);
 	unsigned long frac;
-	u8 nd, no_a, no_b, no_c, no_d;
+	u8 nd, no_a, no_b, no_d;
 	u64 vco;
 	u16 nf;
 
@@ -737,9 +737,6 @@ unsigned long inno_hdmi_phy_rk3328_clk_recalc_rate(struct clk_hw *hw,
 		no_b = inno_read(inno, 0xa5) & RK3328_PRE_PLL_PCLK_DIV_B_MASK;
 		no_b >>= RK3328_PRE_PLL_PCLK_DIV_B_SHIFT;
 		no_b += 2;
-		no_c = inno_read(inno, 0xa6) & RK3328_PRE_PLL_PCLK_DIV_C_MASK;
-		no_c >>= RK3328_PRE_PLL_PCLK_DIV_C_SHIFT;
-		no_c = 1 << no_c;
 		no_d = inno_read(inno, 0xa6) & RK3328_PRE_PLL_PCLK_DIV_D_MASK;
 
 		do_div(vco, (nd * (no_a == 1 ? no_b : no_a) * no_d * 2));
-- 
2.17.1

