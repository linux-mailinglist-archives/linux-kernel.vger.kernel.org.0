Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB6F1345B4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 16:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgAHPHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 10:07:02 -0500
Received: from mga09.intel.com ([134.134.136.24]:20675 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728769AbgAHPGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 10:06:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 07:06:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="422942753"
Received: from otc-lr-04.jf.intel.com ([10.54.39.113])
  by fmsmga006.fm.intel.com with ESMTP; 08 Jan 2020 07:06:54 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, alexey.budankov@linux.intel.com,
        vitaly.slobodskoy@intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [RFC PATCH V3 6/7] perf: Clean up pmu specific data
Date:   Wed,  8 Jan 2020 07:03:08 -0800
Message-Id: <1578495789-95006-6-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578495789-95006-1-git-send-email-kan.liang@linux.intel.com>
References: <1578495789-95006-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The pmu specific data is saved in task_struct now. Remove it from event
context structure.

Remove swap_task_ctx() as well.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No changes since V2

 include/linux/perf_event.h | 11 ----------
 kernel/events/core.c       | 53 ++--------------------------------------------
 2 files changed, 2 insertions(+), 62 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index f271595..364b0d0 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -413,16 +413,6 @@ struct pmu {
 	size_t				task_ctx_size;
 
 	/*
-	 * PMU specific parts of task perf event context (i.e. ctx->task_ctx_data)
-	 * can be synchronized using this function. See Intel LBR callstack support
-	 * implementation and Perf core context switch handling callbacks for usage
-	 * examples.
-	 */
-	void (*swap_task_ctx)		(struct perf_event_context *prev,
-					 struct perf_event_context *next);
-					/* optional */
-
-	/*
 	 * Set up pmu-private data structures for an AUX area
 	 */
 	void *(*setup_aux)		(struct perf_event *event, void **pages,
@@ -817,7 +807,6 @@ struct perf_event_context {
 #ifdef CONFIG_CGROUP_PERF
 	int				nr_cgroups;	 /* cgroup evts */
 #endif
-	void				*task_ctx_data; /* pmu specific data */
 	struct rcu_head			rcu_head;
 };
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1835d9b..23db381 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1214,7 +1214,6 @@ static void free_ctx(struct rcu_head *head)
 	struct perf_event_context *ctx;
 
 	ctx = container_of(head, struct perf_event_context, rcu_head);
-	kfree(ctx->task_ctx_data);
 	kfree(ctx);
 }
 
@@ -3272,28 +3271,14 @@ static void perf_event_context_sched_out(struct task_struct *task, int ctxn,
 		raw_spin_lock(&ctx->lock);
 		raw_spin_lock_nested(&next_ctx->lock, SINGLE_DEPTH_NESTING);
 		if (context_equiv(ctx, next_ctx)) {
-			struct pmu *pmu = ctx->pmu;
-
 			WRITE_ONCE(ctx->task, next);
 			WRITE_ONCE(next_ctx->task, task);
 
 			/*
-			 * PMU specific parts of task perf context can require
-			 * additional synchronization. As an example of such
-			 * synchronization see implementation details of Intel
-			 * LBR call stack data profiling;
-			 */
-			if (pmu->swap_task_ctx)
-				pmu->swap_task_ctx(ctx, next_ctx);
-			else
-				swap(ctx->task_ctx_data, next_ctx->task_ctx_data);
-
-			/*
 			 * RCU_INIT_POINTER here is safe because we've not
 			 * modified the ctx and the above modification of
-			 * ctx->task and ctx->task_ctx_data are immaterial
-			 * since those values are always verified under
-			 * ctx->lock which we're now holding.
+			 * ctx->task is immaterial since this value is always
+			 * verified under ctx->lock which we're now holding.
 			 */
 			RCU_INIT_POINTER(task->perf_event_ctxp[ctxn], next_ctx);
 			RCU_INIT_POINTER(next->perf_event_ctxp[ctxn], ctx);
@@ -4301,7 +4286,6 @@ find_get_context(struct pmu *pmu, struct task_struct *task,
 {
 	struct perf_event_context *ctx, *clone_ctx = NULL;
 	struct perf_cpu_context *cpuctx;
-	void *task_ctx_data = NULL;
 	unsigned long flags;
 	int ctxn, err;
 	int cpu = event->cpu;
@@ -4325,24 +4309,12 @@ find_get_context(struct pmu *pmu, struct task_struct *task,
 	if (ctxn < 0)
 		goto errout;
 
-	if (event->attach_state & PERF_ATTACH_TASK_DATA) {
-		task_ctx_data = kzalloc(pmu->task_ctx_size, GFP_KERNEL);
-		if (!task_ctx_data) {
-			err = -ENOMEM;
-			goto errout;
-		}
-	}
-
 retry:
 	ctx = perf_lock_task_context(task, ctxn, &flags);
 	if (ctx) {
 		clone_ctx = unclone_ctx(ctx);
 		++ctx->pin_count;
 
-		if (task_ctx_data && !ctx->task_ctx_data) {
-			ctx->task_ctx_data = task_ctx_data;
-			task_ctx_data = NULL;
-		}
 		raw_spin_unlock_irqrestore(&ctx->lock, flags);
 
 		if (clone_ctx)
@@ -4353,11 +4325,6 @@ find_get_context(struct pmu *pmu, struct task_struct *task,
 		if (!ctx)
 			goto errout;
 
-		if (task_ctx_data) {
-			ctx->task_ctx_data = task_ctx_data;
-			task_ctx_data = NULL;
-		}
-
 		err = 0;
 		mutex_lock(&task->perf_event_mutex);
 		/*
@@ -4384,11 +4351,9 @@ find_get_context(struct pmu *pmu, struct task_struct *task,
 		}
 	}
 
-	kfree(task_ctx_data);
 	return ctx;
 
 errout:
-	kfree(task_ctx_data);
 	return ERR_PTR(err);
 }
 
@@ -12416,19 +12381,6 @@ inherit_event(struct perf_event *parent_event,
 	if (IS_ERR(child_event))
 		return child_event;
 
-
-	if ((child_event->attach_state & PERF_ATTACH_TASK_DATA) &&
-	    !child_ctx->task_ctx_data) {
-		struct pmu *pmu = child_event->pmu;
-
-		child_ctx->task_ctx_data = kzalloc(pmu->task_ctx_size,
-						   GFP_KERNEL);
-		if (!child_ctx->task_ctx_data) {
-			free_event(child_event);
-			return ERR_PTR(-ENOMEM);
-		}
-	}
-
 	/*
 	 * is_orphaned_event() and list_add_tail(&parent_event->child_list)
 	 * must be under the same lock in order to serialize against
@@ -12439,7 +12391,6 @@ inherit_event(struct perf_event *parent_event,
 	if (is_orphaned_event(parent_event) ||
 	    !atomic_long_inc_not_zero(&parent_event->refcount)) {
 		mutex_unlock(&parent_event->child_mutex);
-		/* task_ctx_data is freed with child_ctx */
 		free_event(child_event);
 		return NULL;
 	}
-- 
2.7.4

