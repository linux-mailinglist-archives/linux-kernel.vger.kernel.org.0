Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE10F9C576
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2019 20:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbfHYSSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Aug 2019 14:18:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58422 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729014AbfHYSS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 14:18:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EF4085AFE3;
        Sun, 25 Aug 2019 18:18:27 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-45.brq.redhat.com [10.40.204.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 049D55D9C3;
        Sun, 25 Aug 2019 18:18:25 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 12/12] libperf: Add sample_event to perf/event.h
Date:   Sun, 25 Aug 2019 20:17:52 +0200
Message-Id: <20190825181752.722-13-jolsa@kernel.org>
In-Reply-To: <20190825181752.722-1-jolsa@kernel.org>
References: <20190825181752.722-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Sun, 25 Aug 2019 18:18:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving sample_event event definition into libperf's event.h
header include.

In order to keep libperf simple, we switch 'u64/u32/u16/u8'
types used events to their generic '__u*' versions.

Link: http://lkml.kernel.org/n/tip-paajp02emao31m93fcy14dbx@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/include/perf/event.h | 5 +++++
 tools/perf/util/event.h             | 5 -----
 tools/perf/util/evlist.c            | 2 +-
 tools/perf/util/evsel.c             | 8 ++++----
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 74317bcf74bf..daa1924c1d11 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -104,4 +104,9 @@ struct bpf_event {
 	__u8 tag[BPF_TAG_SIZE];  // prog tag
 };
 
+struct sample_event {
+	struct perf_event_header header;
+	__u64 array[];
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index cd1d8d1007dc..37349ddb30f0 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -26,11 +26,6 @@
 /* perf sample has 16 bits size limit */
 #define PERF_SAMPLE_MAX_SIZE (1 << 16)
 
-struct sample_event {
-	struct perf_event_header        header;
-	u64 array[];
-};
-
 struct regs_dump {
 	u64 abi;
 	u64 mask;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index ff415680fe0a..47bc54111f57 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -587,7 +587,7 @@ struct evsel *perf_evlist__id2evsel_strict(struct evlist *evlist,
 static int perf_evlist__event2id(struct evlist *evlist,
 				 union perf_event *event, u64 *id)
 {
-	const u64 *array = event->sample.array;
+	const __u64 *array = event->sample.array;
 	ssize_t n;
 
 	n = (event->header.size - sizeof(event->header)) >> 3;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index e983e721beca..552bc4c839f4 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2008,7 +2008,7 @@ static int perf_evsel__parse_id_sample(const struct evsel *evsel,
 				       struct perf_sample *sample)
 {
 	u64 type = evsel->core.attr.sample_type;
-	const u64 *array = event->sample.array;
+	const __u64 *array = event->sample.array;
 	bool swapped = evsel->needs_swap;
 	union u64_swap u;
 
@@ -2098,7 +2098,7 @@ int perf_evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 {
 	u64 type = evsel->core.attr.sample_type;
 	bool swapped = evsel->needs_swap;
-	const u64 *array;
+	const __u64 *array;
 	u16 max_size = event->header.size;
 	const void *endp = (void *)event + max_size;
 	u64 sz;
@@ -2377,7 +2377,7 @@ int perf_evsel__parse_sample_timestamp(struct evsel *evsel,
 				       u64 *timestamp)
 {
 	u64 type = evsel->core.attr.sample_type;
-	const u64 *array;
+	const __u64 *array;
 
 	if (!(type & PERF_SAMPLE_TIME))
 		return -1;
@@ -2528,7 +2528,7 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type,
 				  u64 read_format,
 				  const struct perf_sample *sample)
 {
-	u64 *array;
+	__u64 *array;
 	size_t sz;
 	/*
 	 * used for cross-endian analysis. See git commit 65014ab3
-- 
2.21.0

