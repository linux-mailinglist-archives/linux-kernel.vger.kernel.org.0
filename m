Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE6111345B3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 16:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbgAHPHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 10:07:00 -0500
Received: from mga09.intel.com ([134.134.136.24]:20675 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728729AbgAHPGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 10:06:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 07:06:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="422942708"
Received: from otc-lr-04.jf.intel.com ([10.54.39.113])
  by fmsmga006.fm.intel.com with ESMTP; 08 Jan 2020 07:06:51 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, alexey.budankov@linux.intel.com,
        vitaly.slobodskoy@intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [RFC PATCH V3 3/7] perf: Supply task information to sched_task()
Date:   Wed,  8 Jan 2020 07:03:05 -0800
Message-Id: <1578495789-95006-3-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578495789-95006-1-git-send-email-kan.liang@linux.intel.com>
References: <1578495789-95006-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

To save/restore LBR call stack data in system-wide mode, the task_struct
information is required.

Extend the parameters of sched_task() to supply task_struct information.

When schedule in, the LBR call stack data for new task will be restored.
When schedule out, the LBR call stack data for old task will be saved.
Only need to pass the required task_struct information.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No changes since V2

 arch/powerpc/perf/core-book3s.c | 8 ++++++--
 arch/x86/events/core.c          | 5 +++--
 arch/x86/events/intel/core.c    | 4 ++--
 arch/x86/events/intel/lbr.c     | 3 ++-
 arch/x86/events/perf_event.h    | 5 +++--
 include/linux/perf_event.h      | 2 +-
 kernel/events/core.c            | 2 +-
 7 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 4860462..99cb809 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -126,7 +126,10 @@ static unsigned long ebb_switch_in(bool ebb, struct cpu_hw_events *cpuhw)
 
 static inline void power_pmu_bhrb_enable(struct perf_event *event) {}
 static inline void power_pmu_bhrb_disable(struct perf_event *event) {}
-static void power_pmu_sched_task(struct perf_event_context *ctx, bool sched_in) {}
+static void power_pmu_sched_task(struct perf_event_context *ctx,
+				 struct task_struct *task, bool sched_in)
+{
+}
 static inline void power_pmu_bhrb_read(struct perf_event *event, struct cpu_hw_events *cpuhw) {}
 static void pmao_restore_workaround(bool ebb) { }
 #endif /* CONFIG_PPC32 */
@@ -403,7 +406,8 @@ static void power_pmu_bhrb_disable(struct perf_event *event)
 /* Called from ctxsw to prevent one process's branch entries to
  * mingle with the other process's entries during context switch.
  */
-static void power_pmu_sched_task(struct perf_event_context *ctx, bool sched_in)
+static void power_pmu_sched_task(struct perf_event_context *ctx,
+				 struct task_struct *task, bool sched_in)
 {
 	if (!ppmu->bhrb_nr)
 		return;
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 6e3f0c1..3874a2d 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2237,10 +2237,11 @@ static const struct attribute_group *x86_pmu_attr_groups[] = {
 	NULL,
 };
 
-static void x86_pmu_sched_task(struct perf_event_context *ctx, bool sched_in)
+static void x86_pmu_sched_task(struct perf_event_context *ctx,
+			       struct task_struct *task, bool sched_in)
 {
 	if (x86_pmu.sched_task)
-		x86_pmu.sched_task(ctx, sched_in);
+		x86_pmu.sched_task(ctx, task, sched_in);
 }
 
 static void x86_pmu_swap_task_ctx(struct perf_event_context *prev,
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index dc64b16..439306b 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3814,10 +3814,10 @@ static void intel_pmu_cpu_dead(int cpu)
 }
 
 static void intel_pmu_sched_task(struct perf_event_context *ctx,
-				 bool sched_in)
+				 struct task_struct *task, bool sched_in)
 {
 	intel_pmu_pebs_sched_task(ctx, sched_in);
-	intel_pmu_lbr_sched_task(ctx, sched_in);
+	intel_pmu_lbr_sched_task(ctx, task, sched_in);
 }
 
 static void intel_pmu_swap_task_ctx(struct perf_event_context *prev,
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 534c7660..dbf31f9 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -440,7 +440,8 @@ void intel_pmu_lbr_swap_task_ctx(struct perf_event_context *prev,
 	     next_ctx_data->lbr_callstack_users);
 }
 
-void intel_pmu_lbr_sched_task(struct perf_event_context *ctx, bool sched_in)
+void intel_pmu_lbr_sched_task(struct perf_event_context *ctx,
+			      struct task_struct *task, bool sched_in)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct x86_perf_task_context *task_ctx;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 930611d..55c4812 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -639,7 +639,7 @@ struct x86_pmu {
 
 	void		(*check_microcode)(void);
 	void		(*sched_task)(struct perf_event_context *ctx,
-				      bool sched_in);
+				      struct task_struct *task, bool sched_in);
 
 	/*
 	 * Intel Arch Perfmon v2+
@@ -1027,7 +1027,8 @@ void intel_ds_init(void);
 void intel_pmu_lbr_swap_task_ctx(struct perf_event_context *prev,
 				 struct perf_event_context *next);
 
-void intel_pmu_lbr_sched_task(struct perf_event_context *ctx, bool sched_in);
+void intel_pmu_lbr_sched_task(struct perf_event_context *ctx,
+			      struct task_struct *task, bool sched_in);
 
 u64 lbr_from_signext_quirk_wr(u64 val);
 
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d8b871f..f271595 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -406,7 +406,7 @@ struct pmu {
 	 * context-switches callback
 	 */
 	void (*sched_task)		(struct perf_event_context *ctx,
-					bool sched_in);
+					 struct task_struct *task, bool sched_in);
 	/*
 	 * PMU specific data size
 	 */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 27f5f94..1835d9b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3365,7 +3365,7 @@ static void perf_pmu_sched_task(struct task_struct *prev,
 		perf_ctx_lock(cpuctx, cpuctx->task_ctx);
 		perf_pmu_disable(pmu);
 
-		pmu->sched_task(cpuctx->task_ctx, sched_in);
+		pmu->sched_task(cpuctx->task_ctx, sched_in ? next : prev, sched_in);
 
 		perf_pmu_enable(pmu);
 		perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
-- 
2.7.4

