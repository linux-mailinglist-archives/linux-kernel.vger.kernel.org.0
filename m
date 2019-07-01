Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69D9D48F9E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 21:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbfFQTdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 15:33:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44469 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbfFQTdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:33:39 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJXPCQ3565240
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:33:25 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJXPCQ3565240
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560800005;
        bh=X73ThUNVcllvpLY6j9ALeg9TiggorKLX99K+OBkL7XA=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=d0xkKTXWWA+HKOWLuy/CYrpUzfWpzpmz6VRLaQMLf5Sh3owuggznlrR9URv84javf
         Jy3ZrGprRKgd6A8L3wPmYXjoQ7VZuMgCSaCPKea9IlEY5xsC9k5B/zPtLDPdbBuJ/M
         COmBoPFQDc3Vno6Rru1G5CN8QMluIwSKpVy9sDwPTtVHrg8BRO3cIbYvFwUxatMwPO
         laGY7LERmwk/hZb969IdFaInFNaRw+NfAhzp6VZbX/bJMdNq9u0IL9vWdQuuwormKY
         y3oInuVn/9IjYl7tXBhmJ/by3JN1gUv+YDVWBCO1l+hBaSEnXDaFA7VrvRKFlSV4Nx
         5QSQlo8PdHtjw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJXPEw3565237;
        Mon, 17 Jun 2019 12:33:25 -0700
Date:   Mon, 17 Jun 2019 12:33:25 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-bsnhx7vgsuu6ei307mw60mbj@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, kan.liang@linux.intel.com,
        jolsa@kernel.org, peterz@infradead.org, acme@redhat.com,
        hpa@zytor.com, ak@linux.intel.com, linux-kernel@vger.kernel.org
Reply-To: ak@linux.intel.com, acme@redhat.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, kan.liang@linux.intel.com,
          mingo@kernel.org, tglx@linutronix.de, jolsa@kernel.org,
          peterz@infradead.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Support per-die aggregation
Git-Commit-ID: db5742b6849ed7f01d764e6755b8ab2b422f29b2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-1.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  db5742b6849ed7f01d764e6755b8ab2b422f29b2
Gitweb:     https://git.kernel.org/tip/db5742b6849ed7f01d764e6755b8ab2b422f29b2
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Tue, 4 Jun 2019 15:50:42 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 10 Jun 2019 16:19:59 -0300

perf stat: Support per-die aggregation

It is useful to aggregate counts per die. E.g. Uncore becomes die-scope
on Xeon Cascade Lake-AP.

Introduce a new option "--per-die" to support per-die aggregation.

The global id for each core has been changed to socket + die id + core
id. The global id for each die is socket + die id.

Add die information for per-core aggregation. The output of per-core
aggregation will be changed from "S0-C0" to "S0-D0-C0". Any scripts
which rely on the output format of per-core aggregation probably be
broken.

For 'perf stat record/report', there is no die information when
processing the old perf.data. The per-die result will be the same as
per-socket.

Committer notes:

Renamed 'die' variable to 'die_id' to fix the build in some systems:

    CC       /tmp/build/perf/builtin-script.o
  cc1: warnings being treated as errors
  builtin-stat.c: In function 'perf_env__get_die':
  builtin-stat.c:963: error: declaration of 'die' shadows a global declaration
  util/util.h:19: error: shadowed declaration is here
  mv: cannot stat `/tmp/build/perf/.builtin-stat.o.tmp': No such file or directory

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/n/tip-bsnhx7vgsuu6ei307mw60mbj@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-stat.txt | 10 ++++
 tools/perf/builtin-stat.c              | 87 +++++++++++++++++++++++++++++++---
 tools/perf/util/cpumap.c               | 57 +++++++++++++++++++---
 tools/perf/util/cpumap.h               |  9 +++-
 tools/perf/util/stat-display.c         | 29 ++++++++++--
 tools/perf/util/stat-shadow.c          |  1 +
 tools/perf/util/stat.c                 |  1 +
 tools/perf/util/stat.h                 |  1 +
 8 files changed, 177 insertions(+), 18 deletions(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 1e312c2672e4..930c51c01201 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -200,6 +200,13 @@ use --per-socket in addition to -a. (system-wide).  The output includes the
 socket number and the number of online processors on that socket. This is
 useful to gauge the amount of aggregation.
 
+--per-die::
+Aggregate counts per processor die for system-wide mode measurements.  This
+is a useful mode to detect imbalance between dies.  To enable this mode,
+use --per-die in addition to -a. (system-wide).  The output includes the
+die number and the number of online processors on that die. This is
+useful to gauge the amount of aggregation.
+
 --per-core::
 Aggregate counts per physical processor for system-wide mode measurements.  This
 is a useful mode to detect imbalance between physical cores.  To enable this mode,
@@ -239,6 +246,9 @@ Input file name.
 --per-socket::
 Aggregate counts per processor socket for system-wide mode measurements.
 
+--per-die::
+Aggregate counts per processor die for system-wide mode measurements.
+
 --per-core::
 Aggregate counts per physical processor for system-wide mode measurements.
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 24b8e690fb69..272df8426f0a 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -777,6 +777,8 @@ static struct option stat_options[] = {
 		    "stop workload and print counts after a timeout period in ms (>= 10ms)"),
 	OPT_SET_UINT(0, "per-socket", &stat_config.aggr_mode,
 		     "aggregate counts per processor socket", AGGR_SOCKET),
+	OPT_SET_UINT(0, "per-die", &stat_config.aggr_mode,
+		     "aggregate counts per processor die", AGGR_DIE),
 	OPT_SET_UINT(0, "per-core", &stat_config.aggr_mode,
 		     "aggregate counts per physical processor core", AGGR_CORE),
 	OPT_SET_UINT(0, "per-thread", &stat_config.aggr_mode,
@@ -801,6 +803,12 @@ static int perf_stat__get_socket(struct perf_stat_config *config __maybe_unused,
 	return cpu_map__get_socket(map, cpu, NULL);
 }
 
+static int perf_stat__get_die(struct perf_stat_config *config __maybe_unused,
+			      struct cpu_map *map, int cpu)
+{
+	return cpu_map__get_die(map, cpu, NULL);
+}
+
 static int perf_stat__get_core(struct perf_stat_config *config __maybe_unused,
 			       struct cpu_map *map, int cpu)
 {
@@ -841,6 +849,12 @@ static int perf_stat__get_socket_cached(struct perf_stat_config *config,
 	return perf_stat__get_aggr(config, perf_stat__get_socket, map, idx);
 }
 
+static int perf_stat__get_die_cached(struct perf_stat_config *config,
+					struct cpu_map *map, int idx)
+{
+	return perf_stat__get_aggr(config, perf_stat__get_die, map, idx);
+}
+
 static int perf_stat__get_core_cached(struct perf_stat_config *config,
 				      struct cpu_map *map, int idx)
 {
@@ -871,6 +885,13 @@ static int perf_stat_init_aggr_mode(void)
 		}
 		stat_config.aggr_get_id = perf_stat__get_socket_cached;
 		break;
+	case AGGR_DIE:
+		if (cpu_map__build_die_map(evsel_list->cpus, &stat_config.aggr_map)) {
+			perror("cannot build die map");
+			return -1;
+		}
+		stat_config.aggr_get_id = perf_stat__get_die_cached;
+		break;
 	case AGGR_CORE:
 		if (cpu_map__build_core_map(evsel_list->cpus, &stat_config.aggr_map)) {
 			perror("cannot build core map");
@@ -936,21 +957,55 @@ static int perf_env__get_socket(struct cpu_map *map, int idx, void *data)
 	return cpu == -1 ? -1 : env->cpu[cpu].socket_id;
 }
 
+static int perf_env__get_die(struct cpu_map *map, int idx, void *data)
+{
+	struct perf_env *env = data;
+	int die_id = -1, cpu = perf_env__get_cpu(env, map, idx);
+
+	if (cpu != -1) {
+		/*
+		 * Encode socket in bit range 15:8
+		 * die_id is relative to socket,
+		 * we need a global id. So we combine
+		 * socket + die id
+		 */
+		if (WARN_ONCE(env->cpu[cpu].socket_id >> 8, "The socket id number is too big.\n"))
+			return -1;
+
+		if (WARN_ONCE(env->cpu[cpu].die_id >> 8, "The die id number is too big.\n"))
+			return -1;
+
+		die_id = (env->cpu[cpu].socket_id << 8) | (env->cpu[cpu].die_id & 0xff);
+	}
+
+	return die_id;
+}
+
 static int perf_env__get_core(struct cpu_map *map, int idx, void *data)
 {
 	struct perf_env *env = data;
 	int core = -1, cpu = perf_env__get_cpu(env, map, idx);
 
 	if (cpu != -1) {
-		int socket_id = env->cpu[cpu].socket_id;
-
 		/*
-		 * Encode socket in upper 16 bits
-		 * core_id is relative to socket, and
+		 * Encode socket in bit range 31:24
+		 * encode die id in bit range 23:16
+		 * core_id is relative to socket and die,
 		 * we need a global id. So we combine
-		 * socket + core id.
+		 * socket + die id + core id
 		 */
-		core = (socket_id << 16) | (env->cpu[cpu].core_id & 0xffff);
+		if (WARN_ONCE(env->cpu[cpu].socket_id >> 8, "The socket id number is too big.\n"))
+			return -1;
+
+		if (WARN_ONCE(env->cpu[cpu].die_id >> 8, "The die id number is too big.\n"))
+			return -1;
+
+		if (WARN_ONCE(env->cpu[cpu].core_id >> 16, "The core id number is too big.\n"))
+			return -1;
+
+		core = (env->cpu[cpu].socket_id << 24) |
+		       (env->cpu[cpu].die_id << 16) |
+		       (env->cpu[cpu].core_id & 0xffff);
 	}
 
 	return core;
@@ -962,6 +1017,12 @@ static int perf_env__build_socket_map(struct perf_env *env, struct cpu_map *cpus
 	return cpu_map__build_map(cpus, sockp, perf_env__get_socket, env);
 }
 
+static int perf_env__build_die_map(struct perf_env *env, struct cpu_map *cpus,
+				   struct cpu_map **diep)
+{
+	return cpu_map__build_map(cpus, diep, perf_env__get_die, env);
+}
+
 static int perf_env__build_core_map(struct perf_env *env, struct cpu_map *cpus,
 				    struct cpu_map **corep)
 {
@@ -973,6 +1034,11 @@ static int perf_stat__get_socket_file(struct perf_stat_config *config __maybe_un
 {
 	return perf_env__get_socket(map, idx, &perf_stat.session->header.env);
 }
+static int perf_stat__get_die_file(struct perf_stat_config *config __maybe_unused,
+				   struct cpu_map *map, int idx)
+{
+	return perf_env__get_die(map, idx, &perf_stat.session->header.env);
+}
 
 static int perf_stat__get_core_file(struct perf_stat_config *config __maybe_unused,
 				    struct cpu_map *map, int idx)
@@ -992,6 +1058,13 @@ static int perf_stat_init_aggr_mode_file(struct perf_stat *st)
 		}
 		stat_config.aggr_get_id = perf_stat__get_socket_file;
 		break;
+	case AGGR_DIE:
+		if (perf_env__build_die_map(env, evsel_list->cpus, &stat_config.aggr_map)) {
+			perror("cannot build die map");
+			return -1;
+		}
+		stat_config.aggr_get_id = perf_stat__get_die_file;
+		break;
 	case AGGR_CORE:
 		if (perf_env__build_core_map(env, evsel_list->cpus, &stat_config.aggr_map)) {
 			perror("cannot build core map");
@@ -1542,6 +1615,8 @@ static int __cmd_report(int argc, const char **argv)
 	OPT_STRING('i', "input", &input_name, "file", "input file name"),
 	OPT_SET_UINT(0, "per-socket", &perf_stat.aggr_mode,
 		     "aggregate counts per processor socket", AGGR_SOCKET),
+	OPT_SET_UINT(0, "per-die", &perf_stat.aggr_mode,
+		     "aggregate counts per processor die", AGGR_DIE),
 	OPT_SET_UINT(0, "per-core", &perf_stat.aggr_mode,
 		     "aggregate counts per physical processor core", AGGR_CORE),
 	OPT_SET_UINT('A', "no-aggr", &perf_stat.aggr_mode,
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 7db1365c667e..c11a459ca582 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -380,6 +380,39 @@ int cpu_map__get_die_id(int cpu)
 	return ret ?: value;
 }
 
+int cpu_map__get_die(struct cpu_map *map, int idx, void *data)
+{
+	int cpu, die_id, s;
+
+	if (idx > map->nr)
+		return -1;
+
+	cpu = map->map[idx];
+
+	die_id = cpu_map__get_die_id(cpu);
+	/* There is no die_id on legacy system. */
+	if (die_id == -1)
+		die_id = 0;
+
+	s = cpu_map__get_socket(map, idx, data);
+	if (s == -1)
+		return -1;
+
+	/*
+	 * Encode socket in bit range 15:8
+	 * die_id is relative to socket, and
+	 * we need a global id. So we combine
+	 * socket + die id
+	 */
+	if (WARN_ONCE(die_id >> 8, "The die id number is too big.\n"))
+		return -1;
+
+	if (WARN_ONCE(s >> 8, "The socket id number is too big.\n"))
+		return -1;
+
+	return (s << 8) | (die_id & 0xff);
+}
+
 int cpu_map__get_core_id(int cpu)
 {
 	int value, ret = cpu__get_topology_int(cpu, "core_id", &value);
@@ -388,7 +421,7 @@ int cpu_map__get_core_id(int cpu)
 
 int cpu_map__get_core(struct cpu_map *map, int idx, void *data)
 {
-	int cpu, s;
+	int cpu, s_die;
 
 	if (idx > map->nr)
 		return -1;
@@ -397,17 +430,22 @@ int cpu_map__get_core(struct cpu_map *map, int idx, void *data)
 
 	cpu = cpu_map__get_core_id(cpu);
 
-	s = cpu_map__get_socket(map, idx, data);
-	if (s == -1)
+	/* s_die is the combination of socket + die id */
+	s_die = cpu_map__get_die(map, idx, data);
+	if (s_die == -1)
 		return -1;
 
 	/*
-	 * encode socket in upper 16 bits
-	 * core_id is relative to socket, and
+	 * encode socket in bit range 31:24
+	 * encode die id in bit range 23:16
+	 * core_id is relative to socket and die,
 	 * we need a global id. So we combine
-	 * socket+ core id
+	 * socket + die id + core id
 	 */
-	return (s << 16) | (cpu & 0xffff);
+	if (WARN_ONCE(cpu >> 16, "The core id number is too big.\n"))
+		return -1;
+
+	return (s_die << 16) | (cpu & 0xffff);
 }
 
 int cpu_map__build_socket_map(struct cpu_map *cpus, struct cpu_map **sockp)
@@ -415,6 +453,11 @@ int cpu_map__build_socket_map(struct cpu_map *cpus, struct cpu_map **sockp)
 	return cpu_map__build_map(cpus, sockp, cpu_map__get_socket, NULL);
 }
 
+int cpu_map__build_die_map(struct cpu_map *cpus, struct cpu_map **diep)
+{
+	return cpu_map__build_map(cpus, diep, cpu_map__get_die, NULL);
+}
+
 int cpu_map__build_core_map(struct cpu_map *cpus, struct cpu_map **corep)
 {
 	return cpu_map__build_map(cpus, corep, cpu_map__get_core, NULL);
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 6762ff9e7ad5..1265f0e33920 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -26,9 +26,11 @@ size_t cpu_map__fprintf(struct cpu_map *map, FILE *fp);
 int cpu_map__get_socket_id(int cpu);
 int cpu_map__get_socket(struct cpu_map *map, int idx, void *data);
 int cpu_map__get_die_id(int cpu);
+int cpu_map__get_die(struct cpu_map *map, int idx, void *data);
 int cpu_map__get_core_id(int cpu);
 int cpu_map__get_core(struct cpu_map *map, int idx, void *data);
 int cpu_map__build_socket_map(struct cpu_map *cpus, struct cpu_map **sockp);
+int cpu_map__build_die_map(struct cpu_map *cpus, struct cpu_map **diep);
 int cpu_map__build_core_map(struct cpu_map *cpus, struct cpu_map **corep);
 const struct cpu_map *cpu_map__online(void); /* thread unsafe */
 
@@ -44,7 +46,12 @@ static inline int cpu_map__socket(struct cpu_map *sock, int s)
 
 static inline int cpu_map__id_to_socket(int id)
 {
-	return id >> 16;
+	return id >> 24;
+}
+
+static inline int cpu_map__id_to_die(int id)
+{
+	return (id >> 16) & 0xff;
 }
 
 static inline int cpu_map__id_to_cpu(int id)
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 4c53bae5644b..a6b9de3e83fc 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -69,8 +69,9 @@ static void aggr_printout(struct perf_stat_config *config,
 {
 	switch (config->aggr_mode) {
 	case AGGR_CORE:
-		fprintf(config->output, "S%d-C%*d%s%*d%s",
+		fprintf(config->output, "S%d-D%d-C%*d%s%*d%s",
 			cpu_map__id_to_socket(id),
+			cpu_map__id_to_die(id),
 			config->csv_output ? 0 : -8,
 			cpu_map__id_to_cpu(id),
 			config->csv_sep,
@@ -78,6 +79,16 @@ static void aggr_printout(struct perf_stat_config *config,
 			nr,
 			config->csv_sep);
 		break;
+	case AGGR_DIE:
+		fprintf(config->output, "S%d-D%*d%s%*d%s",
+			cpu_map__id_to_socket(id << 16),
+			config->csv_output ? 0 : -8,
+			cpu_map__id_to_die(id << 16),
+			config->csv_sep,
+			config->csv_output ? 0 : 4,
+			nr,
+			config->csv_sep);
+		break;
 	case AGGR_SOCKET:
 		fprintf(config->output, "S%*d%s%*d%s",
 			config->csv_output ? 0 : -5,
@@ -89,8 +100,9 @@ static void aggr_printout(struct perf_stat_config *config,
 			break;
 	case AGGR_NONE:
 		if (evsel->percore) {
-			fprintf(config->output, "S%d-C%*d%s",
+			fprintf(config->output, "S%d-D%d-C%*d%s",
 				cpu_map__id_to_socket(id),
+				cpu_map__id_to_die(id),
 				config->csv_output ? 0 : -5,
 				cpu_map__id_to_cpu(id), config->csv_sep);
 		} else {
@@ -407,6 +419,7 @@ static void printout(struct perf_stat_config *config, int id, int nr,
 			[AGGR_THREAD] = 1,
 			[AGGR_NONE] = 1,
 			[AGGR_SOCKET] = 2,
+			[AGGR_DIE] = 2,
 			[AGGR_CORE] = 2,
 		};
 
@@ -879,7 +892,8 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
 }
 
 static int aggr_header_lens[] = {
-	[AGGR_CORE] = 18,
+	[AGGR_CORE] = 24,
+	[AGGR_DIE] = 18,
 	[AGGR_SOCKET] = 12,
 	[AGGR_NONE] = 6,
 	[AGGR_THREAD] = 24,
@@ -888,6 +902,7 @@ static int aggr_header_lens[] = {
 
 static const char *aggr_header_csv[] = {
 	[AGGR_CORE] 	= 	"core,cpus,",
+	[AGGR_DIE] 	= 	"die,cpus",
 	[AGGR_SOCKET] 	= 	"socket,cpus",
 	[AGGR_NONE] 	= 	"cpu,",
 	[AGGR_THREAD] 	= 	"comm-pid,",
@@ -954,8 +969,13 @@ static void print_interval(struct perf_stat_config *config,
 			if (!metric_only)
 				fprintf(output, "             counts %*s events\n", unit_width, "unit");
 			break;
+		case AGGR_DIE:
+			fprintf(output, "#           time die          cpus");
+			if (!metric_only)
+				fprintf(output, "             counts %*s events\n", unit_width, "unit");
+			break;
 		case AGGR_CORE:
-			fprintf(output, "#           time core         cpus");
+			fprintf(output, "#           time core            cpus");
 			if (!metric_only)
 				fprintf(output, "             counts %*s events\n", unit_width, "unit");
 			break;
@@ -1165,6 +1185,7 @@ perf_evlist__print_counters(struct perf_evlist *evlist,
 
 	switch (config->aggr_mode) {
 	case AGGR_CORE:
+	case AGGR_DIE:
 	case AGGR_SOCKET:
 		print_aggr(config, evlist, prefix);
 		break;
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 83d8094be4fe..027b09aaa4cf 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -12,6 +12,7 @@
 /*
  * AGGR_GLOBAL: Use CPU 0
  * AGGR_SOCKET: Use first CPU of socket
+ * AGGR_DIE: Use first CPU of die
  * AGGR_CORE: Use first CPU of core
  * AGGR_NONE: Use matching CPU
  * AGGR_THREAD: Not supported?
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index c3115d939b0b..d91fe754b6d2 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -272,6 +272,7 @@ process_counter_values(struct perf_stat_config *config, struct perf_evsel *evsel
 	switch (config->aggr_mode) {
 	case AGGR_THREAD:
 	case AGGR_CORE:
+	case AGGR_DIE:
 	case AGGR_SOCKET:
 	case AGGR_NONE:
 		if (!evsel->snapshot)
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 2f9c9159a364..7032dd1eeac2 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -44,6 +44,7 @@ enum aggr_mode {
 	AGGR_NONE,
 	AGGR_GLOBAL,
 	AGGR_SOCKET,
+	AGGR_DIE,
 	AGGR_CORE,
 	AGGR_THREAD,
 	AGGR_UNSET,
