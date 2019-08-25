Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF96F9C56D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2019 20:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbfHYSSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Aug 2019 14:18:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50822 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728865AbfHYSSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 14:18:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 37863308AA11;
        Sun, 25 Aug 2019 18:18:01 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-45.brq.redhat.com [10.40.204.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF8485D9C3;
        Sun, 25 Aug 2019 18:17:58 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 02/12] libperf: Add mmap2_event to perf/event.h
Date:   Sun, 25 Aug 2019 20:17:42 +0200
Message-Id: <20190825181752.722-3-jolsa@kernel.org>
In-Reply-To: <20190825181752.722-1-jolsa@kernel.org>
References: <20190825181752.722-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Sun, 25 Aug 2019 18:18:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving mmap2_event event definition into libperf's event.h
header include.

In order to keep libperf simple, we switch 'u64/u32/u16/u8'
types used events to their generic '__u*' versions.

Perf added 'u*' types mainly to ease up printing __u64 values
as stated in the linux/types.h comment:

  /*
   * We define u64 as uint64_t for every architecture
   * so that we can print it with "%"PRIx64 without getting warnings.
   *
   * typedef __u64 u64;
   * typedef __s64 s64;
   */

Adding and using new PRI_lu64 and PRI_lx64 macros to be used for
that.  Using extra '_' to ease up the reading and differentiate
them from standard PRI*64 macros.

Link: http://lkml.kernel.org/n/tip-k8me7k7oc0h97oht07yr24sg@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/include/perf/event.h | 15 +++++++++++++++
 tools/perf/util/event.c             |  6 +++---
 tools/perf/util/event.h             | 15 ---------------
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 8eeba16e3ff7..f1f5b0787782 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -15,4 +15,19 @@ struct mmap_event {
 	char filename[PATH_MAX];
 };
 
+struct mmap2_event {
+	struct perf_event_header header;
+	__u32 pid, tid;
+	__u64 start;
+	__u64 len;
+	__u64 pgoff;
+	__u32 maj;
+	__u32 min;
+	__u64 ino;
+	__u64 ino_generation;
+	__u32 prot;
+	__u32 flags;
+	char filename[PATH_MAX];
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 43c86257e7fa..0954f980574f 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -387,7 +387,7 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 		strcpy(execname, "");
 
 		/* 00400000-0040c000 r-xp 00000000 fd:01 41038  /bin/cat */
-		n = sscanf(bf, "%"PRIx64"-%"PRIx64" %s %"PRIx64" %x:%x %u %[^\n]\n",
+		n = sscanf(bf, "%"PRI_lx64"-%"PRI_lx64" %s %"PRI_lx64" %x:%x %u %[^\n]\n",
 		       &event->mmap2.start, &event->mmap2.len, prot,
 		       &event->mmap2.pgoff, &event->mmap2.maj,
 		       &event->mmap2.min,
@@ -1362,8 +1362,8 @@ size_t perf_event__fprintf_mmap(union perf_event *event, FILE *fp)
 
 size_t perf_event__fprintf_mmap2(union perf_event *event, FILE *fp)
 {
-	return fprintf(fp, " %d/%d: [%#" PRIx64 "(%#" PRIx64 ") @ %#" PRIx64
-			   " %02x:%02x %"PRIu64" %"PRIu64"]: %c%c%c%c %s\n",
+	return fprintf(fp, " %d/%d: [%#" PRI_lx64 "(%#" PRI_lx64 ") @ %#" PRI_lx64
+			   " %02x:%02x %"PRI_lu64" %"PRI_lu64"]: %c%c%c%c %s\n",
 		       event->mmap2.pid, event->mmap2.tid, event->mmap2.start,
 		       event->mmap2.len, event->mmap2.pgoff, event->mmap2.maj,
 		       event->mmap2.min, event->mmap2.ino,
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index b244f9e77fa8..fdff9dcd7c2b 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -16,21 +16,6 @@
 #define PRI_lu64 "l" PRIu64
 #define PRI_lx64 "l" PRIx64
 
-struct mmap2_event {
-	struct perf_event_header header;
-	u32 pid, tid;
-	u64 start;
-	u64 len;
-	u64 pgoff;
-	u32 maj;
-	u32 min;
-	u64 ino;
-	u64 ino_generation;
-	u32 prot;
-	u32 flags;
-	char filename[PATH_MAX];
-};
-
 struct comm_event {
 	struct perf_event_header header;
 	u32 pid, tid;
-- 
2.21.0

