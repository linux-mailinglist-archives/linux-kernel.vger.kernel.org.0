Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01CFB9E452
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 11:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbfH0JcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 05:32:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729232AbfH0JcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 05:32:10 -0400
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D013321872;
        Tue, 27 Aug 2019 09:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566898329;
        bh=1d+XOT4U/2uQBCfgzLcq1WP0gCEmQYO/efc0j4zg794=;
        h=From:To:Cc:Subject:Date:From;
        b=s4yfYIoMR1xQ7wQ4kWuakB8VAPqV6OMXJ5L2tRjkFQaKCD/bJNo3lu6NW92HHwDQm
         hFwnQrBUT2JtGOZIfgYmODM0UmYV7xk5Jj6hurF1g67GjEjLWlmSnsGMo7TQzRG+Ki
         phSeujsX1he43Kh4f8LJtOMB2zxEc4gKZDqkT33E=
From:   Maxime Ripard <mripard@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        codekipper@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Revert "ASoC: sun4i-i2s: Remove duplicated quirks structure"
Date:   Tue, 27 Aug 2019 11:32:05 +0200
Message-Id: <20190827093206.17919-1-mripard@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

This reverts commit 3e9acd7ac6933cdc20c441bbf9a38ed9e42e1490.

It turns out that while one I2S controller is described in the A83t
datasheet, the driver supports another, undocumented, one that has been
inherited from the older SoCs, while the documented one uses the new
design.

Fixes: 3e9acd7ac693 ("ASoC: sun4i-i2s: Remove duplicated quirks structure")
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 57bf2a33753e..a6a3f772fdf0 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -1097,6 +1097,11 @@ static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
 	.set_fmt		= sun4i_i2s_set_soc_fmt,
 };
 
+/*
+ * This doesn't describe the TDM controller documented in the A83t
+ * datasheet, but the three undocumented I2S controller that use the
+ * older design.
+ */
 static const struct sun4i_i2s_quirks sun8i_a83t_i2s_quirks = {
 	.has_reset		= true,
 	.reg_offset_txdata	= SUN8I_I2S_FIFO_TX_REG,
@@ -1115,6 +1120,24 @@ static const struct sun4i_i2s_quirks sun8i_a83t_i2s_quirks = {
 	.set_fmt		= sun8i_i2s_set_soc_fmt,
 };
 
+static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
+	.has_reset		= true,
+	.reg_offset_txdata	= SUN8I_I2S_FIFO_TX_REG,
+	.sun4i_i2s_regmap	= &sun8i_i2s_regmap_config,
+	.field_clkdiv_mclk_en	= REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 8, 8),
+	.field_fmt_wss		= REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 2),
+	.field_fmt_sr		= REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 6),
+	.bclk_dividers		= sun8i_i2s_clk_div,
+	.num_bclk_dividers	= ARRAY_SIZE(sun8i_i2s_clk_div),
+	.mclk_dividers		= sun8i_i2s_clk_div,
+	.num_mclk_dividers	= ARRAY_SIZE(sun8i_i2s_clk_div),
+	.get_bclk_parent_rate	= sun8i_i2s_get_bclk_parent_rate,
+	.get_sr			= sun8i_i2s_get_sr_wss,
+	.get_wss		= sun8i_i2s_get_sr_wss,
+	.set_chan_cfg		= sun8i_i2s_set_chan_cfg,
+	.set_fmt		= sun8i_i2s_set_soc_fmt,
+};
+
 static const struct sun4i_i2s_quirks sun50i_a64_codec_i2s_quirks = {
 	.has_reset		= true,
 	.reg_offset_txdata	= SUN8I_I2S_FIFO_TX_REG,
@@ -1296,7 +1319,7 @@ static const struct of_device_id sun4i_i2s_match[] = {
 	},
 	{
 		.compatible = "allwinner,sun8i-h3-i2s",
-		.data = &sun8i_a83t_i2s_quirks,
+		.data = &sun8i_h3_i2s_quirks,
 	},
 	{
 		.compatible = "allwinner,sun50i-a64-codec-i2s",
-- 
2.21.0

