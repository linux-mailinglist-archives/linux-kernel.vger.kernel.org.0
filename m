Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58B9A79F45
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 05:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732660AbfG3DBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 23:01:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:51046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732635AbfG3DBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 23:01:41 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8B4D206DD;
        Tue, 30 Jul 2019 03:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455700;
        bh=OBDKZbnWD+iz3qKJtAGcRPR7Xy30m2zPz0x6D7vxNCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2AMwiS+8ltFHOC9pXfGdpZVGQDVVh4GPOF67rLvkApMAQxwrgGZib/4wX1EfZaePH
         vXeoipu+BpT4GYrAAvNz8uULfycOauTIe+h8W2O/YStJQm2w90alFKN69Aw8g7wN7B
         2aE5QCQb7vM1cSaIsnpsiDVOcL8O4d1sdEXLoW2c=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 094/107] libperf: Add perf_evsel__cpus()/threads() functions
Date:   Mon, 29 Jul 2019 23:55:57 -0300
Message-Id: <20190730025610.22603-95-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add the following functions:

  perf_evsel__cpus()
  perf_evsel__threads()

to access the evsel's cpus and threads objects.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-68-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evsel.c              | 10 ++++++++++
 tools/perf/lib/include/perf/evsel.h |  2 ++
 tools/perf/lib/libperf.map          |  2 ++
 tools/perf/util/evsel.h             |  2 +-
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/perf/lib/evsel.c b/tools/perf/lib/evsel.c
index c3f3722e9f91..8dbe0e841b8f 100644
--- a/tools/perf/lib/evsel.c
+++ b/tools/perf/lib/evsel.c
@@ -215,3 +215,13 @@ int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter)
 				     PERF_EVENT_IOC_SET_FILTER,
 				     (void *)filter);
 }
+
+struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel)
+{
+	return evsel->cpus;
+}
+
+struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel)
+{
+	return evsel->threads;
+}
diff --git a/tools/perf/lib/include/perf/evsel.h b/tools/perf/lib/include/perf/evsel.h
index 0db18dfabdb8..ae9f7eeb53a2 100644
--- a/tools/perf/lib/include/perf/evsel.h
+++ b/tools/perf/lib/include/perf/evsel.h
@@ -32,5 +32,7 @@ LIBPERF_API int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
 				 struct perf_counts_values *count);
 LIBPERF_API int perf_evsel__enable(struct perf_evsel *evsel);
 LIBPERF_API int perf_evsel__disable(struct perf_evsel *evsel);
+LIBPERF_API struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
+LIBPERF_API struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
 
 #endif /* __LIBPERF_EVSEL_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index d4d34bea0b40..9f43b5cda031 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -21,6 +21,8 @@ LIBPERF_0.0.1 {
 		perf_evsel__open;
 		perf_evsel__close;
 		perf_evsel__read;
+		perf_evsel__cpus;
+		perf_evsel__threads;
 		perf_evlist__new;
 		perf_evlist__delete;
 		perf_evlist__init;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 0989fb2eb1ec..3cf35aa782b9 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -193,7 +193,7 @@ struct record_opts;
 
 static inline struct perf_cpu_map *evsel__cpus(struct evsel *evsel)
 {
-	return evsel->core.cpus;
+	return perf_evsel__cpus(&evsel->core);
 }
 
 static inline int perf_evsel__nr_cpus(struct evsel *evsel)
-- 
2.21.0

