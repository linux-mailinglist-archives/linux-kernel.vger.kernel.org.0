Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 490F13C89C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 12:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405594AbfFKKSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 06:18:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:45906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405317AbfFKKRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 06:17:24 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 827E2217D9;
        Tue, 11 Jun 2019 10:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560248243;
        bh=Gs3AgomSubATACS4jWlB2DAJEOVJHDxnXjCX4Nxms6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ekw9hRoHorHFxSax/mYa15LpMvRtWkpPypYsqYlK8+VY9vlE7qT7S19rS8asA6Tmw
         xrzWHYa8gEFOtFz//xBW/yZTsHWLLen2KdmHnbjjbDXJtjzpypg2buCXWPs3wT5wS8
         ypKieVppo0a6sKrdKWaYl0s0gBonH4loCrBWKpqk=
Received: by wens.tw (Postfix, from userid 1000)
        id 64A4860054; Tue, 11 Jun 2019 18:17:18 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Chen-Yu Tsai <wens@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v2 14/25] clk: sunxi-ng: a33: Use local parent references for CLK_FIXED_FACTOR
Date:   Tue, 11 Jun 2019 18:16:47 +0800
Message-Id: <20190611101658.23855-15-wens@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611101658.23855-1-wens@kernel.org>
References: <20190611101658.23855-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

With the new clk parenting code and CLK_FIXED_FACTOR_{HW,FW_NAME}
macros, we can reference parents locally via pointers to struct clk_hw
or DT clock-names.

Convert existing CLK_FIXED_FACTOR definitions to either the _HW or
_FW_NAME variant based on whether the parent clock is internal or
external to the CCU.

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu-sun8i-a33.c | 34 ++++++++++++++++++----------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
index 25bcf3fd2dfc..25a14548f39b 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
@@ -588,19 +588,29 @@ static struct ccu_common *sun8i_a33_ccu_clks[] = {
 	&ats_clk.common,
 };
 
+static const struct clk_hw *clk_parent_pll_audio[] = {
+	&pll_audio_base_clk.common.hw
+};
+
 /* We hardcode the divider to 1 for now */
-static CLK_FIXED_FACTOR(pll_audio_clk, "pll-audio",
-			"pll-audio-base", 1, 1, CLK_SET_RATE_PARENT);
-static CLK_FIXED_FACTOR(pll_audio_2x_clk, "pll-audio-2x",
-			"pll-audio-base", 2, 1, CLK_SET_RATE_PARENT);
-static CLK_FIXED_FACTOR(pll_audio_4x_clk, "pll-audio-4x",
-			"pll-audio-base", 1, 1, CLK_SET_RATE_PARENT);
-static CLK_FIXED_FACTOR(pll_audio_8x_clk, "pll-audio-8x",
-			"pll-audio-base", 1, 2, CLK_SET_RATE_PARENT);
-static CLK_FIXED_FACTOR(pll_periph_2x_clk, "pll-periph-2x",
-			"pll-periph", 1, 2, 0);
-static CLK_FIXED_FACTOR(pll_video_2x_clk, "pll-video-2x",
-			"pll-video", 1, 2, 0);
+static CLK_FIXED_FACTOR_HWS(pll_audio_clk, "pll-audio",
+			    clk_parent_pll_audio,
+			    1, 1, CLK_SET_RATE_PARENT);
+static CLK_FIXED_FACTOR_HWS(pll_audio_2x_clk, "pll-audio-2x",
+			    clk_parent_pll_audio,
+			    2, 1, CLK_SET_RATE_PARENT);
+static CLK_FIXED_FACTOR_HWS(pll_audio_4x_clk, "pll-audio-4x",
+			    clk_parent_pll_audio,
+			    1, 1, CLK_SET_RATE_PARENT);
+static CLK_FIXED_FACTOR_HWS(pll_audio_8x_clk, "pll-audio-8x",
+			    clk_parent_pll_audio,
+			    1, 2, CLK_SET_RATE_PARENT);
+static CLK_FIXED_FACTOR_HW(pll_periph_2x_clk, "pll-periph-2x",
+			   &pll_periph_clk.common.hw,
+			   1, 2, 0);
+static CLK_FIXED_FACTOR_HW(pll_video_2x_clk, "pll-video-2x",
+			   &pll_video_clk.common.hw,
+			   1, 2, 0);
 
 static struct clk_hw_onecell_data sun8i_a33_hw_clks = {
 	.hws	= {
-- 
2.20.1

