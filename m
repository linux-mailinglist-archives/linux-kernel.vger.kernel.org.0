Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36EA848181
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 14:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfFQMFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 08:05:05 -0400
Received: from albert.telenet-ops.be ([195.130.137.90]:43556 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFQMFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:05:05 -0400
Received: from ramsan ([84.194.111.163])
        by albert.telenet-ops.be with bizsmtp
        id Ro542000A3XaVaC06o54q9; Mon, 17 Jun 2019 14:05:04 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hcqNk-0001e0-5T; Mon, 17 Jun 2019 14:05:04 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hcqNk-0002eV-3i; Mon, 17 Jun 2019 14:05:04 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] clk: Add support for setting clk_rate via debugfs
Date:   Mon, 17 Jun 2019 14:05:02 +0200
Message-Id: <20190617120502.10153-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For testing, it is useful to be able to specify a clock rate manually.
As this is a dangerous feature, it is not enabled by default.
Users need to modify the source directly and #define
CLOCK_ALLOW_WRITE_DEBUGFS.

This follows the spirit of commit 09c6ecd394105c48 ("regmap: Add support
for writing to regmap registers via debugfs").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clk/clk.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index c68bc5f695912bf5..0529ac624ed73ba0 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2953,6 +2953,41 @@ static int clk_dump_show(struct seq_file *s, void *data)
 }
 DEFINE_SHOW_ATTRIBUTE(clk_dump);
 
+#undef CLOCK_ALLOW_WRITE_DEBUGFS
+#ifdef CLOCK_ALLOW_WRITE_DEBUGFS
+/*
+ * This can be dangerous, therefore don't provide any real compile time
+ * configuration option for this feature.
+ * People who want to use this will need to modify the source code directly.
+ */
+static int clk_rate_set(void *data, u64 val)
+{
+	struct clk_core *core = data;
+	int ret;
+
+	clk_prepare_lock();
+	ret = clk_core_set_rate_nolock(core, val);
+	clk_prepare_unlock();
+
+	return ret;
+}
+
+#define clk_rate_mode	0644
+#else
+#define clk_rate_set	NULL
+#define clk_rate_mode	0444
+#endif
+
+static int clk_rate_get(void *data, u64 *val)
+{
+	struct clk_core *core = data;
+
+	*val = core->rate;
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(clk_rate_fops, clk_rate_get, clk_rate_set, "%llu\n");
+
 static const struct {
 	unsigned long flag;
 	const char *name;
@@ -3029,7 +3064,8 @@ static void clk_debug_create_one(struct clk_core *core, struct dentry *pdentry)
 	root = debugfs_create_dir(core->name, pdentry);
 	core->dentry = root;
 
-	debugfs_create_ulong("clk_rate", 0444, root, &core->rate);
+	debugfs_create_file("clk_rate", clk_rate_mode, root, core,
+			    &clk_rate_fops);
 	debugfs_create_ulong("clk_accuracy", 0444, root, &core->accuracy);
 	debugfs_create_u32("clk_phase", 0444, root, &core->phase);
 	debugfs_create_file("clk_flags", 0444, root, core, &clk_flags_fops);
-- 
2.17.1

