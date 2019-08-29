Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3389AA1D46
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 16:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbfH2Okz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 10:40:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:44708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728729AbfH2Okv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:40:51 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43D7420644;
        Thu, 29 Aug 2019 14:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567089650;
        bh=kp6tltk0B3MKwOG2D1mNYlweK8YYs5VwGncFEUuL9+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pEd4DzmrNpNyaSa3s5Rq/2lJxMiccF85jdxEq/sOYCOmJr7y9ygvRVN7H04yVxIXn
         bfOvA/FAqOSL+B74wm/x5IBsqNdtZisc5hmjxZLzvjratmMFKwkxVGpKgy0uWel1r4
         rVkM9dbHfDN1gi3wR6IZmB/n7u4WWVBxjtDzpCcY=
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
Subject: [PATCH 23/37] libperf: Add PERF_RECORD_ITRACE_START 'struct itrace_start_event' to perf/event.h
Date:   Thu, 29 Aug 2019 11:39:03 -0300
Message-Id: <20190829143917.29745-24-acme@kernel.org>
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

Move the PERF_RECORD_ITRACE_START event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8' types used
events to their generic '__u*' versions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190828135717.7245-13-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 6 ++++++
 tools/perf/util/event.h             | 5 -----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index d453ac833a58..3bcbc1eaeb35 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -241,4 +241,10 @@ struct aux_event {
 	__u64			 flags;
 };
 
+struct itrace_start_event {
+	struct perf_event_header header;
+	__u32			 pid;
+	__u32			 tid;
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index db901aea33af..f89e8ddadd46 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -332,11 +332,6 @@ struct events_stats {
 	u32 nr_proc_map_timeout;
 };
 
-struct itrace_start_event {
-	struct perf_event_header header;
-	u32 pid, tid;
-};
-
 struct context_switch_event {
 	struct perf_event_header header;
 	u32 next_prev_pid;
-- 
2.21.0

