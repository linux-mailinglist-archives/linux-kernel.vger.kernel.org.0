Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 256B21345B2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 16:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbgAHPG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 10:06:58 -0500
Received: from mga09.intel.com ([134.134.136.24]:20675 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728756AbgAHPGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 10:06:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 07:06:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="422942726"
Received: from otc-lr-04.jf.intel.com ([10.54.39.113])
  by fmsmga006.fm.intel.com with ESMTP; 08 Jan 2020 07:06:52 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, alexey.budankov@linux.intel.com,
        vitaly.slobodskoy@intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [RFC PATCH V3 4/7] perf/x86/lbr: Fix shorter LBRs call stacks for system-wide mode
Date:   Wed,  8 Jan 2020 07:03:06 -0800
Message-Id: <1578495789-95006-4-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578495789-95006-1-git-send-email-kan.liang@linux.intel.com>
References: <1578495789-95006-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

In system-wide mode, LBR callstacks are shorter in comparison to
per-process mode.

LBR MSRs are reset during context switch in system-wide mode. For LBR
call stack, the LBRs should be always saved/restored during context
switch.

Use the space in task_struct to save/restore the LBR call stack data.

For system-wide event, it's unnecessagy to update the
lbr_callstack_users for each threads. Add a variable in x86_pmu to
indicate if the system-wide event is active.

Fixes: 76cb2c617f12 ("perf/x86/intel: Save/restore LBR stack during context switch")
Reported-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Debugged-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No changes since V2

 arch/x86/events/intel/lbr.c  | 57 ++++++++++++++++++++++++++++++++++----------
 arch/x86/events/perf_event.h |  1 +
 2 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index dbf31f9..855628a 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -337,6 +337,12 @@ static inline u64 rdlbr_to(unsigned int idx)
 	return val;
 }
 
+static bool has_lbr_callstack_users(struct x86_perf_task_context *task_ctx)
+{
+	return task_ctx->lbr_callstack_users ||
+	       x86_pmu.lbr_callstack_users;
+}
+
 static void __intel_pmu_lbr_restore(struct x86_perf_task_context *task_ctx)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -344,7 +350,7 @@ static void __intel_pmu_lbr_restore(struct x86_perf_task_context *task_ctx)
 	unsigned lbr_idx, mask;
 	u64 tos;
 
-	if (task_ctx->lbr_callstack_users == 0 ||
+	if (!has_lbr_callstack_users(task_ctx) ||
 	    task_ctx->lbr_stack_state == LBR_NONE) {
 		intel_pmu_lbr_reset();
 		return;
@@ -392,7 +398,7 @@ static void __intel_pmu_lbr_save(struct x86_perf_task_context *task_ctx)
 	u64 tos, from;
 	int i;
 
-	if (task_ctx->lbr_callstack_users == 0) {
+	if (!has_lbr_callstack_users(task_ctx)) {
 		task_ctx->lbr_stack_state = LBR_NONE;
 		return;
 	}
@@ -445,6 +451,7 @@ void intel_pmu_lbr_sched_task(struct perf_event_context *ctx,
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct x86_perf_task_context *task_ctx;
+	struct perf_ctx_data *ctx_data;
 
 	if (!cpuc->lbr_users)
 		return;
@@ -454,15 +461,18 @@ void intel_pmu_lbr_sched_task(struct perf_event_context *ctx,
 	 * the task was scheduled out, restore the stack. Otherwise flush
 	 * the LBR stack.
 	 */
-	task_ctx = ctx ? ctx->task_ctx_data : NULL;
+	rcu_read_lock();
+	ctx_data = rcu_dereference(task->perf_ctx_data);
+	task_ctx = ctx_data ? (struct x86_perf_task_context *) ctx_data->data : NULL;
 	if (task_ctx) {
 		if (sched_in)
 			__intel_pmu_lbr_restore(task_ctx);
 		else
 			__intel_pmu_lbr_save(task_ctx);
+		rcu_read_unlock();
 		return;
 	}
-
+	rcu_read_unlock();
 	/*
 	 * Since a context switch can flip the address space and LBR entries
 	 * are not tagged with an identifier, we need to wipe the LBR, even for
@@ -481,16 +491,27 @@ static inline bool branch_user_callstack(unsigned br_sel)
 void intel_pmu_lbr_add(struct perf_event *event)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	struct x86_perf_task_context *task_ctx;
 
 	if (!x86_pmu.lbr_nr)
 		return;
 
 	cpuc->br_sel = event->hw.branch_reg.reg;
 
-	if (branch_user_callstack(cpuc->br_sel) && event->ctx->task_ctx_data) {
-		task_ctx = event->ctx->task_ctx_data;
-		task_ctx->lbr_callstack_users++;
+	if (branch_user_callstack(cpuc->br_sel)) {
+		if (event->attach_state & PERF_ATTACH_TASK) {
+			struct x86_perf_task_context *task_ctx;
+			struct task_struct *task = event->hw.target;
+			struct perf_ctx_data *ctx_data;
+
+			rcu_read_lock();
+			ctx_data = rcu_dereference(task->perf_ctx_data);
+			if (ctx_data) {
+				task_ctx = (struct x86_perf_task_context *)ctx_data->data;
+				task_ctx->lbr_callstack_users++;
+			}
+			rcu_read_unlock();
+		} else
+			x86_pmu.lbr_callstack_users++;
 	}
 
 	/*
@@ -522,15 +543,25 @@ void intel_pmu_lbr_add(struct perf_event *event)
 void intel_pmu_lbr_del(struct perf_event *event)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	struct x86_perf_task_context *task_ctx;
 
 	if (!x86_pmu.lbr_nr)
 		return;
 
-	if (branch_user_callstack(cpuc->br_sel) &&
-	    event->ctx->task_ctx_data) {
-		task_ctx = event->ctx->task_ctx_data;
-		task_ctx->lbr_callstack_users--;
+	if (branch_user_callstack(cpuc->br_sel)) {
+		if (event->attach_state & PERF_ATTACH_TASK) {
+			struct task_struct *task = event->hw.target;
+			struct x86_perf_task_context *task_ctx;
+			struct perf_ctx_data *ctx_data;
+
+			rcu_read_lock();
+			ctx_data = rcu_dereference(task->perf_ctx_data);
+			if (ctx_data) {
+				task_ctx = (struct x86_perf_task_context *)ctx_data->data;
+				task_ctx->lbr_callstack_users--;
+			}
+			rcu_read_unlock();
+		} else
+			x86_pmu.lbr_callstack_users--;
 	}
 
 	if (x86_pmu.intel_cap.pebs_baseline && event->attr.precise_ip > 0)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 55c4812..b8b7280 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -674,6 +674,7 @@ struct x86_pmu {
 	int		lbr_nr;			   /* hardware stack size */
 	u64		lbr_sel_mask;		   /* LBR_SELECT valid bits */
 	const int	*lbr_sel_map;		   /* lbr_select mappings */
+	u64		lbr_callstack_users;	   /* lbr callstack system wide users */
 	bool		lbr_double_abort;	   /* duplicated lbr aborts */
 	bool		lbr_pt_coexist;		   /* (LBR|BTS) may coexist with PT */
 
-- 
2.7.4

