Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34FEFB3B9E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 15:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387861AbfIPNnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 09:43:11 -0400
Received: from mga04.intel.com ([192.55.52.120]:53809 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387823AbfIPNnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 09:43:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 06:43:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,512,1559545200"; 
   d="scan'208";a="387209025"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.84])
  by fmsmga006.fm.intel.com with ESMTP; 16 Sep 2019 06:43:06 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 08/14] perf/x86/intel: Support per thread RDPMC TopDown metrics
Date:   Mon, 16 Sep 2019 06:41:22 -0700
Message-Id: <20190916134128.18120-9-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190916134128.18120-1-kan.liang@linux.intel.com>
References: <20190916134128.18120-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

With Icelake CPUs, the TopDown metrics are directly available as fixed
counters and do not require generic counters, which make it possible to
measure TopDown per thread/process instead of only per core.

The metrics and slots values have to be saved/restored during context
switching.
The saved values are also used as previous values to calculate the
delta.

The PERF_METRICS MSR value will be returned if RDPMC metrics events.

Originally-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No changes since V3

 arch/x86/events/core.c       |   5 +-
 arch/x86/events/intel/core.c | 102 ++++++++++++++++++++++++++++-------
 include/linux/perf_event.h   |   3 ++
 3 files changed, 91 insertions(+), 19 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 283de3e548b4..585fe1a81bf0 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2198,7 +2198,10 @@ static int x86_pmu_event_idx(struct perf_event *event)
 	if (!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED))
 		return 0;
 
-	if (x86_pmu.num_counters_fixed && idx >= INTEL_PMC_IDX_FIXED) {
+	/* Return PERF_METRICS MSR value for metrics event */
+	if (is_metric_idx(idx))
+		idx = 1 << 29;
+	else if (x86_pmu.num_counters_fixed && idx >= INTEL_PMC_IDX_FIXED) {
 		idx -= INTEL_PMC_IDX_FIXED;
 		idx |= 1 << 30;
 	}
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 71f3086a8adc..7ec0f350d2ac 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2262,6 +2262,11 @@ static int icl_set_topdown_event_period(struct perf_event *event)
 		local64_set(&hwc->period_left, 0);
 	}
 
+	if ((hwc->saved_slots) && is_first_topdown_event_in_group(event)) {
+		wrmsrl(MSR_CORE_PERF_FIXED_CTR3, hwc->saved_slots);
+		wrmsrl(MSR_PERF_METRICS, hwc->saved_metric);
+	}
+
 	perf_event_update_userpage(event);
 
 	return 0;
@@ -2280,7 +2285,7 @@ static u64 icl_get_metrics_event_value(u64 metric, u64 slots, int idx)
 	return  mul_u64_u32_div(slots, val, 0xff);
 }
 
-static void __icl_update_topdown_event(struct perf_event *event,
+static u64 icl_get_topdown_value(struct perf_event *event,
 				       u64 slots, u64 metrics)
 {
 	int idx = event->hw.idx;
@@ -2291,7 +2296,50 @@ static void __icl_update_topdown_event(struct perf_event *event,
 	else
 		delta = slots;
 
-	local64_add(delta, &event->count);
+	return delta;
+}
+
+static void __icl_update_topdown_event(struct perf_event *event,
+				       u64 slots, u64 metrics,
+				       u64 last_slots, u64 last_metrics)
+{
+	u64 delta, last = 0;
+
+	delta = icl_get_topdown_value(event, slots, metrics);
+	if (last_slots)
+		last = icl_get_topdown_value(event, last_slots, last_metrics);
+
+	/*
+	 * The 8bit integer fraction of metric may be not accurate,
+	 * especially when the changes is very small.
+	 * For example, if only a few bad_spec happens, the fraction
+	 * may be reduced from 1 to 0. If so, the bad_spec event value
+	 * will be 0 which is definitely less than the last value.
+	 * Avoid update event->count for this case.
+	 */
+	if (delta > last) {
+		delta -= last;
+		local64_add(delta, &event->count);
+	}
+}
+
+static void update_saved_topdown_regs(struct perf_event *event,
+				      u64 slots, u64 metrics)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	struct perf_event *other;
+	int idx;
+
+	event->hw.saved_slots = slots;
+	event->hw.saved_metric = metrics;
+
+	for_each_set_bit(idx, cpuc->active_mask, INTEL_PMC_IDX_TD_BE_BOUND + 1) {
+		if (!is_topdown_idx(idx))
+			continue;
+		other = cpuc->events[idx];
+		other->hw.saved_slots = slots;
+		other->hw.saved_metric = metrics;
+	}
 }
 
 /*
@@ -2305,6 +2353,7 @@ static u64 icl_update_topdown_event(struct perf_event *event)
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct perf_event *other;
 	u64 slots, metrics;
+	bool reset = true;
 	int idx;
 
 	/*
@@ -2326,26 +2375,46 @@ static u64 icl_update_topdown_event(struct perf_event *event)
 		if (!is_topdown_idx(idx))
 			continue;
 		other = cpuc->events[idx];
-		__icl_update_topdown_event(other, slots, metrics);
+		__icl_update_topdown_event(other, slots, metrics,
+					   event ? event->hw.saved_slots : 0,
+					   event ? event->hw.saved_metric : 0);
 	}
 
 	/*
 	 * Check and update this event, which may have been cleared
 	 * in active_mask e.g. x86_pmu_stop()
 	 */
-	if (event && !test_bit(event->hw.idx, cpuc->active_mask))
-		__icl_update_topdown_event(event, slots, metrics);
+	if (event && !test_bit(event->hw.idx, cpuc->active_mask)) {
+		__icl_update_topdown_event(event, slots, metrics,
+					   event->hw.saved_slots,
+					   event->hw.saved_metric);
 
-	/*
-	 * To avoid the known issues as below, the PERF_METRICS and
-	 * Fixed counter 3 are reset for each read.
-	 * - The 8bit metrics ratio values lose precision when the
-	 *   measurement period gets longer.
-	 * - The PERF_METRICS may report wrong value if its delta was
-	 *   less than 1/255 of Fixed counter 3.
-	 */
-	wrmsrl(MSR_PERF_METRICS, 0);
-	wrmsrl(MSR_CORE_PERF_FIXED_CTR3, 0);
+		/*
+		 * In x86_pmu_stop(), the event is cleared in active_mask first,
+		 * then drain the delta, which indicates context switch for
+		 * counting.
+		 * Save metric and slots for context switch.
+		 * Don't need to reset the PERF_METRICS and Fixed counter 3.
+		 * Because the values will be restored in next schedule in.
+		 */
+		update_saved_topdown_regs(event, slots, metrics);
+		reset = false;
+	}
+
+	if (reset) {
+		/*
+		 * To avoid the known issues as below, the PERF_METRICS and
+		 * Fixed counter 3 are reset for each read.
+		 * - The 8bit metrics ratio values lose precision when the
+		 *   measurement period gets longer.
+		 * - The PERF_METRICS may report wrong value if its delta was
+		 *   less than 1/255 of Fixed counter 3.
+		 */
+		wrmsrl(MSR_PERF_METRICS, 0);
+		wrmsrl(MSR_CORE_PERF_FIXED_CTR3, 0);
+		if (event)
+			update_saved_topdown_regs(event, 0, 0);
+	}
 
 	return slots;
 }
@@ -3538,9 +3607,6 @@ static int intel_pmu_hw_config(struct perf_event *event)
 			event->attr.config1 = event->hw.config &
 					      X86_ALL_EVENT_FLAGS;
 			event->hw.flags |= PERF_X86_EVENT_TOPDOWN;
-
-			if (is_metric_event(event))
-				event->hw.flags &= ~PERF_X86_EVENT_RDPMC_ALLOWED;
 		}
 	}
 
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 61448c19a132..c125068f2e16 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -133,6 +133,9 @@ struct hw_perf_event {
 
 			struct hw_perf_event_extra extra_reg;
 			struct hw_perf_event_extra branch_reg;
+
+			u64		saved_slots;
+			u64		saved_metric;
 		};
 		struct { /* software */
 			struct hrtimer	hrtimer;
-- 
2.17.1

