Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB4EB7291
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2019 07:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388039AbfISFX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Sep 2019 01:23:29 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51754 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387576AbfISFX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 01:23:28 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8J5NGFn008745
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 22:23:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=XHBkJEBIG1Bfmj81zm5SNu/KGNemYwKeFT0DPZCh4oM=;
 b=AsBX4ZvcBz0V/YSGzJ/scitBWdRgH+tZEtyPcocNf8bMTXWPVeqy+wEGGSeZNEEYmOYa
 l3gaC9aG16vr114HGPDcOfXvKY/jJ7N7MmZ78rJTSOE6UTgRZPEA3cyMJlm+Qd8fl/Fr
 it3v5y4zEG6P6t+Kd8F2F1zkydvNFFiqGc8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2v3vay9h5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 22:23:26 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 18 Sep 2019 22:23:25 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 4DF6462E1F22; Wed, 18 Sep 2019 22:23:21 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, <kernel-team@fb.com>,
        <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, Tejun Heo <tj@kernel.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v6] perf: Sharing PMU counters across compatible events
Date:   Wed, 18 Sep 2019 22:23:14 -0700
Message-ID: <20190919052314.2925604-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-19_02:2019-09-18,2019-09-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=878
 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 mlxscore=0 suspectscore=3 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909190049
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch tries to enable PMU sharing. To make perf event scheduling
fast, we use special data structures.

An array of "struct perf_event_dup" is added to the perf_event_context,
to remember all the duplicated events under this ctx. All the events
under this ctx has a "dup_id" pointing to its perf_event_dup. Compatible
events under the same ctx share the same perf_event_dup. The following
figure shows a simplified version of the data structure.

      ctx ->  perf_event_dup -> master
                     ^
                     |
         perf_event /|
                     |
         perf_event /

Connection among perf_event and perf_event_dup are built when events are
added or removed from the ctx. So these are not on the critical path of
schedule or perf_rotate_context().

On the critical paths (add, del read), sharing PMU counters doesn't
increase the complexity. Helper functions event_pmu_[add|del|read]() are
introduced to cover these cases. All these functions have O(1) time
complexity.

We allocate a separate perf_event for perf_event_dup->master. This needs
extra attention, because perf_event_alloc() may sleep. To allocate the
master event properly, a new pointer, tmp_master, is added to perf_event.
tmp_master carries a separate perf_event into list_[add|del]_event().
The master event has valid ->ctx and holds ctx->refcount.

Details about the handling of the master event is added to
include/linux/perf_event.h, before struct perf_event_dup.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 include/linux/perf_event.h |  61 ++++++++
 kernel/events/core.c       | 294 ++++++++++++++++++++++++++++++++++---
 2 files changed, 332 insertions(+), 23 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 61448c19a132..a694e5eee80a 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -722,6 +722,12 @@ struct perf_event {
 #endif
 
 	struct list_head		sb_list;
+
+	/* for PMU sharing */
+	struct perf_event		*tmp_master;
+	int				dup_id;
+	u64				dup_base_count;
+	u64				dup_base_child_count;
 #endif /* CONFIG_PERF_EVENTS */
 };
 
@@ -731,6 +737,58 @@ struct perf_event_groups {
 	u64		index;
 };
 
+/*
+ * Sharing PMU across compatible events
+ *
+ * If two perf_events in the same perf_event_context are counting same
+ * hardware events (instructions, cycles, etc.), they could share the
+ * hardware PMU counter.
+ *
+ * When a perf_event is added to the ctx (list_add_event), it is compared
+ * against other events in the ctx. If they can share the PMU counter,
+ * a perf_event_dup is allocated to represent the sharing.
+ *
+ * Each perf_event_dup has a virtual master event, which is called by
+ * pmu->add() and pmu->del(). We cannot call perf_event_alloc() in
+ * list_add_event(), so it is allocated and carried by event->tmp_master
+ * into list_add_event().
+ *
+ * Virtual master in different cases/paths:
+ *
+ * < I > perf_event_open() -> close() path:
+ *
+ * 1. Allocated by perf_event_alloc() in sys_perf_event_open();
+ * 2. event->tmp_master->ctx assigned in perf_install_in_context();
+ * 3.a. if used by ctx->dup_events, freed in perf_event_release_kernel();
+ * 3.b. if not used by ctx->dup_events, freed in perf_event_open().
+ *
+ * < II > inherit_event() path:
+ *
+ * 1. Allocated by perf_event_alloc() in inherit_event();
+ * 2. tmp_master->ctx assigned in inherit_event();
+ * 3.a. if used by ctx->dup_events, freed in perf_event_release_kernel();
+ * 3.b. if not used by ctx->dup_events, freed in inherit_event().
+ *
+ * < III > perf_pmu_migrate_context() path:
+ * all dup_events removed during migration (no sharing after the move).
+ *
+ * < IV > perf_event_create_kernel_counter() path:
+ * not supported yet.
+ */
+struct perf_event_dup {
+	/*
+	 * master event being called by pmu->add() and pmu->del().
+	 * This event is allocated with perf_event_alloc(). When
+	 * attached to a ctx, this event should hold ctx->refcount.
+	 */
+	struct perf_event       *master;
+	/* number of events in the ctx that shares the master */
+	int			total_event_count;
+	/* number of active events of the master */
+	int			active_event_count;
+};
+
+#define MAX_PERF_EVENT_DUP_PER_CTX 4
 /**
  * struct perf_event_context - event context structure
  *
@@ -791,6 +849,9 @@ struct perf_event_context {
 #endif
 	void				*task_ctx_data; /* pmu specific data */
 	struct rcu_head			rcu_head;
+
+	/* for PMU sharing. array is needed for O(1) access */
+	struct perf_event_dup		dup_events[MAX_PERF_EVENT_DUP_PER_CTX];
 };
 
 /*
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4f08b17d6426..973425e9de9b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1657,6 +1657,142 @@ perf_event_groups_next(struct perf_event *event)
 		event = rb_entry_safe(rb_next(&event->group_node),	\
 				typeof(*event), group_node))
 
+static void _free_event(struct perf_event *event);
+
+/* free event->tmp_master */
+static inline void perf_event_free_tmp_master(struct perf_event *event)
+{
+	if (event->tmp_master) {
+		_free_event(event->tmp_master);
+		event->tmp_master = NULL;
+	}
+}
+
+static inline u64 dup_read_count(struct perf_event_dup *dup)
+{
+	return local64_read(&dup->master->count);
+}
+
+static inline u64 dup_read_child_count(struct perf_event_dup *dup)
+{
+	return atomic64_read(&dup->master->child_count);
+}
+
+/* Returns whether a perf_event can share PMU counter with other events */
+static inline bool perf_event_can_share(struct perf_event *event)
+{
+	/* only do sharing for hardware events */
+	if (is_software_event(event))
+		return false;
+
+	/*
+	 * limit sharing to counting events.
+	 * perf-stat sets PERF_SAMPLE_IDENTIFIER for counting events, so
+	 * let that in.
+	 */
+	if (event->attr.sample_type & ~PERF_SAMPLE_IDENTIFIER)
+		return false;
+
+	return true;
+}
+
+/*
+ * Returns whether the two events can share a PMU counter.
+ *
+ * Note: This function does NOT check perf_event_can_share() for
+ * the two events, they should be checked before this function
+ */
+static inline bool perf_event_compatible(struct perf_event *event_a,
+					 struct perf_event *event_b)
+{
+	return event_a->attr.type == event_b->attr.type &&
+		event_a->attr.config == event_b->attr.config &&
+		event_a->attr.config1 == event_b->attr.config1 &&
+		event_a->attr.config2 == event_b->attr.config2;
+}
+
+/*
+ * After adding a event to the ctx, try find compatible event(s).
+ *
+ * This function should only be called at the end of list_add_event().
+ * Master event cannot be allocated or freed within this function. To add
+ * new master event, the event should already have a master event
+ * allocated (event->tmp_master).
+ */
+static inline void perf_event_setup_dup(struct perf_event *event,
+					struct perf_event_context *ctx)
+
+{
+	struct perf_event *tmp;
+	int empty_slot = -1;
+	int match;
+	int i;
+
+	if (!perf_event_can_share(event))
+		return;
+
+	/* look for sharing with existing dup events */
+	for (i = 0; i < MAX_PERF_EVENT_DUP_PER_CTX; i++) {
+		if (ctx->dup_events[i].master == NULL) {
+			if (empty_slot == -1)
+				empty_slot = i;
+			continue;
+		}
+
+		if (perf_event_compatible(event, ctx->dup_events[i].master)) {
+			event->dup_id = i;
+			ctx->dup_events[i].total_event_count++;
+			return;
+		}
+	}
+
+	if (!event->tmp_master ||  /* perf_event_alloc() failed */
+	    empty_slot == -1)      /* no available dup_event */
+		return;
+
+	match = 0;
+	/* look for dup with other events */
+	list_for_each_entry(tmp, &ctx->event_list, event_entry) {
+		if (tmp == event || tmp->dup_id != -1 ||
+		    !perf_event_can_share(tmp) ||
+		    !perf_event_compatible(event, tmp))
+			continue;
+
+		tmp->dup_id = empty_slot;
+		match++;
+	}
+
+	/* found at least one dup */
+	if (match) {
+		ctx->dup_events[empty_slot].master = event->tmp_master;
+		ctx->dup_events[empty_slot].total_event_count = match + 1;
+		event->dup_id = empty_slot;
+		event->tmp_master = NULL;
+		return;
+	}
+}
+
+/*
+ * Remove the event from ctx->dup_events.
+ * This function should only be called from list_del_event(). Similar to
+ * perf_event_setup_dup(), we cannot call _free_event(master). If a master
+ * event should be freed, it is carried out of this function by the event
+ * (event->tmp_master).
+ */
+static void perf_event_remove_dup(struct perf_event *event,
+				  struct perf_event_context *ctx)
+
+{
+	if (event->dup_id == -1)
+		return;
+
+	if (--ctx->dup_events[event->dup_id].total_event_count == 0) {
+		event->tmp_master = ctx->dup_events[event->dup_id].master;
+		ctx->dup_events[event->dup_id].master = NULL;
+	}
+	event->dup_id = -1;
+}
+
 /*
  * Add an event from the lists for its context.
  * Must be called with ctx->mutex and ctx->lock held.
@@ -1689,6 +1825,7 @@ list_add_event(struct perf_event *event, struct perf_event_context *ctx)
 		ctx->nr_stat++;
 
 	ctx->generation++;
+	perf_event_setup_dup(event, ctx);
 }
 
 /*
@@ -1855,6 +1992,7 @@ list_del_event(struct perf_event *event, struct perf_event_context *ctx)
 	WARN_ON_ONCE(event->ctx != ctx);
 	lockdep_assert_held(&ctx->lock);
 
+	perf_event_remove_dup(event, ctx);
 	/*
 	 * We can have double detach due to exit/hot-unplug + close.
 	 */
@@ -2069,6 +2207,84 @@ event_filter_match(struct perf_event *event)
 	       perf_cgroup_match(event) && pmu_filter_match(event);
 }
 
+/* PMU sharing aware version of event->pmu->add() */
+static int event_pmu_add(struct perf_event *event,
+			 struct perf_event_context *ctx)
+{
+	struct perf_event_dup *dup;
+	int ret;
+
+	/* no sharing, just do event->pmu->add() */
+	if (event->dup_id == -1)
+		return event->pmu->add(event, PERF_EF_START);
+
+	dup = &ctx->dup_events[event->dup_id];
+
+	if (!dup->active_event_count) {
+		ret = event->pmu->add(dup->master, PERF_EF_START);
+		if (ret)
+			return ret;
+	}
+
+	dup->active_event_count++;
+	dup->master->pmu->read(dup->master);
+	event->dup_base_count = dup_read_count(dup);
+	event->dup_base_child_count = dup_read_child_count(dup);
+	return 0;
+}
+
+/*
+ * sync data count from dup->master to event, called on event_pmu_read()
+ * and event_pmu_del()
+ */
+static void event_sync_dup_count(struct perf_event *event,
+				 struct perf_event_dup *dup)
+{
+	u64 new_count;
+	u64 new_child_count;
+
+	event->pmu->read(dup->master);
+	new_count = dup_read_count(dup);
+	new_child_count = dup_read_child_count(dup);
+
+	local64_add(new_count - event->dup_base_count, &event->count);
+	atomic64_add(new_child_count - event->dup_base_child_count,
+		     &event->child_count);
+
+	event->dup_base_count = new_count;
+	event->dup_base_child_count = new_child_count;
+}
+
+/* PMU sharing aware version of event->pmu->del() */
+static void event_pmu_del(struct perf_event *event,
+			  struct perf_event_context *ctx)
+{
+	struct perf_event_dup *dup;
+
+	if (event->dup_id == -1) {
+		event->pmu->del(event, 0);
+		return;
+	}
+
+	dup = &ctx->dup_events[event->dup_id];
+	event_sync_dup_count(event, dup);
+	if (--dup->active_event_count == 0)
+		event->pmu->del(dup->master, 0);
+}
+
+/* PMU sharing aware version of event->pmu->read() */
+static void event_pmu_read(struct perf_event *event)
+{
+	struct perf_event_dup *dup;
+
+	if (event->dup_id == -1) {
+		event->pmu->read(event);
+		return;
+	}
+	dup = &event->ctx->dup_events[event->dup_id];
+	event_sync_dup_count(event, dup);
+}
+
 static void
 event_sched_out(struct perf_event *event,
 		  struct perf_cpu_context *cpuctx,
@@ -2091,7 +2307,7 @@ event_sched_out(struct perf_event *event,
 
 	perf_pmu_disable(event->pmu);
 
-	event->pmu->del(event, 0);
+	event_pmu_del(event, ctx);
 	event->oncpu = -1;
 
 	if (READ_ONCE(event->pending_disable) >= 0) {
@@ -2364,7 +2580,7 @@ event_sched_in(struct perf_event *event,
 
 	perf_log_itrace_start(event);
 
-	if (event->pmu->add(event, PERF_EF_START)) {
+	if (event_pmu_add(event, ctx)) {
 		perf_event_set_state(event, PERF_EVENT_STATE_INACTIVE);
 		event->oncpu = -1;
 		ret = -EAGAIN;
@@ -2612,20 +2828,9 @@ static int  __perf_install_in_context(void *info)
 		raw_spin_lock(&task_ctx->lock);
 	}
 
-#ifdef CONFIG_CGROUP_PERF
-	if (is_cgroup_event(event)) {
-		/*
-		 * If the current cgroup doesn't match the event's
-		 * cgroup, we should not try to schedule it.
-		 */
-		struct perf_cgroup *cgrp = perf_cgroup_from_task(current, ctx);
-		reprogram = cgroup_is_descendant(cgrp->css.cgroup,
-					event->cgrp->css.cgroup);
-	}
-#endif
-
 	if (reprogram) {
-		ctx_sched_out(ctx, cpuctx, EVENT_TIME);
+		/* schedule out all events to set up dup properly */
+		ctx_sched_out(ctx, cpuctx, EVENT_ALL);
 		add_event_to_ctx(event, ctx);
 		ctx_resched(cpuctx, task_ctx, get_event_type(event));
 	} else {
@@ -2664,6 +2869,10 @@ perf_install_in_context(struct perf_event_context *ctx,
 	 * Ensures that if we can observe event->ctx, both the event and ctx
 	 * will be 'complete'. See perf_iterate_sb_cpu().
 	 */
+	if (event->tmp_master) {
+		event->tmp_master->ctx = ctx;
+		get_ctx(ctx);
+	}
 	smp_store_release(&event->ctx, ctx);
 
 	if (!task) {
@@ -3115,7 +3324,7 @@ static void __perf_event_sync_stat(struct perf_event *event,
 	 * don't need to use it.
 	 */
 	if (event->state == PERF_EVENT_STATE_ACTIVE)
-		event->pmu->read(event);
+		event_pmu_read(event);
 
 	perf_event_update_time(event);
 
@@ -3967,14 +4176,14 @@ static void __perf_event_read(void *info)
 		goto unlock;
 
 	if (!data->group) {
-		pmu->read(event);
+		event_pmu_read(event);
 		data->ret = 0;
 		goto unlock;
 	}
 
 	pmu->start_txn(pmu, PERF_PMU_TXN_READ);
 
-	pmu->read(event);
+	event_pmu_read(event);
 
 	for_each_sibling_event(sub, event) {
 		if (sub->state == PERF_EVENT_STATE_ACTIVE) {
@@ -3982,7 +4191,7 @@ static void __perf_event_read(void *info)
 			 * Use sibling's PMU rather than @event's since
 			 * sibling could be on different (eg: software) PMU.
 			 */
-			sub->pmu->read(sub);
+			event_pmu_read(sub);
 		}
 	}
 
@@ -4052,7 +4261,7 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
 	 * oncpu == -1).
 	 */
 	if (event->oncpu == smp_processor_id())
-		event->pmu->read(event);
+		event_pmu_read(event);
 
 	*value = local64_read(&event->count);
 	if (enabled || running) {
@@ -4587,6 +4796,7 @@ static void free_event(struct perf_event *event)
 		return;
 	}
 
+	perf_event_free_tmp_master(event);
 	_free_event(event);
 }
 
@@ -4646,6 +4856,7 @@ static void put_event(struct perf_event *event)
 	if (!atomic_long_dec_and_test(&event->refcount))
 		return;
 
+	perf_event_free_tmp_master(event);
 	_free_event(event);
 }
 
@@ -6261,7 +6472,7 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 
 	if ((leader != event) &&
 	    (leader->state == PERF_EVENT_STATE_ACTIVE))
-		leader->pmu->read(leader);
+		event_pmu_read(leader);
 
 	values[n++] = perf_event_count(leader);
 	if (read_format & PERF_FORMAT_ID)
@@ -6274,7 +6485,7 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 
 		if ((sub != event) &&
 		    (sub->state == PERF_EVENT_STATE_ACTIVE))
-			sub->pmu->read(sub);
+			event_pmu_read(sub);
 
 		values[n++] = perf_event_count(sub);
 		if (read_format & PERF_FORMAT_ID)
@@ -9539,7 +9750,7 @@ static enum hrtimer_restart perf_swevent_hrtimer(struct hrtimer *hrtimer)
 	if (event->state != PERF_EVENT_STATE_ACTIVE)
 		return HRTIMER_NORESTART;
 
-	event->pmu->read(event);
+	event_pmu_read(event);
 
 	perf_sample_data_init(&data, 0, event->hw.last_period);
 	regs = get_irq_regs();
@@ -10430,6 +10641,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	event->id		= atomic64_inc_return(&perf_event_id);
 
 	event->state		= PERF_EVENT_STATE_INACTIVE;
+	event->dup_id		= -1;
 
 	if (task) {
 		event->attach_state = PERF_ATTACH_TASK;
@@ -10986,6 +11198,14 @@ SYSCALL_DEFINE5(perf_event_open,
 		goto err_cred;
 	}
 
+	if (perf_event_can_share(event)) {
+		event->tmp_master = perf_event_alloc(&event->attr, cpu,
+						     task, NULL, NULL,
+						     NULL, NULL, -1);
+		if (IS_ERR(event->tmp_master))
+			event->tmp_master = NULL;
+	}
+
 	if (is_sampling_event(event)) {
 		if (event->pmu->capabilities & PERF_PMU_CAP_NO_INTERRUPT) {
 			err = -EOPNOTSUPP;
@@ -11197,9 +11417,17 @@ SYSCALL_DEFINE5(perf_event_open,
 		perf_remove_from_context(group_leader, 0);
 		put_ctx(gctx);
 
+		/*
+		 * move_group only happens to sw events, from sw ctx to hw
+		 * ctx. The sw events should not have valid dup_id. So it
+		 * is not necessary to handle dup_events.
+		 */
+		WARN_ON_ONCE(group_leader->dup_id != -1);
+
 		for_each_sibling_event(sibling, group_leader) {
 			perf_remove_from_context(sibling, 0);
 			put_ctx(gctx);
+			WARN_ON_ONCE(sibling->dup_id != -1);
 		}
 
 		/*
@@ -11257,6 +11485,9 @@ SYSCALL_DEFINE5(perf_event_open,
 		put_task_struct(task);
 	}
 
+	/* if event->tmp_master is not used by ctx->dup_events, free it */
+	perf_event_free_tmp_master(event);
+
 	mutex_lock(&current->perf_event_mutex);
 	list_add_tail(&event->owner_entry, &current->perf_event_list);
 	mutex_unlock(&current->perf_event_mutex);
@@ -11401,6 +11632,7 @@ void perf_pmu_migrate_context(struct pmu *pmu, int src_cpu, int dst_cpu)
 		perf_remove_from_context(event, 0);
 		unaccount_event_cpu(event, src_cpu);
 		put_ctx(src_ctx);
+		perf_event_free_tmp_master(event);
 		list_add(&event->migrate_entry, &events);
 	}
 
@@ -11773,6 +12005,14 @@ inherit_event(struct perf_event *parent_event,
 	if (IS_ERR(child_event))
 		return child_event;
 
+	if (perf_event_can_share(child_event)) {
+		child_event->tmp_master = perf_event_alloc(&parent_event->attr,
+							   parent_event->cpu,
+							   child, NULL, NULL,
+							   NULL, NULL, -1);
+		if (IS_ERR(child_event->tmp_master))
+			child_event->tmp_master = NULL;
+	}
 
 	if ((child_event->attach_state & PERF_ATTACH_TASK_DATA) &&
 	    !child_ctx->task_ctx_data) {
@@ -11827,6 +12067,10 @@ inherit_event(struct perf_event *parent_event,
 	child_event->overflow_handler = parent_event->overflow_handler;
 	child_event->overflow_handler_context
 		= parent_event->overflow_handler_context;
+	if (child_event->tmp_master) {
+		child_event->tmp_master->ctx = child_ctx;
+		get_ctx(child_ctx);
+	}
 
 	/*
 	 * Precalculate sample_data sizes
@@ -11841,6 +12085,7 @@ inherit_event(struct perf_event *parent_event,
 	add_event_to_ctx(child_event, child_ctx);
 	raw_spin_unlock_irqrestore(&child_ctx->lock, flags);
 
+	perf_event_free_tmp_master(child_event);
 	/*
 	 * Link this into the parent event's child list
 	 */
@@ -12112,6 +12357,7 @@ static void perf_event_exit_cpu_context(int cpu)
 {
 	struct perf_cpu_context *cpuctx;
 	struct perf_event_context *ctx;
+	struct perf_event *event;
 	struct pmu *pmu;
 
 	mutex_lock(&pmus_lock);
@@ -12123,6 +12369,8 @@ static void perf_event_exit_cpu_context(int cpu)
 		smp_call_function_single(cpu, __perf_event_exit_context, ctx, 1);
 		cpuctx->online = 0;
 		mutex_unlock(&ctx->mutex);
+		list_for_each_entry(event, &ctx->event_list, event_entry)
+			perf_event_free_tmp_master(event);
 	}
 	cpumask_clear_cpu(cpu, perf_online_mask);
 	mutex_unlock(&pmus_lock);
-- 
2.17.1

