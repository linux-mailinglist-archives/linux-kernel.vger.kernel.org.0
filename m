Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01C9758FC5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 03:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfF1Bds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 21:33:48 -0400
Received: from mga05.intel.com ([192.55.52.43]:41601 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbfF1Bds (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 21:33:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2019 18:33:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,425,1557212400"; 
   d="scan'208";a="189283631"
Received: from skl.sh.intel.com ([10.239.159.132])
  by fmsmga002.fm.intel.com with ESMTP; 27 Jun 2019 18:33:45 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v6 4/7] perf diff: Use hists to manage basic blocks per symbol
Date:   Fri, 28 Jun 2019 17:23:01 +0800
Message-Id: <1561713784-30533-5-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561713784-30533-1-git-send-email-yao.jin@linux.intel.com>
References: <1561713784-30533-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hist__account_cycles() can account cycles per basic
block. The basic block information is saved in cycles_hist
structure.

This patch processes each symbol, get basic blocks from
cycles_hist and add the basic block entries to a new hists
(in 'struct block_hist'). Using a hists is because
we need to compare, sort and print the basic blocks later.

 v6:
 ---
 Since 'ops' argument is removed from hists__add_entry_block,
 update the code accordingly. No functional change.

 v5:
 ---
 Since now we still carry block_info in 'struct hist_entry'
 we don't need to use our own new/free ops for hist entries.
 And the block_info is released in hist_entry__delete.

 v3:
 ---
 1. In v2, we put block stuffs in 'struct hist_entry', but
 it's not a good design. In v3, we create a new
 'struct block_hist' and cast the 'struct hist_entry' to
 'struct block_hist' in some places, which can avoid adding
 new stuffs in 'struct hist_entry'.

 2. abs() -> labs(), in block_cycles_diff_cmp().

 v2:
 ---
 v1 adds the basic block entries to per data-file hists
 but v2 adds the basic block entries to per symbol hists.
 That is to keep current perf-diff format. Will show the
 result in next patches.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-diff.c | 190 +++++++++++++++++++++++++++++++++++++++++++++-
 tools/perf/util/hist.c    |   3 +
 tools/perf/util/sort.h    |  12 +++
 3 files changed, 202 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index a7e0420..83b8c0f 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -20,6 +20,7 @@
 #include "util/data.h"
 #include "util/config.h"
 #include "util/time-utils.h"
+#include "util/annotate.h"
 
 #include <errno.h>
 #include <inttypes.h>
@@ -87,11 +88,14 @@ static s64 compute_wdiff_w2;
 static const char		*cpu_list;
 static DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
 
+static struct addr_location dummy_al;
+
 enum {
 	COMPUTE_DELTA,
 	COMPUTE_RATIO,
 	COMPUTE_WEIGHTED_DIFF,
 	COMPUTE_DELTA_ABS,
+	COMPUTE_CYCLES,
 	COMPUTE_MAX,
 };
 
@@ -100,6 +104,7 @@ const char *compute_names[COMPUTE_MAX] = {
 	[COMPUTE_DELTA_ABS] = "delta-abs",
 	[COMPUTE_RATIO] = "ratio",
 	[COMPUTE_WEIGHTED_DIFF] = "wdiff",
+	[COMPUTE_CYCLES] = "cycles",
 };
 
 static int compute = COMPUTE_DELTA_ABS;
@@ -234,6 +239,8 @@ static int setup_compute(const struct option *opt, const char *str,
 	for (i = 0; i < COMPUTE_MAX; i++)
 		if (!strcmp(cstr, compute_names[i])) {
 			*cp = i;
+			if (i == COMPUTE_CYCLES)
+				break;
 			return setup_compute_opt(option);
 		}
 
@@ -336,6 +343,31 @@ static int formula_fprintf(struct hist_entry *he, struct hist_entry *pair,
 	return -1;
 }
 
+static void *block_hist_zalloc(size_t size)
+{
+	struct block_hist *bh;
+
+	bh = zalloc(size + sizeof(*bh));
+	if (!bh)
+		return NULL;
+
+	return &bh->he;
+}
+
+static void block_hist_free(void *he)
+{
+	struct block_hist *bh;
+
+	bh = container_of(he, struct block_hist, he);
+	hists__delete_entries(&bh->block_hists);
+	free(bh);
+}
+
+struct hist_entry_ops block_hist_ops = {
+	.new    = block_hist_zalloc,
+	.free   = block_hist_free,
+};
+
 static int diff__process_sample_event(struct perf_tool *tool,
 				      union perf_event *event,
 				      struct perf_sample *sample,
@@ -363,9 +395,22 @@ static int diff__process_sample_event(struct perf_tool *tool,
 		goto out_put;
 	}
 
-	if (!hists__add_entry(hists, &al, NULL, NULL, NULL, sample, true)) {
-		pr_warning("problem incrementing symbol period, skipping event\n");
-		goto out_put;
+	if (compute != COMPUTE_CYCLES) {
+		if (!hists__add_entry(hists, &al, NULL, NULL, NULL, sample,
+				      true)) {
+			pr_warning("problem incrementing symbol period, "
+				   "skipping event\n");
+			goto out_put;
+		}
+	} else {
+		if (!hists__add_entry_ops(hists, &block_hist_ops, &al, NULL,
+					  NULL, NULL, sample, true)) {
+			pr_warning("problem incrementing symbol period, "
+				   "skipping event\n");
+			goto out_put;
+		}
+
+		hist__account_cycles(sample->branch_stack, &al, sample, false);
 	}
 
 	/*
@@ -475,6 +520,127 @@ static void hists__baseline_only(struct hists *hists)
 	}
 }
 
+static int64_t block_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
+			 struct hist_entry *left, struct hist_entry *right)
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
+static int64_t block_cycles_diff_cmp(struct hist_entry *left,
+				     struct hist_entry *right)
+{
+	bool pairs_left  = hist_entry__has_pairs(left);
+	bool pairs_right = hist_entry__has_pairs(right);
+	s64 l, r;
+
+	if (!pairs_left && !pairs_right)
+		return 0;
+
+	l = labs(left->diff.cycles);
+	r = labs(right->diff.cycles);
+	return r - l;
+}
+
+static int64_t block_sort(struct perf_hpp_fmt *fmt __maybe_unused,
+			  struct hist_entry *left, struct hist_entry *right)
+{
+	return block_cycles_diff_cmp(right, left);
+}
+
+static void init_block_hist(struct block_hist *bh)
+{
+	__hists__init(&bh->block_hists, &bh->block_list);
+	perf_hpp_list__init(&bh->block_list);
+
+	INIT_LIST_HEAD(&bh->block_fmt.list);
+	INIT_LIST_HEAD(&bh->block_fmt.sort_list);
+	bh->block_fmt.cmp = block_cmp;
+	bh->block_fmt.sort = block_sort;
+	perf_hpp_list__register_sort_field(&bh->block_list,
+					   &bh->block_fmt);
+	bh->valid = true;
+}
+
+static void init_block_info(struct block_info *bi, struct symbol *sym,
+			    struct cyc_hist *ch, int offset)
+{
+	bi->sym = sym;
+	bi->start = ch->start;
+	bi->end = offset;
+	bi->cycles = ch->cycles;
+	bi->cycles_aggr = ch->cycles_aggr;
+	bi->num = ch->num;
+	bi->num_aggr = ch->num_aggr;
+}
+
+static int process_block_per_sym(struct hist_entry *he)
+{
+	struct annotation *notes;
+	struct cyc_hist *ch;
+	struct block_hist *bh;
+
+	if (!he->ms.map || !he->ms.sym)
+		return 0;
+
+	notes = symbol__annotation(he->ms.sym);
+	if (!notes || !notes->src || !notes->src->cycles_hist)
+		return 0;
+
+	bh = container_of(he, struct block_hist, he);
+	init_block_hist(bh);
+
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
+			init_block_info(bi, he->ms.sym, &ch[i], i);
+			he_block = hists__add_entry_block(&bh->block_hists,
+							  &dummy_al, bi);
+			if (!he_block) {
+				block_info__put(bi);
+				return -1;
+			}
+		}
+	}
+
+	return 0;
+}
+
 static void hists__precompute(struct hists *hists)
 {
 	struct rb_root_cached *root;
@@ -494,6 +660,9 @@ static void hists__precompute(struct hists *hists)
 		he   = rb_entry(next, struct hist_entry, rb_node_in);
 		next = rb_next(&he->rb_node_in);
 
+		if (compute == COMPUTE_CYCLES)
+			process_block_per_sym(he);
+
 		data__for_each_file_new(i, d) {
 			pair = get_pair_data(he, d);
 			if (!pair)
@@ -510,6 +679,9 @@ static void hists__precompute(struct hists *hists)
 			case COMPUTE_WEIGHTED_DIFF:
 				compute_wdiff(he, pair);
 				break;
+			case COMPUTE_CYCLES:
+				process_block_per_sym(pair);
+				break;
 			default:
 				BUG_ON(1);
 			}
@@ -1411,6 +1583,13 @@ static int ui_init(void)
 	case COMPUTE_DELTA_ABS:
 		fmt->sort = hist_entry__cmp_delta_abs_idx;
 		break;
+	case COMPUTE_CYCLES:
+		/*
+		 * Should set since 'fmt->sort' is called without
+		 * checking valid during sorting
+		 */
+		fmt->sort = hist_entry__cmp_nop;
+		break;
 	default:
 		BUG_ON(1);
 	}
@@ -1507,6 +1686,8 @@ int cmd_diff(int argc, const char **argv)
 	if (quiet)
 		perf_quiet_option();
 
+	symbol__annotation_init();
+
 	if (symbol__init(NULL) < 0)
 		return -1;
 
@@ -1516,6 +1697,9 @@ int cmd_diff(int argc, const char **argv)
 	if (check_file_brstack() < 0)
 		return -1;
 
+	if (compute == COMPUTE_CYCLES && !pdiff.has_br_stack)
+		return -1;
+
 	if (ui_init() < 0)
 		return -1;
 
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index c4defff..a6ba7d4 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1229,6 +1229,9 @@ void hist_entry__delete(struct hist_entry *he)
 		mem_info__zput(he->mem_info);
 	}
 
+	if (he->block_info)
+		block_info__zput(he->block_info);
+
 	zfree(&he->res_samples);
 	zfree(&he->stat_acc);
 	free_srcline(he->srcline);
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 43623fa..a0f2321 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -79,6 +79,9 @@ struct hist_entry_diff {
 
 		/* HISTC_WEIGHTED_DIFF */
 		s64	wdiff;
+
+		/* PERF_HPP_DIFF__CYCLES */
+		s64	cycles;
 	};
 };
 
@@ -286,6 +289,15 @@ struct sort_entry {
 	u8	se_width_idx;
 };
 
+struct block_hist {
+	struct hists		block_hists;
+	struct perf_hpp_list	block_list;
+	struct perf_hpp_fmt	block_fmt;
+	int			block_idx;
+	bool			valid;
+	struct hist_entry	he;
+};
+
 extern struct sort_entry sort_thread;
 extern struct list_head hist_entry__sort_list;
 
-- 
2.7.4

