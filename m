Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10F541472BC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 21:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbgAWUkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jan 2020 15:40:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:45840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729360AbgAWUjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 15:39:48 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7E4B2469F;
        Thu, 23 Jan 2020 20:39:47 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1iujGU-000mi3-Jk; Thu, 23 Jan 2020 15:39:46 -0500
Message-Id: <20200123203946.486165030@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 23 Jan 2020 15:39:59 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 29/30] sched: migrate_enable: Busy loop until the migration request is
 completed
References: <20200123203930.646725253@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19.94-rt39-rc2 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 140d7f54a5fff02898d2ca9802b39548bf7455f1 ]

If user task changes the CPU affinity mask of a running task it will
dispatch migration request if the current CPU is no longer allowed. This
might happen shortly before a task enters a migrate_disable() section.
Upon leaving the migrate_disable() section, the task will notice that
the current CPU is no longer allowed and will will dispatch its own
migration request to move it off the current CPU.
While invoking __schedule() the first migration request will be
processed and the task returns on the "new" CPU with "arg.done = 0". Its
own migration request will be processed shortly after and will result in
memory corruption if the stack memory, designed for request, was used
otherwise in the meantime.

Spin until the migration request has been processed if it was accepted.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/sched/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cbd76324babd..4616c086dd26 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7329,7 +7329,7 @@ void migrate_enable(void)
 
 	WARN_ON(smp_processor_id() != cpu);
 	if (!is_cpu_allowed(p, cpu)) {
-		struct migration_arg arg = { p };
+		struct migration_arg arg = { .task = p };
 		struct cpu_stop_work work;
 		struct rq_flags rf;
 
@@ -7342,7 +7342,10 @@ void migrate_enable(void)
 				    &arg, &work);
 		tlb_migrate_finish(p->mm);
 		__schedule(true);
-		WARN_ON_ONCE(!arg.done && !work.disabled);
+		if (!work.disabled) {
+			while (!arg.done)
+				cpu_relax();
+		}
 	}
 
 out:
-- 
2.24.1


