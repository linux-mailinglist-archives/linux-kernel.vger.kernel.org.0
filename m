Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A72ED93D3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 16:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394015AbfJPO1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 10:27:30 -0400
Received: from mga04.intel.com ([192.55.52.120]:27470 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbfJPO1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 10:27:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2019 07:27:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,304,1566889200"; 
   d="scan'208";a="189693348"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 16 Oct 2019 07:27:28 -0700
Received: from [10.125.252.157] (abudanko-mobl.ccr.corp.intel.com [10.125.252.157])
        by linux.intel.com (Postfix) with ESMTP id 6267C580375;
        Wed, 16 Oct 2019 07:27:26 -0700 (PDT)
Subject: [PATCH v3 3/4] perf/x86/intel: implement LBR callstacks context
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
References: <792a98c7-ed89-6c35-f1d7-98ddc9c1a117@linux.intel.com>
Organization: Intel Corp.
Message-ID: <b55b5f1b-bb50-139c-5cec-89fda43e0d4d@linux.intel.com>
Date:   Wed, 16 Oct 2019 17:27:25 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <792a98c7-ed89-6c35-f1d7-98ddc9c1a117@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Implement intel_pmu_lbr_sync_task_ctx() method updating counters
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
Changes in v3:
- replaced assignment with swap at intel_pmu_lbr_sync_task_ctx()

---
 arch/x86/events/intel/lbr.c  | 9 +++++++++
 arch/x86/events/perf_event.h | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index ea54634eabf3..e57734ca59d4 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -417,6 +417,15 @@ static void __intel_pmu_lbr_save(struct x86_perf_task_context *task_ctx)
 	cpuc->last_log_id = ++task_ctx->log_id;
 }
 
+void intel_pmu_lbr_sync_task_ctx(struct x86_perf_task_context *one,
+				 struct x86_perf_task_context *another)
+{
+	if (!one || !another)
+		return;
+
+	swap(one->lbr_callstack_users, another->lbr_callstack_users);
+}
+
 void intel_pmu_lbr_sched_task(struct perf_event_context *ctx, bool sched_in)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index a25e6d7eb87b..3e0087c06fc9 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1024,6 +1024,9 @@ void intel_pmu_store_pebs_lbrs(struct pebs_lbr *lbr);
 
 void intel_ds_init(void);
 
+void intel_pmu_lbr_sync_task_ctx(struct x86_perf_task_context *one,
+				 struct x86_perf_task_context *another);
+
 void intel_pmu_lbr_sched_task(struct perf_event_context *ctx, bool sched_in);
 
 u64 lbr_from_signext_quirk_wr(u64 val);
-- 
2.20.1

