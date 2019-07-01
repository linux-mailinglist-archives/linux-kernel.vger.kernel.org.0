Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72DE822DE9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 10:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730757AbfETIHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 04:07:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:36438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730841AbfETIFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:05:37 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5505208C3;
        Mon, 20 May 2019 08:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558339537;
        bh=UH9oqVCe7Dp6WGo3nZFvV6Debv4vruY9AL9X+Dbmoe4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OYLhZUkr8atpajMwGAZcCQEPdVh0k+kQsEjUoV/eOoGzJr/OO8QftFMgHS+gnfJzL
         GfmnFrTqhgUGQBOB5cQ4T6nmcWsMuIVCmPu7LBIrUE1I92qkSu6OWTvolI0Q0zB8P5
         2ghINoVBHFxbisyQRWMpZq4yJN4qbt+xc3rzkDOs=
Received: by wens.tw (Postfix, from userid 1000)
        id 6151D5FF6A; Mon, 20 May 2019 16:05:32 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/25] clk: fixed-factor: Add CLK_FIXED_FACTOR_HW which takes clk_hw pointer as parent
Date:   Mon, 20 May 2019 16:04:01 +0800
Message-Id: <20190520080421.12575-6-wens@kernel.org>
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

With the new clk parenting code, clk_init_data was expanded to include
.parent_hws, for clk drivers to directly reference parents by clk_hw.

Add a new macro, CLK_FIXED_FACTOR_HW, that can take a struct clk_hw
pointer, instead of a string, as its parent.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 include/linux/clk-provider.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index d0d58c49f3ad..c7b10dd32c39 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -980,6 +980,17 @@ extern struct of_device_id __clk_of_table;
 					      _flags),			\
 	}
 
+#define CLK_FIXED_FACTOR_HW(_struct, _name, _parent,			\
+			    _div, _mult, _flags)			\
+	struct clk_fixed_factor _struct = {				\
+		.div		= _div,					\
+		.mult		= _mult,				\
+		.hw.init	= CLK_HW_INIT_HW(_name,			\
+						 _parent,		\
+						 &clk_fixed_factor_ops,	\
+						 _flags),		\
+	}
+
 #ifdef CONFIG_OF
 int of_clk_add_provider(struct device_node *np,
 			struct clk *(*clk_src_get)(struct of_phandle_args *args,
-- 
2.20.1

