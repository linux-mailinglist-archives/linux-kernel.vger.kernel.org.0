Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D20194C16E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 21:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730604AbfFSTWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 15:22:36 -0400
Received: from mga14.intel.com ([192.55.52.115]:30133 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730574AbfFSTWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 15:22:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2019 12:22:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,394,1557212400"; 
   d="scan'208";a="358707834"
Received: from otc-icl-cdi-210.jf.intel.com ([10.54.55.28])
  by fmsmga006.fm.intel.com with ESMTP; 19 Jun 2019 12:22:33 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 7/8] perf, tools, stat: Support new per thread TopDown metrics
Date:   Wed, 19 Jun 2019 12:22:02 -0700
Message-Id: <20190619192203.3885-8-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190619192203.3885-1-kan.liang@linux.intel.com>
References: <20190619192203.3885-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Icelake has support for reporting per thread TopDown metrics.
These are reported differently than the previous TopDown support,
each metric is standalone, but scaled to pipeline "slots".
We don't need to do anything special for HyperThreading anymore.
Teach perf stat --topdown to handle these new metrics and
print them in the same way as the previous TopDown metrics.
The restrictions of only being able to report information per core is
gone.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No changes since V1

 tools/perf/Documentation/perf-stat.txt |  9 +++-
 tools/perf/builtin-stat.c              | 24 +++++++++
 tools/perf/util/stat-shadow.c          | 89 ++++++++++++++++++++++++++++++++++
 tools/perf/util/stat.c                 |  4 ++
 tools/perf/util/stat.h                 |  8 +++
 5 files changed, 132 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 1e312c2672e4..4c3389dc2063 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -269,8 +269,13 @@ if the workload is actually bound by the CPU and not by something else.
 For best results it is usually a good idea to use it with interval
 mode like -I 1000, as the bottleneck of workloads can change often.
 
-The top down metrics are collected per core instead of per
-CPU thread. Per core mode is automatically enabled
+This enables --metric-only, unless overridden with --no-metric-only.
+
+The following restrictions only apply to older Intel CPUs and Atom,
+on newer CPUs (IceLake and later) TopDown can be collected for any thread:
+
+The top down metrics are collected per core instead of per CPU thread.
+Per core mode is automatically enabled
 and -a (global monitoring) is needed, requiring root rights or
 perf.perf_event_paranoid=-1.
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 24b8e690fb69..02988e946827 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -123,6 +123,14 @@ static const char * topdown_attrs[] = {
 	NULL,
 };
 
+static const char *topdown_metric_attrs[] = {
+	"topdown-retiring",
+	"topdown-bad-spec",
+	"topdown-fe-bound",
+	"topdown-be-bound",
+	NULL,
+};
+
 static const char *smi_cost_attrs = {
 	"{"
 	"msr/aperf/,"
@@ -1251,6 +1259,21 @@ static int add_default_attributes(void)
 		char *str = NULL;
 		bool warn = false;
 
+		if (topdown_filter_events(topdown_metric_attrs, &str, 1) < 0) {
+			pr_err("Out of memory\n");
+			return -1;
+		}
+		if (topdown_metric_attrs[0] && str) {
+			if (!stat_config.interval) {
+				fprintf(stat_config.output,
+					"Topdown accuracy may decreases when measuring long period.\n"
+					"Please print the result regularly, e.g. -I1000\n");
+			}
+			goto setup_metrics;
+		}
+
+		str = NULL;
+
 		if (stat_config.aggr_mode != AGGR_GLOBAL &&
 		    stat_config.aggr_mode != AGGR_CORE) {
 			pr_err("top down event configuration requires --per-core mode\n");
@@ -1272,6 +1295,7 @@ static int add_default_attributes(void)
 		if (topdown_attrs[0] && str) {
 			if (warn)
 				arch_topdown_group_warn();
+setup_metrics:
 			err = parse_events(evsel_list, str, &errinfo);
 			if (err) {
 				fprintf(stderr,
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 83d8094be4fe..6b6ffd64a4c4 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -238,6 +238,18 @@ void perf_stat__update_shadow_stats(struct perf_evsel *counter, u64 count,
 	else if (perf_stat_evsel__is(counter, TOPDOWN_RECOVERY_BUBBLES))
 		update_runtime_stat(st, STAT_TOPDOWN_RECOVERY_BUBBLES,
 				    ctx, cpu, count);
+	else if (perf_stat_evsel__is(counter, TOPDOWN_RETIRING))
+		update_runtime_stat(st, STAT_TOPDOWN_RETIRING,
+				    ctx, cpu, count);
+	else if (perf_stat_evsel__is(counter, TOPDOWN_BAD_SPEC))
+		update_runtime_stat(st, STAT_TOPDOWN_BAD_SPEC,
+				    ctx, cpu, count);
+	else if (perf_stat_evsel__is(counter, TOPDOWN_FE_BOUND))
+		update_runtime_stat(st, STAT_TOPDOWN_FE_BOUND,
+				    ctx, cpu, count);
+	else if (perf_stat_evsel__is(counter, TOPDOWN_BE_BOUND))
+		update_runtime_stat(st, STAT_TOPDOWN_BE_BOUND,
+				    ctx, cpu, count);
 	else if (perf_evsel__match(counter, HARDWARE, HW_STALLED_CYCLES_FRONTEND))
 		update_runtime_stat(st, STAT_STALLED_CYCLES_FRONT,
 				    ctx, cpu, count);
@@ -682,6 +694,47 @@ static double td_be_bound(int ctx, int cpu, struct runtime_stat *st)
 	return sanitize_val(1.0 - sum);
 }
 
+/*
+ * Kernel reports metrics multiplied with slots. To get back
+ * the ratios we need to recreate the sum.
+ */
+
+static double td_metric_ratio(int ctx, int cpu,
+			      enum stat_type type,
+			      struct runtime_stat *stat)
+{
+	double sum = runtime_stat_avg(stat, STAT_TOPDOWN_RETIRING, ctx, cpu) +
+		runtime_stat_avg(stat, STAT_TOPDOWN_FE_BOUND, ctx, cpu) +
+		runtime_stat_avg(stat, STAT_TOPDOWN_BE_BOUND, ctx, cpu) +
+		runtime_stat_avg(stat, STAT_TOPDOWN_BAD_SPEC, ctx, cpu);
+	double d = runtime_stat_avg(stat, type, ctx, cpu);
+
+	if (sum)
+		return d / sum;
+	return 0;
+}
+
+/*
+ * ... but only if most of the values are actually available.
+ * We allow two missing.
+ */
+
+static bool full_td(int ctx, int cpu,
+		    struct runtime_stat *stat)
+{
+	int c = 0;
+
+	if (runtime_stat_avg(stat, STAT_TOPDOWN_RETIRING, ctx, cpu) > 0)
+		c++;
+	if (runtime_stat_avg(stat, STAT_TOPDOWN_BE_BOUND, ctx, cpu) > 0)
+		c++;
+	if (runtime_stat_avg(stat, STAT_TOPDOWN_FE_BOUND, ctx, cpu) > 0)
+		c++;
+	if (runtime_stat_avg(stat, STAT_TOPDOWN_BAD_SPEC, ctx, cpu) > 0)
+		c++;
+	return c >= 2;
+}
+
 static void print_smi_cost(struct perf_stat_config *config,
 			   int cpu, struct perf_evsel *evsel,
 			   struct perf_stat_output_ctx *out,
@@ -970,6 +1023,42 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 					be_bound * 100.);
 		else
 			print_metric(config, ctxp, NULL, NULL, name, 0);
+	} else if (perf_stat_evsel__is(evsel, TOPDOWN_RETIRING) &&
+			full_td(ctx, cpu, st)) {
+		double retiring = td_metric_ratio(ctx, cpu,
+						  STAT_TOPDOWN_RETIRING, st);
+
+		if (retiring > 0.7)
+			color = PERF_COLOR_GREEN;
+		print_metric(config, ctxp, color, "%8.1f%%", "retiring",
+				retiring * 100.);
+	} else if (perf_stat_evsel__is(evsel, TOPDOWN_FE_BOUND) &&
+			full_td(ctx, cpu, st)) {
+		double fe_bound = td_metric_ratio(ctx, cpu,
+						  STAT_TOPDOWN_FE_BOUND, st);
+
+		if (fe_bound > 0.2)
+			color = PERF_COLOR_RED;
+		print_metric(config, ctxp, color, "%8.1f%%", "frontend bound",
+				fe_bound * 100.);
+	} else if (perf_stat_evsel__is(evsel, TOPDOWN_BE_BOUND) &&
+			full_td(ctx, cpu, st)) {
+		double be_bound = td_metric_ratio(ctx, cpu,
+						  STAT_TOPDOWN_BE_BOUND, st);
+
+		if (be_bound > 0.2)
+			color = PERF_COLOR_RED;
+		print_metric(config, ctxp, color, "%8.1f%%", "backend bound",
+				be_bound * 100.);
+	} else if (perf_stat_evsel__is(evsel, TOPDOWN_BAD_SPEC) &&
+			full_td(ctx, cpu, st)) {
+		double bad_spec = td_metric_ratio(ctx, cpu,
+						  STAT_TOPDOWN_BAD_SPEC, st);
+
+		if (bad_spec > 0.1)
+			color = PERF_COLOR_RED;
+		print_metric(config, ctxp, color, "%8.1f%%", "bad speculation",
+				bad_spec * 100.);
 	} else if (evsel->metric_expr) {
 		generic_metric(config, evsel->metric_expr, evsel->metric_events, evsel->name,
 				evsel->metric_name, avg, cpu, out, st);
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index c3115d939b0b..d11701187dc1 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -87,6 +87,10 @@ static const char *id_str[PERF_STAT_EVSEL_ID__MAX] = {
 	ID(TOPDOWN_SLOTS_RETIRED, topdown-slots-retired),
 	ID(TOPDOWN_FETCH_BUBBLES, topdown-fetch-bubbles),
 	ID(TOPDOWN_RECOVERY_BUBBLES, topdown-recovery-bubbles),
+	ID(TOPDOWN_RETIRING, topdown-retiring),
+	ID(TOPDOWN_BAD_SPEC, topdown-bad-spec),
+	ID(TOPDOWN_FE_BOUND, topdown-fe-bound),
+	ID(TOPDOWN_BE_BOUND, topdown-be-bound),
 	ID(SMI_NUM, msr/smi/),
 	ID(APERF, msr/aperf/),
 };
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 2f9c9159a364..827c560ad19f 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -29,6 +29,10 @@ enum perf_stat_evsel_id {
 	PERF_STAT_EVSEL_ID__TOPDOWN_SLOTS_RETIRED,
 	PERF_STAT_EVSEL_ID__TOPDOWN_FETCH_BUBBLES,
 	PERF_STAT_EVSEL_ID__TOPDOWN_RECOVERY_BUBBLES,
+	PERF_STAT_EVSEL_ID__TOPDOWN_RETIRING,
+	PERF_STAT_EVSEL_ID__TOPDOWN_BAD_SPEC,
+	PERF_STAT_EVSEL_ID__TOPDOWN_FE_BOUND,
+	PERF_STAT_EVSEL_ID__TOPDOWN_BE_BOUND,
 	PERF_STAT_EVSEL_ID__SMI_NUM,
 	PERF_STAT_EVSEL_ID__APERF,
 	PERF_STAT_EVSEL_ID__MAX,
@@ -81,6 +85,10 @@ enum stat_type {
 	STAT_TOPDOWN_SLOTS_RETIRED,
 	STAT_TOPDOWN_FETCH_BUBBLES,
 	STAT_TOPDOWN_RECOVERY_BUBBLES,
+	STAT_TOPDOWN_RETIRING,
+	STAT_TOPDOWN_BAD_SPEC,
+	STAT_TOPDOWN_FE_BOUND,
+	STAT_TOPDOWN_BE_BOUND,
 	STAT_SMI_NUM,
 	STAT_APERF,
 	STAT_MAX
-- 
2.14.5

