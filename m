Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCE0E12414
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 23:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfEBVZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 17:25:31 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:53188 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfEBVZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 17:25:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1556832326; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9ODNI1c+j7fdKKl1esNaM/BKEOwQ5AuMNjuepeSujCg=;
        b=BBggk0sgl7K2G+eCdu83XF9ejz6y1//U4czroSDabkbCLUlOn/t1uLRZzMP0sfcg+ve15Z
        CuKrSXHdhB9mgio92crjRdDd4bCQBboHYQeWJDBcdP0ftWYbYCU2CcN6jMdMu9fM8Emoi/
        LAVm/8HIobs5QLMKJXmoDy1o30zpDYQ=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        od@zcrc.me, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 5/5] clk: ingenic/jz4725b: Fix "pll half" divider not read/written properly
Date:   Thu,  2 May 2019 23:25:02 +0200
Message-Id: <20190502212502.24330-5-paul@crapouillou.net>
In-Reply-To: <20190502212502.24330-1-paul@crapouillou.net>
References: <20190502212502.24330-1-paul@crapouillou.net>
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
 drivers/clk/ingenic/jz4725b-cgu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/ingenic/jz4725b-cgu.c b/drivers/clk/ingenic/jz4725b-cgu.c
index 31325dd40a0f..47287956824b 100644
--- a/drivers/clk/ingenic/jz4725b-cgu.c
+++ b/drivers/clk/ingenic/jz4725b-cgu.c
@@ -37,6 +37,10 @@ static const u8 jz4725b_cgu_cpccr_div_table[] = {
 	1, 2, 3, 4, 6, 8,
 };
 
+static const u8 jz4725b_cgu_pll_half_div_table[] = {
+	2, 1,
+};
+
 static const struct ingenic_cgu_clk_info jz4725b_cgu_clocks[] = {
 
 	/* External clocks */
@@ -70,7 +74,10 @@ static const struct ingenic_cgu_clk_info jz4725b_cgu_clocks[] = {
 	[JZ4725B_CLK_PLL_HALF] = {
 		"pll half", CGU_CLK_DIV,
 		.parents = { JZ4725B_CLK_PLL, -1, -1, -1 },
-		.div = { CGU_REG_CPCCR, 21, 1, 1, -1, -1, -1 },
+		.div = {
+			CGU_REG_CPCCR, 21, 1, 1, -1, -1, -1,
+			jz4725b_cgu_pll_half_div_table,
+		},
 	},
 
 	[JZ4725B_CLK_CCLK] = {
-- 
2.21.0.593.g511ec345e18

