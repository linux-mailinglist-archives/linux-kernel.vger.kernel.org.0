Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58DF67CCCD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 21:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731002AbfGaTfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 15:35:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:34862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730474AbfGaTfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 15:35:20 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09BF3217D4;
        Wed, 31 Jul 2019 19:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564601719;
        bh=IXR4z2hRw5kKjUq0WJnH1vtbDbTtP6ODCiSW8+n9P/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ETXIB/uwVwWPB94kChvnIhXWEh0VXb++xeOuPLSoiqQddidR5Sa3hTA+HdszWkOm/
         ctk5zh9HZDoGG48JUc59J/mOS06Ys0hrBVN+oXsAlEoy97uDBJrxQo0DKGdK9McXx4
         gzeXKGVHCLR+xKrqvzTceYTGfHJ2d1QAKS8fD41U=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 2/9] clk: lochnagar: Don't reference clk_init_data after registration
Date:   Wed, 31 Jul 2019 12:35:10 -0700
Message-Id: <20190731193517.237136-3-sboyd@kernel.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190731193517.237136-1-sboyd@kernel.org>
References: <20190731193517.237136-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A future patch is going to change semantics of clk_register() so that
clk_hw::init is guaranteed to be NULL after a clk is registered. Avoid
referencing this member here so that we don't run into NULL pointer
exceptions.

Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---

Please ack so I can take this through clk tree

 drivers/clk/clk-lochnagar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-lochnagar.c b/drivers/clk/clk-lochnagar.c
index fa8c91758b1d..565bcd0cdde9 100644
--- a/drivers/clk/clk-lochnagar.c
+++ b/drivers/clk/clk-lochnagar.c
@@ -198,7 +198,7 @@ static u8 lochnagar_clk_get_parent(struct clk_hw *hw)
 	if (ret < 0) {
 		dev_dbg(priv->dev, "Failed to read parent of %s: %d\n",
 			lclk->name, ret);
-		return hw->init->num_parents;
+		return clk_hw_get_num_parents(hw);
 	}
 
 	val &= lclk->src_mask;
-- 
Sent by a computer through tubes

