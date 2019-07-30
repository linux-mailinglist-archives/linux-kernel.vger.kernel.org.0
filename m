Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87F2F7B2CD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 21:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388503AbfG3TAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 15:00:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45431 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388059AbfG3TAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 15:00:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UJ05Ya3337437
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 12:00:05 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UJ05Ya3337437
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564513206;
        bh=2rUDSYIIBiJ0PM97+S+pkNehnoJe9/BPB3d86sVW1os=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=eIwwbCLJU1qquaxfhqotIf5HZN1rXsXWrpIP27f2vGJZywBDOVAJY4E4MyaZ7ohF6
         UTNFHTmRemTbh8bSzPP+Ux2yp9rOGw09juE0pA+lHiYEvXrxMHpg7GGCyImmqFt19K
         +UC0pzFCm7BKySFXi/kgZvJSznYnS2g0qhcfUEBjVFqf3YyxG9c1suO9GJTWcg7x6X
         0ZL3QHBIVmhI8qfZz1/Ce1QVR5kYsWVbq4M9zmbFDd0peymjFOgeSCr/MlSZc4/XI+
         onIip1s9NCIhgzMeNbm8vTwUsl8hofRSGcwWj0Jesnk/cS6qZQkZRQm0psItcjEg8n
         P6rk9e9QP+Yyw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UJ03573337432;
        Tue, 30 Jul 2019 12:00:03 -0700
Date:   Tue, 30 Jul 2019 12:00:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-384c4ad192a01fe235c7ac9e9fd8605d12a807e8@git.kernel.org>
Cc:     mingo@kernel.org, hpa@zytor.com, namhyung@kernel.org,
        peterz@infradead.org, acme@redhat.com, mpetlan@redhat.com,
        alexey.budankov@linux.intel.com, jolsa@kernel.org,
        ak@linux.intel.com, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: ak@linux.intel.com, alexander.shishkin@linux.intel.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          mingo@kernel.org, hpa@zytor.com, namhyung@kernel.org,
          peterz@infradead.org, acme@redhat.com,
          alexey.budankov@linux.intel.com, mpetlan@redhat.com,
          jolsa@kernel.org
In-Reply-To: <20190721112506.12306-71-jolsa@kernel.org>
References: <20190721112506.12306-71-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] libperf: Add perf_evsel__attr() function
Git-Commit-ID: 384c4ad192a01fe235c7ac9e9fd8605d12a807e8
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

Commit-ID:  384c4ad192a01fe235c7ac9e9fd8605d12a807e8
Gitweb:     https://git.kernel.org/tip/384c4ad192a01fe235c7ac9e9fd8605d12a807e8
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:57 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:46 -0300

libperf: Add perf_evsel__attr() function

Add a perf_evsel__attr() function to get attr pointer from a perf_evsel
instance.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-71-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evsel.c              | 5 +++++
 tools/perf/lib/include/perf/evsel.h | 1 +
 tools/perf/lib/libperf.map          | 1 +
 3 files changed, 7 insertions(+)

diff --git a/tools/perf/lib/evsel.c b/tools/perf/lib/evsel.c
index 8dbe0e841b8f..24abc80dd767 100644
--- a/tools/perf/lib/evsel.c
+++ b/tools/perf/lib/evsel.c
@@ -225,3 +225,8 @@ struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel)
 {
 	return evsel->threads;
 }
+
+struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel)
+{
+	return &evsel->attr;
+}
diff --git a/tools/perf/lib/include/perf/evsel.h b/tools/perf/lib/include/perf/evsel.h
index ae9f7eeb53a2..4388667f265c 100644
--- a/tools/perf/lib/include/perf/evsel.h
+++ b/tools/perf/lib/include/perf/evsel.h
@@ -34,5 +34,6 @@ LIBPERF_API int perf_evsel__enable(struct perf_evsel *evsel);
 LIBPERF_API int perf_evsel__disable(struct perf_evsel *evsel);
 LIBPERF_API struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
 LIBPERF_API struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
+LIBPERF_API struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel);
 
 #endif /* __LIBPERF_EVSEL_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index 2068e3d52227..e24d3cec01c1 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -23,6 +23,7 @@ LIBPERF_0.0.1 {
 		perf_evsel__read;
 		perf_evsel__cpus;
 		perf_evsel__threads;
+		perf_evsel__attr;
 		perf_evlist__new;
 		perf_evlist__delete;
 		perf_evlist__open;
