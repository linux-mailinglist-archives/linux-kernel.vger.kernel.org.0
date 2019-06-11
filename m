Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 280333C874
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 12:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405337AbfFKKR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 06:17:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:45508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404766AbfFKKRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 06:17:22 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AA17208E3;
        Tue, 11 Jun 2019 10:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560248241;
        bh=525aOxhqLv6Y8ZrnilCkqiBQziTal4f1DRT+iqnr65Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K2JiZayT9S16Wgegak2Fw9lid9oEzQHR0gVib6XgxqJO4cIpqXPXpuT9Mdi1JbmeM
         7rvC5A1n/JL8ggAaPY0SyaEx8vkqvkisLhvUUN2N/Yv2CzNAJ8UMm4D3PT6k+pb/jx
         efL6jGN9V7erjha1KNNEgZrrGDsEfsRjXU4YFMQ4=
Received: by wens.tw (Postfix, from userid 1000)
        id 102045F92C; Tue, 11 Jun 2019 18:17:18 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Chen-Yu Tsai <wens@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v2 01/25] clk: Fix debugfs clk_possible_parents for clks without parent string names
Date:   Tue, 11 Jun 2019 18:16:34 +0800
Message-Id: <20190611101658.23855-2-wens@kernel.org>
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

Following the commit fc0c209c147f ("clk: Allow parents to be specified
without string names"), the parent name string is not always populated.

Instead, fetch the parents clk_core struct using the appropriate helper,
and read its name directly. If that fails, go through the possible
sources of parent names. The order in which they are used is different
from how parents are looked up, with the global name having precedence
over local fw_name and indices. This makes more sense as a) the
parent_maps structure does not differentiate between legacy global names
and fallback global names, and b) global names likely provide more
information than local fw_names.

Fixes: fc0c209c147f ("clk: Allow parents to be specified without string names")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/clk.c | 44 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index aa51756fd4d6..093161ca4dcc 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3000,12 +3000,50 @@ DEFINE_SHOW_ATTRIBUTE(clk_flags);
 static int possible_parents_show(struct seq_file *s, void *data)
 {
 	struct clk_core *core = s->private;
+	struct clk_core *parent;
 	int i;
 
-	for (i = 0; i < core->num_parents - 1; i++)
-		seq_printf(s, "%s ", core->parents[i].name);
+	/*
+	 * Go through the following options to fetch a parent's name.
+	 *
+	 * 1. Fetch the registered parent clock and use its name
+	 * 2. Use the global (fallback) name if specified
+	 * 3. Use the local fw_name if provided
+	 * 4. Fetch parent clock's clock-output-name if DT index was set
+	 *
+	 * This may still fail in some cases, such as when the parent is
+	 * specified directly via a struct clk_hw pointer, but it isn't
+	 * registered (yet).
+	 */
+	for (i = 0; i < core->num_parents - 1; i++) {
+		parent = clk_core_get_parent_by_index(core, i);
+		if (parent)
+			seq_printf(s, "%s ", parent->name);
+		else if (core->parents[i].name)
+			seq_printf(s, "%s ", core->parents[i].name);
+		else if (core->parents[i].fw_name)
+			seq_printf(s, "<%s>(fw) ", core->parents[i].fw_name);
+		else if (core->parents[i].index >= 0)
+			seq_printf(s, "%s ",
+				   of_clk_get_parent_name(core->of_node,
+							  core->parents[i].index));
+		else
+			seq_puts(s, "(missing) ");
+	}
 
-	seq_printf(s, "%s\n", core->parents[i].name);
+	parent = clk_core_get_parent_by_index(core, i);
+	if (parent)
+		seq_printf(s, "%s", parent->name);
+	else if (core->parents[i].name)
+		seq_printf(s, "%s", core->parents[i].name);
+	else if (core->parents[i].fw_name)
+		seq_printf(s, "<%s>(fw)", core->parents[i].fw_name);
+	else if (core->parents[i].index >= 0)
+		seq_printf(s, "%s",
+			   of_clk_get_parent_name(core->of_node,
+						  core->parents[i].index));
+	else
+		seq_puts(s, "(missing)");
 
 	return 0;
 }
-- 
2.20.1

