Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99E2C6F309
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2019 13:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfGULcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jul 2019 07:32:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38288 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbfGULcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:32:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F0838883BA;
        Sun, 21 Jul 2019 11:32:21 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 529E25D9D3;
        Sun, 21 Jul 2019 11:32:17 +0000 (UTC)
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
Subject: [PATCH 68/79] libperf: Add perf_evlist__open/close functions
Date:   Sun, 21 Jul 2019 13:24:55 +0200
Message-Id: <20190721112506.12306-69-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Sun, 21 Jul 2019 11:32:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding following functions:
  perf_evlist__open
  perf_evlist__close

It's a simplified version of evlist__open without sampling
id index calculations. We can try to merge it in the future
when these are moved to libperf.

Also adding some helper evlist traversing macros. In future
we can remove them from util/evlist.h, but that requires also
some other changes.

Link: http://lkml.kernel.org/n/tip-s8noamedv8q9q8uk0ri152aa@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/evlist.c                  | 27 +++++++++++++++++++
 tools/perf/lib/include/internal/evlist.h | 34 ++++++++++++++++++++++++
 tools/perf/lib/include/perf/evlist.h     |  2 ++
 tools/perf/lib/libperf.map               |  2 ++
 4 files changed, 65 insertions(+)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index e01788092d8f..044f664e0733 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <perf/evlist.h>
+#include <perf/evsel.h>
 #include <linux/list.h>
 #include <internal/evlist.h>
 #include <internal/evsel.h>
@@ -114,3 +115,29 @@ void perf_evlist__set_maps(struct perf_evlist *evlist,
 
 	perf_evlist__propagate_maps(evlist);
 }
+
+int perf_evlist__open(struct perf_evlist *evlist)
+{
+	struct perf_evsel *evsel;
+	int err;
+
+	perf_evlist__for_each_entry(evlist, evsel) {
+		err = perf_evsel__open(evsel, evsel->cpus, evsel->threads);
+		if (err < 0)
+			goto out_err;
+	}
+
+	return 0;
+
+out_err:
+	perf_evlist__close(evlist);
+	return err;
+}
+
+void perf_evlist__close(struct perf_evlist *evlist)
+{
+	struct perf_evsel *evsel;
+
+	perf_evlist__for_each_entry_reverse(evlist, evsel)
+		perf_evsel__close(evsel);
+}
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index b7b43dbc9b82..448891f06e3e 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -2,6 +2,8 @@
 #ifndef __LIBPERF_INTERNAL_EVLIST_H
 #define __LIBPERF_INTERNAL_EVLIST_H
 
+#include <linux/list.h>
+
 struct perf_cpu_map;
 struct perf_thread_map;
 
@@ -13,4 +15,36 @@ struct perf_evlist {
 	struct perf_thread_map	*threads;
 };
 
+/**
+ * __perf_evlist__for_each_entry - iterate thru all the evsels
+ * @list: list_head instance to iterate
+ * @evsel: struct perf_evsel iterator
+ */
+#define __perf_evlist__for_each_entry(list, evsel) \
+	list_for_each_entry(evsel, list, node)
+
+/**
+ * evlist__for_each_entry - iterate thru all the evsels
+ * @evlist: perf_evlist instance to iterate
+ * @evsel: struct perf_evsel iterator
+ */
+#define perf_evlist__for_each_entry(evlist, evsel) \
+	__perf_evlist__for_each_entry(&(evlist)->entries, evsel)
+
+/**
+ * __perf_evlist__for_each_entry_reverse - iterate thru all the evsels in reverse order
+ * @list: list_head instance to iterate
+ * @evsel: struct evsel iterator
+ */
+#define __perf_evlist__for_each_entry_reverse(list, evsel) \
+	list_for_each_entry_reverse(evsel, list, node)
+
+/**
+ * perf_evlist__for_each_entry_reverse - iterate thru all the evsels in reverse order
+ * @evlist: evlist instance to iterate
+ * @evsel: struct evsel iterator
+ */
+#define perf_evlist__for_each_entry_reverse(evlist, evsel) \
+	__perf_evlist__for_each_entry_reverse(&(evlist)->entries, evsel)
+
 #endif /* __LIBPERF_INTERNAL_EVLIST_H */
diff --git a/tools/perf/lib/include/perf/evlist.h b/tools/perf/lib/include/perf/evlist.h
index b1d8dee018d6..6d3dda743541 100644
--- a/tools/perf/lib/include/perf/evlist.h
+++ b/tools/perf/lib/include/perf/evlist.h
@@ -18,6 +18,8 @@ LIBPERF_API struct perf_evlist *perf_evlist__new(void);
 LIBPERF_API void perf_evlist__delete(struct perf_evlist *evlist);
 LIBPERF_API struct perf_evsel* perf_evlist__next(struct perf_evlist *evlist,
 						 struct perf_evsel *evsel);
+LIBPERF_API int perf_evlist__open(struct perf_evlist *evlist);
+LIBPERF_API void perf_evlist__close(struct perf_evlist *evlist);
 
 #define perf_evlist__for_each_evsel(evlist, pos)	\
 	for ((pos) = perf_evlist__next((evlist), NULL);	\
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index 9f43b5cda031..4f966ddd5e53 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -25,6 +25,8 @@ LIBPERF_0.0.1 {
 		perf_evsel__threads;
 		perf_evlist__new;
 		perf_evlist__delete;
+		perf_evlist__open;
+		perf_evlist__close;
 		perf_evlist__init;
 		perf_evlist__add;
 		perf_evlist__remove;
-- 
2.21.0

