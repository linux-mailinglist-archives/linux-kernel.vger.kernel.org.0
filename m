Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38F7CE963A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 07:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfJ3GFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 02:05:46 -0400
Received: from mga05.intel.com ([192.55.52.43]:63903 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbfJ3GFp (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 02:05:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 23:05:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,246,1569308400"; 
   d="scan'208";a="225217052"
Received: from kbl.sh.intel.com ([10.239.159.163])
  by fmsmga004.fm.intel.com with ESMTP; 29 Oct 2019 23:05:42 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v5 2/7] perf util: Cleanup and refactor block info functions
Date:   Wed, 30 Oct 2019 14:04:25 +0800
Message-Id: <20191030060430.23558-3-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191030060430.23558-1-yao.jin@linux.intel.com>
References: <20191030060430.23558-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have already implemented some block-info related functions.
Now it's time to do some cleanup, refactoring and move the
functions and structures to new block-info.h/block-info.c.

 v4:
 ---
 Move code for skipping column length calculation to patch:
 'perf diff: Don't use hack to skip column length calculation'

 v3:
 ---
 1. Rename the patch title
 2. Rename from block.h/block.c to block-info.h/block-info.c
 3. Move more common part to block-info, such as
    block_info__process_sym.
 4. Remove the nasty hack for skipping calculation of column
    length

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-diff.c    | 107 +++--------------------------
 tools/perf/util/Build        |   1 +
 tools/perf/util/block-info.c | 129 +++++++++++++++++++++++++++++++++++
 tools/perf/util/block-info.h |  43 ++++++++++++
 tools/perf/util/hist.c       |   1 +
 tools/perf/util/symbol.c     |  22 ------
 tools/perf/util/symbol.h     |  24 -------
 7 files changed, 185 insertions(+), 142 deletions(-)
 create mode 100644 tools/perf/util/block-info.c
 create mode 100644 tools/perf/util/block-info.h

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index faf99a81ad3e..6728568fe5c4 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -24,6 +24,7 @@
 #include "util/annotate.h"
 #include "util/map.h"
 #include "util/spark.h"
+#include "util/block-info.h"
 #include <linux/err.h>
 #include <linux/zalloc.h>
 #include <subcmd/pager.h>
@@ -98,8 +99,6 @@ static s64 compute_wdiff_w2;
 static const char		*cpu_list;
 static DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
 
-static struct addr_location dummy_al;
-
 enum {
 	COMPUTE_DELTA,
 	COMPUTE_RATIO,
@@ -537,41 +536,6 @@ static void hists__baseline_only(struct hists *hists)
 	}
 }
 
-static int64_t block_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
-			 struct hist_entry *left, struct hist_entry *right)
-{
-	struct block_info *bi_l = left->block_info;
-	struct block_info *bi_r = right->block_info;
-	int cmp;
-
-	if (!bi_l->sym || !bi_r->sym) {
-		if (!bi_l->sym && !bi_r->sym)
-			return 0;
-		else if (!bi_l->sym)
-			return -1;
-		else
-			return 1;
-	}
-
-	if (bi_l->sym == bi_r->sym) {
-		if (bi_l->start == bi_r->start) {
-			if (bi_l->end == bi_r->end)
-				return 0;
-			else
-				return (int64_t)(bi_r->end - bi_l->end);
-		} else
-			return (int64_t)(bi_r->start - bi_l->start);
-	} else {
-		cmp = strcmp(bi_l->sym->name, bi_r->sym->name);
-		return cmp;
-	}
-
-	if (bi_l->sym->start != bi_r->sym->start)
-		return (int64_t)(bi_r->sym->start - bi_l->sym->start);
-
-	return (int64_t)(bi_r->sym->end - bi_l->sym->end);
-}
-
 static int64_t block_cycles_diff_cmp(struct hist_entry *left,
 				     struct hist_entry *right)
 {
@@ -600,67 +564,13 @@ static void init_block_hist(struct block_hist *bh)
 
 	INIT_LIST_HEAD(&bh->block_fmt.list);
 	INIT_LIST_HEAD(&bh->block_fmt.sort_list);
-	bh->block_fmt.cmp = block_cmp;
+	bh->block_fmt.cmp = block_info__cmp;
 	bh->block_fmt.sort = block_sort;
 	perf_hpp_list__register_sort_field(&bh->block_list,
 					   &bh->block_fmt);
 	bh->valid = true;
 }
 
-static void init_block_info(struct block_info *bi, struct symbol *sym,
-			    struct cyc_hist *ch, int offset)
-{
-	bi->sym = sym;
-	bi->start = ch->start;
-	bi->end = offset;
-	bi->cycles = ch->cycles;
-	bi->cycles_aggr = ch->cycles_aggr;
-	bi->num = ch->num;
-	bi->num_aggr = ch->num_aggr;
-
-	memcpy(bi->cycles_spark, ch->cycles_spark,
-	       NUM_SPARKS * sizeof(u64));
-}
-
-static int process_block_per_sym(struct hist_entry *he)
-{
-	struct annotation *notes;
-	struct cyc_hist *ch;
-	struct block_hist *bh;
-
-	if (!he->ms.map || !he->ms.sym)
-		return 0;
-
-	notes = symbol__annotation(he->ms.sym);
-	if (!notes || !notes->src || !notes->src->cycles_hist)
-		return 0;
-
-	bh = container_of(he, struct block_hist, he);
-	init_block_hist(bh);
-
-	ch = notes->src->cycles_hist;
-	for (unsigned int i = 0; i < symbol__size(he->ms.sym); i++) {
-		if (ch[i].num_aggr) {
-			struct block_info *bi;
-			struct hist_entry *he_block;
-
-			bi = block_info__new();
-			if (!bi)
-				return -1;
-
-			init_block_info(bi, he->ms.sym, &ch[i], i);
-			he_block = hists__add_entry_block(&bh->block_hists,
-							  &dummy_al, bi);
-			if (!he_block) {
-				block_info__put(bi);
-				return -1;
-			}
-		}
-	}
-
-	return 0;
-}
-
 static int block_pair_cmp(struct hist_entry *a, struct hist_entry *b)
 {
 	struct block_info *bi_a = a->block_info;
@@ -785,8 +695,11 @@ static void hists__precompute(struct hists *hists)
 		he   = rb_entry(next, struct hist_entry, rb_node_in);
 		next = rb_next(&he->rb_node_in);
 
-		if (compute == COMPUTE_CYCLES)
-			process_block_per_sym(he);
+		if (compute == COMPUTE_CYCLES) {
+			bh = container_of(he, struct block_hist, he);
+			init_block_hist(bh);
+			block_info__process_sym(he, bh, NULL, 0);
+		}
 
 		data__for_each_file_new(i, d) {
 			pair = get_pair_data(he, d);
@@ -805,10 +718,12 @@ static void hists__precompute(struct hists *hists)
 				compute_wdiff(he, pair);
 				break;
 			case COMPUTE_CYCLES:
-				process_block_per_sym(pair);
-				bh = container_of(he, struct block_hist, he);
 				pair_bh = container_of(pair, struct block_hist,
 						       he);
+				init_block_hist(pair_bh);
+				block_info__process_sym(pair, pair_bh, NULL, 0);
+
+				bh = container_of(he, struct block_hist, he);
 
 				if (bh->valid && pair_bh->valid) {
 					block_hists_match(&bh->block_hists,
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 39814b1806a6..b8e05a147b2b 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -1,4 +1,5 @@
 perf-y += annotate.o
+perf-y += block-info.o
 perf-y += block-range.o
 perf-y += build-id.o
 perf-y += cacheline.o
diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
new file mode 100644
index 000000000000..b9954a32b8f4
--- /dev/null
+++ b/tools/perf/util/block-info.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdlib.h>
+#include <string.h>
+#include <linux/zalloc.h>
+#include "block-info.h"
+#include "sort.h"
+#include "annotate.h"
+#include "symbol.h"
+
+struct block_info *block_info__get(struct block_info *bi)
+{
+	if (bi)
+		refcount_inc(&bi->refcnt);
+	return bi;
+}
+
+void block_info__put(struct block_info *bi)
+{
+	if (bi && refcount_dec_and_test(&bi->refcnt))
+		free(bi);
+}
+
+struct block_info *block_info__new(void)
+{
+	struct block_info *bi = zalloc(sizeof(*bi));
+
+	if (bi)
+		refcount_set(&bi->refcnt, 1);
+	return bi;
+}
+
+int64_t block_info__cmp(struct perf_hpp_fmt *fmt __maybe_unused,
+			struct hist_entry *left, struct hist_entry *right)
+{
+	struct block_info *bi_l = left->block_info;
+	struct block_info *bi_r = right->block_info;
+	int cmp;
+
+	if (!bi_l->sym || !bi_r->sym) {
+		if (!bi_l->sym && !bi_r->sym)
+			return 0;
+		else if (!bi_l->sym)
+			return -1;
+		else
+			return 1;
+	}
+
+	if (bi_l->sym == bi_r->sym) {
+		if (bi_l->start == bi_r->start) {
+			if (bi_l->end == bi_r->end)
+				return 0;
+			else
+				return (int64_t)(bi_r->end - bi_l->end);
+		} else
+			return (int64_t)(bi_r->start - bi_l->start);
+	} else {
+		cmp = strcmp(bi_l->sym->name, bi_r->sym->name);
+		return cmp;
+	}
+
+	if (bi_l->sym->start != bi_r->sym->start)
+		return (int64_t)(bi_r->sym->start - bi_l->sym->start);
+
+	return (int64_t)(bi_r->sym->end - bi_l->sym->end);
+}
+
+static void init_block_info(struct block_info *bi, struct symbol *sym,
+			    struct cyc_hist *ch, int offset,
+			    u64 total_cycles)
+{
+	bi->sym = sym;
+	bi->start = ch->start;
+	bi->end = offset;
+	bi->cycles = ch->cycles;
+	bi->cycles_aggr = ch->cycles_aggr;
+	bi->num = ch->num;
+	bi->num_aggr = ch->num_aggr;
+	bi->total_cycles = total_cycles;
+
+	memcpy(bi->cycles_spark, ch->cycles_spark,
+	       NUM_SPARKS * sizeof(u64));
+}
+
+int block_info__process_sym(struct hist_entry *he, struct block_hist *bh,
+			    u64 *block_cycles_aggr, u64 total_cycles)
+{
+	struct annotation *notes;
+	struct cyc_hist *ch;
+	static struct addr_location al;
+	u64 cycles = 0;
+
+	if (!he->ms.map || !he->ms.sym)
+		return 0;
+
+	memset(&al, 0, sizeof(al));
+	al.map = he->ms.map;
+	al.sym = he->ms.sym;
+
+	notes = symbol__annotation(he->ms.sym);
+	if (!notes || !notes->src || !notes->src->cycles_hist)
+		return 0;
+	ch = notes->src->cycles_hist;
+	for (unsigned int i = 0; i < symbol__size(he->ms.sym); i++) {
+		if (ch[i].num_aggr) {
+			struct block_info *bi;
+			struct hist_entry *he_block;
+
+			bi = block_info__new();
+			if (!bi)
+				return -1;
+
+			init_block_info(bi, he->ms.sym, &ch[i], i,
+					total_cycles);
+			cycles += bi->cycles_aggr / bi->num_aggr;
+
+			he_block = hists__add_entry_block(&bh->block_hists,
+							  &al, bi);
+			if (!he_block) {
+				block_info__put(bi);
+				return -1;
+			}
+		}
+	}
+
+	if (block_cycles_aggr)
+		*block_cycles_aggr += cycles;
+
+	return 0;
+}
diff --git a/tools/perf/util/block-info.h b/tools/perf/util/block-info.h
new file mode 100644
index 000000000000..d55dfc2fda6f
--- /dev/null
+++ b/tools/perf/util/block-info.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_BLOCK_H
+#define __PERF_BLOCK_H
+
+#include <linux/types.h>
+#include <linux/refcount.h>
+#include "util/hist.h"
+#include "util/symbol.h"
+
+struct block_info {
+	struct symbol		*sym;
+	u64			start;
+	u64			end;
+	u64			cycles;
+	u64			cycles_aggr;
+	s64			cycles_spark[NUM_SPARKS];
+	u64			total_cycles;
+	int			num;
+	int			num_aggr;
+	refcount_t		refcnt;
+};
+
+struct block_hist;
+
+struct block_info *block_info__new(void);
+struct block_info *block_info__get(struct block_info *bi);
+void   block_info__put(struct block_info *bi);
+
+static inline void __block_info__zput(struct block_info **bi)
+{
+	block_info__put(*bi);
+	*bi = NULL;
+}
+
+#define block_info__zput(bi) __block_info__zput(&bi)
+
+int64_t block_info__cmp(struct perf_hpp_fmt *fmt __maybe_unused,
+			struct hist_entry *left, struct hist_entry *right);
+
+int block_info__process_sym(struct hist_entry *he, struct block_hist *bh,
+			    u64 *block_cycles_aggr, u64 total_cycles);
+
+#endif /* __PERF_BLOCK_H */
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index daa6eef4fde0..a7fa061987e4 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -18,6 +18,7 @@
 #include "srcline.h"
 #include "symbol.h"
 #include "thread.h"
+#include "block-info.h"
 #include "ui/progress.h"
 #include <errno.h>
 #include <math.h>
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index a8f80e427674..fac8887a6759 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2371,25 +2371,3 @@ struct mem_info *mem_info__new(void)
 		refcount_set(&mi->refcnt, 1);
 	return mi;
 }
-
-struct block_info *block_info__get(struct block_info *bi)
-{
-	if (bi)
-		refcount_inc(&bi->refcnt);
-	return bi;
-}
-
-void block_info__put(struct block_info *bi)
-{
-	if (bi && refcount_dec_and_test(&bi->refcnt))
-		free(bi);
-}
-
-struct block_info *block_info__new(void)
-{
-	struct block_info *bi = zalloc(sizeof(*bi));
-
-	if (bi)
-		refcount_set(&bi->refcnt, 1);
-	return bi;
-}
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index cc2a89b99d3d..c3bd16d75d5d 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -106,18 +106,6 @@ struct ref_reloc_sym {
 	u64		unrelocated_addr;
 };
 
-struct block_info {
-	struct symbol		*sym;
-	u64			start;
-	u64			end;
-	u64			cycles;
-	u64			cycles_aggr;
-	s64			cycles_spark[NUM_SPARKS];
-	int			num;
-	int			num_aggr;
-	refcount_t		refcnt;
-};
-
 struct addr_location {
 	struct machine *machine;
 	struct thread *thread;
@@ -291,16 +279,4 @@ static inline void __mem_info__zput(struct mem_info **mi)
 
 #define mem_info__zput(mi) __mem_info__zput(&mi)
 
-struct block_info *block_info__new(void);
-struct block_info *block_info__get(struct block_info *bi);
-void   block_info__put(struct block_info *bi);
-
-static inline void __block_info__zput(struct block_info **bi)
-{
-	block_info__put(*bi);
-	*bi = NULL;
-}
-
-#define block_info__zput(bi) __block_info__zput(&bi)
-
 #endif /* __PERF_SYMBOL */
-- 
2.17.1

