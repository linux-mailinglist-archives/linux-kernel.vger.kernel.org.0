Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9B314B22F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 11:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgA1KCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 05:02:18 -0500
Received: from gloria.sntech.de ([185.11.138.130]:34238 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbgA1KCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 05:02:17 -0500
Received: from p57b77a13.dip0.t-ipconnect.de ([87.183.122.19] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iwNhE-0008Lk-LY; Tue, 28 Jan 2020 11:02:12 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-clk@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, heiko@sntech.de,
        christoph.muellner@theobroma-systems.com, zhangqing@rock-chips.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH 3/3] clk: rockchip: convert rk3036 pll type to use internal lock status
Date:   Tue, 28 Jan 2020 11:02:03 +0100
Message-Id: <20200128100204.1318450-3-heiko@sntech.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200128100204.1318450-1-heiko@sntech.de>
References: <20200128100204.1318450-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

The rk3036 pll type exposes its lock status in both its pllcon registers
as well as the General Register Files. To remove one dependency convert
it to the "internal" lock status, similar to how rk3399 handles it.

Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
---
 drivers/clk/rockchip/clk-pll.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pll.c
index 26ca46d49191..a677f1f8fac7 100644
--- a/drivers/clk/rockchip/clk-pll.c
+++ b/drivers/clk/rockchip/clk-pll.c
@@ -12,6 +12,7 @@
 #include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/clk-provider.h>
+#include <linux/iopoll.h>
 #include <linux/regmap.h>
 #include <linux/clk.h>
 #include "clk.h"
@@ -109,12 +110,29 @@ static int rockchip_pll_wait_lock(struct rockchip_clk_pll *pll)
 #define RK3036_PLLCON1_REFDIV_SHIFT		0
 #define RK3036_PLLCON1_POSTDIV2_MASK		0x7
 #define RK3036_PLLCON1_POSTDIV2_SHIFT		6
+#define RK3036_PLLCON1_LOCK_STATUS		BIT(10)
 #define RK3036_PLLCON1_DSMPD_MASK		0x1
 #define RK3036_PLLCON1_DSMPD_SHIFT		12
+#define RK3036_PLLCON1_PWRDOWN			BIT(13)
 #define RK3036_PLLCON2_FRAC_MASK		0xffffff
 #define RK3036_PLLCON2_FRAC_SHIFT		0
 
-#define RK3036_PLLCON1_PWRDOWN			(1 << 13)
+static int rockchip_rk3036_pll_wait_lock(struct rockchip_clk_pll *pll)
+{
+	u32 pllcon;
+	int ret;
+
+	/*
+	 * Lock time typical 250, max 500 input clock cycles @24MHz
+	 * So define a very safe maximum of 1000us, meaning 24000 cycles.
+	 */
+	ret = readl_poll_timeout(pll->reg_base + RK3036_PLLCON(1), pllcon,
+				 pllcon & RK3036_PLLCON1_LOCK_STATUS, 0, 1000);
+	if (ret)
+		pr_err("%s: timeout waiting for pll to lock\n", __func__);
+
+	return ret;
+}
 
 static void rockchip_rk3036_pll_get_params(struct rockchip_clk_pll *pll,
 					struct rockchip_pll_rate_table *rate)
@@ -212,7 +230,7 @@ static int rockchip_rk3036_pll_set_params(struct rockchip_clk_pll *pll,
 	writel_relaxed(pllcon, pll->reg_base + RK3036_PLLCON(2));
 
 	/* wait for the pll to lock */
-	ret = rockchip_pll_wait_lock(pll);
+	ret = rockchip_rk3036_pll_wait_lock(pll);
 	if (ret) {
 		pr_warn("%s: pll update unsuccessful, trying to restore old params\n",
 			__func__);
@@ -251,7 +269,7 @@ static int rockchip_rk3036_pll_enable(struct clk_hw *hw)
 
 	writel(HIWORD_UPDATE(0, RK3036_PLLCON1_PWRDOWN, 0),
 	       pll->reg_base + RK3036_PLLCON(1));
-	rockchip_pll_wait_lock(pll);
+	rockchip_rk3036_pll_wait_lock(pll);
 
 	return 0;
 }
-- 
2.24.1

