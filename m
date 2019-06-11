Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDEB3C867
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 12:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405321AbfFKKRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 06:17:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:45536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404870AbfFKKRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 06:17:21 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 123762145D;
        Tue, 11 Jun 2019 10:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560248241;
        bh=ppRbblaoSv/UGkFO4M4R5lNJos+EEEismPHwgTzrRYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lVYwXSO69AAjv7KePSI7sy5UBERDwLb/mALz26kW28J6qpH3OTJYhh+vy25TQBC+8
         aZAM0dVhGA2pMBHF1MmgOqjqOU1oBEG5BZKSzOK5Y3n7HRweMZtBYDMeShMHcWuTUM
         z0rIyshUq0Q8LsQo/3A8U+0+JVSOD8H0sK6ZQjSs=
Received: by wens.tw (Postfix, from userid 1000)
        id 20D986004A; Tue, 11 Jun 2019 18:17:18 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Chen-Yu Tsai <wens@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v2 03/25] clk: Add CLK_HW_INIT_FW_NAME macro using .fw_name in .parent_data
Date:   Tue, 11 Jun 2019 18:16:36 +0800
Message-Id: <20190611101658.23855-4-wens@kernel.org>
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
.parent_data, for clk drivers that have parents referenced using a
combination of device tree clock-names, clock indices, and/or clk_hw
pointers.

Add a CLK_HW_INIT macro for specifying a single parent from the device
tree using .fw_name in struct clk_parent_data.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 include/linux/clk-provider.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 70aad5cefea7..b19063512a29 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -927,6 +927,17 @@ extern struct of_device_id __clk_of_table;
 		.ops		= _ops,					\
 	})
 
+#define CLK_HW_INIT_FW_NAME(_name, _parent, _ops, _flags)		\
+	(&(struct clk_init_data) {					\
+		.flags		= _flags,				\
+		.name		= _name,				\
+		.parent_data	= (const struct clk_parent_data[]) {	\
+					{ .fw_name = _parent },		\
+				  },					\
+		.num_parents	= 1,					\
+		.ops		= _ops,					\
+	})
+
 #define CLK_HW_INIT_PARENTS(_name, _parents, _ops, _flags)	\
 	(&(struct clk_init_data) {				\
 		.flags		= _flags,			\
-- 
2.20.1

