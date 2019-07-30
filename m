Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07FEC7B15A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 20:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbfG3SPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 14:15:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50599 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfG3SPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:15:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UIF2Dd3325987
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:15:02 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UIF2Dd3325987
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564510503;
        bh=RIDbHj4dcX0LAT0D1AlS8luBMzGaCde1C2650N2QVkU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=eZe6oH4MgXWYgCnMi0zP4eS8Kz4nxM9ltUuU0N7K3f5tsZ1bJUCUcsO1S3xq5TLsa
         K0AxVcGmC5Dk/r3xKvwIFjGhiPIQV+0lwhO1OvjECmGoB/uArKJ2CzZ5MA7NP+EqD+
         jIjZmmRBfhLAZ+Kj65gWI9lRY1LwWyHF7jD/7TF47WZgHN0x+vEp1Nvfpfpuz6QZh4
         PJrHZzDD8F8Fc4NanlL7AvjN+xUsmKRaMuxvPfJBDG4HD183T82QBv+y1OFVlRpzj0
         TAjpcDCJjLF+4Chts3UpL4eT0NBTAXdg0h+4+rJ8eFQenZ7MeklRBVg9UMUVo1e8Hp
         eDxJCBvZykUow==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UIF1sa3325926;
        Tue, 30 Jul 2019 11:15:01 -0700
Date:   Tue, 30 Jul 2019 11:15:01 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-365c3ae7452ca95e0a8f1e4716dd806550ade706@git.kernel.org>
Cc:     alexey.budankov@linux.intel.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, mpetlan@redhat.com,
        acme@redhat.com, namhyung@kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, peterz@infradead.org, hpa@zytor.com,
        jolsa@kernel.org, mingo@kernel.org
Reply-To: hpa@zytor.com, peterz@infradead.org, mingo@kernel.org,
          jolsa@kernel.org, mpetlan@redhat.com, acme@redhat.com,
          ak@linux.intel.com, alexey.budankov@linux.intel.com,
          alexander.shishkin@linux.intel.com, namhyung@kernel.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <20190721112506.12306-12-jolsa@kernel.org>
References: <20190721112506.12306-12-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf evsel: Rename perf_evsel__new() to
 evsel__new()
Git-Commit-ID: 365c3ae7452ca95e0a8f1e4716dd806550ade706
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

Commit-ID:  365c3ae7452ca95e0a8f1e4716dd806550ade706
Gitweb:     https://git.kernel.org/tip/365c3ae7452ca95e0a8f1e4716dd806550ade706
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:23:58 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:43 -0300

perf evsel: Rename perf_evsel__new() to evsel__new()

Rename perf_evsel__new() to evsel__new(), so we don't have a name clash
when we add perf_evsel__new() in libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-12-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c     | 2 +-
 tools/perf/tests/sw-clock.c    | 2 +-
 tools/perf/util/evsel.c        | 2 +-
 tools/perf/util/evsel.h        | 2 +-
 tools/perf/util/header.c       | 4 ++--
 tools/perf/util/parse-events.c | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 0f7d1859a2d1..c5eb47f4e42e 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2657,7 +2657,7 @@ static struct evsel *perf_evsel__new_pgfault(u64 config)
 
 	event_attr_init(&attr);
 
-	evsel = perf_evsel__new(&attr);
+	evsel = evsel__new(&attr);
 	if (evsel)
 		evsel->handler = trace__pgfault;
 
diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index 1c7d8adb43d0..247d3734686e 100644
--- a/tools/perf/tests/sw-clock.c
+++ b/tools/perf/tests/sw-clock.c
@@ -49,7 +49,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 		return -1;
 	}
 
-	evsel = perf_evsel__new(&attr);
+	evsel = evsel__new(&attr);
 	if (evsel == NULL) {
 		pr_debug("perf_evsel__new\n");
 		goto out_delete_evlist;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index de379b63f1ce..c9723c2d57c9 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -301,7 +301,7 @@ struct evsel *perf_evsel__new_cycles(bool precise)
 	 * to kick in when we return and before perf_evsel__open() is called.
 	 */
 new_event:
-	evsel = perf_evsel__new(&attr);
+	evsel = evsel__new(&attr);
 	if (evsel == NULL)
 		goto out;
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 20b4e31b63a9..ecea51a918e0 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -219,7 +219,7 @@ int perf_evsel__object_config(size_t object_size,
 
 struct evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx);
 
-static inline struct evsel *perf_evsel__new(struct perf_event_attr *attr)
+static inline struct evsel *evsel__new(struct perf_event_attr *attr)
 {
 	return perf_evsel__new_idx(attr, 0);
 }
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 29bbfd699226..7760ddc4bc18 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3583,7 +3583,7 @@ int perf_session__read_header(struct perf_session *session)
 		}
 
 		tmp = lseek(fd, 0, SEEK_CUR);
-		evsel = perf_evsel__new(&f_attr.attr);
+		evsel = evsel__new(&f_attr.attr);
 
 		if (evsel == NULL)
 			goto out_delete_evlist;
@@ -4021,7 +4021,7 @@ int perf_event__process_attr(struct perf_tool *tool __maybe_unused,
 			return -ENOMEM;
 	}
 
-	evsel = perf_evsel__new(&event->attr.attr);
+	evsel = evsel__new(&event->attr.attr);
 	if (evsel == NULL)
 		return -ENOMEM;
 
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index cc63367f6e45..40087cf74dd1 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2318,7 +2318,7 @@ static bool is_event_supported(u8 type, unsigned config)
 	if (tmap == NULL)
 		return false;
 
-	evsel = perf_evsel__new(&attr);
+	evsel = evsel__new(&attr);
 	if (evsel) {
 		open_return = perf_evsel__open(evsel, NULL, tmap);
 		ret = open_return >= 0;
