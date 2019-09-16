Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8750B3B9F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 15:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387891AbfIPNnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 09:43:14 -0400
Received: from mga04.intel.com ([192.55.52.120]:53809 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387846AbfIPNnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 09:43:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 06:43:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,512,1559545200"; 
   d="scan'208";a="387209035"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.84])
  by fmsmga006.fm.intel.com with ESMTP; 16 Sep 2019 06:43:09 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 10/14] perf/x86/intel: Disable sampling read slots and topdown
Date:   Mon, 16 Sep 2019 06:41:24 -0700
Message-Id: <20190916134128.18120-11-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190916134128.18120-1-kan.liang@linux.intel.com>
References: <20190916134128.18120-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The slots event supports sampling. Users may sampling read slots and
metrics events, e.g perf record -e '{slots, topdown-retiring}:S'.
But the metrics event will reset the fixed counter 3 which will impact
the sampling of the slots event.

Add specific validate_group() support to reject the case and error out
for Icelake.

An alternative fix may unconditionally disable SLOTS sampling. But it's
not a decent fix. Because users may want to only sampling slot events
without topdown metrics event.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No changes since V3

 arch/x86/events/core.c       |  4 ++++
 arch/x86/events/intel/core.c | 20 ++++++++++++++++++++
 arch/x86/events/perf_event.h |  2 ++
 3 files changed, 26 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 585fe1a81bf0..350c21aaea61 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2105,7 +2105,11 @@ static int validate_group(struct perf_event *event)
 
 	fake_cpuc->n_events = 0;
 	ret = x86_pmu.schedule_events(fake_cpuc, n, NULL);
+	if (ret)
+		goto out;
 
+	if (x86_pmu.validate_group)
+		ret = x86_pmu.validate_group(fake_cpuc, n);
 out:
 	free_fake_cpuc(fake_cpuc);
 	return ret;
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 8218f26035e3..b4b02bd24737 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4526,6 +4526,25 @@ static __init void intel_ht_bug(void)
 	x86_pmu.stop_scheduling = intel_stop_scheduling;
 }
 
+static int icl_validate_group(struct cpu_hw_events *cpuc, int n)
+{
+	bool has_sampling_slots = false, has_metrics = false;
+	struct perf_event *e;
+	int i;
+
+	for (i = 0; i < n; i++) {
+		e = cpuc->event_list[i];
+		if (is_slots_event(e) && is_sampling_event(e))
+			has_sampling_slots = true;
+
+		if (is_metric_event(e))
+			has_metrics = true;
+	}
+	if (unlikely(has_sampling_slots && has_metrics))
+		return -EINVAL;
+	return 0;
+}
+
 EVENT_ATTR_STR(mem-loads,	mem_ld_hsw,	"event=0xcd,umask=0x1,ldlat=3");
 EVENT_ATTR_STR(mem-stores,	mem_st_hsw,	"event=0xd0,umask=0x82")
 
@@ -5374,6 +5393,7 @@ __init int intel_pmu_init(void)
 		intel_pmu_pebs_data_source_skl(pmem);
 		x86_pmu.update_topdown_event = icl_update_topdown_event;
 		x86_pmu.set_topdown_event_period = icl_set_topdown_event_period;
+		x86_pmu.validate_group = icl_validate_group;
 		pr_cont("Icelake events, ");
 		name = "icelake";
 		break;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index dbe969ed4403..032c3495982a 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -661,6 +661,8 @@ struct x86_pmu {
 	int		perfctr_second_write;
 	u64		(*limit_period)(struct perf_event *event, u64 l);
 
+	int		(*validate_group)(struct cpu_hw_events *cpuc, int n);
+
 	/* PMI handler bits */
 	unsigned int	late_ack		:1,
 			counter_freezing	:1;
-- 
2.17.1

