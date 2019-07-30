Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E37BF7B150
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 20:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbfG3SMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 14:12:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46595 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfG3SMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:12:17 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UIC4pI3325540
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:12:04 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UIC4pI3325540
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564510325;
        bh=HWrv2Um5ZOPmjoSMAKs1dISVWfu9PtsAybc90yOm8hU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=qXBhG9OZRL9gXBRY0hXJXfJWHN9ichS6UanPyLH2ombGAORRlW1+/1GkwliGOjdIO
         ok8e1Gsfr8JRDrDF058OBmBAFNfBLwobknnBRNfNuh5o8nVrSxblSKHqSzWMD4L+Id
         qlYR2x2zwkFO6PVUiIZv007pWV63GyqmFyzxdPgob0DViUsrRmDy75AMplB/kHfRWA
         aH5I+IWi1ZUShdqrfVbYDJhiLVXPwKxVmju1hw072cr7gXINcVXxtHnP6DPPDtpQOL
         5PYiXNy+FZ1O5b0RcyYmxTReh8X0DP79U3ZiaJ5MNcj3oSW7XCvj3ORjUsclxETeiX
         PcfOyHOXMPtBA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UIC3MB3325537;
        Tue, 30 Jul 2019 11:12:03 -0700
Date:   Tue, 30 Jul 2019 11:12:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-52c86bca94b42239563b1510d5fc6329b0ec1a86@git.kernel.org>
Cc:     tglx@linutronix.de, alexey.budankov@linux.intel.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, ak@linux.intel.com, mingo@kernel.org,
        mpetlan@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        acme@redhat.com, peterz@infradead.org
Reply-To: peterz@infradead.org, linux-kernel@vger.kernel.org,
          acme@redhat.com, hpa@zytor.com, mpetlan@redhat.com,
          mingo@kernel.org, ak@linux.intel.com, jolsa@kernel.org,
          namhyung@kernel.org, alexander.shishkin@linux.intel.com,
          alexey.budankov@linux.intel.com, tglx@linutronix.de
In-Reply-To: <20190721112506.12306-8-jolsa@kernel.org>
References: <20190721112506.12306-8-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf evlist: Rename perf_evlist__init() to
 evlist__init()
Git-Commit-ID: 52c86bca94b42239563b1510d5fc6329b0ec1a86
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

Commit-ID:  52c86bca94b42239563b1510d5fc6329b0ec1a86
Gitweb:     https://git.kernel.org/tip/52c86bca94b42239563b1510d5fc6329b0ec1a86
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:23:54 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:42 -0300

perf evlist: Rename perf_evlist__init() to evlist__init()

Rename perf_evlist__init() to evlist__init(), so we don't have a name
clash when we add perf_evlist__init() in libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-8-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
 
