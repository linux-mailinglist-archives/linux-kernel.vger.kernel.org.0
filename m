Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75D44153CCD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 02:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbgBFB4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 20:56:37 -0500
Received: from mga01.intel.com ([192.55.52.88]:36730 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727474AbgBFB4h (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 20:56:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 17:56:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,407,1574150400"; 
   d="scan'208";a="378930190"
Received: from kbl.sh.intel.com ([10.239.159.24])
  by orsmga004.jf.intel.com with ESMTP; 05 Feb 2020 17:56:34 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] perf stat: Show percore counts in per CPU output
Date:   Thu,  6 Feb 2020 09:56:13 +0800
Message-Id: <20200206015613.527-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have supported the event modifier "percore" which sums up the
event counts for all hardware threads in a core and show the counts
per core.

For example,

 # perf stat -e cpu/event=cpu-cycles,percore/ -a -A -- sleep 1

  Performance counter stats for 'system wide':

 S0-D0-C0                395,072      cpu/event=cpu-cycles,percore/
 S0-D0-C1                851,248      cpu/event=cpu-cycles,percore/
 S0-D0-C2                954,226      cpu/event=cpu-cycles,percore/
 S0-D0-C3              1,233,659      cpu/event=cpu-cycles,percore/

This patch provides a new option "--percore-show-thread". It is
used with event modifier "percore" together to sum up the event counts
for all hardware threads in a core but show the counts per hardware
thread.

For example,

 # perf stat -e cpu/event=cpu-cycles,percore/ -a -A --percore-show-thread  -- sleep 1

  Performance counter stats for 'system wide':

 CPU0               2,453,061      cpu/event=cpu-cycles,percore/
 CPU1               1,823,921      cpu/event=cpu-cycles,percore/
 CPU2               1,383,166      cpu/event=cpu-cycles,percore/
 CPU3               1,102,652      cpu/event=cpu-cycles,percore/
 CPU4               2,453,061      cpu/event=cpu-cycles,percore/
 CPU5               1,823,921      cpu/event=cpu-cycles,percore/
 CPU6               1,383,166      cpu/event=cpu-cycles,percore/
 CPU7               1,102,652      cpu/event=cpu-cycles,percore/

We can see counts are duplicated in some CPU pairs
(CPU0/CPU4, CPU1/CPU5, CPU2/CPU6, CPU3/CPU7).

This new option may be useful for some script processing.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/Documentation/perf-stat.txt |  7 ++++
 tools/perf/builtin-stat.c              |  4 ++
 tools/perf/util/stat-display.c         | 57 ++++++++++++++++++++++----
 tools/perf/util/stat.h                 |  1 +
 4 files changed, 60 insertions(+), 9 deletions(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 9431b8066fb4..f6033b3d0971 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -334,6 +334,13 @@ Configure all used events to run in kernel space.
 --all-user::
 Configure all used events to run in user space.
 
+--percore-show-thread::
+The event modifier "percore" has supported to sum up the event counts
+for all hardware threads in a core and show the counts per core.
+
+This option with event modifier "percore" enabled also sums up the event
+counts for all hardware threads in a core but show the counts per thread.
+
 EXAMPLES
 --------
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index a098c2ebf4ea..ec053dc1e35c 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -929,6 +929,10 @@ static struct option stat_options[] = {
 	OPT_BOOLEAN_FLAG(0, "all-user", &stat_config.all_user,
 			 "Configure all used events to run in user space.",
 			 PARSE_OPT_EXCLUSIVE),
+	OPT_BOOLEAN(0, "percore-show-thread", &stat_config.percore_show_thread,
+		    "Use with 'percore' event qualifier to show the event "
+		    "counts of one hardware thread by sum up total hardware "
+		    "threads of same physical core"),
 	OPT_END()
 };
 
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index bc31fccc0057..ca603e59dfe1 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -110,7 +110,7 @@ static void aggr_printout(struct perf_stat_config *config,
 			config->csv_sep);
 			break;
 	case AGGR_NONE:
-		if (evsel->percore) {
+		if (evsel->percore && !config->percore_show_thread) {
 			fprintf(config->output, "S%d-D%d-C%*d%s",
 				cpu_map__id_to_socket(id),
 				cpu_map__id_to_die(id),
@@ -628,7 +628,7 @@ static void aggr_cb(struct perf_stat_config *config,
 static void print_counter_aggrdata(struct perf_stat_config *config,
 				   struct evsel *counter, int s,
 				   char *prefix, bool metric_only,
-				   bool *first)
+				   bool *first, int cpu)
 {
 	struct aggr_data ad;
 	FILE *output = config->output;
@@ -654,8 +654,15 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
 		fprintf(output, "%s", prefix);
 
 	uval = val * counter->scale;
-	printout(config, id, nr, counter, uval, prefix,
-		 run, ena, 1.0, &rt_stat);
+
+	if (cpu == -1) {
+		printout(config, id, nr, counter, uval, prefix,
+			 run, ena, 1.0, &rt_stat);
+	} else {
+		printout(config, cpu, nr, counter, uval, prefix,
+			 run, ena, 1.0, &rt_stat);
+	}
+
 	if (!metric_only)
 		fputc('\n', output);
 }
@@ -687,7 +694,7 @@ static void print_aggr(struct perf_stat_config *config,
 		evlist__for_each_entry(evlist, counter) {
 			print_counter_aggrdata(config, counter, s,
 					       prefix, metric_only,
-					       &first);
+					       &first, -1);
 		}
 		if (metric_only)
 			fputc('\n', output);
@@ -1163,13 +1170,38 @@ static void print_percore(struct perf_stat_config *config,
 
 		print_counter_aggrdata(config, counter, s,
 				       prefix, metric_only,
-				       &first);
+				       &first, -1);
 	}
 
 	if (metric_only)
 		fputc('\n', output);
 }
 
+static void print_percore_thread(struct perf_stat_config *config,
+				 struct evsel *counter, char *prefix)
+{
+	int cpu, s, s2, id;
+	bool first = true;
+	FILE *output = config->output;
+
+	for (cpu = 0; cpu < perf_evsel__nr_cpus(counter); cpu++) {
+		s2 = config->aggr_get_id(config, evsel__cpus(counter), cpu);
+
+		for (s = 0; s < config->aggr_map->nr; s++) {
+			id = config->aggr_map->map[s];
+			if (s2 == id)
+				break;
+		}
+
+		if (prefix)
+			fprintf(output, "%s", prefix);
+
+		print_counter_aggrdata(config, counter, s,
+				       prefix, false,
+				       &first, cpu);
+	}
+}
+
 void
 perf_evlist__print_counters(struct evlist *evlist,
 			    struct perf_stat_config *config,
@@ -1222,9 +1254,16 @@ perf_evlist__print_counters(struct evlist *evlist,
 			print_no_aggr_metric(config, evlist, prefix);
 		else {
 			evlist__for_each_entry(evlist, counter) {
-				if (counter->percore)
-					print_percore(config, counter, prefix);
-				else
+				if (counter->percore) {
+					if (config->percore_show_thread) {
+						print_percore_thread(config,
+								     counter,
+								     prefix);
+					} else {
+						print_percore(config, counter,
+							      prefix);
+					}
+				} else
 					print_counter(config, counter, prefix);
 			}
 		}
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index fb990efa54a8..b4fdfaa7f2c0 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -109,6 +109,7 @@ struct perf_stat_config {
 	bool			 walltime_run_table;
 	bool			 all_kernel;
 	bool			 all_user;
+	bool			 percore_show_thread;
 	FILE			*output;
 	unsigned int		 interval;
 	unsigned int		 timeout;
-- 
2.17.1

