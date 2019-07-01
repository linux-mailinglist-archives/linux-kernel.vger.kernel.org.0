Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 206703C870
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 12:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405379AbfFKKRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 06:17:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405306AbfFKKRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 06:17:24 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3261C214AF;
        Tue, 11 Jun 2019 10:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560248243;
        bh=qEBYkTzxu/4Dl1C/hKhql6onxGB35Izjqxrvnp600eY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1RrAK4RxwCMNIxmV3bMIAMHOb1OpEaNrTYnT6godqRCYxR2FFD+TfyydiP6auGxsz
         S5Yp0JuO7IA+qv2hzXBVowD5yAt99ipjuDIUwzA+yYebJRw3ietvoj+Q3vS2Dqroce
         jB82hke8ymxLUBfhT7xfj/xiI4tsVnDciZ4nuhG8=
Received: by wens.tw (Postfix, from userid 1000)
        id 3A8A1603A9; Tue, 11 Jun 2019 18:17:18 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Chen-Yu Tsai <wens@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v2 07/25] clk: fixed-factor: Add CLK_FIXED_FACTOR_FW_NAME for DT clock-names parent
Date:   Tue, 11 Jun 2019 18:16:40 +0800
Message-Id: <20190611101658.23855-8-wens@kernel.org>
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
.parent_data, for clk drivers to specify parents using a combination of
device tree clock-names, pointers to struct clk_hw, device tree clocks,
and/or fallback global clock names.

Add a new macro, CLK_FIXED_FACTOR_FW_NAME, that takes a string to match
a clock-names entry in the device tree to specify the clock parent.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 include/linux/clk-provider.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 146a6859969e..e5c44f6dd897 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -1011,6 +1011,17 @@ extern struct of_device_id __clk_of_table;
 						  _flags),	\
 	}
 
+#define CLK_FIXED_FACTOR_FW_NAME(_struct, _name, _parent,		\
+				 _div, _mult, _flags)			\
+	struct clk_fixed_factor _struct = {				\
+		.div		= _div,					\
+		.mult		= _mult,				\
+		.hw.init	= CLK_HW_INIT_FW_NAME(_name,		\
+						      _parent,		\
+						      &clk_fixed_factor_ops, \
+						      _flags),		\
+	}
+
 #ifdef CONFIG_OF
 int of_clk_add_provider(struct device_node *np,
 			struct clk *(*clk_src_get)(struct of_phandle_args *args,
-- 
2.20.1

