Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60E02CE250
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 14:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbfJGMyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 08:54:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34098 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728372AbfJGMyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:54:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 530BC10CC1E0;
        Mon,  7 Oct 2019 12:54:46 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BF5455D9CC;
        Mon,  7 Oct 2019 12:54:43 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 25/36] libperf: Add perf_evlist__purge function
Date:   Mon,  7 Oct 2019 14:53:33 +0200
Message-Id: <20191007125344.14268-26-jolsa@kernel.org>
In-Reply-To: <20191007125344.14268-1-jolsa@kernel.org>
References: <20191007125344.14268-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.65]); Mon, 07 Oct 2019 12:54:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding static perf_evlist__purge function to purge
and delete evsels from evlist.

Adding also perf_evlist__for_each_entry_safe which
is used by perf_evlist__purge.

Link: http://lkml.kernel.org/n/tip-xcwsmyqcxe8zgbpapn27f8n9@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/evlist.c                  | 13 +++++++++++++
 tools/perf/lib/include/internal/evlist.h | 18 ++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 7ba98f0e6365..9534ad9a572f 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -109,6 +109,18 @@ perf_evlist__next(struct perf_evlist *evlist, struct perf_evsel *prev)
 	return next;
 }
 
+static void perf_evlist__purge(struct perf_evlist *evlist)
+{
+	struct perf_evsel *pos, *n;
+
+	perf_evlist__for_each_entry_safe(evlist, n, pos) {
+		list_del_init(&pos->node);
+		perf_evsel__delete(pos);
+	}
+
+	evlist->nr_entries = 0;
+}
+
 void perf_evlist__exit(struct perf_evlist *evlist)
 {
 	perf_cpu_map__put(evlist->cpus);
@@ -125,6 +137,7 @@ void perf_evlist__delete(struct perf_evlist *evlist)
 
 	perf_evlist__munmap(evlist);
 	perf_evlist__close(evlist);
+	perf_evlist__purge(evlist);
 	perf_evlist__exit(evlist);
 	free(evlist);
 }
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index 0721512ffb19..be0b25a70730 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -82,6 +82,24 @@ void perf_evlist__exit(struct perf_evlist *evlist);
 #define perf_evlist__for_each_entry_reverse(evlist, evsel) \
 	__perf_evlist__for_each_entry_reverse(&(evlist)->entries, evsel)
 
+/**
+ * __perf_evlist__for_each_entry_safe - safely iterate thru all the evsels
+ * @list: list_head instance to iterate
+ * @tmp: struct evsel temp iterator
+ * @evsel: struct evsel iterator
+ */
+#define __perf_evlist__for_each_entry_safe(list, tmp, evsel) \
+	list_for_each_entry_safe(evsel, tmp, list, node)
+
+/**
+ * perf_evlist__for_each_entry_safe - safely iterate thru all the evsels
+ * @evlist: evlist instance to iterate
+ * @evsel: struct evsel iterator
+ * @tmp: struct evsel temp iterator
+ */
+#define perf_evlist__for_each_entry_safe(evlist, tmp, evsel) \
+	__perf_evlist__for_each_entry_safe(&(evlist)->entries, tmp, evsel)
+
 static inline struct perf_evsel *perf_evlist__first(struct perf_evlist *evlist)
 {
 	return list_entry(evlist->entries.next, struct perf_evsel, node);
-- 
2.21.0

