Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F38DA03DF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 15:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfH1N5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 09:57:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55418 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbfH1N5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:57:44 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CC8A42BE94;
        Wed, 28 Aug 2019 13:57:43 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 912981001B00;
        Wed, 28 Aug 2019 13:57:41 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 11/23] libperf: Add PERF_RECORD_AUX 'struct aux_event' to perf/event.h
Date:   Wed, 28 Aug 2019 15:57:05 +0200
Message-Id: <20190828135717.7245-12-jolsa@kernel.org>
In-Reply-To: <20190828135717.7245-1-jolsa@kernel.org>
References: <20190828135717.7245-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 28 Aug 2019 13:57:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the PERF_RECORD_AUX event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8'
types used events to their generic '__u*' versions.

Link: http://lkml.kernel.org/n/tip-u8n9stb8xl6hq0qoqjegoiyi@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/include/perf/event.h | 7 +++++++
 tools/perf/util/event.c             | 2 +-
 tools/perf/util/event.h             | 7 -------
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 6292b7c41bac..d453ac833a58 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -234,4 +234,11 @@ struct auxtrace_error_event {
 	char			 msg[MAX_AUXTRACE_ERROR_MSG];
 };
 
+struct aux_event {
+	struct perf_event_header header;
+	__u64			 aux_offset;
+	__u64			 aux_size;
+	__u64			 flags;
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 33616ea62a47..85f9f27782b1 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1448,7 +1448,7 @@ int perf_event__process_exit(struct perf_tool *tool __maybe_unused,
 
 size_t perf_event__fprintf_aux(union perf_event *event, FILE *fp)
 {
-	return fprintf(fp, " offset: %#"PRIx64" size: %#"PRIx64" flags: %#"PRIx64" [%s%s%s]\n",
+	return fprintf(fp, " offset: %#"PRI_lx64" size: %#"PRI_lx64" flags: %#"PRI_lx64" [%s%s%s]\n",
 		       event->aux.aux_offset, event->aux.aux_size,
 		       event->aux.flags,
 		       event->aux.flags & PERF_AUX_FLAG_TRUNCATED ? "T" : "",
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index e334ecbe50a0..db901aea33af 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -332,13 +332,6 @@ struct events_stats {
 	u32 nr_proc_map_timeout;
 };
 
-struct aux_event {
-	struct perf_event_header header;
-	u64	aux_offset;
-	u64	aux_size;
-	u64	flags;
-};
-
 struct itrace_start_event {
 	struct perf_event_header header;
 	u32 pid, tid;
-- 
2.21.0

