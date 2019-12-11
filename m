Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB8B311B90D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 17:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730714AbfLKQor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 11:44:47 -0500
Received: from foss.arm.com ([217.140.110.172]:38696 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730621AbfLKQom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 11:44:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF3601007;
        Wed, 11 Dec 2019 08:44:41 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 15B993F52E;
        Wed, 11 Dec 2019 08:44:40 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com
Subject: [RFC PATCH 7/7] sched/topology: Define and use shortcut pointers for wakeup sd_flag scan
Date:   Wed, 11 Dec 2019 16:44:01 +0000
Message-Id: <20191211164401.5013-8-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211164401.5013-1-valentin.schneider@arm.com>
References: <20191211164401.5013-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reworking select_task_rq_fair()'s domain walk exposed that !want_affine
wakeups only look for highest sched_domain with the required sd_flag
set. This is something we can cache at sched domain build time to slightly
optimize select_task_rq_fair(). Note that this isn't a "free" optimization:
it costs us 3 pointers per CPU.

Add cached per-CPU pointers for the highest domains with SD_BALANCE_WAKE,
SD_BALANCE_EXEC and SD_BALANCE_FORK. Do note that these are exclusively
used in select_task_rq_fair(), which also requires SD_LOAD_BALANCE, so the
cached pointers are also gated by SD_LOAD_BALANCE (which is somewhat icky).

There is another nasty thing that comes out of this: with the
sched_domain/* sysctl knobs, one could e.g. clear SD_LOAD_BALANCE for some
CPU(s) (AFAIK the only way to clear that flag ATM). Before this patch,
that would disable entering find_idlest_cpu() from said CPU(s). With this
patch, writing to the SD flags sysctl wouldn't lead to any cached SD
pointer update, so we'd keep going through the slow-path.

This isn't a new problem (all cached domain pointers are affected by this),
but it is a change in behaviour. It could make sense to either turn this
interface read-only, or add a callback in the flags update to properly
update our cached domain data.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c     | 25 +++++++++++++------------
 kernel/sched/sched.h    |  3 +++
 kernel/sched/topology.c | 12 ++++++++++++
 3 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ea875c7c82d7..5b72597d6540 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6344,17 +6344,6 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 	int want_affine = 0;
 	int sd_flag;
 
-	switch (wake_flags & (WF_TTWU | WF_FORK | WF_EXEC)) {
-	case WF_TTWU:
-		sd_flag = SD_BALANCE_WAKE;
-		break;
-	case WF_FORK:
-		sd_flag = SD_BALANCE_FORK;
-		break;
-	default:
-		sd_flag = SD_BALANCE_EXEC;
-	}
-
 	if (wake_flags & WF_TTWU) {
 		record_wakee(p);
 
@@ -6371,7 +6360,19 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 
 	rcu_read_lock();
 
-	sd = highest_flags_domain(cpu, sd_flag | SD_LOAD_BALANCE);
+	switch (wake_flags & (WF_TTWU | WF_FORK | WF_EXEC)) {
+	case WF_TTWU:
+		sd_flag = SD_BALANCE_WAKE;
+		sd = rcu_dereference(per_cpu(sd_balance_wake, cpu));
+		break;
+	case WF_FORK:
+		sd_flag = SD_BALANCE_FORK;
+		sd = rcu_dereference(per_cpu(sd_balance_fork, cpu));
+		break;
+	default:
+		sd_flag = SD_BALANCE_EXEC;
+		sd = rcu_dereference(per_cpu(sd_balance_exec, cpu));
+	}
 
 	/*
 	 * If !want_affine, we just look for the highest domain where
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 233b3d41e347..ba9d55085c7b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1386,6 +1386,9 @@ DECLARE_PER_CPU(struct sched_domain __rcu *, sd_llc);
 DECLARE_PER_CPU(int, sd_llc_size);
 DECLARE_PER_CPU(int, sd_llc_id);
 DECLARE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
+DECLARE_PER_CPU(struct sched_domain __rcu *, sd_balance_wake);
+DECLARE_PER_CPU(struct sched_domain __rcu *, sd_balance_exec);
+DECLARE_PER_CPU(struct sched_domain __rcu *, sd_balance_fork);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index f0d2a15fd10b..f76f40b64279 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -619,6 +619,9 @@ DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
 DEFINE_PER_CPU(int, sd_llc_size);
 DEFINE_PER_CPU(int, sd_llc_id);
 DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
+DEFINE_PER_CPU(struct sched_domain __rcu *, sd_balance_wake);
+DEFINE_PER_CPU(struct sched_domain __rcu *, sd_balance_exec);
+DEFINE_PER_CPU(struct sched_domain __rcu *, sd_balance_fork);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
@@ -643,6 +646,15 @@ static void update_top_cache_domain(int cpu)
 	per_cpu(sd_llc_id, cpu) = id;
 	rcu_assign_pointer(per_cpu(sd_llc_shared, cpu), sds);
 
+	sd = highest_flags_domain(cpu, SD_BALANCE_WAKE | SD_LOAD_BALANCE);
+	rcu_assign_pointer(per_cpu(sd_balance_wake, cpu), sd);
+
+	sd = highest_flags_domain(cpu, SD_BALANCE_FORK | SD_LOAD_BALANCE);
+	rcu_assign_pointer(per_cpu(sd_balance_fork, cpu), sd);
+
+	sd = highest_flags_domain(cpu, SD_BALANCE_EXEC | SD_LOAD_BALANCE);
+	rcu_assign_pointer(per_cpu(sd_balance_exec, cpu), sd);
+
 	sd = lowest_flags_domain(cpu, SD_NUMA);
 	rcu_assign_pointer(per_cpu(sd_numa, cpu), sd);
 
-- 
2.24.0

