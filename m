Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31EDE22DED
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 10:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbfETIHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 04:07:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:36248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730649AbfETIFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:05:35 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD2A320862;
        Mon, 20 May 2019 08:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558339534;
        bh=vDLQsD2B5mKgg/9AQ94YonY87MdfYhRV3o85LNhdwaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HJuDNJ69iFBxjhRIg6uFFFy37jUgmClEn9Bsh6rx5GBRiCi8dFoIsntl5w2gysoac
         tsFAJ2b7dRlAwkFZefoyRVWM2RV6Fdxi6+NZQ+cz8NJpBswUVPo1J9oNofZ8Ni84Mg
         Rk5CsVk6X+Ze4QnKROEdeHLTcSAErvNKvLssEGyk=
Received: by wens.tw (Postfix, from userid 1000)
        id 413565FD5D; Mon, 20 May 2019 16:05:32 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/25] clk: Add CLK_HW_INIT_* macros using .parent_hws
Date:   Mon, 20 May 2019 16:03:58 +0800
Message-Id: <20190520080421.12575-3-wens@kernel.org>
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

With the new clk parenting code, struct clk_init_data was expanded to
include .parent_hws, for clk drivers to directly list parents by
pointing to their respective struct clk_hw's.

Add macros that can take either one single struct clk_hw *, or an array
of them, for drivers to use.

A special CLK_HW_INIT_HWS macro is included, which takes an array of
struct clk_hw *, but sets .num_parents to 1. This variant is to allow
the reuse of the array, instead of having a compound literal allocated
for each clk sharing the same parent.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 include/linux/clk-provider.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index bb6118f79784..0c241b43a802 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -904,6 +904,24 @@ extern struct of_device_id __clk_of_table;
 		.ops		= _ops,				\
 	})
 
+#define CLK_HW_INIT_HW(_name, _parent, _ops, _flags)			\
+	(&(struct clk_init_data) {					\
+		.flags		= _flags,				\
+		.name		= _name,				\
+		.parent_hws	= (const struct clk_hw*[]) { _parent },	\
+		.num_parents	= 1,					\
+		.ops		= _ops,					\
+	})
+
+#define CLK_HW_INIT_HWS(_name, _parent, _ops, _flags)			\
+	(&(struct clk_init_data) {					\
+		.flags		= _flags,				\
+		.name		= _name,				\
+		.parent_hws	= _parent,				\
+		.num_parents	= 1,					\
+		.ops		= _ops,					\
+	})
+
 #define CLK_HW_INIT_PARENTS(_name, _parents, _ops, _flags)	\
 	(&(struct clk_init_data) {				\
 		.flags		= _flags,			\
@@ -913,6 +931,15 @@ extern struct of_device_id __clk_of_table;
 		.ops		= _ops,				\
 	})
 
+#define CLK_HW_INIT_PARENTS_HW(_name, _parents, _ops, _flags)	\
+	(&(struct clk_init_data) {				\
+		.flags		= _flags,			\
+		.name		= _name,			\
+		.parent_hws	= _parents,			\
+		.num_parents	= ARRAY_SIZE(_parents),		\
+		.ops		= _ops,				\
+	})
+
 #define CLK_HW_INIT_NO_PARENT(_name, _ops, _flags)	\
 	(&(struct clk_init_data) {			\
 		.flags          = _flags,		\
-- 
2.20.1

