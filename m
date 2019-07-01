Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8C9B5BAD0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2019 13:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbfGALgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 07:36:18 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:50972 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfGALgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 07:36:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1561980974; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=6st6YfL1K5fciSijgkV7Q9swYmHShkUiWCGFkUwqYwY=;
        b=TNdIc2/mm8r7MrUYXYX+Ks6pEHsk7ukjdSfYpfnZP8miFQ8d8QPEaSAsfmn4TzOkZE4BGM
        Hsfb0k6ZSwTxDQa2Jv6RbWhvJwMAdq7jTWDQzPFPmv7NNsz01AZI6zdY4SN7QpuZT6HhGD
        vW19LhV1X7+LamoGTKO0or7R/97Z4Cw=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] clk: ingenic/jz4740: Fix "pll half" divider not read/written properly
Date:   Mon,  1 Jul 2019 13:36:06 +0200
Message-Id: <20190701113606.4130-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code was setting the bit 21 of the CPCCR register to use a divider
of 2 for the "pll half" clock, and clearing the bit to use a divider
of 1.

This is the opposite of how this register field works: a cleared bit
means that the /2 divider is used, and a set bit means that the divider
is 1.

Restore the correct behaviour using the newly introduced .div_table
field.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/clk/ingenic/jz4740-cgu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/ingenic/jz4740-cgu.c b/drivers/clk/ingenic/jz4740-cgu.c
index a7f8ce60c957..0957ba4a40a5 100644
--- a/drivers/clk/ingenic/jz4740-cgu.c
+++ b/drivers/clk/ingenic/jz4740-cgu.c
@@ -53,6 +53,10 @@ static const u8 jz4740_cgu_cpccr_div_table[] = {
 	1, 2, 3, 4, 6, 8, 12, 16, 24, 32,
 };
 
+static const u8 jz4740_cgu_pll_half_div_table[] = {
+	2, 1,
+};
+
 static const struct ingenic_cgu_clk_info jz4740_cgu_clocks[] = {
 
 	/* External clocks */
@@ -86,7 +90,10 @@ static const struct ingenic_cgu_clk_info jz4740_cgu_clocks[] = {
 	[JZ4740_CLK_PLL_HALF] = {
 		"pll half", CGU_CLK_DIV,
 		.parents = { JZ4740_CLK_PLL, -1, -1, -1 },
-		.div = { CGU_REG_CPCCR, 21, 1, 1, -1, -1, -1 },
+		.div = {
+			CGU_REG_CPCCR, 21, 1, 1, -1, -1, -1,
+			jz4740_cgu_pll_half_div_table,
+		},
 	},
 
 	[JZ4740_CLK_CCLK] = {
-- 
2.21.0.593.g511ec345e18

