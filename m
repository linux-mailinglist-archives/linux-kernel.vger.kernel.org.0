Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6538A7B2AC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 20:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388264AbfG3SvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 14:51:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54341 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfG3SvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:51:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UIn8rD3335444
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:49:09 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UIn8rD3335444
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564512549;
        bh=CRvYVB6oDk2lTROTHw93L7kdfRSebrP4Z0ORdvA44EE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=UucV2ws3NnOoQSKVC7D7rwkwCEdQ8Whgq5Ml3GFzri5TLI/b7Uw/b+/NnOM6Cl4j4
         cyeRnVhRvkluBvxyn02qAc1V4rq6ym4w9RmTlh07YAJczAi9XEs3UAdv32S799yc4u
         vfriuOzhp2cLF/YQbRMRCYk60O+Ib1NMJ3s1ni3/5epGCC1bheIvm+42lnq9A7GORB
         BqpCu7pwXYmgooANqeoIbP8cK8OOS+IHSK1bbWKFElL/tW3FsfiACok92VhSDZt1Ql
         j3vDpLVFc7ZHFh01QSs3QjqcenRwiv8jXd/p6PyEMVOnw88KqGuFiug04c11ePtqsv
         vBjz62eRW9ycQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UIn8f93335441;
        Tue, 30 Jul 2019 11:49:08 -0700
Date:   Tue, 30 Jul 2019 11:49:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-453fa03090a64c0e0a561f10dfd5e8747796949c@git.kernel.org>
Cc:     hpa@zytor.com, acme@redhat.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, mpetlan@redhat.com, jolsa@kernel.org,
        ak@linux.intel.com, namhyung@kernel.org, tglx@linutronix.de,
        alexey.budankov@linux.intel.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com
Reply-To: acme@redhat.com, mingo@kernel.org, mpetlan@redhat.com,
          peterz@infradead.org, alexander.shishkin@linux.intel.com,
          jolsa@kernel.org, namhyung@kernel.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, alexey.budankov@linux.intel.com,
          ak@linux.intel.com, tglx@linutronix.de
In-Reply-To: <20190721112506.12306-57-jolsa@kernel.org>
References: <20190721112506.12306-57-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] libperf: Add perf_evlist__set_maps() function
Git-Commit-ID: 453fa03090a64c0e0a561f10dfd5e8747796949c
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  453fa03090a64c0e0a561f10dfd5e8747796949c
Gitweb:     https://git.kernel.org/tip/453fa03090a64c0e0a561f10dfd5e8747796949c
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:43 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:45 -0300

libperf: Add perf_evlist__set_maps() function

Move the evlist__set_maps() function from tools/perf to libperf.

Committer notes:

Fix up reject due to earlier inversion in calling perf_evlist__init().

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-57-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/tests/perf-time-to-tsc.c |  3 +-
 tools/perf/builtin-script.c                  |  3 +-
 tools/perf/builtin-stat.c                    |  3 +-
 tools/perf/lib/evlist.c                      | 54 ++++++++++++++++++++++++++
 tools/perf/lib/include/perf/evlist.h         |  6 +++
 tools/perf/lib/libperf.map                   |  1 +
 tools/perf/tests/code-reading.c              |  5 ++-
 tools/perf/tests/keep-tracking.c             |  3 +-
 tools/perf/tests/mmap-basic.c                |  3 +-
 tools/perf/tests/sw-clock.c                  |  3 +-
 tools/perf/tests/switch-tracking.c           |  3 +-
 tools/perf/tests/task-exit.c                 |  3 +-
 tools/perf/util/evlist.c                     | 58 ++--------------------------
 tools/perf/util/evlist.h                     |  2 -
 14 files changed, 83 insertions(+), 67 deletions(-)

diff --git a/tools/perf/arch/x86/tests/perf-time-to-tsc.c b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
index 261bdd680651..582182d98a7f 100644
--- a/tools/perf/arch/x86/tests/perf-time-to-tsc.c
+++ b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
@@ -6,6 +6,7 @@
 #include <linux/types.h>
 #include <sys/prctl.h>
 #include <perf/cpumap.h>
+#include <perf/evlist.h>
 
 #include "parse-events.h"
 #include "evlist.h"
@@ -72,7 +73,7 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 	evlist = evlist__new();
 	CHECK_NOT_NULL__(evlist);
 
-	perf_evlist__set_maps(evlist, cpus, threads);
+	perf_evlist__set_maps(&evlist->core, cpus, threads);
 
 	CHECK__(parse_events(evlist, "cycles:u", NULL));
 
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index a787c5cb1331..46fadbbe1c3e 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -48,6 +48,7 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include <subcmd/pager.h>
+#include <perf/evlist.h>
 
 #include <linux/ctype.h>
 
@@ -3264,7 +3265,7 @@ static int set_maps(struct perf_script *script)
 	if (WARN_ONCE(script->allocated, "stats double allocation\n"))
 		return -EINVAL;
 
-	perf_evlist__set_maps(evlist, script->cpus, script->threads);
+	perf_evlist__set_maps(&evlist->core, script->cpus, script->threads);
 
 	if (perf_evlist__alloc_stats(evlist, true))
 		return -ENOMEM;
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 4a94ca131d56..14e4c970d16a 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -83,6 +83,7 @@
 #include <sys/resource.h>
 
 #include <linux/ctype.h>
+#include <perf/evlist.h>
 
 #define DEFAULT_SEPARATOR	" "
 #define FREEZE_ON_SMI_PATH	"devices/cpu/freeze_on_smi"
@@ -1517,7 +1518,7 @@ static int set_maps(struct perf_stat *st)
 	if (WARN_ONCE(st->maps_allocated, "stats double allocation\n"))
 		return -EINVAL;
 
-	perf_evlist__set_maps(evsel_list, st->cpus, st->threads);
+	perf_evlist__set_maps(&evsel_list->core, st->cpus, st->threads);
 
 	if (perf_evlist__alloc_stats(evsel_list, true))
 		return -ENOMEM;
diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 087ef76ea8fd..6a2308ef9868 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -5,6 +5,8 @@
 #include <internal/evsel.h>
 #include <linux/zalloc.h>
 #include <stdlib.h>
+#include <perf/cpumap.h>
+#include <perf/threadmap.h>
 
 void perf_evlist__init(struct perf_evlist *evlist)
 {
@@ -12,11 +14,39 @@ void perf_evlist__init(struct perf_evlist *evlist)
 	evlist->nr_entries = 0;
 }
 
+static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
+					  struct perf_evsel *evsel)
+{
+	/*
+	 * We already have cpus for evsel (via PMU sysfs) so
+	 * keep it, if there's no target cpu list defined.
+	 */
+	if (!evsel->own_cpus || evlist->has_user_cpus) {
+		perf_cpu_map__put(evsel->cpus);
+		evsel->cpus = perf_cpu_map__get(evlist->cpus);
+	} else if (evsel->cpus != evsel->own_cpus) {
+		perf_cpu_map__put(evsel->cpus);
+		evsel->cpus = perf_cpu_map__get(evsel->own_cpus);
+	}
+
+	perf_thread_map__put(evsel->threads);
+	evsel->threads = perf_thread_map__get(evlist->threads);
+}
+
+static void perf_evlist__propagate_maps(struct perf_evlist *evlist)
+{
+	struct perf_evsel *evsel;
+
+	perf_evlist__for_each_evsel(evlist, evsel)
+		__perf_evlist__propagate_maps(evlist, evsel);
+}
+
 void perf_evlist__add(struct perf_evlist *evlist,
 		      struct perf_evsel *evsel)
 {
 	list_add_tail(&evsel->node, &evlist->entries);
 	evlist->nr_entries += 1;
+	__perf_evlist__propagate_maps(evlist, evsel);
 }
 
 void perf_evlist__remove(struct perf_evlist *evlist,
@@ -60,3 +90,27 @@ void perf_evlist__delete(struct perf_evlist *evlist)
 {
 	free(evlist);
 }
+
+void perf_evlist__set_maps(struct perf_evlist *evlist,
+			   struct perf_cpu_map *cpus,
+			   struct perf_thread_map *threads)
+{
+	/*
+	 * Allow for the possibility that one or another of the maps isn't being
+	 * changed i.e. don't put it.  Note we are assuming the maps that are
+	 * being applied are brand new and evlist is taking ownership of the
+	 * original reference count of 1.  If that is not the case it is up to
+	 * the caller to increase the reference count.
+	 */
+	if (cpus != evlist->cpus) {
+		perf_cpu_map__put(evlist->cpus);
+		evlist->cpus = perf_cpu_map__get(cpus);
+	}
+
+	if (threads != evlist->threads) {
+		perf_thread_map__put(evlist->threads);
+		evlist->threads = perf_thread_map__get(threads);
+	}
+
+	perf_evlist__propagate_maps(evlist);
+}
diff --git a/tools/perf/lib/include/perf/evlist.h b/tools/perf/lib/include/perf/evlist.h
index 9a126fd0773c..b1d8dee018d6 100644
--- a/tools/perf/lib/include/perf/evlist.h
+++ b/tools/perf/lib/include/perf/evlist.h
@@ -6,6 +6,8 @@
 
 struct perf_evlist;
 struct perf_evsel;
+struct perf_cpu_map;
+struct perf_thread_map;
 
 LIBPERF_API void perf_evlist__init(struct perf_evlist *evlist);
 LIBPERF_API void perf_evlist__add(struct perf_evlist *evlist,
@@ -22,4 +24,8 @@ LIBPERF_API struct perf_evsel* perf_evlist__next(struct perf_evlist *evlist,
 	     (pos) != NULL;				\
 	     (pos) = perf_evlist__next((evlist), (pos)))
 
+LIBPERF_API void perf_evlist__set_maps(struct perf_evlist *evlist,
+				       struct perf_cpu_map *cpus,
+				       struct perf_thread_map *threads);
+
 #endif /* __LIBPERF_EVLIST_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index 28ed04cbd223..9b6e8f165014 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -20,6 +20,7 @@ LIBPERF_0.0.1 {
 		perf_evlist__add;
 		perf_evlist__remove;
 		perf_evlist__next;
+		perf_evlist__set_maps;
 	local:
 		*;
 };
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index bfaf22c2023c..e45df0736261 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -9,6 +9,7 @@
 #include <string.h>
 #include <sys/param.h>
 #include <perf/cpumap.h>
+#include <perf/evlist.h>
 
 #include "parse-events.h"
 #include "evlist.h"
@@ -629,7 +630,7 @@ static int do_test_code_reading(bool try_kcore)
 			goto out_put;
 		}
 
-		perf_evlist__set_maps(evlist, cpus, threads);
+		perf_evlist__set_maps(&evlist->core, cpus, threads);
 
 		str = do_determine_event(excl_kernel);
 		pr_debug("Parsing event '%s'\n", str);
@@ -658,7 +659,7 @@ static int do_test_code_reading(bool try_kcore)
 				 */
 				perf_cpu_map__get(cpus);
 				perf_thread_map__get(threads);
-				perf_evlist__set_maps(evlist, NULL, NULL);
+				perf_evlist__set_maps(&evlist->core, NULL, NULL);
 				evlist__delete(evlist);
 				evlist = NULL;
 				continue;
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index 46478ba1ed16..0ce5ce33bac4 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -3,6 +3,7 @@
 #include <unistd.h>
 #include <sys/prctl.h>
 #include <perf/cpumap.h>
+#include <perf/evlist.h>
 
 #include "parse-events.h"
 #include "evlist.h"
@@ -82,7 +83,7 @@ int test__keep_tracking(struct test *test __maybe_unused, int subtest __maybe_un
 	evlist = evlist__new();
 	CHECK_NOT_NULL__(evlist);
 
-	perf_evlist__set_maps(evlist, cpus, threads);
+	perf_evlist__set_maps(&evlist->core, cpus, threads);
 
 	CHECK__(parse_events(evlist, "dummy:u", NULL));
 	CHECK__(parse_events(evlist, "cycles:u", NULL));
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index aa792aebd7f0..7327694fbde0 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -12,6 +12,7 @@
 #include "tests.h"
 #include <linux/err.h>
 #include <linux/kernel.h>
+#include <perf/evlist.h>
 
 /*
  * This test will generate random numbers of calls to some getpid syscalls,
@@ -68,7 +69,7 @@ int test__basic_mmap(struct test *test __maybe_unused, int subtest __maybe_unuse
 		goto out_free_cpus;
 	}
 
-	perf_evlist__set_maps(evlist, cpus, threads);
+	perf_evlist__set_maps(&evlist->core, cpus, threads);
 
 	for (i = 0; i < nsyscalls; ++i) {
 		char name[64];
diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index 2decda2d4c17..c5f1a9f83380 100644
--- a/tools/perf/tests/sw-clock.c
+++ b/tools/perf/tests/sw-clock.c
@@ -11,6 +11,7 @@
 #include "util/evlist.h"
 #include "util/cpumap.h"
 #include "util/thread_map.h"
+#include <perf/evlist.h>
 
 #define NR_LOOPS  10000000
 
@@ -64,7 +65,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 		goto out_free_maps;
 	}
 
-	perf_evlist__set_maps(evlist, cpus, threads);
+	perf_evlist__set_maps(&evlist->core, cpus, threads);
 
 	cpus	= NULL;
 	threads = NULL;
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 9e0bbea15005..e3cee69f6ea2 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -6,6 +6,7 @@
 #include <stdlib.h>
 #include <linux/zalloc.h>
 #include <perf/cpumap.h>
+#include <perf/evlist.h>
 
 #include "parse-events.h"
 #include "evlist.h"
@@ -354,7 +355,7 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
 		goto out_err;
 	}
 
-	perf_evlist__set_maps(evlist, cpus, threads);
+	perf_evlist__set_maps(&evlist->core, cpus, threads);
 
 	/* First event */
 	err = parse_events(evlist, "cpu-clock:u", NULL);
diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index b0192ea636a7..4ca38fd0379a 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -7,6 +7,7 @@
 
 #include <errno.h>
 #include <signal.h>
+#include <perf/evlist.h>
 
 static int exited;
 static int nr_exit;
@@ -71,7 +72,7 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
 		goto out_free_maps;
 	}
 
-	perf_evlist__set_maps(evlist, cpus, threads);
+	perf_evlist__set_maps(&evlist->core, cpus, threads);
 
 	cpus	= NULL;
 	threads = NULL;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 1a6f877ebb03..4433b656cfb7 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -51,7 +51,7 @@ void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
 	for (i = 0; i < PERF_EVLIST__HLIST_SIZE; ++i)
 		INIT_HLIST_HEAD(&evlist->heads[i]);
 	perf_evlist__init(&evlist->core);
-	perf_evlist__set_maps(evlist, cpus, threads);
+	perf_evlist__set_maps(&evlist->core, cpus, threads);
 	fdarray__init(&evlist->pollfd, 64);
 	evlist->workload.pid = -1;
 	evlist->bkw_mmap_state = BKW_MMAP_NOTREADY;
@@ -152,33 +152,6 @@ void evlist__delete(struct evlist *evlist)
 	free(evlist);
 }
 
-static void __perf_evlist__propagate_maps(struct evlist *evlist,
-					  struct evsel *evsel)
-{
-	/*
-	 * We already have cpus for evsel (via PMU sysfs) so
-	 * keep it, if there's no target cpu list defined.
-	 */
-	if (!evsel->core.own_cpus || evlist->core.has_user_cpus) {
-		perf_cpu_map__put(evsel->core.cpus);
-		evsel->core.cpus = perf_cpu_map__get(evlist->core.cpus);
-	} else if (evsel->core.cpus != evsel->core.own_cpus) {
-		perf_cpu_map__put(evsel->core.cpus);
-		evsel->core.cpus = perf_cpu_map__get(evsel->core.own_cpus);
-	}
-
-	perf_thread_map__put(evsel->core.threads);
-	evsel->core.threads = perf_thread_map__get(evlist->core.threads);
-}
-
-static void perf_evlist__propagate_maps(struct evlist *evlist)
-{
-	struct evsel *evsel;
-
-	evlist__for_each_entry(evlist, evsel)
-		__perf_evlist__propagate_maps(evlist, evsel);
-}
-
 void evlist__add(struct evlist *evlist, struct evsel *entry)
 {
 	entry->evlist = evlist;
@@ -189,8 +162,6 @@ void evlist__add(struct evlist *evlist, struct evsel *entry)
 
 	if (evlist->core.nr_entries == 1)
 		perf_evlist__set_id_pos(evlist);
-
-	__perf_evlist__propagate_maps(evlist, entry);
 }
 
 void evlist__remove(struct evlist *evlist, struct evsel *evsel)
@@ -1097,7 +1068,7 @@ int perf_evlist__create_maps(struct evlist *evlist, struct target *target)
 
 	evlist->core.has_user_cpus = !!target->cpu_list;
 
-	perf_evlist__set_maps(evlist, cpus, threads);
+	perf_evlist__set_maps(&evlist->core, cpus, threads);
 
 	return 0;
 
@@ -1106,29 +1077,6 @@ out_delete_threads:
 	return -1;
 }
 
-void perf_evlist__set_maps(struct evlist *evlist, struct perf_cpu_map *cpus,
-			   struct perf_thread_map *threads)
-{
-	/*
-	 * Allow for the possibility that one or another of the maps isn't being
-	 * changed i.e. don't put it.  Note we are assuming the maps that are
-	 * being applied are brand new and evlist is taking ownership of the
-	 * original reference count of 1.  If that is not the case it is up to
-	 * the caller to increase the reference count.
-	 */
-	if (cpus != evlist->core.cpus) {
-		perf_cpu_map__put(evlist->core.cpus);
-		evlist->core.cpus = perf_cpu_map__get(cpus);
-	}
-
-	if (threads != evlist->core.threads) {
-		perf_thread_map__put(evlist->core.threads);
-		evlist->core.threads = perf_thread_map__get(threads);
-	}
-
-	perf_evlist__propagate_maps(evlist);
-}
-
 void __perf_evlist__set_sample_bit(struct evlist *evlist,
 				   enum perf_event_sample_format bit)
 {
@@ -1381,7 +1329,7 @@ static int perf_evlist__create_syswide_maps(struct evlist *evlist)
 	if (!threads)
 		goto out_put;
 
-	perf_evlist__set_maps(evlist, cpus, threads);
+	perf_evlist__set_maps(&evlist->core, cpus, threads);
 out:
 	return err;
 out_put:
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index de2025d198d4..e31ddcc058f2 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -191,8 +191,6 @@ int perf_evlist__enable_event_idx(struct evlist *evlist,
 void perf_evlist__set_selected(struct evlist *evlist,
 			       struct evsel *evsel);
 
-void perf_evlist__set_maps(struct evlist *evlist, struct perf_cpu_map *cpus,
-			   struct perf_thread_map *threads);
 int perf_evlist__create_maps(struct evlist *evlist, struct target *target);
 int perf_evlist__apply_filters(struct evlist *evlist, struct evsel **err_evsel);
 
