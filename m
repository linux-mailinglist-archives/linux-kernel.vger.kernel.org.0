Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 210F96F2F2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2019 13:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfGULai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jul 2019 07:30:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53084 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbfGULag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:30:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4F298A70E;
        Sun, 21 Jul 2019 11:30:36 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7BD115D9D3;
        Sun, 21 Jul 2019 11:30:32 +0000 (UTC)
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
Subject: [PATCH 46/79] libperf: Add perf_evsel__new function
Date:   Sun, 21 Jul 2019 13:24:33 +0200
Message-Id: <20190721112506.12306-47-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Sun, 21 Jul 2019 11:30:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding perf_evsel__new function to create and init
perf_evsel struct dynamicaly.

Link: http://lkml.kernel.org/n/tip-usi0zxyxmai1ld94nrbum43i@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/evsel.c              | 11 +++++++++++
 tools/perf/lib/include/perf/evsel.h |  1 +
 tools/perf/lib/libperf.map          |  1 +
 3 files changed, 13 insertions(+)

diff --git a/tools/perf/lib/evsel.c b/tools/perf/lib/evsel.c
index 17cba35becc7..8e91738c5c38 100644
--- a/tools/perf/lib/evsel.c
+++ b/tools/perf/lib/evsel.c
@@ -2,9 +2,20 @@
 #include <perf/evsel.h>
 #include <linux/list.h>
 #include <internal/evsel.h>
+#include <linux/zalloc.h>
 
 void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr)
 {
 	INIT_LIST_HEAD(&evsel->node);
 	evsel->attr = *attr;
 }
+
+struct perf_evsel *perf_evsel__new(struct perf_event_attr *attr)
+{
+	struct perf_evsel *evsel = zalloc(sizeof(*evsel));
+
+	if (evsel != NULL)
+		perf_evsel__init(evsel, attr);
+
+	return evsel;
+}
diff --git a/tools/perf/lib/include/perf/evsel.h b/tools/perf/lib/include/perf/evsel.h
index 1e6000b02819..ab0b6ee2d0a6 100644
--- a/tools/perf/lib/include/perf/evsel.h
+++ b/tools/perf/lib/include/perf/evsel.h
@@ -9,5 +9,6 @@ struct perf_evsel;
 
 LIBPERF_API void perf_evsel__init(struct perf_evsel *evsel,
 				  struct perf_event_attr *attr);
+LIBPERF_API struct perf_evsel *perf_evsel__new(struct perf_event_attr *attr);
 
 #endif /* __LIBPERF_EVSEL_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index 5e685d6c7a95..e3eac9b60726 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -11,6 +11,7 @@ LIBPERF_0.0.1 {
 		perf_thread_map__comm;
 		perf_thread_map__get;
 		perf_thread_map__put;
+		perf_evsel__new;
 		perf_evsel__init;
 		perf_evlist__new;
 		perf_evlist__init;
-- 
2.21.0

