Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1D42F85CA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 02:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfKLBAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 20:00:02 -0500
Received: from mga14.intel.com ([192.55.52.115]:61337 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727296AbfKLA7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 19:59:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2019 16:59:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,294,1569308400"; 
   d="scan'208";a="215864801"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga002.jf.intel.com with ESMTP; 11 Nov 2019 16:59:43 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 2ED4D301A83; Mon, 11 Nov 2019 16:59:43 -0800 (PST)
From:   Andi Kleen <andi@firstfloor.org>
To:     jolsa@kernel.org
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v6 09/12] perf stat: Use affinity for opening events
Date:   Mon, 11 Nov 2019 16:59:38 -0800
Message-Id: <20191112005941.649137-10-andi@firstfloor.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191112005941.649137-1-andi@firstfloor.org>
References: <20191112005941.649137-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Restructure the event opening in perf stat to cycle through
the events by CPU after setting affinity to that CPU.
This eliminates IPI overhead in the perf API.

We have to loop through the CPU in the outter builtin-stat
code instead of leaving that to low level functions.

It has to change the weak group fallback strategy slightly.
Since we cannot easily undo the opens for other CPUs
move the weak group retry to a separate loop.

Before with a large test case with 94 CPUs:

% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 42.75    4.050910          67     60046       110 perf_event_open

After:

 26.86    0.944396          16     58069       110 perf_event_open

(the number changes slightly because the weak group retries
work differently and the test case relies on weak groups)

Signed-off-by: Andi Kleen <ak@linux.intel.com>

---

v2: Use new iterator macros.
Fix bug that caused unnecessary retry for errored events.
Add extra assert to check assumption that cpumaps are always subsets
v3:
Use new iterator macros
Factored out code movement for error handling.
v4:
Update iterator macros again
Fix minor bug with errored events
v5:
Add comments. Remove redundant iterator start.
Merge evsel open patch into this one again to avoid broke immediate.
---
 tools/perf/builtin-record.c    |   2 +-
 tools/perf/builtin-stat.c      | 121 +++++++++++++++++++++++++++------
 tools/perf/tests/event-times.c |   4 +-
 tools/perf/util/evlist.c       |  10 ++-
 tools/perf/util/evlist.h       |   3 +-
 tools/perf/util/evsel.c        |  18 +++--
 tools/perf/util/evsel.h        |   5 +-
 tools/perf/util/stat.c         |   5 +-
 tools/perf/util/stat.h         |   3 +-
 9 files changed, 137 insertions(+), 34 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 2fb83aabbef5..9f8a9393ce4a 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -776,7 +776,7 @@ static int record__open(struct record *rec)
 			if ((errno == EINVAL || errno == EBADF) &&
 			    pos->leader != pos &&
 			    pos->weak_group) {
-			        pos = perf_evlist__reset_weak_group(evlist, pos);
+			        pos = perf_evlist__reset_weak_group(evlist, pos, true);
 				goto try_again;
 			}
 			rc = -errno;
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 1a586009e5a7..039aefb07777 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -65,6 +65,7 @@
 #include "util/target.h"
 #include "util/time-utils.h"
 #include "util/top.h"
+#include "util/affinity.h"
 #include "asm/bug.h"
 
 #include <linux/time64.h>
@@ -440,6 +441,11 @@ static enum counter_recovery stat_handle_error(struct evsel *counter)
 			ui__warning("%s event is not supported by the kernel.\n",
 				    perf_evsel__name(counter));
 		counter->supported = false;
+		/*
+		 * errored is a sticky flag that means one of the counter's
+		 * cpu event had a problem and needs to be reexamined.
+		 */
+		counter->errored = true;
 
 		if ((counter->leader != counter) ||
 		    !(counter->leader->core.nr_members > 1))
@@ -484,6 +490,9 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	int status = 0;
 	const bool forks = (argc > 0);
 	bool is_pipe = STAT_RECORD ? perf_stat.data.is_pipe : false;
+	struct affinity affinity;
+	int i, cpu;
+	bool second_pass = false;
 
 	if (interval) {
 		ts.tv_sec  = interval / USEC_PER_MSEC;
@@ -508,30 +517,104 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	if (group)
 		perf_evlist__set_leader(evsel_list);
 
-	evlist__for_each_entry(evsel_list, counter) {
+	if (affinity__setup(&affinity) < 0)
+		return -1;
+
+	evlist__for_each_cpu (evsel_list, i, cpu) {
+		affinity__set(&affinity, cpu);
+
+		evlist__for_each_entry(evsel_list, counter) {
+			if (evsel__cpu_iter_skip(counter, cpu))
+				continue;
+			if (counter->reset_group || counter->errored)
+				continue;
 try_again:
-		if (create_perf_stat_counter(counter, &stat_config, &target) < 0) {
-
-			/* Weak group failed. Reset the group. */
-			if ((errno == EINVAL || errno == EBADF) &&
-			    counter->leader != counter &&
-			    counter->weak_group) {
-				counter = perf_evlist__reset_weak_group(evsel_list, counter);
-				goto try_again;
+			if (create_perf_stat_counter(counter, &stat_config, &target,
+						     counter->cpu_iter - 1) < 0) {
+
+				/*
+				 * Weak group failed. We cannot just undo this here
+				 * because earlier CPUs might be in group mode, and the kernel
+				 * doesn't support mixing group and non group reads. Defer
+				 * it to later.
+				 * Don't close here because we're in the wrong affinity.
+				 */
+				if ((errno == EINVAL || errno == EBADF) &&
+				    counter->leader != counter &&
+				    counter->weak_group) {
+					perf_evlist__reset_weak_group(evsel_list, counter, false);
+					assert(counter->reset_group);
+					second_pass = true;
+					continue;
+				}
+
+				switch (stat_handle_error(counter)) {
+				case COUNTER_FATAL:
+					return -1;
+				case COUNTER_RETRY:
+					goto try_again;
+				case COUNTER_SKIP:
+					continue;
+				default:
+					break;
+				}
+
 			}
+			counter->supported = true;
+		}
+	}
 
-			switch (stat_handle_error(counter)) {
-			case COUNTER_FATAL:
-				return -1;
-			case COUNTER_RETRY:
-				goto try_again;
-			case COUNTER_SKIP:
-				continue;
-			default:
-				break;
+	if (second_pass) {
+		/*
+		 * Now redo all the weak group after closing them,
+		 * and also close errored counters.
+		 */
+
+		evlist__for_each_cpu (evsel_list, i, cpu) {
+			affinity__set(&affinity, cpu);
+			/* First close errored or weak retry */
+			evlist__for_each_entry(evsel_list, counter) {
+				if (!counter->reset_group && !counter->errored)
+					continue;
+				if (evsel__cpu_iter_skip_no_inc(counter, cpu))
+					continue;
+				perf_evsel__close_cpu(&counter->core, counter->cpu_iter);
+			}
+			/* Now reopen weak */
+			evlist__for_each_entry(evsel_list, counter) {
+				if (!counter->reset_group && !counter->errored)
+					continue;
+				if (evsel__cpu_iter_skip(counter, cpu))
+					continue;
+				if (!counter->reset_group)
+					continue;
+try_again_reset:
+				pr_debug2("reopening weak %s\n", perf_evsel__name(counter));
+				if (create_perf_stat_counter(counter, &stat_config, &target,
+							     counter->cpu_iter - 1) < 0) {
+
+					switch (stat_handle_error(counter)) {
+					case COUNTER_FATAL:
+						return -1;
+					case COUNTER_RETRY:
+						goto try_again_reset;
+					case COUNTER_SKIP:
+						continue;
+					default:
+						break;
+					}
+				}
+				counter->supported = true;
 			}
 		}
-		counter->supported = true;
+	}
+	affinity__cleanup(&affinity);
+
+	evlist__for_each_entry(evsel_list, counter) {
+		if (!counter->supported) {
+			perf_evsel__free_fd(&counter->core);
+			continue;
+		}
 
 		l = strlen(counter->unit);
 		if (l > stat_config.unit_width)
diff --git a/tools/perf/tests/event-times.c b/tools/perf/tests/event-times.c
index 1ee8704e2284..1e8a9f5c356d 100644
--- a/tools/perf/tests/event-times.c
+++ b/tools/perf/tests/event-times.c
@@ -125,7 +125,7 @@ static int attach__cpu_disabled(struct evlist *evlist)
 
 	evsel->core.attr.disabled = 1;
 
-	err = perf_evsel__open_per_cpu(evsel, cpus);
+	err = perf_evsel__open_per_cpu(evsel, cpus, -1);
 	if (err) {
 		if (err == -EACCES)
 			return TEST_SKIP;
@@ -152,7 +152,7 @@ static int attach__cpu_enabled(struct evlist *evlist)
 		return -1;
 	}
 
-	err = perf_evsel__open_per_cpu(evsel, cpus);
+	err = perf_evsel__open_per_cpu(evsel, cpus, -1);
 	if (err == -EACCES)
 		return TEST_SKIP;
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 7db49a0a0350..17960e4d3a45 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1636,7 +1636,8 @@ void perf_evlist__force_leader(struct evlist *evlist)
 }
 
 struct evsel *perf_evlist__reset_weak_group(struct evlist *evsel_list,
-						 struct evsel *evsel)
+						 struct evsel *evsel,
+						bool close)
 {
 	struct evsel *c2, *leader;
 	bool is_open = true;
@@ -1653,10 +1654,15 @@ struct evsel *perf_evlist__reset_weak_group(struct evlist *evsel_list,
 		if (c2 == evsel)
 			is_open = false;
 		if (c2->leader == leader) {
-			if (is_open)
+			if (is_open && close)
 				perf_evsel__close(&c2->core);
 			c2->leader = c2;
 			c2->core.nr_members = 0;
+			/*
+			 * Set this for all former members of the group
+			 * to indicate they get reopened.
+			 */
+			c2->reset_group = true;
 		}
 	}
 	return leader;
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 12606efc1f7c..ad77091d1e1e 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -355,5 +355,6 @@ bool perf_evlist__exclude_kernel(struct evlist *evlist);
 void perf_evlist__force_leader(struct evlist *evlist);
 
 struct evsel *perf_evlist__reset_weak_group(struct evlist *evlist,
-						 struct evsel *evsel);
+						 struct evsel *evsel,
+						bool close);
 #endif /* __PERF_EVLIST_H */
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d4451846af93..7106f9a067df 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1569,8 +1569,9 @@ static int perf_event_open(struct evsel *evsel,
 	return fd;
 }
 
-int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
-		struct perf_thread_map *threads)
+static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
+		struct perf_thread_map *threads,
+		int start_cpu, int end_cpu)
 {
 	int cpu, thread, nthreads;
 	unsigned long flags = PERF_FLAG_FD_CLOEXEC;
@@ -1647,7 +1648,7 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 	display_attr(&evsel->core.attr);
 
-	for (cpu = 0; cpu < cpus->nr; cpu++) {
+	for (cpu = start_cpu; cpu < end_cpu; cpu++) {
 
 		for (thread = 0; thread < nthreads; thread++) {
 			int fd, group_fd;
@@ -1825,6 +1826,12 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 	return err;
 }
 
+int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
+		struct perf_thread_map *threads)
+{
+	return evsel__open_cpu(evsel, cpus, threads, 0, cpus ? cpus->nr : 1);
+}
+
 void evsel__close(struct evsel *evsel)
 {
 	perf_evsel__close(&evsel->core);
@@ -1832,9 +1839,10 @@ void evsel__close(struct evsel *evsel)
 }
 
 int perf_evsel__open_per_cpu(struct evsel *evsel,
-			     struct perf_cpu_map *cpus)
+			     struct perf_cpu_map *cpus,
+			     int cpu)
 {
-	return evsel__open(evsel, cpus, NULL);
+	return evsel__open_cpu(evsel, cpus, NULL, cpu, cpu + 1);
 }
 
 int perf_evsel__open_per_thread(struct evsel *evsel,
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index b10d5ba21966..ca82a93960cd 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -94,6 +94,8 @@ struct evsel {
 	struct evsel		*metric_leader;
 	bool			collect_stat;
 	bool			weak_group;
+	bool			reset_group;
+	bool			errored;
 	bool			percore;
 	int			cpu_iter;
 	const char		*pmu_name;
@@ -223,7 +225,8 @@ int evsel__enable(struct evsel *evsel);
 int evsel__disable(struct evsel *evsel);
 
 int perf_evsel__open_per_cpu(struct evsel *evsel,
-			     struct perf_cpu_map *cpus);
+			     struct perf_cpu_map *cpus,
+			     int cpu);
 int perf_evsel__open_per_thread(struct evsel *evsel,
 				struct perf_thread_map *threads);
 int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 6822e4ffe224..3aebe732e886 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -463,7 +463,8 @@ size_t perf_event__fprintf_stat_config(union perf_event *event, FILE *fp)
 
 int create_perf_stat_counter(struct evsel *evsel,
 			     struct perf_stat_config *config,
-			     struct target *target)
+			     struct target *target,
+			     int cpu)
 {
 	struct perf_event_attr *attr = &evsel->core.attr;
 	struct evsel *leader = evsel->leader;
@@ -517,7 +518,7 @@ int create_perf_stat_counter(struct evsel *evsel,
 	}
 
 	if (target__has_cpu(target) && !target__has_per_thread(target))
-		return perf_evsel__open_per_cpu(evsel, evsel__cpus(evsel));
+		return perf_evsel__open_per_cpu(evsel, evsel__cpus(evsel), cpu);
 
 	return perf_evsel__open_per_thread(evsel, evsel->core.threads);
 }
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 081c4a5113c6..4c9a7b68c3e7 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -213,7 +213,8 @@ size_t perf_event__fprintf_stat_config(union perf_event *event, FILE *fp);
 
 int create_perf_stat_counter(struct evsel *evsel,
 			     struct perf_stat_config *config,
-			     struct target *target);
+			     struct target *target,
+			     int cpu);
 void
 perf_evlist__print_counters(struct evlist *evlist,
 			    struct perf_stat_config *config,
-- 
2.23.0

