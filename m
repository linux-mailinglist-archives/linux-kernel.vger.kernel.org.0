Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43AB111A519
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 08:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfLKHbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 02:31:13 -0500
Received: from mga01.intel.com ([192.55.52.88]:35977 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbfLKHbM (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 02:31:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2019 23:31:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,301,1571727600"; 
   d="scan'208";a="238435798"
Received: from kbl.sh.intel.com ([10.239.159.163])
  by fmsmga004.fm.intel.com with ESMTP; 10 Dec 2019 23:31:09 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 1/3] perf report: Change sort order by a specified event in group
Date:   Wed, 11 Dec 2019 15:30:34 +0800
Message-Id: <20191211073036.31504-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When performing "perf report --group", it shows the event group information
together. By default, the output is sorted by the first event in group.

It would be nice for user to select any event for sorting. This patch
introduces a new option "--group-sort-idx" to sort the output by the
event at the index n in event group.

For example,

Before:

  # perf report --group --stdio

  # To display the perf.data header info, please use --header/--header-only options.
  #
  #
  # Total Lost Samples: 0
  #
  # Samples: 12K of events 'cpu/instructions,period=2000003/, cpu/cpu-cycles,period=200003/, BR_MISP_RETIRED.ALL_BRANCHES:pp, cpu/event=0xc0,umask=1,cmask=1,
  # Event count (approx.): 6451235635
  #
  #                         Overhead  Command    Shared Object            Symbol
  # ................................  .........  .......................  ...................................
  #
      92.19%  98.68%   0.00%  93.30%  mgen       mgen                     [.] LOOP1
       3.12%   0.29%   0.00%   0.16%  gsd-color  libglib-2.0.so.0.5600.4  [.] 0x0000000000049515
       1.56%   0.03%   0.00%   0.04%  gsd-color  libglib-2.0.so.0.5600.4  [.] 0x00000000000494b7
       1.56%   0.01%   0.00%   0.00%  gsd-color  libglib-2.0.so.0.5600.4  [.] 0x00000000000494ce
       1.56%   0.00%   0.00%   0.00%  mgen       [kernel.kallsyms]        [k] task_tick_fair
       0.00%   0.15%   0.00%   0.04%  perf       [kernel.kallsyms]        [k] smp_call_function_single
       0.00%   0.13%   0.00%   6.08%  swapper    [kernel.kallsyms]        [k] intel_idle
       0.00%   0.03%   0.00%   0.00%  gsd-color  libglib-2.0.so.0.5600.4  [.] g_main_context_check
       0.00%   0.03%   0.00%   0.00%  swapper    [kernel.kallsyms]        [k] apic_timer_interrupt
       ...

After:

  # perf report --group --stdio --group-sort-idx 3

  # To display the perf.data header info, please use --header/--header-only options.
  #
  #
  # Total Lost Samples: 0
  #
  # Samples: 12K of events 'cpu/instructions,period=2000003/, cpu/cpu-cycles,period=200003/, BR_MISP_RETIRED.ALL_BRANCHES:pp, cpu/event=0xc0,umask=1,cmask=1,
  # Event count (approx.): 6451235635
  #
  #                         Overhead  Command    Shared Object            Symbol
  # ................................  .........  .......................  ...................................
  #
      92.19%  98.68%   0.00%  93.30%  mgen       mgen                     [.] LOOP1
       0.00%   0.13%   0.00%   6.08%  swapper    [kernel.kallsyms]        [k] intel_idle
       3.12%   0.29%   0.00%   0.16%  gsd-color  libglib-2.0.so.0.5600.4  [.] 0x0000000000049515
       0.00%   0.00%   0.00%   0.06%  swapper    [kernel.kallsyms]        [k] hrtimer_start_range_ns
       1.56%   0.03%   0.00%   0.04%  gsd-color  libglib-2.0.so.0.5600.4  [.] 0x00000000000494b7
       0.00%   0.15%   0.00%   0.04%  perf       [kernel.kallsyms]        [k] smp_call_function_single
       0.00%   0.00%   0.00%   0.02%  mgen       [kernel.kallsyms]        [k] update_curr
       0.00%   0.00%   0.00%   0.02%  mgen       [kernel.kallsyms]        [k] apic_timer_interrupt
       0.00%   0.00%   0.00%   0.02%  mgen       [kernel.kallsyms]        [k] native_apic_msr_eoi_write
       0.00%   0.00%   0.00%   0.02%  mgen       [kernel.kallsyms]        [k] __update_load_avg_se
       0.00%   0.00%   0.00%   0.02%  mgen       [kernel.kallsyms]        [k] scheduler_tick

Now the output is sorted by the fourth event in group.

 v2:
 ---
 No change

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/Documentation/perf-report.txt |   4 +
 tools/perf/builtin-report.c              |  10 +++
 tools/perf/ui/hist.c                     | 110 +++++++++++++++++++----
 tools/perf/util/symbol_conf.h            |   1 +
 4 files changed, 110 insertions(+), 15 deletions(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 8dbe2119686a..9ade613ef020 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -371,6 +371,10 @@ OPTIONS
 	Show event group information together. It forces group output also
 	if there are no groups defined in data file.
 
+--group-sort-idx::
+	Sort the output by the event at the index n in group. If n is invalid,
+	sort by the first event. WARNING: This should be used with --group.
+
 --demangle::
 	Demangle symbol names to human readable form. It's enabled by default,
 	disable with --no-demangle.
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 387311c67264..729cf7611d8a 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1210,6 +1210,10 @@ int cmd_report(int argc, const char **argv)
 		    "Show a column with the sum of periods"),
 	OPT_BOOLEAN_SET(0, "group", &symbol_conf.event_group, &report.group_set,
 		    "Show event group information together"),
+	OPT_INTEGER(0, "group-sort-idx", &symbol_conf.group_sort_idx,
+		    "Sort the output by the event at the index n in group. "
+		    "If n is invalid, sort by the first event. "
+		    "WARNING: use only with --group."),
 	OPT_CALLBACK_NOOPT('b', "branch-stack", &branch_mode, "",
 		    "use branch records for per branch histogram filling",
 		    parse_branch_mode),
@@ -1302,6 +1306,12 @@ int cmd_report(int argc, const char **argv)
 		return -EINVAL;
 	}
 
+	if (symbol_conf.group_sort_idx &&
+	    (!symbol_conf.event_group || !report.group_set)) {
+		parse_options_usage(NULL, options, "group-sort-idx", 0);
+		return -EINVAL;
+	}
+
 	if (report.inverted_callchain)
 		callchain_param.order = ORDER_CALLER;
 	if (symbol_conf.cumulate_callchain && !callchain_param.order_set)
diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index f73675500061..8991beca60cb 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -151,15 +151,106 @@ static int field_cmp(u64 field_a, u64 field_b)
 	return 0;
 }
 
+static int pair_fields_alloc(struct hist_entry *a, struct hist_entry *b,
+			     hpp_field_fn get_field, int nr_members,
+			     u64 **fields_a, u64 **fields_b)
+{
+	struct evsel *evsel;
+	struct hist_entry *pair;
+	u64 *fa, *fb;
+	int ret = -1;
+
+	fa = calloc(nr_members, sizeof(*fa));
+	fb = calloc(nr_members, sizeof(*fb));
+
+	if (!fa || !fb)
+		goto out;
+
+	list_for_each_entry(pair, &a->pairs.head, pairs.node) {
+		evsel = hists_to_evsel(pair->hists);
+		fa[perf_evsel__group_idx(evsel)] = get_field(pair);
+	}
+
+	list_for_each_entry(pair, &b->pairs.head, pairs.node) {
+		evsel = hists_to_evsel(pair->hists);
+		fb[perf_evsel__group_idx(evsel)] = get_field(pair);
+	}
+
+	*fields_a = fa;
+	*fields_b = fb;
+	ret = 0;
+
+out:
+	if (ret != 0) {
+		free(fa);
+		free(fb);
+		*fields_a = NULL;
+		*fields_b = NULL;
+	}
+
+	return ret;
+}
+
+static int __hpp__group_sort_idx(struct hist_entry *a, struct hist_entry *b,
+				 hpp_field_fn get_field, int idx)
+{
+	struct evsel *evsel = hists_to_evsel(a->hists);
+	u64 *fields_a, *fields_b;
+	int cmp, nr_members, ret, i;
+
+	cmp = field_cmp(get_field(a), get_field(b));
+	if (!perf_evsel__is_group_event(evsel))
+		return cmp;
+
+	nr_members = evsel->core.nr_members;
+	ret = pair_fields_alloc(a, b, get_field, nr_members,
+			      &fields_a, &fields_b);
+	if (ret) {
+		ret = cmp;
+		goto out;
+	}
+
+	for (i = 1; i < nr_members; i++) {
+		if (i == idx) {
+			ret = field_cmp(fields_a[i], fields_b[i]);
+			if (ret)
+				goto out;
+		}
+	}
+
+	if (cmp) {
+		ret = cmp;
+		goto out;
+	}
+
+	for (i = 1; i < nr_members; i++) {
+		if (i != idx) {
+			ret = field_cmp(fields_a[i], fields_b[i]);
+			if (ret)
+				goto out;
+		}
+	}
+
+out:
+	free(fields_a);
+	free(fields_b);
+
+	return ret;
+}
+
 static int __hpp__sort(struct hist_entry *a, struct hist_entry *b,
 		       hpp_field_fn get_field)
 {
 	s64 ret;
 	int i, nr_members;
 	struct evsel *evsel;
-	struct hist_entry *pair;
 	u64 *fields_a, *fields_b;
 
+	if (symbol_conf.group_sort_idx && symbol_conf.event_group) {
+		return __hpp__group_sort_idx(a, b, get_field,
+					     symbol_conf.group_sort_idx);
+	}
+
 	ret = field_cmp(get_field(a), get_field(b));
 	if (ret || !symbol_conf.event_group)
 		return ret;
@@ -169,22 +260,11 @@ static int __hpp__sort(struct hist_entry *a, struct hist_entry *b,
 		return ret;
 
 	nr_members = evsel->core.nr_members;
-	fields_a = calloc(nr_members, sizeof(*fields_a));
-	fields_b = calloc(nr_members, sizeof(*fields_b));
-
-	if (!fields_a || !fields_b)
+	i = pair_fields_alloc(a, b, get_field, nr_members,
+			      &fields_a, &fields_b);
+	if (i)
 		goto out;
 
-	list_for_each_entry(pair, &a->pairs.head, pairs.node) {
-		evsel = hists_to_evsel(pair->hists);
-		fields_a[perf_evsel__group_idx(evsel)] = get_field(pair);
-	}
-
-	list_for_each_entry(pair, &b->pairs.head, pairs.node) {
-		evsel = hists_to_evsel(pair->hists);
-		fields_b[perf_evsel__group_idx(evsel)] = get_field(pair);
-	}
-
 	for (i = 1; i < nr_members; i++) {
 		ret = field_cmp(fields_a[i], fields_b[i]);
 		if (ret)
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index 10f1ec3e0349..b916afb95ec5 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -73,6 +73,7 @@ struct symbol_conf {
 	const char	*symfs;
 	int		res_sample;
 	int		pad_output_len_dso;
+	int		group_sort_idx;
 };
 
 extern struct symbol_conf symbol_conf;
-- 
2.17.1

