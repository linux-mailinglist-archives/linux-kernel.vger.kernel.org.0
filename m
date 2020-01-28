Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C48714B486
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 13:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgA1M4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 07:56:31 -0500
Received: from mga03.intel.com ([134.134.136.65]:39253 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgA1M43 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 07:56:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2020 04:56:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,373,1574150400"; 
   d="scan'208";a="309073700"
Received: from kbl.sh.intel.com ([10.239.159.24])
  by orsmga001.jf.intel.com with ESMTP; 28 Jan 2020 04:56:27 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v5 2/4] perf util: Validate map/dso/sym before comparing blocks
Date:   Tue, 28 Jan 2020 20:55:54 +0800
Message-Id: <20200128125556.25498-3-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200128125556.25498-1-yao.jin@linux.intel.com>
References: <20200128125556.25498-1-yao.jin@linux.intel.com>
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

 v4/v5:
 ------
 No change.

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

