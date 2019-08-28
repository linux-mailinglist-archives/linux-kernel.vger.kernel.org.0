Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40C7CA03D0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 15:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfH1N53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 09:57:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51048 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbfH1N50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:57:26 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3C39C800DF6;
        Wed, 28 Aug 2019 13:57:26 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9434A1001B00;
        Wed, 28 Aug 2019 13:57:24 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 03/23] libperf: Add PERF_RECORD_EVENT_UPDATE 'struct event_update_event' to perf/event.h
Date:   Wed, 28 Aug 2019 15:56:57 +0200
Message-Id: <20190828135717.7245-4-jolsa@kernel.org>
In-Reply-To: <20190828135717.7245-1-jolsa@kernel.org>
References: <20190828135717.7245-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Wed, 28 Aug 2019 13:57:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the PERF_RECORD_EVENT_UPDATE event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8'
types used events to their generic '__u*' versions.

Link: http://lkml.kernel.org/n/tip-evb1r0gk2usfnby0b9dxlzfs@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/include/perf/event.h | 22 ++++++++++++++++++++++
 tools/perf/util/event.h             | 23 -----------------------
 tools/perf/util/header.c            |  2 +-
 3 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 469be778fdc1..3d99818077d8 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -141,4 +141,26 @@ struct cpu_map_event {
 	struct cpu_map_data	 data;
 };
 
+enum {
+	PERF_EVENT_UPDATE__UNIT  = 0,
+	PERF_EVENT_UPDATE__SCALE = 1,
+	PERF_EVENT_UPDATE__NAME  = 2,
+	PERF_EVENT_UPDATE__CPUS  = 3,
+};
+
+struct event_update_event_cpus {
+	struct cpu_map_data	 cpus;
+};
+
+struct event_update_event_scale {
+	double			 scale;
+};
+
+struct event_update_event {
+	struct perf_event_header header;
+	__u64			 type;
+	__u64			 id;
+	char			 data[];
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 84bf67353635..a579e6b439d6 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -337,29 +337,6 @@ struct events_stats {
 	u32 nr_proc_map_timeout;
 };
 
-enum {
-	PERF_EVENT_UPDATE__UNIT  = 0,
-	PERF_EVENT_UPDATE__SCALE = 1,
-	PERF_EVENT_UPDATE__NAME  = 2,
-	PERF_EVENT_UPDATE__CPUS  = 3,
-};
-
-struct event_update_event_cpus {
-	struct cpu_map_data cpus;
-};
-
-struct event_update_event_scale {
-	double scale;
-};
-
-struct event_update_event {
-	struct perf_event_header header;
-	u64 type;
-	u64 id;
-
-	char data[];
-};
-
 #define MAX_EVENT_NAME 64
 
 struct perf_trace_event_type {
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 1f2965a07bef..cc4998fcf4ee 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3892,7 +3892,7 @@ size_t perf_event__fprintf_event_update(union perf_event *event, FILE *fp)
 	struct perf_cpu_map *map;
 	size_t ret;
 
-	ret = fprintf(fp, "\n... id:    %" PRIu64 "\n", ev->id);
+	ret = fprintf(fp, "\n... id:    %" PRI_lu64 "\n", ev->id);
 
 	switch (ev->type) {
 	case PERF_EVENT_UPDATE__SCALE:
-- 
2.21.0

