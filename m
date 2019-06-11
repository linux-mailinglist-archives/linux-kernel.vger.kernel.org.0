Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88DA53C8A6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 12:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405280AbfFKKRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 06:17:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:45530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404521AbfFKKRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 06:17:21 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 071F52089E;
        Tue, 11 Jun 2019 10:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560248241;
        bh=KouIinatvemgGOpgiZa1tRYYMGvRXsqhx6dScroA1Vs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CFB2YHMnvMkfpUyAFeJiyjHkB4CQZ6FHv6lpmcoKZfnpJyfbCudWCGLgpRvh8ORLO
         OVzJW+8UiLiFiA9nyq3s/PnIJyJJJZAuZxlMuKF92saI7HPoZzPRRKMnOi66OCJFm7
         g5TzEQ7GoTld8RtLC8HzWPDKi2kMtJ4bnIlbpvag=
Received: by wens.tw (Postfix, from userid 1000)
        id 2A0675FE53; Tue, 11 Jun 2019 18:17:18 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Chen-Yu Tsai <wens@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v2 04/25] clk: Add CLK_HW_INIT_PARENT_DATA macro using .parent_data
Date:   Tue, 11 Jun 2019 18:16:37 +0800
Message-Id: <20190611101658.23855-5-wens@kernel.org>
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

With the new clk parenting code, struct clk_init_data was expanded to
include .parent_data, for clk drivers that have parents referenced using
a combination of device tree clock-names, clock indices, and/or struct
clk_hw pointers.

Add a new macro that can take a list of struct clk_parent_data for
drivers to use.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 include/linux/clk-provider.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index b19063512a29..0fd14c4874d6 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -956,6 +956,15 @@ extern struct of_device_id __clk_of_table;
 		.ops		= _ops,				\
 	})
 
+#define CLK_HW_INIT_PARENTS_DATA(_name, _parents, _ops, _flags)	\
+	(&(struct clk_init_data) {				\
+		.flags		= _flags,			\
+		.name		= _name,			\
+		.parent_data	= _parents,			\
+		.num_parents	= ARRAY_SIZE(_parents),		\
+		.ops		= _ops,				\
+	})
+
 #define CLK_HW_INIT_NO_PARENT(_name, _ops, _flags)	\
 	(&(struct clk_init_data) {			\
 		.flags          = _flags,		\
-- 
2.20.1

