Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 420E2B209C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2019 15:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391148AbfIMNYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Sep 2019 09:24:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44822 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390746AbfIMNYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:24:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C88E78980E1;
        Fri, 13 Sep 2019 13:24:18 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A91B5C1D4;
        Fri, 13 Sep 2019 13:24:14 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 07/73] perf tools: Rename perf_evlist__exit() to evlist__exit()
Date:   Fri, 13 Sep 2019 15:22:49 +0200
Message-Id: <20190913132355.21634-8-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Fri, 13 Sep 2019 13:24:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename (perf_evlist__exit) to evlist__exit(), so we don't have a
name clash when we add (perf_evlist__exit) in libperf.

Link: http://lkml.kernel.org/n/tip-p06j15gw578nyggy56v83z6b@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/evlist.c | 4 ++--
 tools/perf/util/evlist.h | 2 +-
 tools/perf/util/python.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index dc7117c33ab8..d71fafd472ea 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -137,7 +137,7 @@ static void perf_evlist__purge(struct evlist *evlist)
 	evlist->core.nr_entries = 0;
 }
 
-void perf_evlist__exit(struct evlist *evlist)
+void evlist__exit(struct evlist *evlist)
 {
 	zfree(&evlist->mmap);
 	zfree(&evlist->overwrite_mmap);
@@ -156,7 +156,7 @@ void evlist__delete(struct evlist *evlist)
 	evlist->core.cpus = NULL;
 	evlist->core.threads = NULL;
 	perf_evlist__purge(evlist);
-	perf_evlist__exit(evlist);
+	evlist__exit(evlist);
 	free(evlist);
 }
 
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index f07501602353..b33c5d67410a 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -65,7 +65,7 @@ struct evlist *perf_evlist__new_default(void);
 struct evlist *perf_evlist__new_dummy(void);
 void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
 		  struct perf_thread_map *threads);
-void perf_evlist__exit(struct evlist *evlist);
+void evlist__exit(struct evlist *evlist);
 void evlist__delete(struct evlist *evlist);
 
 void evlist__add(struct evlist *evlist, struct evsel *entry);
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 9b0eaf83212f..7e28f7e18d41 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -884,7 +884,7 @@ static int pyrf_evlist__init(struct pyrf_evlist *pevlist,
 
 static void pyrf_evlist__delete(struct pyrf_evlist *pevlist)
 {
-	perf_evlist__exit(&pevlist->evlist);
+	evlist__exit(&pevlist->evlist);
 	Py_TYPE(pevlist)->tp_free((PyObject*)pevlist);
 }
 
-- 
2.21.0

