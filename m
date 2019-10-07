Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7E0CEB5E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 20:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbfJGSAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 14:00:19 -0400
Received: from mga11.intel.com ([192.55.52.93]:33637 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729403AbfJGSAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 14:00:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 10:59:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,269,1566889200"; 
   d="scan'208";a="193161285"
Received: from unknown (HELO labuser-Ice-Lake-Client-Platform.jf.intel.com) ([10.54.55.65])
  by fmsmga007.fm.intel.com with ESMTP; 07 Oct 2019 10:59:59 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jolsa@kernel.org, namhyung@kernel.org, ak@linux.intel.com,
        vitaly.slobodskoy@intel.com, pavel.gerasimov@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 05/10] perf machine: Refine the function for LBR call stack reconstruction
Date:   Mon,  7 Oct 2019 10:59:05 -0700
Message-Id: <20191007175910.2805-6-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191007175910.2805-1-kan.liang@linux.intel.com>
References: <20191007175910.2805-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

LBR only collect the user call stack. To reconstruct a call stack, both
kernel call stack and user call stack are required. The function
resolve_lbr_callchain_sample() mix the kernel call stack and user
call stack. Now, with the help of TOS, perf tool can reconstruct a more
complete call stack by adding some user call stack from previous sample.
However, current implementation is hard to be extended to support it.

Abstract two new functions to resolve user call stack and kernel
call stack respectively.

No functional changes.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/machine.c | 186 ++++++++++++++++++++++++--------------
 1 file changed, 119 insertions(+), 67 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 70a9f8716a4b..e3e516e30093 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2183,6 +2183,96 @@ static int remove_loops(struct branch_entry *l, int nr,
 	return nr;
 }
 
+
+static int lbr_callchain_add_kernel_ip(struct thread *thread,
+				       struct callchain_cursor *cursor,
+				       struct perf_sample *sample,
+				       struct symbol **parent,
+				       struct addr_location *root_al,
+				       bool callee, int end)
+{
+	struct ip_callchain *chain = sample->callchain;
+	u8 cpumode = PERF_RECORD_MISC_USER;
+	int err, i;
+
+	if (callee) {
+		for (i = 0; i < end + 1; i++) {
+			err = add_callchain_ip(thread, cursor, parent,
+					       root_al, &cpumode, chain->ips[i],
+					       false, NULL, NULL, 0);
+			if (err)
+				return err;
+		}
+	} else {
+		for (i = end; i >= 0; i--) {
+			err = add_callchain_ip(thread, cursor, parent,
+					       root_al, &cpumode, chain->ips[i],
+					       false, NULL, NULL, 0);
+			if (err)
+				return err;
+		}
+	}
+
+	return 0;
+}
+
+static int lbr_callchain_add_lbr_ip(struct thread *thread,
+				    struct callchain_cursor *cursor,
+				    struct perf_sample *sample,
+				    struct symbol **parent,
+				    struct addr_location *root_al,
+				    bool callee)
+{
+	struct branch_stack *lbr_stack = sample->branch_stack;
+	u8 cpumode = PERF_RECORD_MISC_USER;
+	int lbr_nr = lbr_stack->nr;
+	struct branch_flags *flags;
+	u64 ip, branch_from = 0;
+	int err, i;
+
+	if (callee) {
+		ip = lbr_stack->entries[0].to;
+		flags = &lbr_stack->entries[0].flags;
+		branch_from = lbr_stack->entries[0].from;
+		err = add_callchain_ip(thread, cursor, parent,
+				       root_al, &cpumode, ip,
+				       true, flags, NULL, branch_from);
+		if (err)
+			return err;
+
+		for (i = 0; i < lbr_nr; i++) {
+			ip = lbr_stack->entries[i].from;
+			flags = &lbr_stack->entries[i].flags;
+			err = add_callchain_ip(thread, cursor, parent,
+					       root_al, &cpumode, ip,
+					       true, flags, NULL, branch_from);
+			if (err)
+				return err;
+		}
+	} else {
+		for (i = lbr_nr - 1; i >= 0; i--) {
+			ip = lbr_stack->entries[i].from;
+			flags = &lbr_stack->entries[i].flags;
+			err = add_callchain_ip(thread, cursor, parent,
+					       root_al, &cpumode, ip,
+					       true, flags, NULL, branch_from);
+			if (err)
+				return err;
+		}
+
+		ip = lbr_stack->entries[0].to;
+		flags = &lbr_stack->entries[0].flags;
+		branch_from = lbr_stack->entries[0].from;
+		err = add_callchain_ip(thread, cursor, parent,
+				       root_al, &cpumode, ip,
+				       true, flags, NULL, branch_from);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 /*
  * Recolve LBR callstack chain sample
  * Return:
@@ -2198,82 +2288,44 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 					int max_stack)
 {
 	struct ip_callchain *chain = sample->callchain;
-	int chain_nr = min(max_stack, (int)chain->nr), i;
-	u8 cpumode = PERF_RECORD_MISC_USER;
-	u64 ip, branch_from = 0;
+	int chain_nr = min(max_stack, (int)chain->nr);
+	int i, err;
 
 	for (i = 0; i < chain_nr; i++) {
 		if (chain->ips[i] == PERF_CONTEXT_USER)
 			break;
 	}
 
-	/* LBR only affects the user callchain */
-	if (i != chain_nr) {
-		struct branch_stack *lbr_stack = sample->branch_stack;
-		int lbr_nr = lbr_stack->nr, j, k;
-		bool branch;
-		struct branch_flags *flags;
-		/*
-		 * LBR callstack can only get user call chain.
-		 * The mix_chain_nr is kernel call chain
-		 * number plus LBR user call chain number.
-		 * i is kernel call chain number,
-		 * 1 is PERF_CONTEXT_USER,
-		 * lbr_nr + 1 is the user call chain number.
-		 * For details, please refer to the comments
-		 * in callchain__printf
-		 */
-		int mix_chain_nr = i + 1 + lbr_nr + 1;
-
-		for (j = 0; j < mix_chain_nr; j++) {
-			int err;
-			branch = false;
-			flags = NULL;
-
-			if (callchain_param.order == ORDER_CALLEE) {
-				if (j < i + 1)
-					ip = chain->ips[j];
-				else if (j > i + 1) {
-					k = j - i - 2;
-					ip = lbr_stack->entries[k].from;
-					branch = true;
-					flags = &lbr_stack->entries[k].flags;
-				} else {
-					ip = lbr_stack->entries[0].to;
-					branch = true;
-					flags = &lbr_stack->entries[0].flags;
-					branch_from =
-						lbr_stack->entries[0].from;
-				}
-			} else {
-				if (j < lbr_nr) {
-					k = lbr_nr - j - 1;
-					ip = lbr_stack->entries[k].from;
-					branch = true;
-					flags = &lbr_stack->entries[k].flags;
-				}
-				else if (j > lbr_nr)
-					ip = chain->ips[i + 1 - (j - lbr_nr)];
-				else {
-					ip = lbr_stack->entries[0].to;
-					branch = true;
-					flags = &lbr_stack->entries[0].flags;
-					branch_from =
-						lbr_stack->entries[0].from;
-				}
-			}
+	/*
+	 * LBR only affects the user callchain.
+	 * Fall back if there is no user callchain.
+	 */
+	if (i == chain_nr)
+		return 0;
 
-			err = add_callchain_ip(thread, cursor, parent,
-					       root_al, &cpumode, ip,
-					       branch, flags, NULL,
-					       branch_from);
-			if (err)
-				return (err < 0) ? err : 0;
-		}
-		return 1;
+	if (callchain_param.order == ORDER_CALLEE) {
+		err = lbr_callchain_add_kernel_ip(thread, cursor, sample,
+						  parent, root_al, true, i);
+		if (err)
+			goto error;
+		err = lbr_callchain_add_lbr_ip(thread, cursor, sample,
+					       parent, root_al, true);
+		if (err)
+			goto error;
+	} else {
+		err = lbr_callchain_add_lbr_ip(thread, cursor, sample,
+					       parent, root_al, false);
+		if (err)
+			goto error;
+		err = lbr_callchain_add_kernel_ip(thread, cursor, sample,
+						  parent, root_al, false, i);
+		if (err)
+			goto error;
 	}
 
-	return 0;
+	return 1;
+error:
+	return (err < 0) ? err : 0;
 }
 
 static int find_prev_cpumode(struct ip_callchain *chain, struct thread *thread,
-- 
2.17.1

