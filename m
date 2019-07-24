Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E002774191
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 00:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388485AbfGXWi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 18:38:59 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:52659 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388289AbfGXWi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 18:38:58 -0400
Received: by mail-pf1-f201.google.com with SMTP id a20so29479938pfn.19
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 15:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jYzOQuLjACO1jCX76ypB0SXi+99DekEskl91WobYek4=;
        b=TkDn1s08SSK80z6MQofaTE+gGf7Nl+sXsTo8Ejo61c6qEDIr2c9v18fACAh1y7iv1I
         xj7epzKDqflPOG/ZNPy9jqGPe+WHABiPYzvfb4fXuvM8XZzrhzJcc7AdhZQFqq5pxfwc
         zvO77Mx5oJ4EwdQ2AoGhwdfI3ry2JkiwFTamPpNNtT9SW2RVFR6gy9wJ8MhwhAa79OtE
         skkxMGv9YgM564EDRVTv3wnW4F9nv+U4+Egsyy4pXsrRUX7WhoVk2M+MqwQHRzEVV+4Q
         pOwHCvQrO6guLDtQbeDRBLyTc6+1cgwwQ8/Xs4a+LfgogL9ax4JxcqtyZq/lRmLarPuB
         gTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jYzOQuLjACO1jCX76ypB0SXi+99DekEskl91WobYek4=;
        b=iva51JqWg6US6mHHdaa03nUWH6/g45ZE7qfO3Pm2tg6SXRF0FmnomPhEv02wW9B4V5
         VgxpFGF16osLJArvVtmodOwcYIrNbHp46nSrD45oAoieTy7YppXXRTZHIKabqri9FhEj
         t/B3yMIPt964MlFBo0blKQw6B517crOWYRuLE8lD+j185Q0/IaogI9irEf5YQkoaWeq8
         a/oKUnFocvizVFrsbn/OdpNwXoESPNs54Q9uhDH6CHzM6bZOAG2pK6I2wmDwrHMzJ5kK
         AhQ3g9DRhR1QseoJ+H0n9b6nUmc4vnoHOxnRJVPIQ/MYy2oio/cu1idl7KqzXOWyj5O5
         UAYg==
X-Gm-Message-State: APjAAAVGdJMiyUYsm5xOPZUlQB8nLZiaUaOJHW30+rb4b4weCV+tj7cp
        CU66lAGiEc3Zd2rrOsU3GcOSDChJX6vP
X-Google-Smtp-Source: APXvYqycV3hMS7LnNSOT3g/d6WMCWuz0U9Hc+r9CLGV3kFiVSFUku6SRjNnyyandB2GuEr/s37pugYUNy68U
X-Received: by 2002:a65:464d:: with SMTP id k13mr75192556pgr.99.1564007937507;
 Wed, 24 Jul 2019 15:38:57 -0700 (PDT)
Date:   Wed, 24 Jul 2019 15:37:46 -0700
In-Reply-To: <20190724223746.153620-1-irogers@google.com>
Message-Id: <20190724223746.153620-8-irogers@google.com>
Mime-Version: 1.0
References: <20190702065955.165738-1-irogers@google.com> <20190724223746.153620-1-irogers@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v2 7/7] perf: rename visit_groups_merge to ctx_groups_sched_in
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

The visit_groups_merge function no longer takes a function pointer,
change the name to be similar to other sched_in functions.
Follow Kan Liang's <kan.liang@linux.intel.com> and remove the single
caller flexible_sched_in and pinned_sched_in, moving functionality to
caller.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 include/linux/perf_event.h |  4 +-
 kernel/events/core.c       | 77 ++++++++++++++++----------------------
 2 files changed, 35 insertions(+), 46 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 2d411786ab87..4ef3e954fa44 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -802,8 +802,8 @@ struct perf_cpu_context {
 #ifdef CONFIG_CGROUP_PERF
 	struct perf_cgroup		*cgrp;
 	struct list_head		cgrp_cpuctx_entry;
-	struct perf_event		**visit_groups_merge_iterator_storage;
-	int			       visit_groups_merge_iterator_storage_size;
+	struct perf_event		**ctx_groups_sched_in_iterator_storage;
+	int			      ctx_groups_sched_in_iterator_storage_size;
 #endif
 
 	struct list_head		sched_cb_entry;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index fb1027387e8e..8447cb07e90a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2640,22 +2640,22 @@ static int  __perf_install_in_context(void *info)
 					event->cgrp->css.cgroup);
 
 		/*
-		 * Ensure space for visit_groups_merge iterator storage. With
+		 * Ensure space for ctx_groups_sched_in iterator storage. With
 		 * cgroup profiling we may have an event at each depth plus
 		 * system wide events.
 		 */
 		max_iterators = perf_event_cgroup_depth(event) + 1;
 		if (max_iterators >
-		    cpuctx->visit_groups_merge_iterator_storage_size) {
+		    cpuctx->ctx_groups_sched_in_iterator_storage_size) {
 			struct perf_event **storage =
-			   krealloc(cpuctx->visit_groups_merge_iterator_storage,
+			  krealloc(cpuctx->ctx_groups_sched_in_iterator_storage,
 				    sizeof(struct perf_event *) * max_iterators,
 				    GFP_KERNEL);
 			if (storage) {
-				cpuctx->visit_groups_merge_iterator_storage
-						= storage;
-				cpuctx->visit_groups_merge_iterator_storage_size
-						= max_iterators;
+				cpuctx->ctx_groups_sched_in_iterator_storage
+				    = storage;
+			       cpuctx->ctx_groups_sched_in_iterator_storage_size
+				    = max_iterators;
 			} else {
 				WARN_ONCE(1, "Unable to increase iterator "
 					"storage for perf events with cgroups");
@@ -3471,32 +3471,33 @@ static int flexible_sched_in(struct perf_event_context *ctx,
  * Without cgroups, with a task context, there may be per-CPU and any
  * CPU events.
  */
-#define MIN_VISIT_GROUP_MERGE_ITERATORS 2
+#define MIN_CTX_GROUPS_SCHED_IN_ITERATORS 2
 
-static int visit_groups_merge(struct perf_event_context *ctx,
-			      struct perf_cpu_context *cpuctx,
-			      bool is_pinned,
-			      int *data)
+static int ctx_groups_sched_in(struct perf_event_context *ctx,
+			       struct perf_cpu_context *cpuctx,
+			       bool is_pinned,
+			       int *data)
 {
 	/*
 	 * A set of iterators, the iterator for the visit is chosen by the
 	 * group_index.
 	 */
 #ifndef CONFIG_CGROUP_PERF
-	struct perf_event *itrs[MIN_VISIT_GROUP_MERGE_ITERATORS];
+	struct perf_event *itrs[MIN_CTX_GROUPS_SCHED_IN_ITERATORS];
 	struct perf_event_heap heap = {
 		.storage = itrs,
 		.num_elements = 0,
-		.max_elements = MIN_VISIT_GROUP_MERGE_ITERATORS
+		.max_elements = MIN_CTX_GROUPS_SCHED_IN_ITERATORS
 	};
 #else
 	/*
 	 * With cgroups usage space in the CPU context reserved for iterators.
 	 */
 	struct perf_event_heap heap = {
-		.storage = cpuctx->visit_groups_merge_iterator_storage,
+		.storage = cpuctx->ctx_groups_sched_in_iterator_storage,
 		.num_elements = 0,
-		.max_elements = cpuctx->visit_groups_merge_iterator_storage_size
+		.max_elements =
+			cpuctx->ctx_groups_sched_in_iterator_storage_size
 	};
 #endif
 	int ret, cpu = smp_processor_id();
@@ -3628,27 +3629,6 @@ static int flexible_sched_in(struct perf_event_context *ctx,
 	return 0;
 }
 
-static void
-ctx_pinned_sched_in(struct perf_event_context *ctx,
-		    struct perf_cpu_context *cpuctx)
-{
-	visit_groups_merge(ctx,
-			   cpuctx,
-			   /*is_pinned=*/true,
-			   NULL);
-}
-
-static void
-ctx_flexible_sched_in(struct perf_event_context *ctx,
-		      struct perf_cpu_context *cpuctx)
-{
-	int can_add_hw = 1;
-
-	visit_groups_merge(ctx,
-			   cpuctx,
-			   /*is_pinned=*/false,
-			   &can_add_hw);
-}
 
 static void
 ctx_sched_in(struct perf_event_context *ctx,
@@ -3686,11 +3666,20 @@ ctx_sched_in(struct perf_event_context *ctx,
 	 * in order to give them the best chance of going on.
 	 */
 	if (is_active & EVENT_PINNED)
-		ctx_pinned_sched_in(ctx, cpuctx);
+		ctx_groups_sched_in(ctx,
+				    cpuctx,
+				    /*is_pinned=*/true,
+				    NULL);
 
 	/* Then walk through the lower prio flexible groups */
-	if (is_active & EVENT_FLEXIBLE)
-		ctx_flexible_sched_in(ctx, cpuctx);
+	if (is_active & EVENT_FLEXIBLE) {
+		int can_add_hw = 1;
+
+		ctx_groups_sched_in(ctx,
+				    cpuctx,
+				    /*is_pinned=*/false,
+				    &can_add_hw);
+	}
 }
 
 static void cpu_ctx_sched_in(struct perf_cpu_context *cpuctx,
@@ -10266,12 +10255,12 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 		cpuctx->ctx.pmu = pmu;
 		cpuctx->online = cpumask_test_cpu(cpu, perf_online_mask);
 #ifdef CONFIG_CGROUP_PERF
-		cpuctx->visit_groups_merge_iterator_storage =
-				kmalloc_array(MIN_VISIT_GROUP_MERGE_ITERATORS,
+		cpuctx->ctx_groups_sched_in_iterator_storage =
+				kmalloc_array(MIN_CTX_GROUPS_SCHED_IN_ITERATORS,
 					      sizeof(struct perf_event *),
 					      GFP_KERNEL);
-		cpuctx->visit_groups_merge_iterator_storage_size =
-				MIN_VISIT_GROUP_MERGE_ITERATORS;
+		cpuctx->ctx_groups_sched_in_iterator_storage_size =
+				MIN_CTX_GROUPS_SCHED_IN_ITERATORS;
 #endif
 		__perf_mux_hrtimer_init(cpuctx, cpu);
 	}
-- 
2.22.0.709.g102302147b-goog

