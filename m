Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 187D124266
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 23:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfETVAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 17:00:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36054 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbfETVAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 17:00:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 99F0D30842B5;
        Mon, 20 May 2019 21:00:08 +0000 (UTC)
Received: from llong.com (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 50C4964049;
        Mon, 20 May 2019 21:00:07 +0000 (UTC)
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
Subject: [PATCH v8 10/19] locking/rwsem: Wake up almost all readers in wait queue
Date:   Mon, 20 May 2019 16:59:09 -0400
Message-Id: <20190520205918.22251-11-longman@redhat.com>
In-Reply-To: <20190520205918.22251-1-longman@redhat.com>
References: <20190520205918.22251-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 20 May 2019 21:00:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the front of the wait queue is a reader, other readers
immediately following the first reader will also be woken up at the
same time. However, if there is a writer in between. Those readers
behind the writer will not be woken up.

Because of optimistic spinning, the lock acquisition order is not FIFO
anyway. The lock handoff mechanism will ensure that lock starvation
will not happen.

Assuming that the lock hold times of the other readers still in the
queue will be about the same as the readers that are being woken up,
there is really not much additional cost other than the additional
latency due to the wakeup of additional tasks by the waker. Therefore
all the readers up to a maximum of 256 in the queue are woken up when
the first waiter is a reader to improve reader throughput. This is
somewhat similar in concept to a phase-fair R/W lock.

With a locking microbenchmark running on 5.1 based kernel, the total
locking rates (in kops/s) on a 8-socket IvyBridge-EX system with
equal numbers of readers and writers before and after this patch were
as follows:

   # of Threads  Pre-Patch   Post-patch
   ------------  ---------   ----------
        4          1,641        1,674
        8            731        1,062
       16            564          924
       32             78          300
       64             38          195
      240             50          149

There is no performance gain at low contention level. At high contention
level, however, this patch gives a pretty decent performance boost.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index eb43201b89b4..b8e209c5fa55 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -254,6 +254,14 @@ enum writer_wait_state {
  */
 #define RWSEM_WAIT_TIMEOUT	DIV_ROUND_UP(HZ, 250)
 
+/*
+ * Magic number to batch-wakeup waiting readers, even when writers are
+ * also present in the queue. This both limits the amount of work the
+ * waking thread must do and also prevents any potential counter overflow,
+ * however unlikely.
+ */
+#define MAX_READERS_WAKEUP	0x100
+
 /*
  * handle the lock release when processes blocked on it that can now run
  * - if we come here from up_xxxx(), then the RWSEM_FLAG_WAITERS bit must
@@ -329,11 +337,17 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
 	}
 
 	/*
-	 * Grant an infinite number of read locks to the readers at the front
-	 * of the queue. We know that woken will be at least 1 as we accounted
+	 * Grant up to MAX_READERS_WAKEUP read locks to all the readers in the
+	 * queue. We know that the woken will be at least 1 as we accounted
 	 * for above. Note we increment the 'active part' of the count by the
 	 * number of readers before waking any processes up.
 	 *
+	 * This is an adaptation of the phase-fair R/W locks where at the
+	 * reader phase (first waiter is a reader), all readers are eligible
+	 * to acquire the lock at the same time irrespective of their order
+	 * in the queue. The writers acquire the lock according to their
+	 * order in the queue.
+	 *
 	 * We have to do wakeup in 2 passes to prevent the possibility that
 	 * the reader count may be decremented before it is incremented. It
 	 * is because the to-be-woken waiter may not have slept yet. So it
@@ -345,13 +359,20 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
 	 * 2) For each waiters in the new list, clear waiter->task and
 	 *    put them into wake_q to be woken up later.
 	 */
-	list_for_each_entry(waiter, &sem->wait_list, list) {
+	INIT_LIST_HEAD(&wlist);
+	list_for_each_entry_safe(waiter, tmp, &sem->wait_list, list) {
 		if (waiter->type == RWSEM_WAITING_FOR_WRITE)
-			break;
+			continue;
 
 		woken++;
+		list_move_tail(&waiter->list, &wlist);
+
+		/*
+		 * Limit # of readers that can be woken up per wakeup call.
+		 */
+		if (woken >= MAX_READERS_WAKEUP)
+			break;
 	}
-	list_cut_before(&wlist, &sem->wait_list, &waiter->list);
 
 	adjustment = woken * RWSEM_READER_BIAS - adjustment;
 	lockevent_cond_inc(rwsem_wake_reader, woken);
-- 
2.18.1

