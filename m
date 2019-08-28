Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA8C3A03D1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 15:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfH1N5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 09:57:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52652 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbfH1N52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:57:28 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 33694308339B;
        Wed, 28 Aug 2019 13:57:28 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8B9D81001B00;
        Wed, 28 Aug 2019 13:57:26 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 04/23] libperf: Add PERF_RECORD_HEADER_EVENT_TYPE 'struct event_type_event' to perf/event.h
Date:   Wed, 28 Aug 2019 15:56:58 +0200
Message-Id: <20190828135717.7245-5-jolsa@kernel.org>
In-Reply-To: <20190828135717.7245-1-jolsa@kernel.org>
References: <20190828135717.7245-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 28 Aug 2019 13:57:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the PERF_RECORD_HEADER_EVENT_TYPE event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8'
types used events to their generic '__u*' versions.

Link: http://lkml.kernel.org/n/tip-1zsyvaupk78y7w42jfrvue1q@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/include/perf/event.h | 12 ++++++++++++
 tools/perf/util/event.h             | 12 ------------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 3d99818077d8..ecd1536a3a0c 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -163,4 +163,16 @@ struct event_update_event {
 	char			 data[];
 };
 
+#define MAX_EVENT_NAME 64
+
+struct perf_trace_event_type {
+	__u64			 event_id;
+	char			 name[MAX_EVENT_NAME];
+};
+
+struct event_type_event {
+	struct perf_event_header	 header;
+	struct perf_trace_event_type	 event_type;
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index a579e6b439d6..00725a1b602b 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -337,18 +337,6 @@ struct events_stats {
 	u32 nr_proc_map_timeout;
 };
 
-#define MAX_EVENT_NAME 64
-
-struct perf_trace_event_type {
-	u64	event_id;
-	char	name[MAX_EVENT_NAME];
-};
-
-struct event_type_event {
-	struct perf_event_header header;
-	struct perf_trace_event_type event_type;
-};
-
 struct tracing_data_event {
 	struct perf_event_header header;
 	u32 size;
-- 
2.21.0

