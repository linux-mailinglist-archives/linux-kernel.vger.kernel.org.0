Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0726446515
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 18:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfFNQzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 12:55:11 -0400
Received: from gloria.sntech.de ([185.11.138.130]:43224 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbfFNQzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 12:55:06 -0400
Received: from we0305.dip.tu-dresden.de ([141.76.177.49] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hbpTd-0006Tl-L3; Fri, 14 Jun 2019 18:54:57 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org,
        justin.swartz@risingedge.co.za, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 2/4] clk: rockchip: export HDMIPHY clock
Date:   Fri, 14 Jun 2019 18:54:52 +0200
Message-Id: <20190614165454.13743-3-heiko@sntech.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614165454.13743-1-heiko@sntech.de>
References: <20190614165454.13743-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export the hdmiphy clock mux via the newly added clock-id.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/rockchip/clk-rk3228.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3228.c b/drivers/clk/rockchip/clk-rk3228.c
index 1c5267d134ee..d17cfb7a3ff4 100644
--- a/drivers/clk/rockchip/clk-rk3228.c
+++ b/drivers/clk/rockchip/clk-rk3228.c
@@ -247,7 +247,7 @@ static struct rockchip_clk_branch rk3228_clk_branches[] __initdata = {
 			RK2928_CLKGATE_CON(4), 0, GFLAGS),
 
 	/* PD_MISC */
-	MUX(0, "hdmiphy", mux_hdmiphy_p, CLK_SET_RATE_PARENT,
+	MUX(SCLK_HDMI_PHY, "hdmiphy", mux_hdmiphy_p, CLK_SET_RATE_PARENT,
 			RK2928_MISC_CON, 13, 1, MFLAGS),
 	MUX(0, "usb480m_phy", mux_usb480m_phy_p, CLK_SET_RATE_PARENT,
 			RK2928_MISC_CON, 14, 1, MFLAGS),
-- 
2.20.1

