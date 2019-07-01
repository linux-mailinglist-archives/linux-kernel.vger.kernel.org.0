Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E963C24275
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 23:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfETVA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 17:00:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35248 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727023AbfETVAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 17:00:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2F47C3086258;
        Mon, 20 May 2019 21:00:07 +0000 (UTC)
Received: from llong.com (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD357183EA;
        Mon, 20 May 2019 21:00:05 +0000 (UTC)
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
Subject: [PATCH v8 09/19] locking/rwsem: More optimal RT task handling of null owner
Date:   Mon, 20 May 2019 16:59:08 -0400
Message-Id: <20190520205918.22251-10-longman@redhat.com>
In-Reply-To: <20190520205918.22251-1-longman@redhat.com>
References: <20190520205918.22251-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 20 May 2019 21:00:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An RT task can do optimistic spinning only if the lock holder is
actually running. If the state of the lock holder isn't known, there
is a possibility that high priority of the RT task may block forward
progress of the lock holder if it happens to reside on the same CPU.
This will lead to deadlock. So we have to make sure that an RT task
will not spin on a reader-owned rwsem.

When the owner is temporarily set to NULL, there are two cases
where we may want to continue spinning:

 1) The lock owner is in the process of releasing the lock, sem->owner
    is cleared but the lock has not been released yet.

 2) The lock was free and owner cleared, but another task just comes
    in and acquire the lock before we try to get it. The new owner may
    be a spinnable writer.

So an RT task is now made to retry one more time to see if it can
acquire the lock or continue spinning on the new owning writer.

When testing on a 8-socket IvyBridge-EX system, the one additional retry
seems to improve locking performance of RT write locking threads under
heavy contentions. The table below shows the locking rates (in kops/s)
with various write locking threads before and after the patch.

    Locking threads     Pre-patch     Post-patch
    ---------------     ---------     -----------
            4             2,753          2,608
            8             2,529          2,520
           16             1,727          1,918
           32             1,263          1,956
           64               889          1,343

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem.c | 51 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 36aed5236bd2..eb43201b89b4 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -566,6 +566,7 @@ static noinline enum owner_state rwsem_spin_on_owner(struct rw_semaphore *sem)
 static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 {
 	bool taken = false;
+	int prev_owner_state = OWNER_NULL;
 
 	preempt_disable();
 
@@ -583,7 +584,12 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 	 *  2) readers own the lock as we can't determine if they are
 	 *     actively running or not.
 	 */
-	while (rwsem_spin_on_owner(sem) & OWNER_SPINNABLE) {
+	for (;;) {
+		enum owner_state owner_state = rwsem_spin_on_owner(sem);
+
+		if (!(owner_state & OWNER_SPINNABLE))
+			break;
+
 		/*
 		 * Try to acquire the lock
 		 */
@@ -593,13 +599,44 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 		}
 
 		/*
-		 * When there's no owner, we might have preempted between the
-		 * owner acquiring the lock and setting the owner field. If
-		 * we're an RT task that will live-lock because we won't let
-		 * the owner complete.
+		 * An RT task cannot do optimistic spinning if it cannot
+		 * be sure the lock holder is running or live-lock may
+		 * happen if the current task and the lock holder happen
+		 * to run in the same CPU. However, aborting optimistic
+		 * spinning while a NULL owner is detected may miss some
+		 * opportunity where spinning can continue without causing
+		 * problem.
+		 *
+		 * There are 2 possible cases where an RT task may be able
+		 * to continue spinning.
+		 *
+		 * 1) The lock owner is in the process of releasing the
+		 *    lock, sem->owner is cleared but the lock has not
+		 *    been released yet.
+		 * 2) The lock was free and owner cleared, but another
+		 *    task just comes in and acquire the lock before
+		 *    we try to get it. The new owner may be a spinnable
+		 *    writer.
+		 *
+		 * To take advantage of two scenarios listed agove, the RT
+		 * task is made to retry one more time to see if it can
+		 * acquire the lock or continue spinning on the new owning
+		 * writer. Of course, if the time lag is long enough or the
+		 * new owner is not a writer or spinnable, the RT task will
+		 * quit spinning.
+		 *
+		 * If the owner is a writer, the need_resched() check is
+		 * done inside rwsem_spin_on_owner(). If the owner is not
+		 * a writer, need_resched() check needs to be done here.
 		 */
-		if (!sem->owner && (need_resched() || rt_task(current)))
-			break;
+		if (owner_state != OWNER_WRITER) {
+			if (need_resched())
+				break;
+			if (rt_task(current) &&
+			   (prev_owner_state != OWNER_WRITER))
+				break;
+		}
+		prev_owner_state = owner_state;
 
 		/*
 		 * The cpu_relax() call is a compiler barrier which forces
-- 
2.18.1

