Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 824ACA03E6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 15:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfH1N6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 09:58:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59242 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727086AbfH1N6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:58:10 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E990CA53272;
        Wed, 28 Aug 2019 13:58:09 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 500961001B05;
        Wed, 28 Aug 2019 13:58:08 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 23/23] libperf: Move 'enum perf_user_event_type' to perf/event.h
Date:   Wed, 28 Aug 2019 15:57:17 +0200
Message-Id: <20190828135717.7245-24-jolsa@kernel.org>
In-Reply-To: <20190828135717.7245-1-jolsa@kernel.org>
References: <20190828135717.7245-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Wed, 28 Aug 2019 13:58:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So it's available for libperf's users.

Link: http://lkml.kernel.org/n/tip-oci51ex7bb8gjuqzy9u1801z@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/include/perf/event.h | 23 +++++++++++++++++++++++
 tools/perf/util/event.h             | 23 -----------------------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 1655c744ec2b..18106899cb4e 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -323,6 +323,29 @@ struct perf_record_compressed {
 	char			 data[];
 };
 
+enum perf_user_event_type { /* above any possible kernel type */
+	PERF_RECORD_USER_TYPE_START		= 64,
+	PERF_RECORD_HEADER_ATTR			= 64,
+	PERF_RECORD_HEADER_EVENT_TYPE		= 65, /* deprecated */
+	PERF_RECORD_HEADER_TRACING_DATA		= 66,
+	PERF_RECORD_HEADER_BUILD_ID		= 67,
+	PERF_RECORD_FINISHED_ROUND		= 68,
+	PERF_RECORD_ID_INDEX			= 69,
+	PERF_RECORD_AUXTRACE_INFO		= 70,
+	PERF_RECORD_AUXTRACE			= 71,
+	PERF_RECORD_AUXTRACE_ERROR		= 72,
+	PERF_RECORD_THREAD_MAP			= 73,
+	PERF_RECORD_CPU_MAP			= 74,
+	PERF_RECORD_STAT_CONFIG			= 75,
+	PERF_RECORD_STAT			= 76,
+	PERF_RECORD_STAT_ROUND			= 77,
+	PERF_RECORD_EVENT_UPDATE		= 78,
+	PERF_RECORD_TIME_CONV			= 79,
+	PERF_RECORD_HEADER_FEATURE		= 80,
+	PERF_RECORD_COMPRESSED			= 81,
+	PERF_RECORD_HEADER_MAX
+};
+
 union perf_event {
 	struct perf_event_header		header;
 	struct perf_record_mmap			mmap;
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index a7341e14eb48..4c0c5232bd41 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -146,29 +146,6 @@ struct perf_sample {
 	 PERF_MEM_S(LOCK, NA) |\
 	 PERF_MEM_S(TLB, NA))
 
-enum perf_user_event_type { /* above any possible kernel type */
-	PERF_RECORD_USER_TYPE_START		= 64,
-	PERF_RECORD_HEADER_ATTR			= 64,
-	PERF_RECORD_HEADER_EVENT_TYPE		= 65, /* deprecated */
-	PERF_RECORD_HEADER_TRACING_DATA		= 66,
-	PERF_RECORD_HEADER_BUILD_ID		= 67,
-	PERF_RECORD_FINISHED_ROUND		= 68,
-	PERF_RECORD_ID_INDEX			= 69,
-	PERF_RECORD_AUXTRACE_INFO		= 70,
-	PERF_RECORD_AUXTRACE			= 71,
-	PERF_RECORD_AUXTRACE_ERROR		= 72,
-	PERF_RECORD_THREAD_MAP			= 73,
-	PERF_RECORD_CPU_MAP			= 74,
-	PERF_RECORD_STAT_CONFIG			= 75,
-	PERF_RECORD_STAT			= 76,
-	PERF_RECORD_STAT_ROUND			= 77,
-	PERF_RECORD_EVENT_UPDATE		= 78,
-	PERF_RECORD_TIME_CONV			= 79,
-	PERF_RECORD_HEADER_FEATURE		= 80,
-	PERF_RECORD_COMPRESSED			= 81,
-	PERF_RECORD_HEADER_MAX
-};
-
 enum auxtrace_error_type {
 	PERF_AUXTRACE_ERROR_ITRACE  = 1,
 	PERF_AUXTRACE_ERROR_MAX
-- 
2.21.0

