Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42429B20E3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2019 15:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391344AbfIMN2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Sep 2019 09:28:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60614 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391054AbfIMNYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:24:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 640243001571;
        Fri, 13 Sep 2019 13:24:41 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BEB7E5C1D4;
        Fri, 13 Sep 2019 13:24:39 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 17/73] libperf: Add event_copy to struct perf_mmap
Date:   Fri, 13 Sep 2019 15:22:59 +0200
Message-Id: <20190913132355.21634-18-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 13 Sep 2019 13:24:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move event_copy from tools/perf's mmap to libperf's perf_mmap struct.

Link: http://lkml.kernel.org/n/tip-9m9j1xm3xjaa1sogvbva0o8i@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/include/internal/mmap.h | 4 ++++
 tools/perf/util/mmap.c                 | 4 ++--
 tools/perf/util/mmap.h                 | 1 -
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/perf/lib/include/internal/mmap.h
index 631e58dbc9e6..3a404ec06214 100644
--- a/tools/perf/lib/include/internal/mmap.h
+++ b/tools/perf/lib/include/internal/mmap.h
@@ -7,6 +7,9 @@
 #include <stdlib.h>
 #include <stdbool.h>
 
+/* perf sample has 16 bits size limit */
+#define PERF_SAMPLE_MAX_SIZE (1 << 16)
+
 /**
  * struct perf_mmap - perf's ring buffer mmap details
  *
@@ -22,6 +25,7 @@ struct perf_mmap {
 	u64		 start;
 	u64		 end;
 	bool		 overwrite;
+	char		 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
 };
 
 #endif /* __LIBPERF_INTERNAL_MMAP_H */
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index a8850ce2c2ff..4b8ec8dd79c5 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -51,7 +51,7 @@ static union perf_event *perf_mmap__read(struct mmap *map,
 		if ((*startp & map->core.mask) + size != ((*startp + size) & map->core.mask)) {
 			unsigned int offset = *startp;
 			unsigned int len = min(sizeof(*event), size), cpy;
-			void *dst = map->event_copy;
+			void *dst = map->core.event_copy;
 
 			do {
 				cpy = min(map->core.mask + 1 - (offset & map->core.mask), len);
@@ -61,7 +61,7 @@ static union perf_event *perf_mmap__read(struct mmap *map,
 				len -= cpy;
 			} while (len);
 
-			event = (union perf_event *)map->event_copy;
+			event = (union perf_event *)map->core.event_copy;
 		}
 
 		*startp += size;
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index 1dea2abe1de5..bdbbf48ee906 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -23,7 +23,6 @@ struct aiocb;
 struct mmap {
 	struct perf_mmap	core;
 	struct auxtrace_mmap auxtrace_mmap;
-	char		 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
 #ifdef HAVE_AIO_SUPPORT
 	struct {
 		void		 **data;
-- 
2.21.0

