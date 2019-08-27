Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDCCD9DB3E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 03:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbfH0Biq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 21:38:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729041AbfH0Bhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 21:37:40 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38BD022CF5;
        Tue, 27 Aug 2019 01:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566869859;
        bh=ut/Y9o1kdN6hSigVUOUWHNuPyfUvPJhjA8NjivZC2bQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1L3mbJD+H1TiSJ2wMKaEBGaFGvspmHv4NQuiJdqtos03GlnU2+4kMbPGutLwU95G8
         AqadfBuWPD1uZFleI8bNwmrnLVJGfo+QMqLKsKU61UMfcKRbKylOCmTODIf73prE46
         /zRt6QlBPAjdB1sxOqghNQSrPRBav6K6Gji+6FKQ=
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
Subject: [PATCH 19/33] libperf: Add PERF_RECORD_COMM 'struct comm_event' to perf/event.h
Date:   Mon, 26 Aug 2019 22:36:20 -0300
Message-Id: <20190827013634.3173-20-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190827013634.3173-1-acme@kernel.org>
References: <20190827013634.3173-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Moving comm_event event definition into libperf's event.h
header include.

In order to keep libperf simple, we switch 'u64/u32/u16/u8'
types used events to their generic '__u*' versions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190825181752.722-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 6 ++++++
 tools/perf/util/event.h             | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index c82e0c2c004b..3729a7d9253e 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -30,4 +30,10 @@ struct mmap2_event {
 	char			 filename[PATH_MAX];
 };
 
+struct comm_event {
+	struct perf_event_header header;
+	__u32			 pid, tid;
+	char			 comm[16];
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index af252be8ca5b..e8973a783267 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -27,12 +27,6 @@
 #define PRI_lx64 PRIx64
 #endif
 
-struct comm_event {
-	struct perf_event_header header;
-	u32 pid, tid;
-	char comm[16];
-};
-
 struct namespaces_event {
 	struct perf_event_header header;
 	u32 pid, tid;
-- 
2.21.0

