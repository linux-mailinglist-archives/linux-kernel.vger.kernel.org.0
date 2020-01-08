Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE8C0134E5B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 22:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgAHVHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 16:07:53 -0500
Received: from o1.b.az.sendgrid.net ([208.117.55.133]:27313 "EHLO
        o1.b.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbgAHVHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 16:07:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:in-reply-to:references:to:cc:content-type:
        content-transfer-encoding;
        s=001; bh=z7v+PHtCfxxSYzksa8sjIkGNZO+Cebil1muBgONTycw=;
        b=TNcftyB5vfFCz/cR335HHvZEfP4tV7WTYve825dY6U764rG7p+UFs1Blx8+TMFVozcpd
        pDVX2M8CnPBKDQ0STWoCM48DOWyw8NhixmVazdf7JoS0SCZdgbxE81MROMR586ot9CnoTK
        mKE8qAzea8F+kgzh5aqlrAoHJJt3DveO4=
Received: by filterdrecv-p3mdw1-56c97568b5-s6xnl with SMTP id filterdrecv-p3mdw1-56c97568b5-s6xnl-18-5E1644A4-77
        2020-01-08 21:07:48.851520111 +0000 UTC m=+1974282.198634428
Received: from bionic.localdomain (unknown [98.128.173.80])
        by ismtpd0005p1lon1.sendgrid.net (SG) with ESMTP id lLaqo8mYSqGJjrFhaF-BCQ
        Wed, 08 Jan 2020 21:07:48.651 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 04/14] phy/rockchip: inno-hdmi: do not power on rk3328 post
 pll on reg write
Date:   Wed, 08 Jan 2020 21:07:48 +0000 (UTC)
Message-Id: <20200108210740.28769-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200108210740.28769-1-jonas@kwiboo.se>
References: <20200108210740.28769-1-jonas@kwiboo.se>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0hw15U3oWHTPc4TwQx?=
 =?us-ascii?Q?txUqjYQPmIA9mX6ZYKTWszlO=2FxfJ51fsfWmyvKC?=
 =?us-ascii?Q?j7Obcn4yKxNp48Wpw66GUjBQIXsRsJaam7vUFqf?=
 =?us-ascii?Q?ID=2FF28oEEki12ADlaTvOFAozHi9SETAbq6xQKgh?=
 =?us-ascii?Q?W62E5vSSbZfWq7v035+xkOOUKIUY83LVoQgkGOh?=
 =?us-ascii?Q?zEMeDYkLCgjBliZNGuOoQ=3D=3D?=
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

inno_write is used to configure 0xaa reg, that also hold the
POST_PLL_POWER_DOWN bit.
When POST_PLL_REFCLK_SEL_TMDS is configured the power down bit is not
taken into consideration.

Fix this by keeping the power down bit until configuration is complete.
Also reorder the reg write order for consistency.

Fixes: 53706a116863 ("phy: add Rockchip Innosilicon hdmi phy")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
index 06db69c8373e..3a59a6da0440 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
@@ -1020,9 +1020,10 @@ inno_hdmi_phy_rk3328_power_on(struct inno_hdmi_phy *inno,
 
 	inno_write(inno, 0xac, RK3328_POST_PLL_FB_DIV_7_0(cfg->fbdiv));
 	if (cfg->postdiv == 1) {
-		inno_write(inno, 0xaa, RK3328_POST_PLL_REFCLK_SEL_TMDS);
 		inno_write(inno, 0xab, RK3328_POST_PLL_FB_DIV_8(cfg->fbdiv) |
 			   RK3328_POST_PLL_PRE_DIV(cfg->prediv));
+		inno_write(inno, 0xaa, RK3328_POST_PLL_REFCLK_SEL_TMDS |
+			   RK3328_POST_PLL_POWER_DOWN);
 	} else {
 		v = (cfg->postdiv / 2) - 1;
 		v &= RK3328_POST_PLL_POST_DIV_MASK;
@@ -1030,7 +1031,8 @@ inno_hdmi_phy_rk3328_power_on(struct inno_hdmi_phy *inno,
 		inno_write(inno, 0xab, RK3328_POST_PLL_FB_DIV_8(cfg->fbdiv) |
 			   RK3328_POST_PLL_PRE_DIV(cfg->prediv));
 		inno_write(inno, 0xaa, RK3328_POST_PLL_POST_DIV_ENABLE |
-			   RK3328_POST_PLL_REFCLK_SEL_TMDS);
+			   RK3328_POST_PLL_REFCLK_SEL_TMDS |
+			   RK3328_POST_PLL_POWER_DOWN);
 	}
 
 	for (v = 0; v < 14; v++)
-- 
2.17.1

