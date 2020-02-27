Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2560171F61
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 15:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387436AbgB0OfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 09:35:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:45204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387911AbgB0OeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:34:14 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8084B246BB;
        Thu, 27 Feb 2020 14:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582814053;
        bh=R0LTnhxsgRuXLRhJuPDr/LBV2cxOdDlF+48t6yCQXxg=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=WcnhcUDmCmTvUaXgs0G7oN8ifZTdQWtKw32t7dM4iyWDOlyoM83kt4RL6bNHhRnwS
         KDt9CqS6KIzjmQYz44xeGrxuECx3Wb1zBDRxut+4+eg+fpyp1VywjXIlWB+gRwYaiC
         WdM8OTiU438Dj0rG6+THrcOm9yWjUufzJ2FGeyO4=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 16/23] sched: migrate_enable: Use select_fallback_rq()
Date:   Thu, 27 Feb 2020 08:33:27 -0600
Message-Id: <e39f1b40d8f989b76f0ca0e86b4bf42258dce04e.1582814004.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1582814004.git.zanussi@kernel.org>
References: <cover.1582814004.git.zanussi@kernel.org>
In-Reply-To: <cover.1582814004.git.zanussi@kernel.org>
References: <cover.1582814004.git.zanussi@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Scott Wood <swood@redhat.com>

v4.14.170-rt75-rc2 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit adfa969d4cfcc995a9d866020124e50f1827d2d1 ]

migrate_enable() currently open-codes a variant of select_fallback_rq().
However, it does not have the "No more Mr. Nice Guy" fallback and thus
it will pass an invalid CPU to the migration thread if cpus_mask only
contains a CPU that is !active.

Signed-off-by: Scott Wood <swood@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/sched/core.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 189e6f08575e..46324d2099e3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7008,6 +7008,7 @@ void migrate_enable(void)
 	if (p->migrate_disable_update) {
 		struct rq *rq;
 		struct rq_flags rf;
+		int cpu = task_cpu(p);
 
 		rq = task_rq_lock(p, &rf);
 		update_rq_clock(rq);
@@ -7017,21 +7018,15 @@ void migrate_enable(void)
 
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
2.14.1

