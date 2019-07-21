Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51C426F2C7
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2019 13:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfGUL0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jul 2019 07:26:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36514 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726429AbfGUL0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:26:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E55F98535C;
        Sun, 21 Jul 2019 11:26:42 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B51E25D9D3;
        Sun, 21 Jul 2019 11:26:38 +0000 (UTC)
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
Subject: [PATCH 07/79] perf tools: Rename perf_evlist__init to evlist__init
Date:   Sun, 21 Jul 2019 13:23:54 +0200
Message-Id: <20190721112506.12306-8-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Sun, 21 Jul 2019 11:26:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renaming perf_evlist__init to evlist__init, so we don't
have a name clash when we add perf_evlist__init in libperf.

Link: http://lkml.kernel.org/n/tip-6trhnvxytm6m433qdjdzmitz@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/evlist.c | 6 +++---
 tools/perf/util/evlist.h | 4 ++--
 tools/perf/util/python.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index c234fa4ba92a..4fcd55c8a8d5 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -41,8 +41,8 @@ int sigqueue(pid_t pid, int sig, const union sigval value);
 #define FD(e, x, y) (*(int *)xyarray__entry(e->fd, x, y))
 #define SID(e, x, y) xyarray__entry(e->sample_id, x, y)
 
-void perf_evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
-		       struct perf_thread_map *threads)
+void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
+		  struct perf_thread_map *threads)
 {
 	int i;
 
@@ -60,7 +60,7 @@ struct evlist *perf_evlist__new(void)
 	struct evlist *evlist = zalloc(sizeof(*evlist));
 
 	if (evlist != NULL)
-		perf_evlist__init(evlist, NULL, NULL);
+		evlist__init(evlist, NULL, NULL);
 
 	return evlist;
 }
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 54f1c3e2b721..d6a3fa461566 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -68,8 +68,8 @@ struct evsel_str_handler {
 struct evlist *perf_evlist__new(void);
 struct evlist *perf_evlist__new_default(void);
 struct evlist *perf_evlist__new_dummy(void);
-void perf_evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
-		       struct perf_thread_map *threads);
+void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
+		  struct perf_thread_map *threads);
 void perf_evlist__exit(struct evlist *evlist);
 void perf_evlist__delete(struct evlist *evlist);
 
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index f6fe3c90828f..ade4e85c6d81 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -873,7 +873,7 @@ static int pyrf_evlist__init(struct pyrf_evlist *pevlist,
 
 	threads = ((struct pyrf_thread_map *)pthreads)->threads;
 	cpus = ((struct pyrf_cpu_map *)pcpus)->cpus;
-	perf_evlist__init(&pevlist->evlist, cpus, threads);
+	evlist__init(&pevlist->evlist, cpus, threads);
 	return 0;
 }
 
-- 
2.21.0

