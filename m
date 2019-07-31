Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA5D7CCD8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 21:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730535AbfGaTfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 15:35:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:34876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729737AbfGaTfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 15:35:21 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B23B4217D7;
        Wed, 31 Jul 2019 19:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564601720;
        bh=HfN2MQysfM/pLD5DmbpZ0LVsnJDMstZJe8ye/rK0+DQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L7Yrh/vXryB3bAXc1CeV3+7xXmKVJOrb7RdSzBnKcrQk3zCAqWM8DXukbpi6MUXR6
         GN8I9zssC2xz55HDCiKSuJIzeqj6pcvQ0d6itfiRCk48OUY/Ln+eiuitXntGp95Ul7
         6gmNP47EnDr4iCHM935am3Xh3zQvhS70M9RqqKf4=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 7/9] clk: sprd: Don't reference clk_init_data after registration
Date:   Wed, 31 Jul 2019 12:35:15 -0700
Message-Id: <20190731193517.237136-8-sboyd@kernel.org>
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

Cc: Chunyan Zhang <zhang.chunyan@linaro.org>
Cc: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---

Please ack so I can take this through clk tree

 drivers/clk/sprd/common.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sprd/common.c b/drivers/clk/sprd/common.c
index a5bdca1de5d0..9d56eac43832 100644
--- a/drivers/clk/sprd/common.c
+++ b/drivers/clk/sprd/common.c
@@ -76,16 +76,17 @@ int sprd_clk_probe(struct device *dev, struct clk_hw_onecell_data *clkhw)
 	struct clk_hw *hw;
 
 	for (i = 0; i < clkhw->num; i++) {
+		const char *name;
 
 		hw = clkhw->hws[i];
-
 		if (!hw)
 			continue;
 
+		name = hw->init->name;
 		ret = devm_clk_hw_register(dev, hw);
 		if (ret) {
 			dev_err(dev, "Couldn't register clock %d - %s\n",
-				i, hw->init->name);
+				i, name);
 			return ret;
 		}
 	}
-- 
Sent by a computer through tubes

