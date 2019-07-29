Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F34CD79A9A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 23:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbfG2VIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 17:08:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57054 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729298AbfG2VIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:08:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5F3F530860C6;
        Mon, 29 Jul 2019 21:08:36 +0000 (UTC)
Received: from llong.com (dhcp-17-160.bos.redhat.com [10.18.17.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5E8175C1A1;
        Mon, 29 Jul 2019 21:08:30 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Phil Auld <pauld@redhat.com>, Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v3] sched/core: Don't use dying mm as active_mm of kthreads
Date:   Mon, 29 Jul 2019 17:07:28 -0400
Message-Id: <20190729210728.21634-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 29 Jul 2019 21:08:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was found that a dying mm_struct where the owning task has exited
can stay on as active_mm of kernel threads as long as no other user
tasks run on those CPUs that use it as active_mm. This prolongs the
life time of dying mm holding up some resources that cannot be freed
on a mostly idle system.

Fix that by forcing the kernel threads to use init_mm as the active_mm
during a kernel thread to kernel thread transition if the previous
active_mm is dying (!mm_users). This will allows the freeing of resources
associated with the dying mm ASAP.

The presence of a kernel-to-kernel thread transition indicates that
the cpu is probably idling with no higher priority user task to run.
So the overhead of loading the mm_users cacheline should not really
matter in this case.

My testing on an x86 system showed that the mm_struct was freed within
seconds after the task exited instead of staying alive for minutes or
even longer on a mostly idle system before this patch.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/sched/core.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 795077af4f1a..41997e676251 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3214,6 +3214,8 @@ static __always_inline struct rq *
 context_switch(struct rq *rq, struct task_struct *prev,
 	       struct task_struct *next, struct rq_flags *rf)
 {
+	struct mm_struct *next_mm = next->mm;
+
 	prepare_task_switch(rq, prev, next);
 
 	/*
@@ -3229,8 +3231,22 @@ context_switch(struct rq *rq, struct task_struct *prev,
 	 *
 	 * kernel ->   user   switch + mmdrop() active
 	 *   user ->   user   switch
+	 *
+	 * kernel -> kernel and !prev->active_mm->mm_users:
+	 *   switch to init_mm + mmgrab() + mmdrop()
 	 */
-	if (!next->mm) {                                // to kernel
+	if (!next_mm) {					// to kernel
+		/*
+		 * Checking is only done on kernel -> kernel transition
+		 * to avoid any performance overhead while user tasks
+		 * are running.
+		 */
+		if (unlikely(!prev->mm &&
+			     !atomic_read(&prev->active_mm->mm_users))) {
+			next_mm = next->active_mm = &init_mm;
+			mmgrab(next_mm);
+			goto mm_switch;
+		}
 		enter_lazy_tlb(prev->active_mm, next);
 
 		next->active_mm = prev->active_mm;
@@ -3239,6 +3255,7 @@ context_switch(struct rq *rq, struct task_struct *prev,
 		else
 			prev->active_mm = NULL;
 	} else {                                        // to user
+mm_switch:
 		/*
 		 * sys_membarrier() requires an smp_mb() between setting
 		 * rq->curr and returning to userspace.
@@ -3248,7 +3265,7 @@ context_switch(struct rq *rq, struct task_struct *prev,
 		 * finish_task_switch()'s mmdrop().
 		 */
 
-		switch_mm_irqs_off(prev->active_mm, next->mm, next);
+		switch_mm_irqs_off(prev->active_mm, next_mm, next);
 
 		if (!prev->mm) {                        // from kernel
 			/* will mmdrop() in finish_task_switch(). */
-- 
2.18.1

