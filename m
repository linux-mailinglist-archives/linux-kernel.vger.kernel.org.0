Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF119D8CEE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 11:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392131AbfJPJv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 05:51:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:10371 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729546AbfJPJv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 05:51:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2019 02:51:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,303,1566889200"; 
   d="scan'208";a="194793393"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 16 Oct 2019 02:51:27 -0700
Received: from [10.125.252.157] (abudanko-mobl.ccr.corp.intel.com [10.125.252.157])
        by linux.intel.com (Postfix) with ESMTP id 283C25803C5;
        Wed, 16 Oct 2019 02:51:24 -0700 (PDT)
Subject: [PATCH v2 4/4] perf/core,x86: synchronize PMU task contexts on
 optimized context switches
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <5964c7e9-ab6f-c0d0-3dca-31196606e337@linux.intel.com>
Organization: Intel Corp.
Message-ID: <86a555af-c757-66bb-fdc9-0ba99c81a4ef@linux.intel.com>
Date:   Wed, 16 Oct 2019 12:51:24 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5964c7e9-ab6f-c0d0-3dca-31196606e337@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Install Intel specific PMU task context synchronization adapter and
extend optimized context switch path with PMU specific task context
synchronization to fix LBR callstack virtualization on context switches.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 arch/x86/events/intel/core.c | 7 +++++++
 kernel/events/core.c         | 9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 43c966d1208e..7cfa658cce4b 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3819,6 +3819,12 @@ static void intel_pmu_sched_task(struct perf_event_context *ctx,
 	intel_pmu_lbr_sched_task(ctx, sched_in);
 }
 
+static void intel_pmu_sync_task_ctx(struct x86_perf_task_context *one,
+				    struct x86_perf_task_context *another)
+{
+	intel_pmu_lbr_sync_task_ctx(one, another);
+}
+
 static int intel_pmu_check_period(struct perf_event *event, u64 value)
 {
 	return intel_pmu_has_bts_period(event, value) ? -EINVAL : 0;
@@ -3954,6 +3960,7 @@ static __initconst const struct x86_pmu intel_pmu = {
 
 	.guest_get_msrs		= intel_guest_get_msrs,
 	.sched_task		= intel_pmu_sched_task,
+	.sync_task_ctx		= intel_pmu_sync_task_ctx,
 
 	.check_period		= intel_pmu_check_period,
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2aad959e6def..3c7edd8454ef 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3204,11 +3204,20 @@ static void perf_event_context_sched_out(struct task_struct *task, int ctxn,
 		raw_spin_lock(&ctx->lock);
 		raw_spin_lock_nested(&next_ctx->lock, SINGLE_DEPTH_NESTING);
 		if (context_equiv(ctx, next_ctx)) {
+			struct pmu *pmu = ctx->pmu;
+
 			WRITE_ONCE(ctx->task, next);
 			WRITE_ONCE(next_ctx->task, task);
 
 			swap(ctx->task_ctx_data, next_ctx->task_ctx_data);
 
+			/*
+			 * PMU specific parts of task perf context may require
+			 * additional synchronization, at least for proper Intel
+			 * LBR callstack data profiling;
+			 */
+			pmu->sync_task_ctx(ctx->task_ctx_data,
+					   next_ctx->task_ctx_data);
 			/*
 			 * RCU_INIT_POINTER here is safe because we've not
 			 * modified the ctx and the above modification of
-- 
2.20.1

