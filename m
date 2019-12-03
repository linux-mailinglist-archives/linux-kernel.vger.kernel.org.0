Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53D1F10FCA2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 12:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfLCLpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 06:45:31 -0500
Received: from mga09.intel.com ([134.134.136.24]:48897 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbfLCLpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 06:45:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2019 03:45:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,273,1571727600"; 
   d="scan'208";a="293772844"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 03 Dec 2019 03:45:30 -0800
Received: from [10.125.253.16] (abudanko-mobl.ccr.corp.intel.com [10.125.253.16])
        by linux.intel.com (Postfix) with ESMTP id 7BE5F58033E;
        Tue,  3 Dec 2019 03:45:28 -0800 (PST)
Subject: [PATCH v5 3/3] perf record: adapt affinity to machines with #CPUs >
 1K
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <d1aead99-474a-46d3-36be-36dbb8e5581b@linux.intel.com>
Organization: Intel Corp.
Message-ID: <96d7e2ff-ce8b-c1e0-d52c-aa59ea96f0ea@linux.intel.com>
Date:   Tue, 3 Dec 2019 14:45:27 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <d1aead99-474a-46d3-36be-36dbb8e5581b@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Use struct mmap_cpu_mask type for tool's thread and mmap data
buffers to overcome current 1024 CPUs mask size limitation of
cpu_set_t type.

Currently glibc cpu_set_t type has internal mask size limit
of 1024 CPUs. Moving to struct mmap_cpu_mask type allows
overcoming that limit. tools bitmap API is used to manipulate
objects of struct mmap_cpu_mask type.

Reported-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-record.c | 28 ++++++++++++++++++++++------
 tools/perf/util/mmap.c      | 28 ++++++++++++++++++++++------
 tools/perf/util/mmap.h      |  2 +-
 3 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index fb19ef63cc35..7bc83755ef8c 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -62,6 +62,7 @@
 #include <linux/string.h>
 #include <linux/time64.h>
 #include <linux/zalloc.h>
+#include <linux/bitmap.h>
 
 struct switch_output {
 	bool		 enabled;
@@ -93,7 +94,7 @@ struct record {
 	bool			timestamp_boundary;
 	struct switch_output	switch_output;
 	unsigned long long	samples;
-	cpu_set_t		affinity_mask;
+	struct mmap_cpu_mask	affinity_mask;
 	unsigned long		output_max_size;	/* = 0: unlimited */
 };
 
@@ -961,10 +962,15 @@ static struct perf_event_header finished_round_event = {
 static void record__adjust_affinity(struct record *rec, struct mmap *map)
 {
 	if (rec->opts.affinity != PERF_AFFINITY_SYS &&
-	    !CPU_EQUAL(&rec->affinity_mask, &map->affinity_mask)) {
-		CPU_ZERO(&rec->affinity_mask);
-		CPU_OR(&rec->affinity_mask, &rec->affinity_mask, &map->affinity_mask);
-		sched_setaffinity(0, sizeof(rec->affinity_mask), &rec->affinity_mask);
+	    !bitmap_equal(rec->affinity_mask.bits, map->affinity_mask.bits,
+			  rec->affinity_mask.nbits)) {
+		bitmap_zero(rec->affinity_mask.bits, rec->affinity_mask.nbits);
+		bitmap_or(rec->affinity_mask.bits, rec->affinity_mask.bits,
+			  map->affinity_mask.bits, rec->affinity_mask.nbits);
+		sched_setaffinity(0, MMAP_CPU_MASK_BYTES(&rec->affinity_mask),
+				  (cpu_set_t *)rec->affinity_mask.bits);
+		if (verbose == 2)
+			mmap_cpu_mask__scnprintf(&rec->affinity_mask, "thread");
 	}
 }
 
@@ -2433,7 +2439,6 @@ int cmd_record(int argc, const char **argv)
 # undef REASON
 #endif
 
-	CPU_ZERO(&rec->affinity_mask);
 	rec->opts.affinity = PERF_AFFINITY_SYS;
 
 	rec->evlist = evlist__new();
@@ -2499,6 +2504,16 @@ int cmd_record(int argc, const char **argv)
 
 	symbol__init(NULL);
 
+	if (rec->opts.affinity != PERF_AFFINITY_SYS) {
+		rec->affinity_mask.nbits = cpu__max_cpu();
+		rec->affinity_mask.bits = bitmap_alloc(rec->affinity_mask.nbits);
+		if (!rec->affinity_mask.bits) {
+			pr_err("Failed to allocate thread mask for %ld cpus\n", rec->affinity_mask.nbits);
+			return -ENOMEM;
+		}
+		pr_debug2("thread mask[%ld]: empty\n", rec->affinity_mask.nbits);
+	}
+
 	err = record__auxtrace_init(rec);
 	if (err)
 		goto out;
@@ -2613,6 +2628,7 @@ int cmd_record(int argc, const char **argv)
 
 	err = __cmd_record(&record, argc, argv);
 out:
+	bitmap_free(rec->affinity_mask.bits);
 	evlist__delete(rec->evlist);
 	symbol__exit();
 	auxtrace_record__free(rec->itr);
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 43c12b4a3e17..832d2cb94b2c 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -219,6 +219,8 @@ static void perf_mmap__aio_munmap(struct mmap *map __maybe_unused)
 
 void mmap__munmap(struct mmap *map)
 {
+	bitmap_free(map->affinity_mask.bits);
+
 	perf_mmap__aio_munmap(map);
 	if (map->data != NULL) {
 		munmap(map->data, mmap__mmap_len(map));
@@ -227,7 +229,7 @@ void mmap__munmap(struct mmap *map)
 	auxtrace_mmap__munmap(&map->auxtrace_mmap);
 }
 
-static void build_node_mask(int node, cpu_set_t *mask)
+static void build_node_mask(int node, struct mmap_cpu_mask *mask)
 {
 	int c, cpu, nr_cpus;
 	const struct perf_cpu_map *cpu_map = NULL;
@@ -240,17 +242,23 @@ static void build_node_mask(int node, cpu_set_t *mask)
 	for (c = 0; c < nr_cpus; c++) {
 		cpu = cpu_map->map[c]; /* map c index to online cpu index */
 		if (cpu__get_node(cpu) == node)
-			CPU_SET(cpu, mask);
+			set_bit(cpu, mask->bits);
 	}
 }
 
-static void perf_mmap__setup_affinity_mask(struct mmap *map, struct mmap_params *mp)
+static int perf_mmap__setup_affinity_mask(struct mmap *map, struct mmap_params *mp)
 {
-	CPU_ZERO(&map->affinity_mask);
+	map->affinity_mask.nbits = cpu__max_cpu();
+	map->affinity_mask.bits = bitmap_alloc(map->affinity_mask.nbits);
+	if (!map->affinity_mask.bits)
+		return -1;
+
 	if (mp->affinity == PERF_AFFINITY_NODE && cpu__max_node() > 1)
 		build_node_mask(cpu__get_node(map->core.cpu), &map->affinity_mask);
 	else if (mp->affinity == PERF_AFFINITY_CPU)
-		CPU_SET(map->core.cpu, &map->affinity_mask);
+		set_bit(map->core.cpu, map->affinity_mask.bits);
+
+	return 0;
 }
 
 int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
@@ -261,7 +269,15 @@ int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
 		return -1;
 	}
 
-	perf_mmap__setup_affinity_mask(map, mp);
+	if (mp->affinity != PERF_AFFINITY_SYS &&
+		perf_mmap__setup_affinity_mask(map, mp)) {
+		pr_debug2("failed to alloc mmap affinity mask, error %d\n",
+			  errno);
+		return -1;
+	}
+
+	if (verbose == 2)
+		mmap_cpu_mask__scnprintf(&map->affinity_mask, "mmap");
 
 	map->core.flush = mp->flush;
 
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index ef51667fabcb..9d5f589f02ae 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -40,7 +40,7 @@ struct mmap {
 		int		 nr_cblocks;
 	} aio;
 #endif
-	cpu_set_t	affinity_mask;
+	struct mmap_cpu_mask	affinity_mask;
 	void		*data;
 	int		comp_level;
 };
-- 
2.20.1


