Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F489B4923
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 10:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389078AbfIQIT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 04:19:28 -0400
Received: from gloria.sntech.de ([185.11.138.130]:46546 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728771AbfIQIT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 04:19:26 -0400
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iA8hm-0005Uf-Pw; Tue, 17 Sep 2019 10:19:22 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        finley.xiao@rock-chips.com, zhangqing@rock-chips.com,
        christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 4/5] clk: rockchip: add video-related niu clocks as critical on px30
Date:   Tue, 17 Sep 2019 10:19:02 +0200
Message-Id: <20190917081903.25139-4-heiko@sntech.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190917081903.25139-1-heiko@sntech.de>
References: <20190917081903.25139-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Video-In and -Out interconnect clocks need to stay on all the
time for the peripheral to work and we do not model the actual
interconnect at this point. So mark them as critical for now.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/rockchip/clk-px30.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/rockchip/clk-px30.c b/drivers/clk/rockchip/clk-px30.c
index 5c77da1e3abc..7a8bc416c947 100644
--- a/drivers/clk/rockchip/clk-px30.c
+++ b/drivers/clk/rockchip/clk-px30.c
@@ -803,25 +803,25 @@ static struct rockchip_clk_branch px30_clk_branches[] __initdata = {
 	GATE(0, "pclk_cpu_hoost", "pclk_top_pre", CLK_IGNORE_UNUSED, PX30_CLKGATE_CON(16), 7, GFLAGS),
 
 	/* PD_VI */
-	GATE(0, "aclk_vi_niu", "aclk_vi_pre", CLK_IGNORE_UNUSED, PX30_CLKGATE_CON(4), 15, GFLAGS),
+	GATE(0, "aclk_vi_niu", "aclk_vi_pre", 0, PX30_CLKGATE_CON(4), 15, GFLAGS),
 	GATE(ACLK_CIF, "aclk_cif", "aclk_vi_pre", 0, PX30_CLKGATE_CON(5), 1, GFLAGS),
 	GATE(ACLK_ISP, "aclk_isp", "aclk_vi_pre", 0, PX30_CLKGATE_CON(5), 3, GFLAGS),
-	GATE(0, "hclk_vi_niu", "hclk_vi_pre", CLK_IGNORE_UNUSED, PX30_CLKGATE_CON(5), 0, GFLAGS),
+	GATE(0, "hclk_vi_niu", "hclk_vi_pre", 0, PX30_CLKGATE_CON(5), 0, GFLAGS),
 	GATE(HCLK_CIF, "hclk_cif", "hclk_vi_pre", 0, PX30_CLKGATE_CON(5), 2, GFLAGS),
 	GATE(HCLK_ISP, "hclk_isp", "hclk_vi_pre", 0, PX30_CLKGATE_CON(5), 4, GFLAGS),
 
 	/* PD_VO */
-	GATE(0, "aclk_vo_niu", "aclk_vo_pre", CLK_IGNORE_UNUSED, PX30_CLKGATE_CON(3), 0, GFLAGS),
+	GATE(0, "aclk_vo_niu", "aclk_vo_pre", 0, PX30_CLKGATE_CON(3), 0, GFLAGS),
 	GATE(ACLK_VOPB, "aclk_vopb", "aclk_vo_pre", 0, PX30_CLKGATE_CON(3), 3, GFLAGS),
 	GATE(ACLK_RGA, "aclk_rga", "aclk_vo_pre", 0, PX30_CLKGATE_CON(3), 7, GFLAGS),
 	GATE(ACLK_VOPL, "aclk_vopl", "aclk_vo_pre", 0, PX30_CLKGATE_CON(3), 5, GFLAGS),
 
-	GATE(0, "hclk_vo_niu", "hclk_vo_pre", CLK_IGNORE_UNUSED, PX30_CLKGATE_CON(3), 1, GFLAGS),
+	GATE(0, "hclk_vo_niu", "hclk_vo_pre", 0, PX30_CLKGATE_CON(3), 1, GFLAGS),
 	GATE(HCLK_VOPB, "hclk_vopb", "hclk_vo_pre", 0, PX30_CLKGATE_CON(3), 4, GFLAGS),
 	GATE(HCLK_RGA, "hclk_rga", "hclk_vo_pre", 0, PX30_CLKGATE_CON(3), 8, GFLAGS),
 	GATE(HCLK_VOPL, "hclk_vopl", "hclk_vo_pre", 0, PX30_CLKGATE_CON(3), 6, GFLAGS),
 
-	GATE(0, "pclk_vo_niu", "pclk_vo_pre", CLK_IGNORE_UNUSED, PX30_CLKGATE_CON(3), 2, GFLAGS),
+	GATE(0, "pclk_vo_niu", "pclk_vo_pre", 0, PX30_CLKGATE_CON(3), 2, GFLAGS),
 	GATE(PCLK_MIPI_DSI, "pclk_mipi_dsi", "pclk_vo_pre", 0, PX30_CLKGATE_CON(3), 9, GFLAGS),
 
 	/* PD_BUS */
@@ -986,6 +986,11 @@ static const char *const px30_cru_critical_clocks[] __initconst = {
 	"pclk_top_pre",
 	"pclk_pmu_pre",
 	"hclk_usb_niu",
+	"pclk_vo_niu",
+	"aclk_vo_niu",
+	"hclk_vo_niu",
+	"aclk_vi_niu",
+	"hclk_vi_niu",
 	"pll_npll",
 	"usb480m",
 	"clk_uart2",
-- 
2.20.1

