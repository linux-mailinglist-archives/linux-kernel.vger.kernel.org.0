Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDB306F2DE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2019 13:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfGUL2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jul 2019 07:28:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56008 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbfGUL2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:28:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B44AB30821C0;
        Sun, 21 Jul 2019 11:28:40 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 187A25D9D3;
        Sun, 21 Jul 2019 11:28:35 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 29/79] libperf: Add perf_cpu_map__dummy_new function
Date:   Sun, 21 Jul 2019 13:24:16 +0200
Message-Id: <20190721112506.12306-30-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Sun, 21 Jul 2019 11:28:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving cpu_map__dummy_new into libperf as
perf_cpu_map__dummy_new function.

Link: http://lkml.kernel.org/n/tip-9j9jt4qht42mcd2p2vxsu7xx@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/cpumap.c              | 13 +++++++++++++
 tools/perf/lib/include/perf/cpumap.h |  4 ++++
 tools/perf/lib/libperf.map           |  1 +
 tools/perf/tests/sw-clock.c          |  2 +-
 tools/perf/tests/task-exit.c         |  2 +-
 tools/perf/util/cpumap.c             | 15 +--------------
 tools/perf/util/cpumap.h             |  2 +-
 tools/perf/util/evlist.c             |  2 +-
 tools/perf/util/evsel.c              |  2 +-
 9 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/tools/perf/lib/cpumap.c b/tools/perf/lib/cpumap.c
index 86a199c26f20..80d587ab95aa 100644
--- a/tools/perf/lib/cpumap.c
+++ b/tools/perf/lib/cpumap.c
@@ -3,3 +3,16 @@
 #include <stdlib.h>
 #include <linux/refcount.h>
 #include <internal/cpumap.h>
+
+struct perf_cpu_map *perf_cpu_map__dummy_new(void)
+{
+	struct perf_cpu_map *cpus = malloc(sizeof(*cpus) + sizeof(int));
+
+	if (cpus != NULL) {
+		cpus->nr = 1;
+		cpus->map[0] = -1;
+		refcount_set(&cpus->refcnt, 1);
+	}
+
+	return cpus;
+}
diff --git a/tools/perf/lib/include/perf/cpumap.h b/tools/perf/lib/include/perf/cpumap.h
index 8355d3ce7d0c..fa1e5aa9d662 100644
--- a/tools/perf/lib/include/perf/cpumap.h
+++ b/tools/perf/lib/include/perf/cpumap.h
@@ -2,6 +2,10 @@
 #ifndef __LIBPERF_CPUMAP_H
 #define __LIBPERF_CPUMAP_H
 
+#include <perf/core.h>
+
 struct perf_cpu_map;
 
+LIBPERF_API struct perf_cpu_map *perf_cpu_map__dummy_new(void);
+
 #endif /* __LIBPERF_CPUMAP_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index 3536242c545c..65201c6cbe7e 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -1,6 +1,7 @@
 LIBPERF_0.0.1 {
 	global:
 		libperf_set_print;
+		perf_cpu_map__dummy_new;
 	local:
 		*;
 };
diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index ba033a6e6c0f..c6d3f4488b73 100644
--- a/tools/perf/tests/sw-clock.c
+++ b/tools/perf/tests/sw-clock.c
@@ -56,7 +56,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 	}
 	evlist__add(evlist, evsel);
 
-	cpus = cpu_map__dummy_new();
+	cpus = perf_cpu_map__dummy_new();
 	threads = thread_map__new_by_tid(getpid());
 	if (!cpus || !threads) {
 		err = -ENOMEM;
diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index d17effdd55c8..c094fb8cc877 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -63,7 +63,7 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
 	 * perf_evlist__prepare_workload we'll fill in the only thread
 	 * we're monitoring, the one forked there.
 	 */
-	cpus = cpu_map__dummy_new();
+	cpus = perf_cpu_map__dummy_new();
 	threads = thread_map__new_by_tid(-1);
 	if (!cpus || !threads) {
 		err = -ENOMEM;
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 5eb4e1fbb877..acda9bfb4002 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -189,7 +189,7 @@ struct perf_cpu_map *cpu_map__new(const char *cpu_list)
 	else if (*cpu_list != '\0')
 		cpus = cpu_map__default_new();
 	else
-		cpus = cpu_map__dummy_new();
+		cpus = perf_cpu_map__dummy_new();
 invalid:
 	free(tmp_cpus);
 out:
@@ -256,19 +256,6 @@ size_t cpu_map__fprintf(struct perf_cpu_map *map, FILE *fp)
 #undef BUFSIZE
 }
 
-struct perf_cpu_map *cpu_map__dummy_new(void)
-{
-	struct perf_cpu_map *cpus = malloc(sizeof(*cpus) + sizeof(int));
-
-	if (cpus != NULL) {
-		cpus->nr = 1;
-		cpus->map[0] = -1;
-		refcount_set(&cpus->refcnt, 1);
-	}
-
-	return cpus;
-}
-
 struct perf_cpu_map *cpu_map__empty_new(int nr)
 {
 	struct perf_cpu_map *cpus = malloc(sizeof(*cpus) + sizeof(int) * nr);
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index c2ba9ae195f7..0ce3f6bd9449 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -6,13 +6,13 @@
 #include <stdbool.h>
 #include <linux/refcount.h>
 #include <internal/cpumap.h>
+#include <perf/cpumap.h>
 
 #include "perf.h"
 #include "util/debug.h"
 
 struct perf_cpu_map *cpu_map__new(const char *cpu_list);
 struct perf_cpu_map *cpu_map__empty_new(int nr);
-struct perf_cpu_map *cpu_map__dummy_new(void);
 struct perf_cpu_map *cpu_map__new_data(struct cpu_map_data *data);
 struct perf_cpu_map *cpu_map__read(FILE *file);
 size_t cpu_map__snprint(struct perf_cpu_map *map, char *buf, size_t size);
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 1bedec28e58f..461c1e68e9e7 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1086,7 +1086,7 @@ int perf_evlist__create_maps(struct evlist *evlist, struct target *target)
 		return -1;
 
 	if (target__uses_dummy_map(target))
-		cpus = cpu_map__dummy_new();
+		cpus = perf_cpu_map__dummy_new();
 	else
 		cpus = cpu_map__new(target->cpu_list);
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 5aeb7260c8e1..a389752840a9 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1840,7 +1840,7 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 		static struct perf_cpu_map *empty_cpu_map;
 
 		if (empty_cpu_map == NULL) {
-			empty_cpu_map = cpu_map__dummy_new();
+			empty_cpu_map = perf_cpu_map__dummy_new();
 			if (empty_cpu_map == NULL)
 				return -ENOMEM;
 		}
-- 
2.21.0

