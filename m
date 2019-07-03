Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47E215C9AA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 09:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbfGBHAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 03:00:33 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:33261 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfGBHAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 03:00:31 -0400
Received: by mail-ua1-f74.google.com with SMTP id p19so2908883uar.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 00:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jkIEDx9lhGbtl8GTNeQPYnayKb1QjpDnYWNlSgnDX2I=;
        b=RcDlj3ZnKCKLHUAPQvuFulCdmds7/PL25rWSpP2prx7gXDuUu0yQe4mwbTX/BXdk7j
         zY5EtxwxvOgcKuplH399tndhLLfGykFadpWzABkxYsB5ZgwJUxlXUBqSWMVaewTv/xXS
         qB1R9i4aq3H+YJQ5WORW1jbWdbYOThRU+2/8r7QBdB5yf0beKje8YniVwbUJMfUSoOcj
         fdE/hXlDMAViknFH/F8L08npHwi0mJ8Bdx/2fexanmp0Pq+vMVt+3pwwGcSKSHA/awmG
         vdZ0L9051/4rbbtgkfmJXj0BLLkBsxrZf2xe7lYsvEgZxC0Ov8/tU7Y2AR5hz9g5AMHC
         qB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jkIEDx9lhGbtl8GTNeQPYnayKb1QjpDnYWNlSgnDX2I=;
        b=W/ejUUzwdGq1dHECMF1dXBkkpfVgixGV0U9IyNZlTql2phgod1bK/uts7i0SIXm8Uo
         JKBeOccII2YoeQMp95jbJvazJmgCjhzS3P88MBt6x7BWFMEeM27OGJDL2hFfyiYWLbk8
         gGOkCkOYSmFH6f8otujHaHmGoaWEKfISLXWv0oo9lyhV2ohZ8+nsYUjf4EoeKANyzrBt
         OimxnCBYOYfWOsibJ6Jjwd6qwBakJQBcNHm95HKKaRBikf8GfoHbw88YEUKPT5f/Hkkg
         nbAfcG0Ty2CycZKvRBvvYATWY70syxeUN773ZL6aqMfbPX1CMsDzHIaPAvSQJmkyCDRV
         aLYw==
X-Gm-Message-State: APjAAAWOvNMw7GuwYzDA4Z4HveulBB3sG3SUxlPp7S3xK920n1fo8eEC
        E1IIfw2LfwJy0k6NcxGUngLkYa6kKUQV
X-Google-Smtp-Source: APXvYqwF8o3bkjVZ4hA0skprsqG5lUUbJl9am9OSOjO3d17+dYVv33sRwZdy3j0kQisXCm8+QxdZWoDkWU7W
X-Received: by 2002:a67:d39e:: with SMTP id b30mr16845811vsj.212.1562050830069;
 Tue, 02 Jul 2019 00:00:30 -0700 (PDT)
Date:   Mon,  1 Jul 2019 23:59:52 -0700
In-Reply-To: <20190702065955.165738-1-irogers@google.com>
Message-Id: <20190702065955.165738-5-irogers@google.com>
Mime-Version: 1.0
References: <20190702065955.165738-1-irogers@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH 4/7] perf: avoid a bounded set of visit_groups_merge iterators
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a per-cpu array of iterators that gets resized when cgroup events
are added. The size of the array reflects the maximum depth of cgroups,
although not all cgroups will have events monitored within them. This
approach avoids added storage cost to perf_event.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 include/linux/perf_event.h |  2 +
 kernel/events/core.c       | 94 ++++++++++++++++++++++++++++----------
 2 files changed, 71 insertions(+), 25 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 16e38c286d46..5c479f61622c 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -802,6 +802,8 @@ struct perf_cpu_context {
 #ifdef CONFIG_CGROUP_PERF
 	struct perf_cgroup		*cgrp;
 	struct list_head		cgrp_cpuctx_entry;
+	struct perf_event		**visit_groups_merge_iterator_storage;
+	int			       visit_groups_merge_iterator_storage_size;
 #endif
 
 	struct list_head		sched_cb_entry;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 396b5ac6dcd4..a2c5ea868de9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1711,6 +1711,20 @@ perf_event_groups_next(struct perf_event *event)
 	return next;
 }
 
+#ifdef CONFIG_CGROUP_PERF
+int perf_event_cgroup_depth(struct perf_event *event)
+{
+	struct cgroup_subsys_state *css;
+	struct perf_cgroup *cgrp = event->cgrp;
+	int depth = 0;
+
+	if (cgrp)
+		for (css = &cgrp->css; css; css = css->parent)
+			depth++;
+	return depth;
+}
+#endif
+
 /*
  * Iterate through the whole groups tree.
  */
@@ -2592,6 +2606,7 @@ static int  __perf_install_in_context(void *info)
 
 #ifdef CONFIG_CGROUP_PERF
 	if (is_cgroup_event(event)) {
+		int max_iterators;
 		/*
 		 * If the current cgroup doesn't match the event's
 		 * cgroup, we should not try to schedule it.
@@ -2599,6 +2614,30 @@ static int  __perf_install_in_context(void *info)
 		struct perf_cgroup *cgrp = perf_cgroup_from_task(current, ctx);
 		reprogram = cgroup_is_descendant(cgrp->css.cgroup,
 					event->cgrp->css.cgroup);
+
+		/*
+		 * Ensure space for visit_groups_merge iterator storage. With
+		 * cgroup profiling we may have an event at each depth plus
+		 * system wide events.
+		 */
+		max_iterators = perf_event_cgroup_depth(event) + 1;
+		if (max_iterators >
+		    cpuctx->visit_groups_merge_iterator_storage_size) {
+			struct perf_event **storage =
+			   krealloc(cpuctx->visit_groups_merge_iterator_storage,
+				    sizeof(struct perf_event *) * max_iterators,
+				    GFP_KERNEL);
+			if (storage) {
+				cpuctx->visit_groups_merge_iterator_storage
+						= storage;
+				cpuctx->visit_groups_merge_iterator_storage_size
+						= max_iterators;
+			} else {
+				WARN_ONCE(1, "Unable to increase iterator "
+					"storage for perf events with cgroups");
+				ret = -ENOMEM;
+			}
+		}
 	}
 #endif
 
@@ -3389,6 +3428,13 @@ static void min_heap_pop_push(struct perf_event_heap *heap,
 	}
 }
 
+
+/*
+ * Without cgroups, with a task context, there may be per-CPU and any
+ * CPU events.
+ */
+#define MIN_VISIT_GROUP_MERGE_ITERATORS 2
+
 static int visit_groups_merge(struct perf_event_context *ctx,
 			      struct perf_cpu_context *cpuctx,
 			      struct perf_event_groups *groups,
@@ -3398,35 +3444,27 @@ static int visit_groups_merge(struct perf_event_context *ctx,
 					  int *),
 			      int *data)
 {
-#ifndef CONFIG_CGROUP_PERF
-	/*
-	 * Without cgroups, with a task context, iterate over per-CPU and any
-	 * CPU events.
-	 */
-	const int max_itrs = 2;
-#else
-	/*
-	 * The depth of cgroups is limited by MAX_PATH. It is unlikely that this
-	 * many parent-child related cgroups will have perf events
-	 * monitored. Limit the number of cgroup iterators to 16.
-	 */
-	const int max_cgroups_with_events_depth = 16;
-	/*
-	 * With cgroups we either iterate for a task context (per-CPU or any CPU
-	 * events) or for per CPU the global and per cgroup events.
-	 */
-	const int max_itrs = max(2, 1 + max_cgroups_with_events_depth);
-#endif
 	/*
 	 * A set of iterators, the iterator for the visit is chosen by the
 	 * group_index.
 	 */
-	struct perf_event *itrs[max_itrs];
+#ifndef CONFIG_CGROUP_PERF
+	struct perf_event *itrs[MIN_VISIT_GROUP_MERGE_ITERATORS];
 	struct perf_event_heap heap = {
 		.storage = itrs,
 		.num_elements = 0,
-		.max_elements = max_itrs
+		.max_elements = MIN_VISIT_GROUP_MERGE_ITERATORS
 	};
+#else
+	/*
+	 * With cgroups usage space in the CPU context reserved for iterators.
+	 */
+	struct perf_event_heap heap = {
+		.storage = cpuctx->visit_groups_merge_iterator_storage,
+		.num_elements = 0,
+		.max_elements = cpuctx->visit_groups_merge_iterator_storage_size
+	};
+#endif
 	int ret, cpu = smp_processor_id();
 
 	heap.storage[0] = perf_event_groups_first(groups, cpu, NULL);
@@ -3461,9 +3499,8 @@ static int visit_groups_merge(struct perf_event_context *ctx,
 					heap.num_elements++;
 					if (heap.num_elements ==
 					    heap.max_elements) {
-						WARN_ONCE(
-				     max_cgroups_with_events_depth,
-				     "Insufficient iterators for cgroup depth");
+						WARN_ONCE(1,
+						"per-CPU min-heap under sized");
 						break;
 					}
 				}
@@ -10155,7 +10192,14 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 		lockdep_set_class(&cpuctx->ctx.lock, &cpuctx_lock);
 		cpuctx->ctx.pmu = pmu;
 		cpuctx->online = cpumask_test_cpu(cpu, perf_online_mask);
-
+#ifdef CONFIG_CGROUP_PERF
+		cpuctx->visit_groups_merge_iterator_storage =
+				kmalloc_array(MIN_VISIT_GROUP_MERGE_ITERATORS,
+					      sizeof(struct perf_event *),
+					      GFP_KERNEL);
+		cpuctx->visit_groups_merge_iterator_storage_size =
+				MIN_VISIT_GROUP_MERGE_ITERATORS;
+#endif
 		__perf_mux_hrtimer_init(cpuctx, cpu);
 	}
 
-- 
2.22.0.410.gd8fdbe21b5-goog

