Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C483D7B286
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 20:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388357AbfG3Sr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 14:47:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53259 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388028AbfG3Sr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:47:56 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UIldTf3335049
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:47:40 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UIldTf3335049
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564512460;
        bh=ZOH/ETZSfGVTE47W65o7fhpFqjrSZ6W+ZyifyrK+edE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=pyQ3rquOST2IYP6qX7C8kKw+3p0cMW3el3hwdC+RU/LoVmzyQ+/xDDpsFjyXs+gOb
         4buhuE7Fi5UfgUmetn/+yH11aTRFuxJmV93SILr99QEApPZJfFzAJ1ozwpOFoWed6p
         5tPowvKasD032MQYz90map2dBQnOfGyRjPx7GOp0LuCoyy1hPu+wtywhOqjx3ESPrP
         pUkAbQ/hMGmFDF6+khycNs6QgWDLvQsLyqKaK1BlMOKzOywrA5j7VLWH01wMCNGVzO
         nuJcVCXEWL8C8P/dU5Eg4BSpVEE3q6mz7T/EdWl6l8Z8ZHBXxW+F4+h1wbOvgom2ny
         fRPRHLkBaR9hA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UIldoZ3335046;
        Tue, 30 Jul 2019 11:47:39 -0700
Date:   Tue, 30 Jul 2019 11:47:39 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-f72f901d90b00aaf2a6c1335b41311687b3f2dec@git.kernel.org>
Cc:     mpetlan@redhat.com, jolsa@kernel.org, acme@redhat.com,
        alexander.shishkin@linux.intel.com,
        alexey.budankov@linux.intel.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, ak@linux.intel.com, namhyung@kernel.org,
        peterz@infradead.org, mingo@kernel.org, tglx@linutronix.de
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, namhyung@kernel.org,
          ak@linux.intel.com, acme@redhat.com, jolsa@kernel.org,
          mpetlan@redhat.com, alexander.shishkin@linux.intel.com,
          alexey.budankov@linux.intel.com, mingo@kernel.org,
          tglx@linutronix.de, peterz@infradead.org
In-Reply-To: <20190721112506.12306-55-jolsa@kernel.org>
References: <20190721112506.12306-55-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] libperf: Add cpus to struct perf_evlist
Git-Commit-ID: f72f901d90b00aaf2a6c1335b41311687b3f2dec
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

Commit-ID:  f72f901d90b00aaf2a6c1335b41311687b3f2dec
Gitweb:     https://git.kernel.org/tip/f72f901d90b00aaf2a6c1335b41311687b3f2dec
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:41 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:45 -0300

libperf: Add cpus to struct perf_evlist

Move cpus from tools/perf's evlist to libperf's perf_evlist struct.

Committer notes:

Fixed up this one:

  tools/perf/arch/arm/util/cs-etm.c

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-55-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/cs-etm.c        |  8 +++----
 tools/perf/arch/x86/util/intel-bts.c     |  2 +-
 tools/perf/arch/x86/util/intel-pt.c      |  4 ++--
 tools/perf/builtin-ftrace.c              |  2 +-
 tools/perf/builtin-record.c              |  2 +-
 tools/perf/builtin-stat.c                | 16 +++++++-------
 tools/perf/builtin-top.c                 |  2 +-
 tools/perf/lib/include/internal/evlist.h |  9 +++++---
 tools/perf/util/auxtrace.c               |  2 +-
 tools/perf/util/evlist.c                 | 36 ++++++++++++++++----------------
 tools/perf/util/evlist.h                 |  1 -
 tools/perf/util/record.c                 |  6 +++---
 tools/perf/util/stat-display.c           |  6 +++---
 tools/perf/util/stat.c                   |  2 +-
 tools/perf/util/top.c                    |  6 +++---
 15 files changed, 53 insertions(+), 51 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index c25bc1528b96..5cb07e8cb296 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -155,7 +155,7 @@ static int cs_etm_set_option(struct auxtrace_record *itr,
 			     struct evsel *evsel, u32 option)
 {
 	int i, err = -EINVAL;
-	struct perf_cpu_map *event_cpus = evsel->evlist->cpus;
+	struct perf_cpu_map *event_cpus = evsel->evlist->core.cpus;
 	struct perf_cpu_map *online_cpus = perf_cpu_map__new(NULL);
 
 	/* Set option of each CPU we have */
@@ -253,7 +253,7 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 				container_of(itr, struct cs_etm_recording, itr);
 	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
 	struct evsel *evsel, *cs_etm_evsel = NULL;
-	struct perf_cpu_map *cpus = evlist->cpus;
+	struct perf_cpu_map *cpus = evlist->core.cpus;
 	bool privileged = (geteuid() == 0 || perf_event_paranoid() < 0);
 	int err = 0;
 
@@ -489,7 +489,7 @@ cs_etm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
 {
 	int i;
 	int etmv3 = 0, etmv4 = 0;
-	struct perf_cpu_map *event_cpus = evlist->cpus;
+	struct perf_cpu_map *event_cpus = evlist->core.cpus;
 	struct perf_cpu_map *online_cpus = perf_cpu_map__new(NULL);
 
 	/* cpu map is not empty, we have specific CPUs to work with */
@@ -636,7 +636,7 @@ static int cs_etm_info_fill(struct auxtrace_record *itr,
 	u32 offset;
 	u64 nr_cpu, type;
 	struct perf_cpu_map *cpu_map;
-	struct perf_cpu_map *event_cpus = session->evlist->cpus;
+	struct perf_cpu_map *event_cpus = session->evlist->core.cpus;
 	struct perf_cpu_map *online_cpus = perf_cpu_map__new(NULL);
 	struct cs_etm_recording *ptr =
 			container_of(itr, struct cs_etm_recording, itr);
diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index d8a091266185..7b23318ebd7b 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -106,7 +106,7 @@ static int intel_bts_recording_options(struct auxtrace_record *itr,
 			container_of(itr, struct intel_bts_recording, itr);
 	struct perf_pmu *intel_bts_pmu = btsr->intel_bts_pmu;
 	struct evsel *evsel, *intel_bts_evsel = NULL;
-	const struct perf_cpu_map *cpus = evlist->cpus;
+	const struct perf_cpu_map *cpus = evlist->core.cpus;
 	bool privileged = geteuid() == 0 || perf_event_paranoid() < 0;
 
 	btsr->evlist = evlist;
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index aada6a2c456a..218a4e694618 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -365,7 +365,7 @@ static int intel_pt_info_fill(struct auxtrace_record *itr,
 			ui__warning("Intel Processor Trace: TSC not available\n");
 	}
 
-	per_cpu_mmaps = !cpu_map__empty(session->evlist->cpus);
+	per_cpu_mmaps = !cpu_map__empty(session->evlist->core.cpus);
 
 	auxtrace_info->type = PERF_AUXTRACE_INTEL_PT;
 	auxtrace_info->priv[INTEL_PT_PMU_TYPE] = intel_pt_pmu->type;
@@ -557,7 +557,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 	struct perf_pmu *intel_pt_pmu = ptr->intel_pt_pmu;
 	bool have_timing_info, need_immediate = false;
 	struct evsel *evsel, *intel_pt_evsel = NULL;
-	const struct perf_cpu_map *cpus = evlist->cpus;
+	const struct perf_cpu_map *cpus = evlist->core.cpus;
 	bool privileged = geteuid() == 0 || perf_event_paranoid() < 0;
 	u64 tsc_bit;
 	int err;
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 77989254fdd8..f481a870e728 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -192,7 +192,7 @@ static int set_tracing_cpumask(struct perf_cpu_map *cpumap)
 
 static int set_tracing_cpu(struct perf_ftrace *ftrace)
 {
-	struct perf_cpu_map *cpumap = ftrace->evlist->cpus;
+	struct perf_cpu_map *cpumap = ftrace->evlist->core.cpus;
 
 	if (!target__has_cpu(&ftrace->target))
 		return 0;
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 27ff899bed88..d4f0430c2f49 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1283,7 +1283,7 @@ static int record__synthesize(struct record *rec, bool tail)
 		return err;
 	}
 
-	err = perf_event__synthesize_cpu_map(&rec->tool, rec->evlist->cpus,
+	err = perf_event__synthesize_cpu_map(&rec->tool, rec->evlist->core.cpus,
 					     process_synthesized_event, NULL);
 	if (err < 0) {
 		pr_err("Couldn't synthesize cpu map.\n");
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 8ad3643d61f9..d81b0b1ef514 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -884,21 +884,21 @@ static int perf_stat_init_aggr_mode(void)
 
 	switch (stat_config.aggr_mode) {
 	case AGGR_SOCKET:
-		if (cpu_map__build_socket_map(evsel_list->cpus, &stat_config.aggr_map)) {
+		if (cpu_map__build_socket_map(evsel_list->core.cpus, &stat_config.aggr_map)) {
 			perror("cannot build socket map");
 			return -1;
 		}
 		stat_config.aggr_get_id = perf_stat__get_socket_cached;
 		break;
 	case AGGR_DIE:
-		if (cpu_map__build_die_map(evsel_list->cpus, &stat_config.aggr_map)) {
+		if (cpu_map__build_die_map(evsel_list->core.cpus, &stat_config.aggr_map)) {
 			perror("cannot build die map");
 			return -1;
 		}
 		stat_config.aggr_get_id = perf_stat__get_die_cached;
 		break;
 	case AGGR_CORE:
-		if (cpu_map__build_core_map(evsel_list->cpus, &stat_config.aggr_map)) {
+		if (cpu_map__build_core_map(evsel_list->core.cpus, &stat_config.aggr_map)) {
 			perror("cannot build core map");
 			return -1;
 		}
@@ -906,7 +906,7 @@ static int perf_stat_init_aggr_mode(void)
 		break;
 	case AGGR_NONE:
 		if (term_percore_set()) {
-			if (cpu_map__build_core_map(evsel_list->cpus,
+			if (cpu_map__build_core_map(evsel_list->core.cpus,
 						    &stat_config.aggr_map)) {
 				perror("cannot build core map");
 				return -1;
@@ -926,7 +926,7 @@ static int perf_stat_init_aggr_mode(void)
 	 * taking the highest cpu number to be the size of
 	 * the aggregation translate cpumap.
 	 */
-	nr = cpu_map__get_max(evsel_list->cpus);
+	nr = cpu_map__get_max(evsel_list->core.cpus);
 	stat_config.cpus_aggr_map = cpu_map__empty_new(nr + 1);
 	return stat_config.cpus_aggr_map ? 0 : -ENOMEM;
 }
@@ -1057,21 +1057,21 @@ static int perf_stat_init_aggr_mode_file(struct perf_stat *st)
 
 	switch (stat_config.aggr_mode) {
 	case AGGR_SOCKET:
-		if (perf_env__build_socket_map(env, evsel_list->cpus, &stat_config.aggr_map)) {
+		if (perf_env__build_socket_map(env, evsel_list->core.cpus, &stat_config.aggr_map)) {
 			perror("cannot build socket map");
 			return -1;
 		}
 		stat_config.aggr_get_id = perf_stat__get_socket_file;
 		break;
 	case AGGR_DIE:
-		if (perf_env__build_die_map(env, evsel_list->cpus, &stat_config.aggr_map)) {
+		if (perf_env__build_die_map(env, evsel_list->core.cpus, &stat_config.aggr_map)) {
 			perror("cannot build die map");
 			return -1;
 		}
 		stat_config.aggr_get_id = perf_stat__get_die_file;
 		break;
 	case AGGR_CORE:
-		if (perf_env__build_core_map(env, evsel_list->cpus, &stat_config.aggr_map)) {
+		if (perf_env__build_core_map(env, evsel_list->core.cpus, &stat_config.aggr_map)) {
 			perror("cannot build core map");
 			return -1;
 		}
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 54d06d271bfd..947f83e53272 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -989,7 +989,7 @@ static int perf_top__start_counters(struct perf_top *top)
 
 	evlist__for_each_entry(evlist, counter) {
 try_again:
-		if (evsel__open(counter, top->evlist->cpus,
+		if (evsel__open(counter, top->evlist->core.cpus,
 				     top->evlist->threads) < 0) {
 
 			/*
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index 9964e4a9456e..f9caab1fe3c3 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -2,10 +2,13 @@
 #ifndef __LIBPERF_INTERNAL_EVLIST_H
 #define __LIBPERF_INTERNAL_EVLIST_H
 
+struct perf_cpu_map;
+
 struct perf_evlist {
-	struct list_head	entries;
-	int			nr_entries;
-	bool			has_user_cpus;
+	struct list_head	 entries;
+	int			 nr_entries;
+	bool			 has_user_cpus;
+	struct perf_cpu_map	*cpus;
 };
 
 #endif /* __LIBPERF_INTERNAL_EVLIST_H */
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 843959f85d6f..67a2afc5d964 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -130,7 +130,7 @@ void auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp,
 	mp->idx = idx;
 
 	if (per_cpu) {
-		mp->cpu = evlist->cpus->map[idx];
+		mp->cpu = evlist->core.cpus->map[idx];
 		if (evlist->threads)
 			mp->tid = thread_map__pid(evlist->threads, 0);
 		else
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 23a8ead4512f..977b9291fb0d 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -143,9 +143,9 @@ void evlist__delete(struct evlist *evlist)
 
 	perf_evlist__munmap(evlist);
 	evlist__close(evlist);
-	perf_cpu_map__put(evlist->cpus);
+	perf_cpu_map__put(evlist->core.cpus);
 	perf_thread_map__put(evlist->threads);
-	evlist->cpus = NULL;
+	evlist->core.cpus = NULL;
 	evlist->threads = NULL;
 	perf_evlist__purge(evlist);
 	perf_evlist__exit(evlist);
@@ -161,7 +161,7 @@ static void __perf_evlist__propagate_maps(struct evlist *evlist,
 	 */
 	if (!evsel->core.own_cpus || evlist->core.has_user_cpus) {
 		perf_cpu_map__put(evsel->core.cpus);
-		evsel->core.cpus = perf_cpu_map__get(evlist->cpus);
+		evsel->core.cpus = perf_cpu_map__get(evlist->core.cpus);
 	} else if (evsel->core.cpus != evsel->core.own_cpus) {
 		perf_cpu_map__put(evsel->core.cpus);
 		evsel->core.cpus = perf_cpu_map__get(evsel->core.own_cpus);
@@ -398,7 +398,7 @@ static int perf_evlist__enable_event_thread(struct evlist *evlist,
 					    int thread)
 {
 	int cpu;
-	int nr_cpus = cpu_map__nr(evlist->cpus);
+	int nr_cpus = cpu_map__nr(evlist->core.cpus);
 
 	if (!evsel->fd)
 		return -EINVAL;
@@ -414,7 +414,7 @@ static int perf_evlist__enable_event_thread(struct evlist *evlist,
 int perf_evlist__enable_event_idx(struct evlist *evlist,
 				  struct evsel *evsel, int idx)
 {
-	bool per_cpu_mmaps = !cpu_map__empty(evlist->cpus);
+	bool per_cpu_mmaps = !cpu_map__empty(evlist->core.cpus);
 
 	if (per_cpu_mmaps)
 		return perf_evlist__enable_event_cpu(evlist, evsel, idx);
@@ -424,7 +424,7 @@ int perf_evlist__enable_event_idx(struct evlist *evlist,
 
 int perf_evlist__alloc_pollfd(struct evlist *evlist)
 {
-	int nr_cpus = cpu_map__nr(evlist->cpus);
+	int nr_cpus = cpu_map__nr(evlist->core.cpus);
 	int nr_threads = thread_map__nr(evlist->threads);
 	int nfds = 0;
 	struct evsel *evsel;
@@ -552,8 +552,8 @@ static void perf_evlist__set_sid_idx(struct evlist *evlist,
 {
 	struct perf_sample_id *sid = SID(evsel, cpu, thread);
 	sid->idx = idx;
-	if (evlist->cpus && cpu >= 0)
-		sid->cpu = evlist->cpus->map[cpu];
+	if (evlist->core.cpus && cpu >= 0)
+		sid->cpu = evlist->core.cpus->map[cpu];
 	else
 		sid->cpu = -1;
 	if (!evsel->system_wide && evlist->threads && thread >= 0)
@@ -720,8 +720,8 @@ static struct perf_mmap *perf_evlist__alloc_mmap(struct evlist *evlist,
 	int i;
 	struct perf_mmap *map;
 
-	evlist->nr_mmaps = cpu_map__nr(evlist->cpus);
-	if (cpu_map__empty(evlist->cpus))
+	evlist->nr_mmaps = cpu_map__nr(evlist->core.cpus);
+	if (cpu_map__empty(evlist->core.cpus))
 		evlist->nr_mmaps = thread_map__nr(evlist->threads);
 	map = zalloc(evlist->nr_mmaps * sizeof(struct perf_mmap));
 	if (!map)
@@ -759,7 +759,7 @@ static int perf_evlist__mmap_per_evsel(struct evlist *evlist, int idx,
 {
 	struct evsel *evsel;
 	int revent;
-	int evlist_cpu = cpu_map__cpu(evlist->cpus, cpu_idx);
+	int evlist_cpu = cpu_map__cpu(evlist->core.cpus, cpu_idx);
 
 	evlist__for_each_entry(evlist, evsel) {
 		struct perf_mmap *maps = evlist->mmap;
@@ -835,7 +835,7 @@ static int perf_evlist__mmap_per_cpu(struct evlist *evlist,
 				     struct mmap_params *mp)
 {
 	int cpu, thread;
-	int nr_cpus = cpu_map__nr(evlist->cpus);
+	int nr_cpus = cpu_map__nr(evlist->core.cpus);
 	int nr_threads = thread_map__nr(evlist->threads);
 
 	pr_debug2("perf event ring buffer mmapped per cpu\n");
@@ -1014,7 +1014,7 @@ int perf_evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 			 int comp_level)
 {
 	struct evsel *evsel;
-	const struct perf_cpu_map *cpus = evlist->cpus;
+	const struct perf_cpu_map *cpus = evlist->core.cpus;
 	const struct perf_thread_map *threads = evlist->threads;
 	/*
 	 * Delay setting mp.prot: set it before calling perf_mmap__mmap.
@@ -1116,9 +1116,9 @@ void perf_evlist__set_maps(struct evlist *evlist, struct perf_cpu_map *cpus,
 	 * original reference count of 1.  If that is not the case it is up to
 	 * the caller to increase the reference count.
 	 */
-	if (cpus != evlist->cpus) {
-		perf_cpu_map__put(evlist->cpus);
-		evlist->cpus = perf_cpu_map__get(cpus);
+	if (cpus != evlist->core.cpus) {
+		perf_cpu_map__put(evlist->core.cpus);
+		evlist->core.cpus = perf_cpu_map__get(cpus);
 	}
 
 	if (threads != evlist->threads) {
@@ -1398,7 +1398,7 @@ int evlist__open(struct evlist *evlist)
 	 * Default: one fd per CPU, all threads, aka systemwide
 	 * as sys_perf_event_open(cpu = -1, thread = -1) is EINVAL
 	 */
-	if (evlist->threads == NULL && evlist->cpus == NULL) {
+	if (evlist->threads == NULL && evlist->core.cpus == NULL) {
 		err = perf_evlist__create_syswide_maps(evlist);
 		if (err < 0)
 			goto out_err;
@@ -1920,7 +1920,7 @@ int perf_evlist__start_sb_thread(struct evlist *evlist,
 		goto out_delete_evlist;
 
 	evlist__for_each_entry(evlist, counter) {
-		if (evsel__open(counter, evlist->cpus,
+		if (evsel__open(counter, evlist->core.cpus,
 				     evlist->threads) < 0)
 			goto out_delete_evlist;
 	}
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 35cca0242631..fdd8f83eac2d 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -44,7 +44,6 @@ struct evlist {
 	struct perf_mmap *mmap;
 	struct perf_mmap *overwrite_mmap;
 	struct perf_thread_map *threads;
-	struct perf_cpu_map *cpus;
 	struct evsel *selected;
 	struct events_stats stats;
 	struct perf_env	*env;
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index 03dcdb3f33a7..e59382d99196 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -148,7 +148,7 @@ void perf_evlist__config(struct evlist *evlist, struct record_opts *opts,
 	if (opts->group)
 		perf_evlist__set_leader(evlist);
 
-	if (evlist->cpus->map[0] < 0)
+	if (evlist->core.cpus->map[0] < 0)
 		opts->no_inherit = true;
 
 	use_comm_exec = perf_can_comm_exec();
@@ -275,13 +275,13 @@ bool perf_evlist__can_select_event(struct evlist *evlist, const char *str)
 
 	evsel = perf_evlist__last(temp_evlist);
 
-	if (!evlist || cpu_map__empty(evlist->cpus)) {
+	if (!evlist || cpu_map__empty(evlist->core.cpus)) {
 		struct perf_cpu_map *cpus = perf_cpu_map__new(NULL);
 
 		cpu =  cpus ? cpus->map[0] : 0;
 		perf_cpu_map__put(cpus);
 	} else {
-		cpu = evlist->cpus->map[0];
+		cpu = evlist->core.cpus->map[0];
 	}
 
 	while (1) {
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 7c938135398b..4a162858583f 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -327,7 +327,7 @@ static int first_shadow_cpu(struct perf_stat_config *config,
 	for (i = 0; i < perf_evsel__nr_cpus(evsel); i++) {
 		int cpu2 = evsel__cpus(evsel)->map[i];
 
-		if (config->aggr_get_id(config, evlist->cpus, cpu2) == id)
+		if (config->aggr_get_id(config, evlist->core.cpus, cpu2) == id)
 			return cpu2;
 	}
 	return 0;
@@ -500,7 +500,7 @@ static void aggr_update_shadow(struct perf_stat_config *config,
 		evlist__for_each_entry(evlist, counter) {
 			val = 0;
 			for (cpu = 0; cpu < perf_evsel__nr_cpus(counter); cpu++) {
-				s2 = config->aggr_get_id(config, evlist->cpus, cpu);
+				s2 = config->aggr_get_id(config, evlist->core.cpus, cpu);
 				if (s2 != id)
 					continue;
 				val += perf_counts(counter->counts, cpu, 0)->val;
@@ -868,7 +868,7 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
 	u64 ena, run, val;
 	double uval;
 
-	nrcpus = evlist->cpus->nr;
+	nrcpus = evlist->core.cpus->nr;
 	for (cpu = 0; cpu < nrcpus; cpu++) {
 		bool first = true;
 
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 1e351462ca49..24c9c3015983 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -514,7 +514,7 @@ int perf_stat_synthesize_config(struct perf_stat_config *config,
 		return err;
 	}
 
-	err = perf_event__synthesize_cpu_map(tool, evlist->cpus,
+	err = perf_event__synthesize_cpu_map(tool, evlist->core.cpus,
 					     process, NULL);
 	if (err < 0) {
 		pr_err("Couldn't synthesize thread map.\n");
diff --git a/tools/perf/util/top.c b/tools/perf/util/top.c
index f533f1aac045..e5b690cf2898 100644
--- a/tools/perf/util/top.c
+++ b/tools/perf/util/top.c
@@ -95,15 +95,15 @@ size_t perf_top__header_snprintf(struct perf_top *top, char *bf, size_t size)
 
 	if (target->cpu_list)
 		ret += SNPRINTF(bf + ret, size - ret, ", CPU%s: %s)",
-				top->evlist->cpus->nr > 1 ? "s" : "",
+				top->evlist->core.cpus->nr > 1 ? "s" : "",
 				target->cpu_list);
 	else {
 		if (target->tid)
 			ret += SNPRINTF(bf + ret, size - ret, ")");
 		else
 			ret += SNPRINTF(bf + ret, size - ret, ", %d CPU%s)",
-					top->evlist->cpus->nr,
-					top->evlist->cpus->nr > 1 ? "s" : "");
+					top->evlist->core.cpus->nr,
+					top->evlist->core.cpus->nr > 1 ? "s" : "");
 	}
 
 	perf_top__reset_sample_counters(top);
