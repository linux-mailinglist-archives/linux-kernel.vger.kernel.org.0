Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6ADB3BAF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 15:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388072AbfIPNnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 09:43:46 -0400
Received: from mga04.intel.com ([192.55.52.120]:53809 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387800AbfIPNnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 09:43:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 06:43:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,512,1559545200"; 
   d="scan'208";a="387209022"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.84])
  by fmsmga006.fm.intel.com with ESMTP; 16 Sep 2019 06:43:05 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 07/14] perf/x86/intel: Support hardware TopDown metrics
Date:   Mon, 16 Sep 2019 06:41:21 -0700
Message-Id: <20190916134128.18120-8-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190916134128.18120-1-kan.liang@linux.intel.com>
References: <20190916134128.18120-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Intro
=====

Icelake has support for measuring the four top level TopDown metrics
directly in hardware. This is implemented by an additional "metrics"
register, and a new Fixed Counter 3 that measures pipeline "slots".

Events
======

We export four metric events as separate perf events, which map to
internal "metrics" counter register. Those events do not exist in
hardware, but can be allocated by the scheduler.

For the event mapping we use a special 0x00 event code, which is
reserved for fake events. The metric events start from umask 0x10.

When setting up such events they point to the slots counter, and a
special callback, update_topdown_event(), reads the additional metrics
msr to generate the metrics. Then the metric is reported by multiplying
the metric (fraction) with slots.

This multiplication allows to easily keep a running count, for example
when the slots counter overflows, and makes all the standard tools, such
as a perf stat, work. They can do deltas of the values without needing
to know about fraction. This also simplifies accumulating the counts
of child events, which otherwise would need to know how to average
fraction values.

All four metric events don't support sampling. Since they will be
handled specially for event update, a flag PERF_X86_EVENT_TOPDOWN is
introduced to indicate this case.

The slots event can support both sampling and counting.
For counting, the flag is also applied.
For sampling, it will be handled normally as other normal events.

Groups
======

To avoid reading the METRICS register multiple times, the metrics and
slots value can only be updated by the first slots/metrics event in a
group. All active slots and metrics events will be updated one time.

Reset
======

Both PERF_METRICS and fixed counter 3 are required to start from zero.
However, current perf has -max_period as default initial value.
The patch force initial value as 0 for topdown and slots event counting.

Additionally, for certain scenarios that involve counting metrics at
high rates, SW is required to periodically clear both MSRs in order to
maintain accurate measurements. In this patch, both PERF_METRICS and
Fixed counter 3 are reset for each read.

NMI
======

The METRICS related register may be overflow. The bit 48 of STATUS
register will be set. If so, PERF_METRICS and Fixed counter 3 are
required to be reset. The patch also update all active slots and
metrics events in NMI handler.

The update_topdown_event() has to read two registers separately. The
values may be modify by a NMI. PMU has to be disabled before calling the
function.

RDPMC
======

RDPMC is temporarily disabled. The following patch will enable it.

Originally-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V3:
- Modify the description
- Fix unconditionally allows collecting 4 extra events

 arch/x86/events/core.c           |  38 ++++++
 arch/x86/events/intel/core.c     | 215 ++++++++++++++++++++++++++++++-
 arch/x86/events/perf_event.h     |  39 ++++++
 arch/x86/include/asm/msr-index.h |   2 +
 4 files changed, 290 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index fc8b0cbe5dc1..283de3e548b4 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -76,6 +76,9 @@ u64 x86_perf_event_update(struct perf_event *event)
 	if (idx == INTEL_PMC_IDX_FIXED_BTS)
 		return 0;
 
+	/* Specially handle the counting of Topdown slots/metrics */
+	if (unlikely(is_topdown_count(event)) && x86_pmu.update_topdown_event)
+		return x86_pmu.update_topdown_event(event);
 	/*
 	 * Careful: an NMI might modify the previous event value.
 	 *
@@ -992,6 +995,26 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 	return unsched ? -EINVAL : 0;
 }
 
+static int add_nr_metric_event(struct cpu_hw_events *cpuc,
+			       struct perf_event *event,
+			       int *max_count)
+{
+	/* There are 4 TopDown metrics events. */
+	if (is_metric_event(event) && (++cpuc->n_metric_event > 4))
+		return -EINVAL;
+
+	*max_count += cpuc->n_metric_event;
+
+	return 0;
+}
+
+static void del_nr_metric_event(struct cpu_hw_events *cpuc,
+				struct perf_event *event)
+{
+	if (is_metric_event(event))
+		cpuc->n_metric_event--;
+}
+
 /*
  * dogrp: true if must collect siblings events (group)
  * returns total number of events and error code
@@ -1027,6 +1050,10 @@ static int collect_events(struct cpu_hw_events *cpuc, struct perf_event *leader,
 		cpuc->pebs_output = is_pebs_pt(leader) + 1;
 	}
 
+	if (x86_pmu.intel_cap.perf_metrics &&
+	    add_nr_metric_event(cpuc, leader, &max_count))
+			return -EINVAL;
+
 	if (is_x86_event(leader)) {
 		if (n >= max_count)
 			return -EINVAL;
@@ -1041,6 +1068,10 @@ static int collect_events(struct cpu_hw_events *cpuc, struct perf_event *leader,
 		    event->state <= PERF_EVENT_STATE_OFF)
 			continue;
 
+		if (x86_pmu.intel_cap.perf_metrics &&
+		    add_nr_metric_event(cpuc, event, &max_count))
+			return -EINVAL;
+
 		if (n >= max_count)
 			return -EINVAL;
 
@@ -1204,6 +1235,11 @@ int x86_perf_event_set_period(struct perf_event *event)
 	if (idx == INTEL_PMC_IDX_FIXED_BTS)
 		return 0;
 
+	/* Specially handle the counting of Topdown slots/metrics */
+	if (unlikely(is_topdown_count(event)) &&
+	    x86_pmu.set_topdown_event_period)
+		return x86_pmu.set_topdown_event_period(event);
+
 	/*
 	 * If we are way outside a reasonable range then just skip forward:
 	 */
@@ -1481,6 +1517,8 @@ static void x86_pmu_del(struct perf_event *event, int flags)
 	}
 	cpuc->event_constraint[i-1] = NULL;
 	--cpuc->n_events;
+	if (x86_pmu.intel_cap.perf_metrics)
+		del_nr_metric_event(cpuc, event);
 
 	perf_event_update_userpage(event);
 
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index c7e093e5abd2..71f3086a8adc 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -247,6 +247,10 @@ static struct event_constraint intel_icl_event_constraints[] = {
 	FIXED_EVENT_CONSTRAINT(0x003c, 1),	/* CPU_CLK_UNHALTED.CORE */
 	FIXED_EVENT_CONSTRAINT(0x0300, 2),	/* CPU_CLK_UNHALTED.REF */
 	FIXED_EVENT_CONSTRAINT(0x0400, 3),	/* SLOTS */
+	METRIC_EVENT_CONSTRAINT(0x1000, 0),	/* Retiring metric */
+	METRIC_EVENT_CONSTRAINT(0x1100, 1),	/* Bad speculation metric */
+	METRIC_EVENT_CONSTRAINT(0x1200, 2),	/* FE bound metric */
+	METRIC_EVENT_CONSTRAINT(0x1300, 3),	/* BE bound metric */
 	INTEL_EVENT_CONSTRAINT_RANGE(0x03, 0x0a, 0xf),
 	INTEL_EVENT_CONSTRAINT_RANGE(0x1f, 0x28, 0xf),
 	INTEL_EVENT_CONSTRAINT(0x32, 0xf),	/* SW_PREFETCH_ACCESS.* */
@@ -267,6 +271,14 @@ static struct extra_reg intel_icl_extra_regs[] __read_mostly = {
 	INTEL_UEVENT_EXTRA_REG(0x01bb, MSR_OFFCORE_RSP_1, 0x3fffffbfffull, RSP_1),
 	INTEL_UEVENT_PEBS_LDLAT_EXTRA_REG(0x01cd),
 	INTEL_UEVENT_EXTRA_REG(0x01c6, MSR_PEBS_FRONTEND, 0x7fff17, FE),
+	/*
+	 * The original Fixed Ctr 3 are shared from different metrics
+	 * events. So use the extra reg to enforce the same
+	 * configuration on the original register, but do not actually
+	 * write to it.
+	 */
+	INTEL_UEVENT_EXTRA_REG(0x0400, 0, -1L, TOPDOWN),
+	INTEL_UEVENT_TOPDOWN_EXTRA_REG(0x1000),
 	EVENT_EXTRA_END
 };
 
@@ -2216,10 +2228,148 @@ static void intel_pmu_del_event(struct perf_event *event)
 		intel_pmu_pebs_del(event);
 }
 
+static bool is_first_topdown_event_in_group(struct perf_event *event)
+{
+	struct perf_event *first = NULL;
+
+	if (is_topdown_event(event->group_leader))
+		first = event->group_leader;
+	else {
+		for_each_sibling_event(first, event->group_leader)
+			if (is_topdown_event(first))
+				break;
+	}
+
+	if (event == first)
+		return true;
+
+	return false;
+}
+
+static int icl_set_topdown_event_period(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	s64 left = local64_read(&hwc->period_left);
+
+	/*
+	 * Clear PERF_METRICS and Fixed counter 3 in initialization.
+	 * After that, both MSRs will be cleared for each read.
+	 * Don't need to clear them again.
+	 */
+	if (left == x86_pmu.max_period) {
+		wrmsrl(MSR_CORE_PERF_FIXED_CTR3, 0);
+		wrmsrl(MSR_PERF_METRICS, 0);
+		local64_set(&hwc->period_left, 0);
+	}
+
+	perf_event_update_userpage(event);
+
+	return 0;
+}
+
+static u64 icl_get_metrics_event_value(u64 metric, u64 slots, int idx)
+{
+	u32 val;
+
+	/*
+	 * The metric is reported as an 8bit integer fraction
+	 * suming up to 0xff.
+	 * slots-in-metric = (Metric / 0xff) * slots
+	 */
+	val = (metric >> ((idx - INTEL_PMC_IDX_FIXED_METRIC_BASE) * 8)) & 0xff;
+	return  mul_u64_u32_div(slots, val, 0xff);
+}
+
+static void __icl_update_topdown_event(struct perf_event *event,
+				       u64 slots, u64 metrics)
+{
+	int idx = event->hw.idx;
+	u64 delta;
+
+	if (is_metric_idx(idx))
+		delta = icl_get_metrics_event_value(metrics, slots, idx);
+	else
+		delta = slots;
+
+	local64_add(delta, &event->count);
+}
+
+/*
+ * Update all active Topdown events.
+ *
+ * The PERF_METRICS and Fixed counter 3 are read separately. The values may be
+ * modify by a NMI. PMU has to be disabled before calling this function.
+ */
+static u64 icl_update_topdown_event(struct perf_event *event)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	struct perf_event *other;
+	u64 slots, metrics;
+	int idx;
+
+	/*
+	 * Only need to update all events for the first
+	 * slots/metrics event in a group
+	 */
+	if (event && !is_first_topdown_event_in_group(event))
+		return 0;
+
+	/* read Fixed counter 3 */
+	rdpmcl((3 | 1<<30), slots);
+	if (!slots)
+		return 0;
+
+	/* read PERF_METRICS */
+	rdpmcl((1<<29), metrics);
+
+	for_each_set_bit(idx, cpuc->active_mask, INTEL_PMC_IDX_TD_BE_BOUND + 1) {
+		if (!is_topdown_idx(idx))
+			continue;
+		other = cpuc->events[idx];
+		__icl_update_topdown_event(other, slots, metrics);
+	}
+
+	/*
+	 * Check and update this event, which may have been cleared
+	 * in active_mask e.g. x86_pmu_stop()
+	 */
+	if (event && !test_bit(event->hw.idx, cpuc->active_mask))
+		__icl_update_topdown_event(event, slots, metrics);
+
+	/*
+	 * To avoid the known issues as below, the PERF_METRICS and
+	 * Fixed counter 3 are reset for each read.
+	 * - The 8bit metrics ratio values lose precision when the
+	 *   measurement period gets longer.
+	 * - The PERF_METRICS may report wrong value if its delta was
+	 *   less than 1/255 of Fixed counter 3.
+	 */
+	wrmsrl(MSR_PERF_METRICS, 0);
+	wrmsrl(MSR_CORE_PERF_FIXED_CTR3, 0);
+
+	return slots;
+}
+
+static void intel_pmu_read_topdown_event(struct perf_event *event)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+
+	/* Only need to call update_topdown_event() once for group read. */
+	if ((cpuc->txn_flags & PERF_PMU_TXN_READ) &&
+	    !is_first_topdown_event_in_group(event))
+		return;
+
+	perf_pmu_disable(event->pmu);
+	x86_pmu.update_topdown_event(event);
+	perf_pmu_enable(event->pmu);
+}
+
 static void intel_pmu_read_event(struct perf_event *event)
 {
 	if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD)
 		intel_pmu_auto_reload_read(event);
+	else if (is_topdown_count(event) && x86_pmu.update_topdown_event)
+		intel_pmu_read_topdown_event(event);
 	else
 		x86_perf_event_update(event);
 }
@@ -2431,6 +2581,15 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 			intel_pt_interrupt();
 	}
 
+	/*
+	 * Intel Perf mertrics
+	 */
+	if (__test_and_clear_bit(48, (unsigned long *)&status)) {
+		handled++;
+		if (x86_pmu.update_topdown_event)
+			x86_pmu.update_topdown_event(NULL);
+	}
+
 	/*
 	 * Checkpointed counters can lead to 'spurious' PMIs because the
 	 * rollback caused by the PMI will have cleared the overflow status
@@ -3349,6 +3508,42 @@ static int intel_pmu_hw_config(struct perf_event *event)
 	if (event->attr.type != PERF_TYPE_RAW)
 		return 0;
 
+	/*
+	 * Config Topdown slots and metric events
+	 *
+	 * The slots event on Fixed Counter 3 can support sampling,
+	 * which will be handled normally in x86_perf_event_update().
+	 *
+	 * The metric events don't support sampling.
+	 *
+	 * For counting, topdown slots and metric events will be
+	 * handled specially for event update.
+	 * A flag PERF_X86_EVENT_TOPDOWN is applied for the case.
+	 */
+	if (x86_pmu.intel_cap.perf_metrics && is_topdown_event(event)) {
+		if (is_metric_event(event) && is_sampling_event(event))
+			return -EINVAL;
+
+		if (!is_sampling_event(event)) {
+			if (event->attr.config1 != 0)
+				return -EINVAL;
+			if (event->attr.config & ARCH_PERFMON_EVENTSEL_ANY)
+				return -EINVAL;
+			/*
+			 * Put configuration (minus event) into config1 so that
+			 * the scheduler enforces through an extra_reg that
+			 * all instances of the metrics events have the same
+			 * configuration.
+			 */
+			event->attr.config1 = event->hw.config &
+					      X86_ALL_EVENT_FLAGS;
+			event->hw.flags |= PERF_X86_EVENT_TOPDOWN;
+
+			if (is_metric_event(event))
+				event->hw.flags &= ~PERF_X86_EVENT_RDPMC_ALLOWED;
+		}
+	}
+
 	if (!(event->attr.config & ARCH_PERFMON_EVENTSEL_ANY))
 		return 0;
 
@@ -5095,6 +5290,8 @@ __init int intel_pmu_init(void)
 		x86_pmu.rtm_abort_event = X86_CONFIG(.event=0xca, .umask=0x02);
 		x86_pmu.lbr_pt_coexist = true;
 		intel_pmu_pebs_data_source_skl(pmem);
+		x86_pmu.update_topdown_event = icl_update_topdown_event;
+		x86_pmu.set_topdown_event_period = icl_set_topdown_event_period;
 		pr_cont("Icelake events, ");
 		name = "icelake";
 		break;
@@ -5151,10 +5348,17 @@ __init int intel_pmu_init(void)
 		 * counter, so do not extend mask to generic counters
 		 */
 		for_each_event_constraint(c, x86_pmu.event_constraints) {
-			if (c->cmask == FIXED_EVENT_FLAGS
-			    && c->idxmsk64 != INTEL_PMC_MSK_FIXED_REF_CYCLES
-			    && c->idxmsk64 != INTEL_PMC_MSK_FIXED_SLOTS) {
-				c->idxmsk64 |= (1ULL << x86_pmu.num_counters) - 1;
+			if (c->cmask == FIXED_EVENT_FLAGS) {
+				/*
+				 * Don't extend topdown slots and metrics
+				 * events to generic counters.
+				 */
+				if (c->idxmsk64 & INTEL_PMC_MSK_TOPDOWN) {
+					c->weight = hweight64(c->idxmsk64);
+					continue;
+				}
+				if (c->idxmsk64 != INTEL_PMC_MSK_FIXED_REF_CYCLES)
+					c->idxmsk64 |= (1ULL << x86_pmu.num_counters) - 1;
 			}
 			c->idxmsk64 &=
 				~(~0ULL << (INTEL_PMC_IDX_FIXED + x86_pmu.num_counters_fixed));
@@ -5207,6 +5411,9 @@ __init int intel_pmu_init(void)
 	if (x86_pmu.counter_freezing)
 		x86_pmu.handle_irq = intel_pmu_handle_irq_v4;
 
+	if (x86_pmu.intel_cap.perf_metrics)
+		x86_pmu.intel_ctrl |= 1ULL << 48;
+
 	return 0;
 }
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index cbbead3c12dc..dbe969ed4403 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -40,6 +40,7 @@ enum extra_reg_type {
 	EXTRA_REG_LBR   = 2,	/* lbr_select */
 	EXTRA_REG_LDLAT = 3,	/* ld_lat_threshold */
 	EXTRA_REG_FE    = 4,    /* fe_* */
+	EXTRA_REG_TOPDOWN = 5,	/* Topdown slots/metrics */
 
 	EXTRA_REG_MAX		/* number of entries needed */
 };
@@ -77,6 +78,29 @@ static inline bool constraint_match(struct event_constraint *c, u64 ecode)
 #define PERF_X86_EVENT_AUTO_RELOAD	0x0200 /* use PEBS auto-reload */
 #define PERF_X86_EVENT_LARGE_PEBS	0x0400 /* use large PEBS */
 #define PERF_X86_EVENT_PEBS_VIA_PT	0x0800 /* use PT buffer for PEBS */
+#define PERF_X86_EVENT_TOPDOWN		0x1000 /* Count Topdown slots/metrics events */
+
+static inline bool is_topdown_count(struct perf_event *event)
+{
+	return event->hw.flags & PERF_X86_EVENT_TOPDOWN;
+}
+
+static inline bool is_metric_event(struct perf_event *event)
+{
+	return ((event->attr.config & ARCH_PERFMON_EVENTSEL_EVENT) == 0) &&
+	       ((event->attr.config & INTEL_ARCH_EVENT_MASK) >= 0x1000)  &&
+	       ((event->attr.config & INTEL_ARCH_EVENT_MASK) <= 0x1300);
+}
+
+static inline bool is_slots_event(struct perf_event *event)
+{
+	return (event->attr.config & INTEL_ARCH_EVENT_MASK) == 0x0400;
+}
+
+static inline bool is_topdown_event(struct perf_event *event)
+{
+	return is_metric_event(event) || is_slots_event(event);
+}
 
 struct amd_nb {
 	int nb_id;  /* NorthBridge id */
@@ -266,6 +290,12 @@ struct cpu_hw_events {
 	 */
 	u64				tfa_shadow;
 
+	/*
+	 * Perf Metrics
+	 */
+	/* number of accepted metrics events */
+	int				n_metric_event;
+
 	/*
 	 * AMD specific bits
 	 */
@@ -517,6 +547,9 @@ struct extra_reg {
 			       0xffff, \
 			       LDLAT)
 
+#define INTEL_UEVENT_TOPDOWN_EXTRA_REG(event)	\
+	EVENT_EXTRA_REG(event, 0, 0xfcff, -1L, TOPDOWN)
+
 #define EVENT_EXTRA_END EVENT_EXTRA_REG(0, 0, 0, 0, RSP_0)
 
 union perf_capabilities {
@@ -696,6 +729,12 @@ struct x86_pmu {
 	 */
 	atomic_t	lbr_exclusive[x86_lbr_exclusive_max];
 
+	/*
+	 * Intel perf metrics
+	 */
+	u64		(*update_topdown_event)(struct perf_event *event);
+	int		(*set_topdown_event_period)(struct perf_event *event);
+
 	/*
 	 * AMD bits
 	 */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 5ebfd97d4ac9..74064bedd4a1 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -118,6 +118,8 @@
 #define MSR_TURBO_RATIO_LIMIT1		0x000001ae
 #define MSR_TURBO_RATIO_LIMIT2		0x000001af
 
+#define MSR_PERF_METRICS		0x00000329
+
 #define MSR_LBR_SELECT			0x000001c8
 #define MSR_LBR_TOS			0x000001c9
 #define MSR_LBR_NHM_FROM		0x00000680
-- 
2.17.1

