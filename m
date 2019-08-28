Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45D0CA03D6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 15:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfH1N5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 09:57:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:3918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbfH1N5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:57:38 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EB3E63C93;
        Wed, 28 Aug 2019 13:57:37 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4ED481001B08;
        Wed, 28 Aug 2019 13:57:36 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 09/23] libperf: Add PERF_RECORD_AUXTRACE 'struct auxtrace_event' to perf/event.h
Date:   Wed, 28 Aug 2019 15:57:03 +0200
Message-Id: <20190828135717.7245-10-jolsa@kernel.org>
In-Reply-To: <20190828135717.7245-1-jolsa@kernel.org>
References: <20190828135717.7245-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 28 Aug 2019 13:57:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the PERF_RECORD_AUXTRACE event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8'
types used events to their generic '__u*' versions.

Link: http://lkml.kernel.org/n/tip-wrq43lrq47pqj0vhdqpgyanz@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/include/perf/event.h | 11 +++++++++++
 tools/perf/util/auxtrace.c          |  2 +-
 tools/perf/util/event.h             | 11 -----------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 02da73491451..78001c2973b6 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -208,4 +208,15 @@ struct auxtrace_info_event {
 	__u64			 priv[];
 };
 
+struct auxtrace_event {
+	struct perf_event_header header;
+	__u64			 size;
+	__u64			 offset;
+	__u64			 reference;
+	__u32			 idx;
+	__u32			 tid;
+	__u32			 cpu;
+	__u32			 reserved__; /* For alignment */
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 12e9b7acbb2c..0d2ba1397e47 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -942,7 +942,7 @@ s64 perf_event__process_auxtrace(struct perf_session *session,
 	s64 err;
 
 	if (dump_trace)
-		fprintf(stdout, " size: %#"PRIx64"  offset: %#"PRIx64"  ref: %#"PRIx64"  idx: %u  tid: %d  cpu: %d\n",
+		fprintf(stdout, " size: %#"PRI_lx64"  offset: %#"PRI_lx64"  ref: %#"PRI_lx64"  idx: %u  tid: %d  cpu: %d\n",
 			event->auxtrace.size, event->auxtrace.offset,
 			event->auxtrace.reference, event->auxtrace.idx,
 			event->auxtrace.tid, event->auxtrace.cpu);
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index ca2cae332c43..60895a3b2c85 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -332,17 +332,6 @@ struct events_stats {
 	u32 nr_proc_map_timeout;
 };
 
-struct auxtrace_event {
-	struct perf_event_header header;
-	u64 size;
-	u64 offset;
-	u64 reference;
-	u32 idx;
-	u32 tid;
-	u32 cpu;
-	u32 reserved__; /* For alignment */
-};
-
 #define MAX_AUXTRACE_ERROR_MSG 64
 
 struct auxtrace_error_event {
-- 
2.21.0

