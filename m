Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72033A1D4B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 16:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbfH2OlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 10:41:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:45008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728811AbfH2OlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:41:06 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C4EC23429;
        Thu, 29 Aug 2019 14:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567089666;
        bh=yH8drg+za+l1b0kxyJe5KjQEg2mXA2s2s/c9Z46Qi6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S4IM2c6ekmD3uwzb9j3YGkg95UjDvm2xU/TipDDS2TPnYKlmpgfRB59ds3SAXYDOM
         9ahlwn5wDXpMMuIPzRfNqGgpaYRi35edgvM6l8lkJn5obj0bCneLLV6ll09lc23l2o
         8Ra78d97ExKDv0Yt4OhUNQxn7g3YFdmcRn2sIx6g=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 28/37] libperf: Add PERF_RECORD_STAT_ROUND 'struct stat_round_event' to perf/event.h
Date:   Thu, 29 Aug 2019 11:39:08 -0300
Message-Id: <20190829143917.29745-29-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190829143917.29745-1-acme@kernel.org>
References: <20190829143917.29745-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move the PERF_RECORD_STAT_ROUND event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8' types used
events to their generic '__u*' versions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190828135717.7245-18-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 6 ++++++
 tools/perf/util/event.h             | 6 ------
 tools/perf/util/stat.c              | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 7d1834f558d6..34d365bd2c5c 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -299,4 +299,10 @@ struct stat_event {
 	};
 };
 
+struct stat_round_event {
+	struct perf_event_header header;
+	__u64			 type;
+	__u64			 time;
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index f3a02e01852a..ec76412afba1 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -337,12 +337,6 @@ enum {
 	PERF_STAT_ROUND_TYPE__FINAL	= 1,
 };
 
-struct stat_round_event {
-	struct perf_event_header	header;
-	u64				type;
-	u64				time;
-};
-
 struct time_conv_event {
 	struct perf_event_header header;
 	u64 time_shift;
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index c0cd9f9bb0ea..4c7957496e7c 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -418,7 +418,7 @@ size_t perf_event__fprintf_stat_round(union perf_event *event, FILE *fp)
 	struct stat_round_event *rd = (struct stat_round_event *)event;
 	size_t ret;
 
-	ret = fprintf(fp, "\n... time %" PRIu64 ", type %s\n", rd->time,
+	ret = fprintf(fp, "\n... time %" PRI_lu64 ", type %s\n", rd->time,
 		      rd->type == PERF_STAT_ROUND_TYPE__FINAL ? "FINAL" : "INTERVAL");
 
 	return ret;
-- 
2.21.0

