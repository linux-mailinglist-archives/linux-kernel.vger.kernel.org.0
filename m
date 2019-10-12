Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73FB8D4DB8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2019 08:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbfJLGwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Oct 2019 02:52:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54390 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbfJLGwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 02:52:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3A81C6908D;
        Sat, 12 Oct 2019 06:52:21 +0000 (UTC)
Received: from t460p.redhat.com (ovpn-117-172.phx2.redhat.com [10.3.117.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 64D8160A97;
        Sat, 12 Oct 2019 06:52:20 +0000 (UTC)
From:   Scott Wood <swood@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Scott Wood <swood@redhat.com>
Subject: [PATCH RT v2 1/3] sched: migrate_enable: Use select_fallback_rq()
Date:   Sat, 12 Oct 2019 01:52:12 -0500
Message-Id: <20191012065214.28109-2-swood@redhat.com>
In-Reply-To: <20191012065214.28109-1-swood@redhat.com>
References: <20191012065214.28109-1-swood@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Sat, 12 Oct 2019 06:52:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

migrate_enable() currently open-codes a variant of select_fallback_rq().
However, it does not have the "No more Mr. Nice Guy" fallback and thus
it will pass an invalid CPU to the migration thread if cpus_mask only
contains a CPU that is !active.

Signed-off-by: Scott Wood <swood@redhat.com>
---
This scenario will be more likely after the next patch, since
the migrate_disable_update check goes away.  However, it could happen
anyway if cpus_mask was updated to a CPU other than the one we were
pinned to, and that CPU subsequently became inactive.
---
 kernel/sched/core.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 93b4ae1ecaff..bfd160e90797 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7405,6 +7405,7 @@ void migrate_enable(void)
 	if (p->migrate_disable_update) {
 		struct rq *rq;
 		struct rq_flags rf;
+		int cpu = task_cpu(p);
 
 		rq = task_rq_lock(p, &rf);
 		update_rq_clock(rq);
@@ -7414,21 +7415,15 @@ void migrate_enable(void)
 
 		p->migrate_disable_update = 0;
 
-		WARN_ON(smp_processor_id() != task_cpu(p));
-		if (!cpumask_test_cpu(task_cpu(p), &p->cpus_mask)) {
-			const struct cpumask *cpu_valid_mask = cpu_active_mask;
-			struct migration_arg arg;
-			unsigned int dest_cpu;
-
-			if (p->flags & PF_KTHREAD) {
-				/*
-				 * Kernel threads are allowed on online && !active CPUs
-				 */
-				cpu_valid_mask = cpu_online_mask;
-			}
-			dest_cpu = cpumask_any_and(cpu_valid_mask, &p->cpus_mask);
-			arg.task = p;
-			arg.dest_cpu = dest_cpu;
+		WARN_ON(smp_processor_id() != cpu);
+		if (!cpumask_test_cpu(cpu, &p->cpus_mask)) {
+			struct migration_arg arg = { p };
+			struct rq_flags rf;
+
+			rq = task_rq_lock(p, &rf);
+			update_rq_clock(rq);
+			arg.dest_cpu = select_fallback_rq(cpu, p);
+			task_rq_unlock(rq, p, &rf);
 
 			unpin_current_cpu();
 			preempt_lazy_enable();
-- 
1.8.3.1

