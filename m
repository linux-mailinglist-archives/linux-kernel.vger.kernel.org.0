Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCA657B23D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 20:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388024AbfG3SoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 14:44:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42181 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfG3SoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:44:13 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UIi0313332865
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:44:00 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UIi0313332865
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564512241;
        bh=8EucXuZyudfWUs9jGdtekK7O2DmAmmJ67DlAYkGrzLI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=ta9tPPMsrmjk4mSk42U05fpv61566hjMq/G4wMDm7mERy770I4LJi3mJeIhKjApRg
         9ZRDimndAJNvqjINR6JuaG8NV/Aw3O/P5v0OlnsxcqwQbRz8W3xSi7JmgeV61tX4EU
         0DYw37tGwf52knn31xIC7VEQUjNlz9uB29dg1dhS3/Efdt0qbei2mjKwsrKmZjU5he
         8WrHRQaECJv46kcJR7sDvuVWiOMws6qiQXsZCLyNF4NyLEdhz/wP+mwhdAtqMt1myS
         1XZh+ht8A6tSUok2rqFdBPll0elVXYHWNAMV+3Wx/wmkUcrsmzsq1cydAOhEyKuAsw
         774rhF4NSMUQQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UIi0Ch3332862;
        Tue, 30 Jul 2019 11:44:00 -0700
Date:   Tue, 30 Jul 2019 11:44:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-b9358ee95ec65fe7e2c4dc12e4d3da4aeee0d8fc@git.kernel.org>
Cc:     namhyung@kernel.org, hpa@zytor.com, mpetlan@redhat.com,
        ak@linux.intel.com, alexander.shishkin@linux.intel.com,
        acme@redhat.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        jolsa@kernel.org, tglx@linutronix.de,
        alexey.budankov@linux.intel.com, peterz@infradead.org
Reply-To: acme@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
          namhyung@kernel.org, alexander.shishkin@linux.intel.com,
          tglx@linutronix.de, peterz@infradead.org,
          alexey.budankov@linux.intel.com, ak@linux.intel.com,
          jolsa@kernel.org, mpetlan@redhat.com, mingo@kernel.org
In-Reply-To: <20190721112506.12306-50-jolsa@kernel.org>
References: <20190721112506.12306-50-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] libperf: Add perf_evsel__delete() function
Git-Commit-ID: b9358ee95ec65fe7e2c4dc12e4d3da4aeee0d8fc
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

Commit-ID:  b9358ee95ec65fe7e2c4dc12e4d3da4aeee0d8fc
Gitweb:     https://git.kernel.org/tip/b9358ee95ec65fe7e2c4dc12e4d3da4aeee0d8fc
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:36 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:45 -0300

libperf: Add perf_evsel__delete() function

Add the perf_evsel__delete() function to delete a perf_evsel instance.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-50-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evsel.c              | 6 ++++++
 tools/perf/lib/include/perf/evsel.h | 1 +
 tools/perf/lib/libperf.map          | 1 +
 3 files changed, 8 insertions(+)

diff --git a/tools/perf/lib/evsel.c b/tools/perf/lib/evsel.c
index 8e91738c5c38..ddc3ad447bfb 100644
--- a/tools/perf/lib/evsel.c
+++ b/tools/perf/lib/evsel.c
@@ -3,6 +3,7 @@
 #include <linux/list.h>
 #include <internal/evsel.h>
 #include <linux/zalloc.h>
+#include <stdlib.h>
 
 void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr)
 {
@@ -19,3 +20,8 @@ struct perf_evsel *perf_evsel__new(struct perf_event_attr *attr)
 
 	return evsel;
 }
+
+void perf_evsel__delete(struct perf_evsel *evsel)
+{
+	free(evsel);
+}
diff --git a/tools/perf/lib/include/perf/evsel.h b/tools/perf/lib/include/perf/evsel.h
index 21b66fc1937f..a57efc0f5c8b 100644
--- a/tools/perf/lib/include/perf/evsel.h
+++ b/tools/perf/lib/include/perf/evsel.h
@@ -10,5 +10,6 @@ struct perf_event_attr;
 LIBPERF_API void perf_evsel__init(struct perf_evsel *evsel,
 				  struct perf_event_attr *attr);
 LIBPERF_API struct perf_evsel *perf_evsel__new(struct perf_event_attr *attr);
+LIBPERF_API void perf_evsel__delete(struct perf_evsel *evsel);
 
 #endif /* __LIBPERF_EVSEL_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index 153e77cd6739..28ed04cbd223 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -12,6 +12,7 @@ LIBPERF_0.0.1 {
 		perf_thread_map__get;
 		perf_thread_map__put;
 		perf_evsel__new;
+		perf_evsel__delete;
 		perf_evsel__init;
 		perf_evlist__new;
 		perf_evlist__delete;
