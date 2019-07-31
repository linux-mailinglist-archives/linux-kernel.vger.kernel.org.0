Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C49D77C438
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 15:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbfGaN6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 09:58:42 -0400
Received: from mga05.intel.com ([192.55.52.43]:47382 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfGaN6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 09:58:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jul 2019 06:58:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,330,1559545200"; 
   d="scan'208";a="177318769"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 31 Jul 2019 06:58:37 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v2 1/7] perf: Allow normal events to be sources of AUX data
Date:   Wed, 31 Jul 2019 16:58:23 +0300
Message-Id: <20190731135829.54435-2-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731135829.54435-1-alexander.shishkin@linux.intel.com>
References: <20190731135829.54435-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases, ordinary (non-AUX) events can generate data for AUX events.
For example, PEBS events can come out as records in the Intel PT stream
instead of their usual DS records, if configured to do so.

One requirement for such events is to consistently schedule together, to
ensure that the data from the "AUX source" events isn't lost while their
corresponding AUX event is not scheduled. We use grouping to provide this
guarantee: an "AUX source" event can be added to a group where an AUX event
is a group leader, and provided that the former supports writing to the
latter.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 include/linux/perf_event.h      | 14 +++++
 include/uapi/linux/perf_event.h |  3 +-
 kernel/events/core.c            | 92 +++++++++++++++++++++++++++++++++
 3 files changed, 108 insertions(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index e8ad3c590a23..ba86bfa6bb66 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -246,6 +246,7 @@ struct perf_event;
 #define PERF_PMU_CAP_ITRACE			0x20
 #define PERF_PMU_CAP_HETEROGENEOUS_CPUS		0x40
 #define PERF_PMU_CAP_NO_EXCLUDE			0x80
+#define PERF_PMU_CAP_AUX_SOURCE			0x100
 
 /**
  * struct pmu - generic performance monitoring unit
@@ -446,6 +447,16 @@ struct pmu {
 	void (*addr_filters_sync)	(struct perf_event *event);
 					/* optional */
 
+	/*
+	 * Check if event can be used for aux_source purposes for
+	 * events of this PMU.
+	 *
+	 * Runs from perf_event_open(). Should return 0 for "no match"
+	 * or non-zero for "match".
+	 */
+	int (*aux_source_match)		(struct perf_event *event);
+					/* optional */
+
 	/*
 	 * Filter events for PMU-specific reasons.
 	 */
@@ -681,6 +692,9 @@ struct perf_event {
 	struct perf_addr_filter_range	*addr_filter_ranges;
 	unsigned long			addr_filters_gen;
 
+	/* for aux_source events */
+	struct perf_event		*aux_event;
+
 	void (*destroy)(struct perf_event *);
 	struct rcu_head			rcu_head;
 
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 7198ddd0c6b1..213cae95e713 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -374,7 +374,8 @@ struct perf_event_attr {
 				namespaces     :  1, /* include namespaces data */
 				ksymbol        :  1, /* include ksymbol events */
 				bpf_event      :  1, /* include bpf events */
-				__reserved_1   : 33;
+				aux_source     :  1, /* generate AUX records instead of events */
+				__reserved_1   : 32;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index c1f52a749db2..453775b0abf1 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1887,6 +1887,88 @@ list_del_event(struct perf_event *event, struct perf_event_context *ctx)
 	ctx->generation++;
 }
 
+static int
+perf_aux_source_match(struct perf_event *event, struct perf_event *aux_event)
+{
+	if (!has_aux(aux_event))
+		return 0;
+
+	if (!event->pmu->aux_source_match)
+		return 0;
+
+	return event->pmu->aux_source_match(aux_event);
+}
+
+static void put_event(struct perf_event *event);
+static void event_sched_out(struct perf_event *event,
+			    struct perf_cpu_context *cpuctx,
+			    struct perf_event_context *ctx);
+
+static void perf_put_aux_event(struct perf_event *event)
+{
+	struct perf_event_context *ctx = event->ctx;
+	struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
+	struct perf_event *iter = NULL;
+
+	/*
+	 * If event uses aux_event tear down the link
+	 */
+	if (event->aux_event) {
+		put_event(event->aux_event);
+		event->aux_event = NULL;
+		return;
+	}
+
+	/*
+	 * If the event is an aux_event, tear down all links to
+	 * it from other events.
+	 */
+	for_each_sibling_event(iter, event->group_leader) {
+		if (iter->aux_event != event)
+			continue;
+
+		iter->aux_event = NULL;
+		put_event(event);
+
+		/*
+		 * If it's ACTIVE, schedule it out. It won't schedule
+		 * again because !aux_event.
+		 */
+		event_sched_out(iter, cpuctx, ctx);
+	}
+}
+
+static int perf_get_aux_event(struct perf_event *event,
+			      struct perf_event *group_leader)
+{
+	struct perf_event *aux_event = group_leader;
+
+	/*
+	 * Our group leader must be an aux event if we want to be
+	 * an aux_source. This way, the aux event will precede its
+	 * aux_source events in the group, and therefore will always
+	  schedule first.
+	 */
+	if (!aux_event)
+		return 0;
+
+	if (!perf_aux_source_match(event, aux_event))
+		return 0;
+
+	if (!atomic_long_inc_not_zero(&aux_event->refcount))
+		return 0;
+
+	/*
+	 * Link aux_sources to their aux event; this is undone in
+	 * perf_group_detach() by perf_put_aux_event(). When the
+	 * group in torn down, the aux_source events loose their
+	 * link to the aux_event and can't schedule any more.
+	 */
+	event->aux_event = aux_event;
+
+	return 1;
+}
+
 static void perf_group_detach(struct perf_event *event)
 {
 	struct perf_event *sibling, *tmp;
@@ -1902,6 +1984,8 @@ static void perf_group_detach(struct perf_event *event)
 
 	event->attach_state &= ~PERF_ATTACH_GROUP;
 
+	perf_put_aux_event(event);
+
 	/*
 	 * If this is a sibling, remove it from its group.
 	 */
@@ -10423,6 +10507,12 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 		goto err_ns;
 	}
 
+	if (event->attr.aux_source &&
+	    !(pmu->capabilities & PERF_PMU_CAP_AUX_SOURCE)) {
+		err = -EOPNOTSUPP;
+		goto err_pmu;
+	}
+
 	err = exclusive_event_init(event);
 	if (err)
 		goto err_pmu;
@@ -11079,6 +11169,8 @@ SYSCALL_DEFINE5(perf_event_open,
 		}
 	}
 
+	if (event->attr.aux_source && !perf_get_aux_event(event, group_leader))
+		goto err_locked;
 
 	/*
 	 * Must be under the same ctx::mutex as perf_install_in_context(),
-- 
2.20.1

