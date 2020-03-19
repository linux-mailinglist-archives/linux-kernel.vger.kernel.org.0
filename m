Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDC318C164
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 21:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbgCSU3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 16:29:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:60498 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727265AbgCSU27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 16:28:59 -0400
IronPort-SDR: 1EYbic2w9UrnnsUy7X1rANwhqIwJSIzvm0qWMuScxLNkArBU/bmVHqs763L09cqOTh0IWCAyQK
 KF/HR+t1sXjA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 13:28:58 -0700
IronPort-SDR: XekZK/9D185OU+ShcZr7ZfztigR20Wyr5tYb26STYI6ZnHZ3NfUdZ6u5PVLYLy7I0/y+gxldKp
 cXuqZ5ODWSQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,572,1574150400"; 
   d="scan'208";a="239031257"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by orsmga008.jf.intel.com with ESMTP; 19 Mar 2020 13:28:58 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, jolsa@redhat.com, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     namhyung@kernel.org, adrian.hunter@intel.com,
        mathieu.poirier@linaro.org, ravi.bangoria@linux.ibm.com,
        alexey.budankov@linux.intel.com, vitaly.slobodskoy@intel.com,
        pavel.gerasimov@intel.com, mpe@ellerman.id.au, eranian@google.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 11/17] perf tools: Save previous cursor nodes for LBR stitching approach
Date:   Thu, 19 Mar 2020 13:25:11 -0700
Message-Id: <20200319202517.23423-12-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200319202517.23423-1-kan.liang@linux.intel.com>
References: <20200319202517.23423-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The cursor nodes which generates from sample are eventually added into
callchain. To avoid generating cursor nodes from previous samples again,
the previous cursor nodes are also saved for LBR stitching approach.

Some option, e.g. hide-unresolved, may hide some LBRs.
Add a variable 'valid' in struct callchain_cursor_node to indicate this
case. The LBR stitching approach will only append the valid cursor nodes
from previous samples later.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/callchain.h |  3 ++
 tools/perf/util/machine.c   | 77 +++++++++++++++++++++++++++++++++++--
 tools/perf/util/thread.h    |  8 ++++
 3 files changed, 84 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index 706bb7bbe1e1..cb33cd42ff43 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -143,6 +143,9 @@ struct callchain_cursor_node {
 	u64				ip;
 	struct map_symbol		ms;
 	const char			*srcline;
+	/* Indicate valid cursor node for LBR stitch */
+	bool				valid;
+
 	bool				branch;
 	struct branch_flags		branch_flags;
 	u64				branch_from;
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index d91e11bfc8ca..f190265a1f26 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2193,6 +2193,31 @@ static int lbr_callchain_add_kernel_ip(struct thread *thread,
 	return 0;
 }
 
+static void save_lbr_cursor_node(struct thread *thread,
+				 struct callchain_cursor *cursor,
+				 int idx)
+{
+	struct lbr_stitch *lbr_stitch = thread->lbr_stitch;
+
+	if (!lbr_stitch)
+		return;
+
+	if (cursor->pos == cursor->nr) {
+		lbr_stitch->prev_lbr_cursor[idx].valid = false;
+		return;
+	}
+
+	if (!cursor->curr)
+		cursor->curr = cursor->first;
+	else
+		cursor->curr = cursor->curr->next;
+	memcpy(&lbr_stitch->prev_lbr_cursor[idx], cursor->curr,
+	       sizeof(struct callchain_cursor_node));
+
+	lbr_stitch->prev_lbr_cursor[idx].valid = true;
+	cursor->pos++;
+}
+
 static int lbr_callchain_add_lbr_ip(struct thread *thread,
 				    struct callchain_cursor *cursor,
 				    struct perf_sample *sample,
@@ -2209,6 +2234,21 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 	int err, i;
 	u64 ip;
 
+	/*
+	 * The curr and pos are not used in writing session. They are cleared
+	 * in callchain_cursor_commit() when the writing session is closed.
+	 * Using curr and pos to track the current cursor node.
+	 */
+	if (thread->lbr_stitch) {
+		cursor->curr = NULL;
+		cursor->pos = cursor->nr;
+		if (cursor->nr) {
+			cursor->curr = cursor->first;
+			for (i = 0; i < (int)(cursor->nr - 1); i++)
+				cursor->curr = cursor->curr->next;
+		}
+	}
+
 	if (callee) {
 		/* Add LBR ip from first entries.to */
 		ip = entries[0].to;
@@ -2221,6 +2261,20 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 		if (err)
 			return err;
 
+		/*
+		 * The number of cursor node increases.
+		 * Move the current cursor node.
+		 * But does not need to save current cursor node for entry 0.
+		 * It's impossible to stitch the whole LBRs of previous sample.
+		 */
+		if (thread->lbr_stitch && (cursor->pos != cursor->nr)) {
+			if (!cursor->curr)
+				cursor->curr = cursor->first;
+			else
+				cursor->curr = cursor->curr->next;
+			cursor->pos++;
+		}
+
 		/* Add LBR ip from entries.from one by one. */
 		for (i = 0; i < lbr_nr; i++) {
 			ip = entries[i].from;
@@ -2231,6 +2285,7 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 					       *branch_from);
 			if (err)
 				return err;
+			save_lbr_cursor_node(thread, cursor, i);
 		}
 		return 0;
 	}
@@ -2245,6 +2300,7 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 				       *branch_from);
 		if (err)
 			return err;
+		save_lbr_cursor_node(thread, cursor, i);
 	}
 
 	/* Add LBR ip from first entries.to */
@@ -2261,7 +2317,7 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 	return 0;
 }
 
-static bool alloc_lbr_stitch(struct thread *thread)
+static bool alloc_lbr_stitch(struct thread *thread, unsigned int max_lbr)
 {
 	if (thread->lbr_stitch)
 		return true;
@@ -2270,6 +2326,15 @@ static bool alloc_lbr_stitch(struct thread *thread)
 	if (!thread->lbr_stitch)
 		goto err;
 
+	thread->lbr_stitch->prev_lbr_cursor = calloc(max_lbr + 1, sizeof(struct callchain_cursor_node));
+	if (!thread->lbr_stitch->prev_lbr_cursor)
+		goto free_lbr_stitch;
+
+	return true;
+
+free_lbr_stitch:
+	free(thread->lbr_stitch);
+	thread->lbr_stitch = NULL;
 err:
 	pr_warning("Failed to allocate space for stitched LBRs. Disable LBR stitch\n");
 	thread->lbr_stitch_enable = false;
@@ -2288,7 +2353,8 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 					struct perf_sample *sample,
 					struct symbol **parent,
 					struct addr_location *root_al,
-					int max_stack)
+					int max_stack,
+					unsigned int max_lbr)
 {
 	struct ip_callchain *chain = sample->callchain;
 	int chain_nr = min(max_stack, (int)chain->nr), i;
@@ -2306,7 +2372,7 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 		return 0;
 
 	if (thread->lbr_stitch_enable && !sample->no_hw_idx &&
-	    alloc_lbr_stitch(thread)) {
+	    (max_lbr > 0) && alloc_lbr_stitch(thread, max_lbr)) {
 		lbr_stitch = thread->lbr_stitch;
 
 		memcpy(&lbr_stitch->prev_sample, sample, sizeof(*sample));
@@ -2386,8 +2452,11 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 		chain_nr = chain->nr;
 
 	if (perf_evsel__has_branch_callstack(evsel)) {
+		struct perf_env *env = perf_evsel__env(evsel);
+
 		err = resolve_lbr_callchain_sample(thread, cursor, sample, parent,
-						   root_al, max_stack);
+						   root_al, max_stack,
+						   !env ? 0 : env->max_branches);
 		if (err)
 			return (err < 0) ? err : 0;
 	}
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index f65a84a25f93..477c669cdbfa 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -14,6 +14,7 @@
 #include <intlist.h>
 #include "rwsem.h"
 #include "event.h"
+#include "callchain.h"
 
 struct addr_location;
 struct map;
@@ -23,6 +24,7 @@ struct unwind_libunwind_ops;
 
 struct lbr_stitch {
 	struct perf_sample		prev_sample;
+	struct callchain_cursor_node	*prev_lbr_cursor;
 };
 
 struct thread {
@@ -153,6 +155,12 @@ static inline bool thread__is_filtered(struct thread *thread)
 
 static inline void thread__free_stitch_list(struct thread *thread)
 {
+	struct lbr_stitch *lbr_stitch = thread->lbr_stitch;
+
+	if (!lbr_stitch)
+		return;
+
+	free(lbr_stitch->prev_lbr_cursor);
 	free(thread->lbr_stitch);
 }
 
-- 
2.17.1

