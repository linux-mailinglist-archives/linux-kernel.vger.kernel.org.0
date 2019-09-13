Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A11AB20C6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2019 15:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391537AbfIMN0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Sep 2019 09:26:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45538 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391526AbfIMN0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:26:11 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A882A806A40;
        Fri, 13 Sep 2019 13:26:10 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0DE7A5C1D4;
        Fri, 13 Sep 2019 13:26:08 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 54/73] libperf: Add perf_evlist_mmap_ops::idx callback
Date:   Fri, 13 Sep 2019 15:23:36 +0200
Message-Id: <20190913132355.21634-55-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Fri, 13 Sep 2019 13:26:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding perf_evlist_mmap_ops::idx callback to be called
in mmap_per_cpu and mmap_per_thread with current cpu and
thread indexes. It's used by current aux code, so perf
will used this callback to set aux index.

Link: http://lkml.kernel.org/n/tip-smr1w2e6j37ncbmsd1eet228@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/evlist.c                  | 18 +++++++++++++-----
 tools/perf/lib/include/internal/evlist.h |  4 ++++
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 0f103c10d8ca..67b5f14f738f 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -397,7 +397,8 @@ mmap_per_evsel(struct perf_evlist *evlist, int idx,
 }
 
 static int
-mmap_per_thread(struct perf_evlist *evlist, struct perf_mmap_param *mp)
+mmap_per_thread(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
+		struct perf_mmap_param *mp)
 {
 	int thread;
 	int nr_threads = perf_thread_map__nr(evlist->threads);
@@ -406,6 +407,9 @@ mmap_per_thread(struct perf_evlist *evlist, struct perf_mmap_param *mp)
 		int output = -1;
 		int output_overwrite = -1;
 
+		if (ops->idx)
+			ops->idx(evlist, mp, thread, false);
+
 		if (mmap_per_evsel(evlist, thread, mp, 0, thread,
 				   &output, &output_overwrite))
 			goto out_unmap;
@@ -419,7 +423,8 @@ mmap_per_thread(struct perf_evlist *evlist, struct perf_mmap_param *mp)
 }
 
 static int
-mmap_per_cpu(struct perf_evlist *evlist, struct perf_mmap_param *mp)
+mmap_per_cpu(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
+	     struct perf_mmap_param *mp)
 {
 	int nr_threads = perf_thread_map__nr(evlist->threads);
 	int nr_cpus    = perf_cpu_map__nr(evlist->cpus);
@@ -429,6 +434,9 @@ mmap_per_cpu(struct perf_evlist *evlist, struct perf_mmap_param *mp)
 		int output = -1;
 		int output_overwrite = -1;
 
+		if (ops->idx)
+			ops->idx(evlist, mp, cpu, true);
+
 		for (thread = 0; thread < nr_threads; thread++) {
 			if (mmap_per_evsel(evlist, cpu, mp, cpu,
 					   thread, &output, &output_overwrite))
@@ -462,15 +470,15 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
 	}
 
 	if (perf_cpu_map__empty(cpus))
-		return mmap_per_thread(evlist, mp);
+		return mmap_per_thread(evlist, ops, mp);
 
-	return mmap_per_cpu(evlist, mp);
+	return mmap_per_cpu(evlist, ops, mp);
 }
 
 int perf_evlist__mmap(struct perf_evlist *evlist, int pages)
 {
 	struct perf_mmap_param mp;
-	struct perf_evlist_mmap_ops ops;
+	struct perf_evlist_mmap_ops ops = { 0 };
 
 	if (!evlist->mmap && perf_evlist__alloc_maps(evlist))
 		return -ENOMEM;
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index 5a8706a81c0d..64522b8237be 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -27,7 +27,11 @@ struct perf_evlist {
 	struct perf_mmap	**mmap_ovw;
 };
 
+typedef void
+(*perf_evlist_mmap__cb_idx_t)(struct perf_evlist*, struct perf_mmap_param*, int, bool);
+
 struct perf_evlist_mmap_ops {
+	perf_evlist_mmap__cb_idx_t	idx;
 };
 
 int perf_evlist__alloc_pollfd(struct perf_evlist *evlist);
-- 
2.21.0

