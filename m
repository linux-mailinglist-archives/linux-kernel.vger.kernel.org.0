Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E33DA22DB4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 10:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730976AbfETIFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 04:05:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:36608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730862AbfETIFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:05:38 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09F842146F;
        Mon, 20 May 2019 08:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558339537;
        bh=CWNcXcAiiwq60Rxoas+cEOG2AqiMII6Upp6sD2Byv84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wHL45ANTG59HHoxXdcVLam0z457jT6PGVw7gbBmpJftjcCdyD/mrtLx1lsNkgVWwo
         J9JwEpJ5ituKo+ZjXt0AJmt5eSu7ZGwYR/0a8pi6HflCi4AduivatUjdceTLe9+qf6
         mSiax4axNXHRhdVmOHZANQesx4KwOT8/X+nRpQjk=
Received: by wens.tw (Postfix, from userid 1000)
        id 75FEE60527; Mon, 20 May 2019 16:05:32 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/25] clk: sunxi-ng: switch to of_clk_hw_register() for registering clks
Date:   Mon, 20 May 2019 16:04:04 +0800
Message-Id: <20190520080421.12575-9-wens@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520080421.12575-1-wens@kernel.org>
References: <20190520080421.12575-1-wens@kernel.org>
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

