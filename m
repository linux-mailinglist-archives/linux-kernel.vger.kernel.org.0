Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0016C2426C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 23:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfETVAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 17:00:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42398 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbfETVAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 17:00:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 706F55D61E;
        Mon, 20 May 2019 21:00:23 +0000 (UTC)
Received: from llong.com (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D60F64049;
        Mon, 20 May 2019 21:00:22 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v8 19/19] locking/rwsem: Disable preemption in down_read*() if owner in count
Date:   Mon, 20 May 2019 16:59:18 -0400
Message-Id: <20190520205918.22251-20-longman@redhat.com>
In-Reply-To: <20190520205918.22251-1-longman@redhat.com>
References: <20190520205918.22251-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 20 May 2019 21:00:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is very unlikely that successive preemption at the middle of
down_read's inc-check-dec sequence will cause the reader count to
overflow, For absolute correctness, however, we still need to prevent
that possibility from happening. So preemption will be disabled during
the down_read*() call.

For PREEMPT=n kernels, there isn't much overhead in doing that.
For PREEMPT=y kernels, there will be some additional cost. RT kernels
have their own rwsem code, so it will not be a problem for them.

If MERGE_OWNER_INTO_COUNT isn't defined, we don't need to worry about
reader count overflow and so we don't need to disable preemption.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 29f0e0e5b62e..cede2f99220b 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -356,6 +356,24 @@ static inline void rwsem_set_nonspinnable(struct rw_semaphore *sem)
 }
 
 #ifdef MERGE_OWNER_INTO_COUNT
+/*
+ * It is very unlikely that successive preemption at the middle of
+ * down_read's inc-check-dec sequence will cause the reader count to
+ * overflow, For absolute correctness, we still need to prevent
+ * that possibility from happening. So preemption will be disabled
+ * during the down_read*() call.
+ *
+ * For PREEMPT=n kernels, there isn't much overhead in doing that.
+ * For PREEMPT=y kernels, there will be some additional cost.
+ *
+ * If MERGE_OWNER_INTO_COUNT isn't defined, we don't need to worry
+ * about reader count overflow and so we don't need to disable
+ * preemption.
+ */
+#define rwsem_preempt_disable()			preempt_disable()
+#define rwsem_preempt_enable()			preempt_enable()
+#define rwsem_schedule_preempt_disabled()	schedule_preempt_disabled()
+
 /*
  * Get the owner value from count to have early access to the task structure.
  */
@@ -420,6 +438,10 @@ late_initcall(rwsem_show_count_status);
 
 #else /* !MERGE_OWNER_INTO_COUNT */
 
+#define rwsem_preempt_disable()
+#define rwsem_preempt_enable()
+#define rwsem_schedule_preempt_disabled()	schedule()
+
 /*
  * Return just the real task structure pointer of the owner
  */
@@ -1247,7 +1269,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state, long adjustment)
 			raw_spin_unlock_irq(&sem->wait_lock);
 			break;
 		}
-		schedule();
+		rwsem_schedule_preempt_disabled();
 		lockevent_inc(rwsem_sleep_reader);
 	}
 
@@ -1472,28 +1494,36 @@ static struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem)
  */
 inline void __down_read(struct rw_semaphore *sem)
 {
-	long tmp, adjustment = rwsem_read_trylock(sem, &tmp);
+	long tmp, adjustment;
 
+	rwsem_preempt_disable();
+	adjustment = rwsem_read_trylock(sem, &tmp);
 	if (unlikely(tmp & RWSEM_READ_FAILED_MASK)) {
 		rwsem_down_read_slowpath(sem, TASK_UNINTERRUPTIBLE, adjustment);
 		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	} else {
 		rwsem_set_reader_owned(sem);
 	}
+	rwsem_preempt_enable();
 }
 
 static inline int __down_read_killable(struct rw_semaphore *sem)
 {
-	long tmp, adjustment = rwsem_read_trylock(sem, &tmp);
+	long tmp, adjustment;
 
+	rwsem_preempt_disable();
+	adjustment = rwsem_read_trylock(sem, &tmp);
 	if (unlikely(tmp & RWSEM_READ_FAILED_MASK)) {
 		if (IS_ERR(rwsem_down_read_slowpath(sem, TASK_KILLABLE,
-						    adjustment)))
+						    adjustment))) {
+			rwsem_preempt_enable();
 			return -EINTR;
+		}
 		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	} else {
 		rwsem_set_reader_owned(sem);
 	}
+	rwsem_preempt_enable();
 	return 0;
 }
 
-- 
2.18.1

