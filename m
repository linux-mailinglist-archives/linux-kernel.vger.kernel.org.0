Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36818E4679
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 11:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408586AbfJYI75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 04:59:57 -0400
Received: from mga17.intel.com ([192.55.52.151]:38719 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405717AbfJYI74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:59:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 01:59:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,228,1569308400"; 
   d="scan'208";a="210337097"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 25 Oct 2019 01:59:56 -0700
Received: from [10.125.252.238] (abudanko-mobl.ccr.corp.intel.com [10.125.252.238])
        by linux.intel.com (Postfix) with ESMTP id 791B458042B;
        Fri, 25 Oct 2019 01:59:53 -0700 (PDT)
Subject: [PATCH v5 3/4] perf/x86/intel: implement LBR callstacks context
 synchronization
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
References: <6fa20503-b5ad-16c7-260e-5243509176bc@linux.intel.com>
Organization: Intel Corp.
Message-ID: <a1384d27-a205-cb00-7cff-bff60a79a671@linux.intel.com>
Date:   Fri, 25 Oct 2019 11:59:52 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <6fa20503-b5ad-16c7-260e-5243509176bc@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Implement intel_pmu_lbr_swap_task_ctx() method updating counters
of the events that requested LBR callstack data on a sample.

The counter can be zero for the case when task context belongs to
a thread that has just come from a block on a futex and the context
contains saved (lbr_stack_state == LBR_VALID) LBR register values.

For the values to be restored at LBR registers on the next thread's
switch-in event it swaps the counter value with the one that is
expected to be non zero at the previous equivalent task perf event
context.

Swap operation type ensures the previous task perf event context
stays consistent with the amount of events that requested LBR
callstack data on a sample.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 arch/x86/events/intel/lbr.c  | 23 +++++++++++++++++++++++
 arch/x86/events/perf_event.h |  3 +++
 2 files changed, 26 insertions(+)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index ea54634eabf3..534c76606049 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -417,6 +417,29 @@ static void __intel_pmu_lbr_save(struct x86_perf_task_context *task_ctx)
 	cpuc->last_log_id = ++task_ctx->log_id;
 }
 
+void intel_pmu_lbr_swap_task_ctx(struct perf_event_context *prev,
+				 struct perf_event_context *next)
+{
+	struct x86_perf_task_context *prev_ctx_data, *next_ctx_data;
+
+	swap(prev->task_ctx_data, next->task_ctx_data);
+
+	/*
+	 * Architecture specific synchronization makes sense in
+	 * case both prev->task_ctx_data and next->task_ctx_data
+	 * pointers are allocated.
+	 */
+
+	prev_ctx_data = next->task_ctx_data;
+	next_ctx_data = prev->task_ctx_data;
+
+	if (!prev_ctx_data || !next_ctx_data)
+		return;
+
+	swap(prev_ctx_data->lbr_callstack_users,
+	     next_ctx_data->lbr_callstack_users);
+}
+
 void intel_pmu_lbr_sched_task(struct perf_event_context *ctx, bool sched_in)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 5384317eaa16..930611db8f9a 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1024,6 +1024,9 @@ void intel_pmu_store_pebs_lbrs(struct pebs_lbr *lbr);
 
 void intel_ds_init(void);
 
+void intel_pmu_lbr_swap_task_ctx(struct perf_event_context *prev,
+				 struct perf_event_context *next);
+
 void intel_pmu_lbr_sched_task(struct perf_event_context *ctx, bool sched_in);
 
 u64 lbr_from_signext_quirk_wr(u64 val);
-- 
2.20.1

