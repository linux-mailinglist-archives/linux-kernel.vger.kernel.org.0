Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1839E7B2B3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 20:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388473AbfG3Sx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 14:53:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37797 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387964AbfG3Sx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:53:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UIrEt63336196
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:53:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UIrEt63336196
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564512795;
        bh=LO65ksnAEWmXeBBpo1yQkEIAiPmbNWgnptSNzwtAtwU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=TEXHEE74KunqIEU10WTm+xEBBzP1+xOeu/Xk7m0pQqWSbTClEtVdzB97CWqDOJh3H
         nktIt1JhKOEYd18ZwB/0JL0KMSu1WxXbYN4AoOF8KOZKumfYE7/jeHsKjyfZ4s+GRU
         q0GaZu4CLcKusRzKph6Z7DpC5KoXVCsTCcFUOPwa7cWq48k6AYXbrYM9xA3UvaRC2S
         eRoTg+iZGvtMCIIgwr+Woz4uozR738MUKOJysEixHpCwGlnh8kAw41dmN7PFnrRQR0
         t5ZoyZV2WAQV0rQnvLMTOpYfjaVq1xnT7pwvUG5a2J5SzkQqbjWyiGQ3RWHfM5jnPB
         +jAONjXmYfL6g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UIrEtE3336193;
        Tue, 30 Jul 2019 11:53:14 -0700
Date:   Tue, 30 Jul 2019 11:53:14 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-b8eca4d761c57fcf691a8063cd562f205645d11f@git.kernel.org>
Cc:     namhyung@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@kernel.org, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, acme@redhat.com,
        linux-kernel@vger.kernel.org, alexey.budankov@linux.intel.com,
        mpetlan@redhat.com, hpa@zytor.com, ak@linux.intel.com
Reply-To: acme@redhat.com, mpetlan@redhat.com,
          alexey.budankov@linux.intel.com, linux-kernel@vger.kernel.org,
          hpa@zytor.com, ak@linux.intel.com, peterz@infradead.org,
          tglx@linutronix.de, mingo@kernel.org,
          alexander.shishkin@linux.intel.com, jolsa@kernel.org,
          namhyung@kernel.org
In-Reply-To: <20190721112506.12306-62-jolsa@kernel.org>
References: <20190721112506.12306-62-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] libperf: Adopt perf_evsel__alloc_fd() function from
 tools/perf
Git-Commit-ID: b8eca4d761c57fcf691a8063cd562f205645d11f
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

Commit-ID:  b8eca4d761c57fcf691a8063cd562f205645d11f
Gitweb:     https://git.kernel.org/tip/b8eca4d761c57fcf691a8063cd562f205645d11f
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:48 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:46 -0300

libperf: Adopt perf_evsel__alloc_fd() function from tools/perf

Move the perf_evsel__alloc_fd() function from perf to libperf.

It's not exported.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-62-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evsel.c                  | 21 +++++++++++++++++++++
 tools/perf/lib/include/internal/evsel.h |  2 ++
 tools/perf/util/evsel.c                 | 18 +-----------------
 3 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/tools/perf/lib/evsel.c b/tools/perf/lib/evsel.c
index ddc3ad447bfb..027f1edb4e8e 100644
--- a/tools/perf/lib/evsel.c
+++ b/tools/perf/lib/evsel.c
@@ -1,9 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
 #include <perf/evsel.h>
 #include <linux/list.h>
 #include <internal/evsel.h>
 #include <linux/zalloc.h>
 #include <stdlib.h>
+#include <internal/xyarray.h>
+#include <linux/string.h>
 
 void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr)
 {
@@ -25,3 +28,21 @@ void perf_evsel__delete(struct perf_evsel *evsel)
 {
 	free(evsel);
 }
+
+#define FD(e, x, y) (*(int *) xyarray__entry(e->fd, x, y))
+
+int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthreads)
+{
+	evsel->fd = xyarray__new(ncpus, nthreads, sizeof(int));
+
+	if (evsel->fd) {
+		int cpu, thread;
+		for (cpu = 0; cpu < ncpus; cpu++) {
+			for (thread = 0; thread < nthreads; thread++) {
+				FD(evsel, cpu, thread) = -1;
+			}
+		}
+	}
+
+	return evsel->fd != NULL ? 0 : -ENOMEM;
+}
diff --git a/tools/perf/lib/include/internal/evsel.h b/tools/perf/lib/include/internal/evsel.h
index 29eca9576546..3cb9a0f5f32e 100644
--- a/tools/perf/lib/include/internal/evsel.h
+++ b/tools/perf/lib/include/internal/evsel.h
@@ -20,4 +20,6 @@ struct perf_evsel {
 	int			 nr_members;
 };
 
+int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthreads);
+
 #endif /* __LIBPERF_INTERNAL_EVSEL_H */
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 8b9a00598677..d3c8488f7069 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1153,22 +1153,6 @@ void perf_evsel__config(struct evsel *evsel, struct record_opts *opts,
 		perf_evsel__reset_sample_bit(evsel, BRANCH_STACK);
 }
 
-static int perf_evsel__alloc_fd(struct evsel *evsel, int ncpus, int nthreads)
-{
-	evsel->core.fd = xyarray__new(ncpus, nthreads, sizeof(int));
-
-	if (evsel->core.fd) {
-		int cpu, thread;
-		for (cpu = 0; cpu < ncpus; cpu++) {
-			for (thread = 0; thread < nthreads; thread++) {
-				FD(evsel, cpu, thread) = -1;
-			}
-		}
-	}
-
-	return evsel->core.fd != NULL ? 0 : -ENOMEM;
-}
-
 static int perf_evsel__run_ioctl(struct evsel *evsel,
 			  int ioc,  void *arg)
 {
@@ -1866,7 +1850,7 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 		nthreads = threads->nr;
 
 	if (evsel->core.fd == NULL &&
-	    perf_evsel__alloc_fd(evsel, cpus->nr, nthreads) < 0)
+	    perf_evsel__alloc_fd(&evsel->core, cpus->nr, nthreads) < 0)
 		return -ENOMEM;
 
 	if (evsel->cgrp) {
