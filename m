Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A614133BB2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 07:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgAHG3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 01:29:44 -0500
Received: from mga18.intel.com ([134.134.136.126]:23681 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgAHG3n (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 01:29:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2020 22:29:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,408,1571727600"; 
   d="scan'208";a="233506778"
Received: from kbl.sh.intel.com ([10.239.159.163])
  by orsmga002.jf.intel.com with ESMTP; 07 Jan 2020 22:29:41 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 2/4] perf util: Validate map/dso/sym before comparing blocks
Date:   Wed,  8 Jan 2020 07:03:52 +0800
Message-Id: <20200107230354.30132-2-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200107230354.30132-1-yao.jin@linux.intel.com>
References: <20200107230354.30132-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

block_pair_cmp() is a function which is used to compare
two blocks. This patch checks the validity of map, dso and
sym before comparing blocks.

If they are invalid, we will not compare the address because
the address might not make sense.

Another change is it returns cmp if sym->name is not equal.

This patch uses "strcmp(ms_p->sym->name, ms_h->sym->name)" is
because we have checked ms->sym yet, we don't need an additional
checking for bi->sym.

 v3:
 ---
 Separate from original patch.
 Return cmp if it's not 0.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/block-info.c | 18 ++++++++++++------
 tools/perf/util/block-info.h |  2 +-
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
index f0f38bdd496a..2d0929aa0a65 100644
--- a/tools/perf/util/block-info.c
+++ b/tools/perf/util/block-info.c
@@ -476,18 +476,24 @@ float block_info__total_cycles_percent(struct hist_entry *he)
 	return 0.0;
 }
 
-int block_pair_cmp(struct hist_entry *a, struct hist_entry *b)
+int block_pair_cmp(struct hist_entry *pair, struct hist_entry *he)
 {
-	struct block_info *bi_a = a->block_info;
-	struct block_info *bi_b = b->block_info;
+	struct block_info *bi_p = pair->block_info;
+	struct block_info *bi_h = he->block_info;
+	struct map_symbol *ms_p = &pair->ms;
+	struct map_symbol *ms_h = &he->ms;
 	int cmp;
 
-	if (!bi_a->sym || !bi_b->sym)
+	if (!ms_p->map || !ms_p->map->dso || !ms_p->sym ||
+	    !ms_h->map || !ms_h->map->dso || !ms_h->sym) {
 		return -1;
+	}
 
-	cmp = strcmp(bi_a->sym->name, bi_b->sym->name);
+	cmp = strcmp(ms_p->sym->name, ms_h->sym->name);
+	if (cmp)
+		return cmp;
 
-	if ((!cmp) && (bi_a->start == bi_b->start) && (bi_a->end == bi_b->end))
+	if ((bi_p->start == bi_h->start) && (bi_p->end == bi_h->end))
 		return 0;
 
 	return -1;
diff --git a/tools/perf/util/block-info.h b/tools/perf/util/block-info.h
index 4fa91eeae92e..bfa22c59195d 100644
--- a/tools/perf/util/block-info.h
+++ b/tools/perf/util/block-info.h
@@ -76,6 +76,6 @@ int report__browse_block_hists(struct block_hist *bh, float min_percent,
 
 float block_info__total_cycles_percent(struct hist_entry *he);
 
-int block_pair_cmp(struct hist_entry *a, struct hist_entry *b);
+int block_pair_cmp(struct hist_entry *pair, struct hist_entry *he);
 
 #endif /* __PERF_BLOCK_H */
-- 
2.17.1

