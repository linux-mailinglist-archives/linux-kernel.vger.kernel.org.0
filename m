Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F10C1CE240
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 14:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbfJGMxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 08:53:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46370 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727490AbfJGMxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:53:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1FF8D7FDCC;
        Mon,  7 Oct 2019 12:53:52 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 79AE45D9CC;
        Mon,  7 Oct 2019 12:53:50 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 02/36] libperf: Add 'struct perf_mmap_param'
Date:   Mon,  7 Oct 2019 14:53:10 +0200
Message-Id: <20191007125344.14268-3-jolsa@kernel.org>
In-Reply-To: <20191007125344.14268-1-jolsa@kernel.org>
References: <20191007125344.14268-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 07 Oct 2019 12:53:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add libperf's version of mmap params 'struct perf_mmap_param' object
with the basics: 'prot' and 'mask'.  Encapsulate it in the current
'struct mmap_params' object.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-41-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/internal/mmap.h |  5 +++++
 tools/perf/util/evlist.c               | 14 +++++++++-----
 tools/perf/util/mmap.c                 |  4 ++--
 tools/perf/util/mmap.h                 |  3 ++-
 4 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/perf/lib/include/internal/mmap.h
index e25890de6a55..b26806b36bb6 100644
--- a/tools/perf/lib/include/internal/mmap.h
+++ b/tools/perf/lib/include/internal/mmap.h
@@ -29,6 +29,11 @@ struct perf_mmap {
 	char		 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
 };
 
+struct perf_mmap_param {
+	int	prot;
+	int	mask;
+};
+
 void perf_mmap__init(struct perf_mmap *map, bool overwrite);
 
 #endif /* __LIBPERF_INTERNAL_MMAP_H */
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 633a407b1294..666339d4d1cd 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -643,7 +643,7 @@ static int evlist__mmap_per_evsel(struct evlist *evlist, int idx,
 		int fd;
 		int cpu;
 
-		mp->prot = PROT_READ | PROT_WRITE;
+		mp->core.prot = PROT_READ | PROT_WRITE;
 		if (evsel->core.attr.write_backward) {
 			output = _output_overwrite;
 			maps = evlist->overwrite_mmap;
@@ -656,7 +656,7 @@ static int evlist__mmap_per_evsel(struct evlist *evlist, int idx,
 				if (evlist->bkw_mmap_state == BKW_MMAP_NOTREADY)
 					perf_evlist__toggle_bkw_mmap(evlist, BKW_MMAP_RUNNING);
 			}
-			mp->prot &= ~PROT_WRITE;
+			mp->core.prot &= ~PROT_WRITE;
 		}
 
 		if (evsel->core.system_wide && thread)
@@ -897,8 +897,12 @@ int evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 	 * Its value is decided by evsel's write_backward.
 	 * So &mp should not be passed through const pointer.
 	 */
-	struct mmap_params mp = { .nr_cblocks = nr_cblocks, .affinity = affinity, .flush = flush,
-				  .comp_level = comp_level };
+	struct mmap_params mp = {
+		.nr_cblocks	= nr_cblocks,
+		.affinity	= affinity,
+		.flush		= flush,
+		.comp_level	= comp_level
+	};
 
 	if (!evlist->mmap)
 		evlist->mmap = evlist__alloc_mmap(evlist, false);
@@ -910,7 +914,7 @@ int evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 
 	evlist->core.mmap_len = evlist__mmap_size(pages);
 	pr_debug("mmap size %zuB\n", evlist->core.mmap_len);
-	mp.mask = evlist->core.mmap_len - page_size - 1;
+	mp.core.mask = evlist->core.mmap_len - page_size - 1;
 
 	auxtrace_mmap_params__init(&mp.auxtrace_mp, evlist->core.mmap_len,
 				   auxtrace_pages, auxtrace_overwrite);
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index a35dc57d5995..a496ced5ed2a 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -370,8 +370,8 @@ int perf_mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
 	 */
 	refcount_set(&map->core.refcnt, 2);
 	map->core.prev = 0;
-	map->core.mask = mp->mask;
-	map->core.base = mmap(NULL, perf_mmap__mmap_len(map), mp->prot,
+	map->core.mask = mp->core.mask;
+	map->core.base = mmap(NULL, perf_mmap__mmap_len(map), mp->core.prot,
 			 MAP_SHARED, fd, 0);
 	if (map->core.base == MAP_FAILED) {
 		pr_debug2("failed to mmap perf event ring buffer, error %d\n",
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index e567c1c875bd..4ff75d8aeb05 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -37,7 +37,8 @@ struct mmap {
 };
 
 struct mmap_params {
-	int prot, mask, nr_cblocks, affinity, flush, comp_level;
+	struct perf_mmap_param core;
+	int nr_cblocks, affinity, flush, comp_level;
 	struct auxtrace_mmap_params auxtrace_mp;
 };
 
-- 
2.21.0

