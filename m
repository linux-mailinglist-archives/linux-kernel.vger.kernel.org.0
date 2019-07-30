Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B625F79F32
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 05:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732426AbfG3DAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 23:00:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:49828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732409AbfG3DAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 23:00:30 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63B68217D4;
        Tue, 30 Jul 2019 03:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455629;
        bh=FVt0dzUs4KRZqn7FH8ICPLEJDBPf5B871CtTmPo8UgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0wFmhUQU72fRJXNv629yCQy3NZzA/KAer66eUSWOHpbcAyTrhs0+MBujCs4crC7OD
         bowTygdP9C+Ixpwb4JNetAc1ZPDJzViQ/If253qvJVVgSRE+QisVga1qHH3mYvIzZB
         vluu89EnHRwN0Wx2rK09sBnXfqCyeT18fSORaCFY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 074/107] libperf: Add perf_evlist__for_each_evsel() iterator
Date:   Mon, 29 Jul 2019 23:55:37 -0300
Message-Id: <20190730025610.22603-75-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add a perf_evlist__for_each_evsel() macro to iterate perf_evsel objects
in evlist.

Introduce the perf_evlist__next() function to do that without exposing
'struct perf_evlist' internals.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-48-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evlist.c              | 20 ++++++++++++++++++++
 tools/perf/lib/include/perf/evlist.h |  7 +++++++
 tools/perf/lib/libperf.map           |  1 +
 3 files changed, 28 insertions(+)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 0517deb4cb1c..979ee423490f 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -34,3 +34,23 @@ struct perf_evlist *perf_evlist__new(void)
 
 	return evlist;
 }
+
+struct perf_evsel *
+perf_evlist__next(struct perf_evlist *evlist, struct perf_evsel *prev)
+{
+	struct perf_evsel *next;
+
+	if (!prev) {
+		next = list_first_entry(&evlist->entries,
+					struct perf_evsel,
+					node);
+	} else {
+		next = list_next_entry(prev, node);
+	}
+
+	/* Empty list is noticed here so don't need checking on entry. */
+	if (&next->node == &evlist->entries)
+		return NULL;
+
+	return next;
+}
diff --git a/tools/perf/lib/include/perf/evlist.h b/tools/perf/lib/include/perf/evlist.h
index 7255a60869a1..5092b622935b 100644
--- a/tools/perf/lib/include/perf/evlist.h
+++ b/tools/perf/lib/include/perf/evlist.h
@@ -13,5 +13,12 @@ LIBPERF_API void perf_evlist__add(struct perf_evlist *evlist,
 LIBPERF_API void perf_evlist__remove(struct perf_evlist *evlist,
 				     struct perf_evsel *evsel);
 LIBPERF_API struct perf_evlist *perf_evlist__new(void);
+LIBPERF_API struct perf_evsel* perf_evlist__next(struct perf_evlist *evlist,
+						 struct perf_evsel *evsel);
+
+#define perf_evlist__for_each_evsel(evlist, pos)	\
+	for ((pos) = perf_evlist__next((evlist), NULL);	\
+	     (pos) != NULL;				\
+	     (pos) = perf_evlist__next((evlist), (pos)))
 
 #endif /* __LIBPERF_EVLIST_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index e3eac9b60726..c0968226f7b6 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -17,6 +17,7 @@ LIBPERF_0.0.1 {
 		perf_evlist__init;
 		perf_evlist__add;
 		perf_evlist__remove;
+		perf_evlist__next;
 	local:
 		*;
 };
-- 
2.21.0

