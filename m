Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84FF38E367
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 06:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfHOEKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 00:10:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:33152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbfHOEKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 00:10:38 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37CF9208C2;
        Thu, 15 Aug 2019 04:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565842238;
        bh=8F3KRsBxdhyWon/KQ5t5lXGBquSIxOV11AsIVZq7ikQ=;
        h=From:To:Cc:Subject:Date:From;
        b=QHwVyyn3C/XQA4Csutk/Nfs1u2TaBaXhbnpmmiQs9nwObS17SgmrWrpd5PCpCRTJo
         U7MMeOVGYnOx/aanAWmj0gRPLfFw+/kW0LnoUDXenr3muZyvliLInjrX1NaYUi3ASY
         dfEXFC1qN/ue9gWK+TSQHvSsJmG7PmiTR7/lAqXI=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH] clk: sunxi: Don't call clk_hw_get_name() on a hw that isn't registered
Date:   Wed, 14 Aug 2019 21:10:37 -0700
Message-Id: <20190815041037.3470-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The implementation of clk_hw_get_name() relies on the clk_core
associated with the clk_hw pointer existing. If of_clk_hw_register()
fails, there isn't a clk_core created yet, so calling clk_hw_get_name()
here fails. Extract the name first so we can print it later.

Fixes: 1d80c14248d6 ("clk: sunxi-ng: Add common infrastructure")
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/sunxi-ng/ccu_common.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_common.c b/drivers/clk/sunxi-ng/ccu_common.c
index 7fe3ac980e5f..2e20e650b6c0 100644
--- a/drivers/clk/sunxi-ng/ccu_common.c
+++ b/drivers/clk/sunxi-ng/ccu_common.c
@@ -97,14 +97,15 @@ int sunxi_ccu_probe(struct device_node *node, void __iomem *reg,
 
 	for (i = 0; i < desc->hw_clks->num ; i++) {
 		struct clk_hw *hw = desc->hw_clks->hws[i];
+		const char *name;
 
 		if (!hw)
 			continue;
 
+		name = hw->init->name;
 		ret = of_clk_hw_register(node, hw);
 		if (ret) {
-			pr_err("Couldn't register clock %d - %s\n",
-			       i, clk_hw_get_name(hw));
+			pr_err("Couldn't register clock %d - %s\n", i, name);
 			goto err_clk_unreg;
 		}
 	}

base-commit: 5f9e832c137075045d15cd6899ab0505cfb2ca4b
-- 
Sent by a computer through tubes

