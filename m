Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37238100741
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 15:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfKROVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 09:21:08 -0500
Received: from mga06.intel.com ([134.134.136.31]:37678 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbfKROVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 09:21:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 06:21:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,320,1569308400"; 
   d="scan'208";a="208864284"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 18 Nov 2019 06:21:07 -0800
Received: from [10.252.10.190] (abudanko-mobl.ccr.corp.intel.com [10.252.10.190])
        by linux.intel.com (Postfix) with ESMTP id 2AF935800FE;
        Mon, 18 Nov 2019 06:21:04 -0800 (PST)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v3] perf session: fix decompression of PERF_RECORD_COMPRESSED
 records
Organization: Intel Corp.
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <cf782c34-f3f8-2f9f-d6ab-145cee0d5322@linux.intel.com>
Date:   Mon, 18 Nov 2019 17:21:03 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Avoid termination of trace loading in case the last record in
the decompressed buffer partly resides in the following
mmaped PERF_RECORD_COMPRESSED record. In this case NULL value
returned by fetch_mmaped_event() means to proceed to the next
mmaped record then decompress it and load compressed events.

The issue can be reproduced like this:

  $ perf record -z -- some_long_running_workload
  $ perf report --stdio -vv
  decomp (B): 44519 to 163000
  decomp (B): 48119 to 174800
  decomp (B): 65527 to 131072
  fetch_mmaped_event: head=0x1ffe0 event->header_size=0x28, mmap_size=0x20000: fuzzed perf.data?
  Error:
  failed to process sample
  ...

Testing:

  71: Zstd perf.data compression/decompression              : Ok

  $ tools/perf/perf report -vv --stdio
  decomp (B): 59593 to 262160
  decomp (B): 4438 to 16512
  decomp (B): 285 to 880
  Looking at the vmlinux_path (8 entries long)
  Using vmlinux for symbols
  decomp (B): 57474 to 261248
  prefetch_event: head=0x3fc78 event->header_size=0x28, mmap_size=0x3fc80: fuzzed or compressed perf.data?
  decomp (B): 25 to 32
  decomp (B): 52 to 120
  ...

Fixes: 57fc032ad643 ("perf session: Avoid infinite loop when seeing invalid header.size")
Link: https://marc.info/?l=linux-kernel&m=156580812427554&w=2
Co-developed-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
Changes in v3:
- extended debug message with 'fuzzed or compressed perf.data?'
Changes in v2:
- avoided static declaration of prefetch_event();
- renamed 'ret' to 'error' for returning in case of split compressed 
  or overlapping records;
- passed only needs_swap quality into fetch_*_event() instead of 
  the whole session object;
---
 tools/perf/util/session.c | 44 ++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index f07b8ecb91bc..8454a650146b 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1958,8 +1958,8 @@ static int __perf_session__process_pipe_events(struct perf_session *session)
 }
 
 static union perf_event *
-fetch_mmaped_event(struct perf_session *session,
-		   u64 head, size_t mmap_size, char *buf)
+prefetch_event(char *buf, u64 head, size_t mmap_size,
+	       bool needs_swap, union perf_event *error)
 {
 	union perf_event *event;
 
@@ -1971,20 +1971,32 @@ fetch_mmaped_event(struct perf_session *session,
 		return NULL;
 
 	event = (union perf_event *)(buf + head);
+	if (needs_swap)
+		perf_event_header__bswap(&event->header);
 
-	if (session->header.needs_swap)
+	if (head + event->header.size <= mmap_size)
+		return event;
+
+	/* We're not fetching the event so swap back again */
+	if (needs_swap)
 		perf_event_header__bswap(&event->header);
 
-	if (head + event->header.size > mmap_size) {
-		/* We're not fetching the event so swap back again */
-		if (session->header.needs_swap)
-			perf_event_header__bswap(&event->header);
-		pr_debug("%s: head=%#" PRIx64 " event->header_size=%#x, mmap_size=%#zx: fuzzed perf.data?\n",
-			 __func__, head, event->header.size, mmap_size);
-		return ERR_PTR(-EINVAL);
-	}
+	pr_debug("%s: head=%#" PRIx64 " event->header_size=%#x, mmap_size=%#zx:"
+		 " fuzzed or compressed perf.data?\n",__func__, head, event->header.size, mmap_size);
 
-	return event;
+	return error;
+}
+
+static union perf_event *
+fetch_mmaped_event(u64 head, size_t mmap_size, char *buf, bool needs_swap)
+{
+	return prefetch_event(buf, head, mmap_size, needs_swap, ERR_PTR(-EINVAL));
+}
+
+static union perf_event *
+fetch_decomp_event(u64 head, size_t mmap_size, char *buf, bool needs_swap)
+{
+	return prefetch_event(buf, head, mmap_size, needs_swap, NULL);
 }
 
 static int __perf_session__process_decomp_events(struct perf_session *session)
@@ -1997,10 +2009,8 @@ static int __perf_session__process_decomp_events(struct perf_session *session)
 		return 0;
 
 	while (decomp->head < decomp->size && !session_done()) {
-		union perf_event *event = fetch_mmaped_event(session, decomp->head, decomp->size, decomp->data);
-
-		if (IS_ERR(event))
-			return PTR_ERR(event);
+		union perf_event *event = fetch_decomp_event(decomp->head, decomp->size, decomp->data,
+							     session->header.needs_swap);
 
 		if (!event)
 			break;
@@ -2100,7 +2110,7 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 	}
 
 more:
-	event = fetch_mmaped_event(session, head, mmap_size, buf);
+	event = fetch_mmaped_event(head, mmap_size, buf, session->header.needs_swap);
 	if (IS_ERR(event))
 		return PTR_ERR(event);
 
-- 
2.20.1

