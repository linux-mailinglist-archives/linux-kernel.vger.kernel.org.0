Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCBD57B229
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 20:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbfG3SlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 14:41:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41909 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfG3SlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:41:15 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UIf4mv3332337
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:41:04 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UIf4mv3332337
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564512064;
        bh=M7WcuYWozD9cqn2CnsBTqK07EjQNpz71ZURjCKEA+D8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=2lR27eD2GxwbNmig6E7pvJPfDnrlUlBK8YvzrdaGO7nd9dl5vxMNjf/HqBvGDuK++
         iPcJtNYum9IP+zuRIk/Q7Ho8e9Kzf8Yw1gbPNv7WgeuG1vnxGzkDqi+ixi+p7suLOV
         l/oJn3QaJF25yVURH/zPpOi/9HHX3C2Tz/8ar/5n6tHYxSKKNkehJTk/uUPm2wDrDb
         PHYaxOdCm3BmKZbIoiBi9CGIhfBQ03T/u3eYwxxFr8Armus5uBCgp4zb4gRvsRGbaQ
         /2iP6sxMnuumgAMsqqlrfGzxIKsjz6WB89Dmg9XmLaC853PKLRzi23q1dr9c+RJOv4
         kzVm4v9k5qVvQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UIf3D93332334;
        Tue, 30 Jul 2019 11:41:03 -0700
Date:   Tue, 30 Jul 2019 11:41:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-634912d61ccc6bfeebb87716c276fbea20f63bdc@git.kernel.org>
Cc:     mpetlan@redhat.com, acme@redhat.com, peterz@infradead.org,
        ak@linux.intel.com, namhyung@kernel.org, mingo@kernel.org,
        alexey.budankov@linux.intel.com,
        alexander.shishkin@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, tglx@linutronix.de
Reply-To: acme@redhat.com, mpetlan@redhat.com, peterz@infradead.org,
          hpa@zytor.com, alexander.shishkin@linux.intel.com,
          alexey.budankov@linux.intel.com, ak@linux.intel.com,
          namhyung@kernel.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org, jolsa@kernel.org,
          tglx@linutronix.de
In-Reply-To: <20190721112506.12306-46-jolsa@kernel.org>
References: <20190721112506.12306-46-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] libperf: Add perf_evlist__new() function
Git-Commit-ID: 634912d61ccc6bfeebb87716c276fbea20f63bdc
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

Commit-ID:  634912d61ccc6bfeebb87716c276fbea20f63bdc
Gitweb:     https://git.kernel.org/tip/634912d61ccc6bfeebb87716c276fbea20f63bdc
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:32 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:45 -0300

libperf: Add perf_evlist__new() function

Add perf_evlist__new() function to create and init a perf_evlist struct
dynamicaly.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-46-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evlist.c              | 11 +++++++++++
 tools/perf/lib/include/perf/evlist.h |  1 +
 tools/perf/lib/libperf.map           |  1 +
 3 files changed, 13 insertions(+)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 1b27fd2de9b9..0517deb4cb1c 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -3,6 +3,7 @@
 #include <linux/list.h>
 #include <internal/evlist.h>
 #include <internal/evsel.h>
+#include <linux/zalloc.h>
 
 void perf_evlist__init(struct perf_evlist *evlist)
 {
@@ -23,3 +24,13 @@ void perf_evlist__remove(struct perf_evlist *evlist,
 	list_del_init(&evsel->node);
 	evlist->nr_entries -= 1;
 }
+
+struct perf_evlist *perf_evlist__new(void)
+{
+	struct perf_evlist *evlist = zalloc(sizeof(*evlist));
+
+	if (evlist != NULL)
+		perf_evlist__init(evlist);
+
+	return evlist;
+}
diff --git a/tools/perf/lib/include/perf/evlist.h b/tools/perf/lib/include/perf/evlist.h
index e0c87995c6ff..7255a60869a1 100644
--- a/tools/perf/lib/include/perf/evlist.h
+++ b/tools/perf/lib/include/perf/evlist.h
@@ -12,5 +12,6 @@ LIBPERF_API void perf_evlist__add(struct perf_evlist *evlist,
 				  struct perf_evsel *evsel);
 LIBPERF_API void perf_evlist__remove(struct perf_evlist *evlist,
 				     struct perf_evsel *evsel);
+LIBPERF_API struct perf_evlist *perf_evlist__new(void);
 
 #endif /* __LIBPERF_EVLIST_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index e38473a8f32f..5e685d6c7a95 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -12,6 +12,7 @@ LIBPERF_0.0.1 {
 		perf_thread_map__get;
 		perf_thread_map__put;
 		perf_evsel__init;
+		perf_evlist__new;
 		perf_evlist__init;
 		perf_evlist__add;
 		perf_evlist__remove;
