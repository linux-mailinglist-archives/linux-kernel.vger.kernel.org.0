Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3105D3C86A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 12:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405357AbfFKKR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 06:17:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:45710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405305AbfFKKRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 06:17:23 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 290F1205F4;
        Tue, 11 Jun 2019 10:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560248243;
        bh=/09KXtWMPv1zDkULx4kUbHsUHwiB0AovEkKYAfE+tjE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YrENXfBzzImZk3E1jcAAmytgqJelWHx7GPPcLLtW59aeb2j+mMwraPZUBnJrO9vxb
         zGslfYs8c45q6f2PMNSs/rJeHf8GaHfbAT9FEIn8O7k1FVCUnZyx+bE7ckjYy17JBE
         SIOa3YxkEfgEnWIFfSB04UndiVN9XazPD10GwAAE=
Received: by wens.tw (Postfix, from userid 1000)
        id 3F187603E3; Tue, 11 Jun 2019 18:17:18 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Chen-Yu Tsai <wens@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v2 08/25] clk: sunxi-ng: switch to of_clk_hw_register() for registering clks
Date:   Tue, 11 Jun 2019 18:16:41 +0800
Message-Id: <20190611101658.23855-9-wens@kernel.org>
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

Commit 89a5ddcc799d ("clk: Add of_clk_hw_register() API for early clk
drivers") introduces a new API for registering clks, which allows the
user to directly specify a device node, even if there is no struct
device attached to it. The device node is used for local DT clock-names
matching.

Switch to of_clk_hw_register() so that local DT clock-names matching
works.

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu_common.c b/drivers/clk/sunxi-ng/ccu_common.c
index 40aac316128f..f1db29854934 100644
--- a/drivers/clk/sunxi-ng/ccu_common.c
+++ b/drivers/clk/sunxi-ng/ccu_common.c
@@ -110,7 +110,7 @@ int sunxi_ccu_probe(struct device_node *node, void __iomem *reg,
 		if (!hw)
 			continue;
 
-		ret = clk_hw_register(NULL, hw);
+		ret = of_clk_hw_register(node, hw);
 		if (ret) {
 			pr_err("Couldn't register clock %d - %s\n",
 			       i, clk_hw_get_name(hw));
-- 
2.20.1

