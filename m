Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16BFD3C8A1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 12:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405604AbfFKKS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 06:18:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:45786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405309AbfFKKRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 06:17:23 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5353E2173B;
        Tue, 11 Jun 2019 10:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560248243;
        bh=i0B2yKWgFIEvAKMI/QmOeIMqDZsEa7g7GDicC8lryn0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Drz0VCn5Hmx5zfQP1b0rziWP4CDB+dhNluMzjRB9YHIbY6e99bX1G060yBDFLYcxX
         Fw/pfmH0zyzmPBwXxSNy6buCAK1W+1LjPbJRnPUSg1rUm/Uccft5YG6BdQw4gZWjQF
         ML4TGu6j+skip6u8wwq9XlHA8vZ2KcjkEEoO8Ogk=
Received: by wens.tw (Postfix, from userid 1000)
        id 2EE09600FD; Tue, 11 Jun 2019 18:17:18 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Chen-Yu Tsai <wens@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v2 05/25] clk: fixed-factor: Add CLK_FIXED_FACTOR_HW which takes clk_hw pointer as parent
Date:   Tue, 11 Jun 2019 18:16:38 +0800
Message-Id: <20190611101658.23855-6-wens@kernel.org>
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

With the new clk parenting code, clk_init_data was expanded to include
.parent_hws, for clk drivers to directly reference parents by clk_hw.

Add a new macro, CLK_FIXED_FACTOR_HW, that can take a struct clk_hw
pointer, instead of a string, as its parent.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 include/linux/clk-provider.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 0fd14c4874d6..c85e9f3809f2 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -985,6 +985,17 @@ extern struct of_device_id __clk_of_table;
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

