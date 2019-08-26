Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E89069DA15
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 01:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfHZXnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 19:43:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbfHZXnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 19:43:14 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 854F92070B;
        Mon, 26 Aug 2019 23:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566862992;
        bh=5TX3sN6ggVjR2lC78XvpMigPOe2ekPP4Nw027KQ221Q=;
        h=From:To:Cc:Subject:Date:From;
        b=B4ynBZ9J0oCsIxXnHNUHyuc3LzNWvyclukdm3TPnns8mvBlrb3PN3+jb9IIOdJAIj
         xhP6hQz51Hfd+KWSte/T2prfRsPAxXF7e8eWVWKgmNRzdHKfGjVT671O61796AjPG2
         1xtUnZPD/pMioiROesuBpxmyZA8lqsvN1V6dAq4s=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCH] clk: Evict unregistered clks from parent caches
Date:   Mon, 26 Aug 2019 16:43:11 -0700
Message-Id: <20190826234311.138147-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We leave a dangling pointer in each clk_core::parents array that has an
unregistered clk as a potential parent when that clk_core pointer is
freed by clk{_hw}_unregister(). It is impossible for the true parent of
a clk to be set with clk_set_parent() once the dangling pointer is left
in the cache because we compare parent pointers in
clk_fetch_parent_index() instead of checking for a matching clk name or
clk_hw pointer.

Before commit ede77858473a ("clk: Remove global clk traversal on fetch
parent index"), we would check clk_hw pointers, which has a higher
chance of being the same between registration and unregistration, but it
can still be allocated and freed by the clk provider. In fact, this has
been a long standing problem since commit da0f0b2c3ad2 ("clk: Correct
lookup logic in clk_fetch_parent_index()") where we stopped trying to
compare clk names and skipped over entries in the cache that weren't
NULL.

There are good (performance) reasons to not do the global tree lookup in
cases where the cache holds dangling pointers to parents that have been
unregistered. Let's take the performance hit on the uncommon
registration path instead. Loop through all the clk_core::parents arrays
when a clk is unregistered and set the entry to NULL when the parent
cache entry and clk being unregistered are the same pointer. This will
fix this problem and avoid the overhead for the "normal" case.

Based on a patch by Bjorn Andersson.

Fixes: da0f0b2c3ad2 ("clk: Correct lookup logic in clk_fetch_parent_index()")
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index c0990703ce54..f3982bfa39d6 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3737,6 +3737,34 @@ static const struct clk_ops clk_nodrv_ops = {
 	.set_parent	= clk_nodrv_set_parent,
 };
 
+static void clk_core_evict_parent_cache_subtree(struct clk_core *root,
+						struct clk_core *target)
+{
+	int i;
+	struct clk_core *child;
+
+	for (i = 0; i < root->num_parents; i++)
+		if (root->parents[i].core == target)
+			root->parents[i].core = NULL;
+
+	hlist_for_each_entry(child, &root->children, child_node)
+		clk_core_evict_parent_cache_subtree(child, target);
+}
+
+/* Remove this clk from all parent caches */
+static void clk_core_evict_parent_cache(struct clk_core *core)
+{
+	struct hlist_head **lists;
+	struct clk_core *root;
+
+	lockdep_assert_held(&prepare_lock);
+
+	for (lists = all_lists; *lists; lists++)
+		hlist_for_each_entry(root, *lists, child_node)
+			clk_core_evict_parent_cache_subtree(root, core);
+
+}
+
 /**
  * clk_unregister - unregister a currently registered clock
  * @clk: clock to unregister
@@ -3775,6 +3803,8 @@ void clk_unregister(struct clk *clk)
 			clk_core_set_parent_nolock(child, NULL);
 	}
 
+	clk_core_evict_parent_cache(clk->core);
+
 	hlist_del_init(&clk->core->child_node);
 
 	if (clk->core->prepare_count)
-- 
Sent by a computer through tubes

