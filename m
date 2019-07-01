Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96AFC24267
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 23:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfETVAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 17:00:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52842 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726933AbfETVAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 17:00:11 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0AC42301E3D2;
        Mon, 20 May 2019 21:00:10 +0000 (UTC)
Received: from llong.com (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B95D717995;
        Mon, 20 May 2019 21:00:08 +0000 (UTC)
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
Subject: [PATCH v8 11/19] locking/rwsem: Clarify usage of owner's nonspinaable bit
Date:   Mon, 20 May 2019 16:59:10 -0400
Message-Id: <20190520205918.22251-12-longman@redhat.com>
In-Reply-To: <20190520205918.22251-1-longman@redhat.com>
References: <20190520205918.22251-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 20 May 2019 21:00:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bit 1 of sem->owner (RWSEM_ANONYMOUSLY_OWNED) is used to designate an
anonymous owner - readers or an anonymous writer. The setting of this
anonymous bit is used as an indicator that optimistic spinning cannot
be done on this rwsem.

With the upcoming reader optimistic spinning patches, a reader-owned
rwsem can be spinned on for a limit period of time. We still need
this bit to indicate a rwsem is nonspinnable, but not setting this
bit loses its meaning that the owner is known. So rename the bit
to RWSEM_NONSPINNABLE to clarify its meaning.

This patch also fixes a DEBUG_RWSEMS_WARN_ON() bug in __up_write().

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/rwsem.h  |  2 +-
 kernel/locking/rwsem.c | 43 +++++++++++++++++++++---------------------
 2 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 148983e21d47..bb76e82398b2 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -50,7 +50,7 @@ struct rw_semaphore {
 };
 
 /*
- * Setting bit 1 of the owner field but not bit 0 will indicate
+ * Setting all bits of the owner field except bit 0 will indicate
  * that the rwsem is writer-owned with an unknown owner.
  */
 #define RWSEM_OWNER_UNKNOWN	((struct task_struct *)-2L)
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index b8e209c5fa55..be939accd60c 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -33,17 +33,18 @@
 /*
  * The least significant 2 bits of the owner value has the following
  * meanings when set.
- *  - RWSEM_READER_OWNED (bit 0): The rwsem is owned by readers
- *  - RWSEM_ANONYMOUSLY_OWNED (bit 1): The rwsem is anonymously owned,
- *    i.e. the owner(s) cannot be readily determined. It can be reader
- *    owned or the owning writer is indeterminate.
+ *  - Bit 0: RWSEM_READER_OWNED - The rwsem is owned by readers
+ *  - Bit 1: RWSEM_NONSPINNABLE - Waiters cannot spin on the rwsem
+ *    The rwsem is anonymously owned, i.e. the owner(s) cannot be
+ *    readily determined. It can be reader owned or the owning writer
+ *    is indeterminate.
  *
  * When a writer acquires a rwsem, it puts its task_struct pointer
  * into the owner field. It is cleared after an unlock.
  *
  * When a reader acquires a rwsem, it will also puts its task_struct
  * pointer into the owner field with both the RWSEM_READER_OWNED and
- * RWSEM_ANONYMOUSLY_OWNED bits set. On unlock, the owner field will
+ * RWSEM_NONSPINNABLE bits set. On unlock, the owner field will
  * largely be left untouched. So for a free or reader-owned rwsem,
  * the owner value may contain information about the last reader that
  * acquires the rwsem. The anonymous bit is set because that particular
@@ -55,7 +56,8 @@
  * a rwsem, but the overhead is simply too big.
  */
 #define RWSEM_READER_OWNED	(1UL << 0)
-#define RWSEM_ANONYMOUSLY_OWNED	(1UL << 1)
+#define RWSEM_NONSPINNABLE	(1UL << 1)
+#define RWSEM_OWNER_FLAGS_MASK	(RWSEM_READER_OWNED | RWSEM_NONSPINNABLE)
 
 #ifdef CONFIG_DEBUG_RWSEMS
 # define DEBUG_RWSEMS_WARN_ON(c, sem)	do {			\
@@ -132,7 +134,7 @@ static inline void __rwsem_set_reader_owned(struct rw_semaphore *sem,
 					    struct task_struct *owner)
 {
 	unsigned long val = (unsigned long)owner | RWSEM_READER_OWNED
-						 | RWSEM_ANONYMOUSLY_OWNED;
+						 | RWSEM_NONSPINNABLE;
 
 	WRITE_ONCE(sem->owner, (struct task_struct *)val);
 }
@@ -144,20 +146,12 @@ static inline void rwsem_set_reader_owned(struct rw_semaphore *sem)
 
 /*
  * Return true if the a rwsem waiter can spin on the rwsem's owner
- * and steal the lock, i.e. the lock is not anonymously owned.
+ * and steal the lock.
  * N.B. !owner is considered spinnable.
  */
 static inline bool is_rwsem_owner_spinnable(struct task_struct *owner)
 {
-	return !((unsigned long)owner & RWSEM_ANONYMOUSLY_OWNED);
-}
-
-/*
- * Return true if rwsem is owned by an anonymous writer or readers.
- */
-static inline bool rwsem_has_anonymous_owner(struct task_struct *owner)
-{
-	return (unsigned long)owner & RWSEM_ANONYMOUSLY_OWNED;
+	return !((unsigned long)owner & RWSEM_NONSPINNABLE);
 }
 
 #ifdef CONFIG_DEBUG_RWSEMS
@@ -170,10 +164,10 @@ static inline bool rwsem_has_anonymous_owner(struct task_struct *owner)
 static inline void rwsem_clear_reader_owned(struct rw_semaphore *sem)
 {
 	unsigned long val = (unsigned long)current | RWSEM_READER_OWNED
-						   | RWSEM_ANONYMOUSLY_OWNED;
+						   | RWSEM_NONSPINNABLE;
 	if (READ_ONCE(sem->owner) == (struct task_struct *)val)
 		cmpxchg_relaxed((unsigned long *)&sem->owner, val,
-				RWSEM_READER_OWNED | RWSEM_ANONYMOUSLY_OWNED);
+				RWSEM_READER_OWNED | RWSEM_NONSPINNABLE);
 }
 #else
 static inline void rwsem_clear_reader_owned(struct rw_semaphore *sem)
@@ -495,7 +489,7 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 	struct task_struct *owner;
 	bool ret = true;
 
-	BUILD_BUG_ON(!rwsem_has_anonymous_owner(RWSEM_OWNER_UNKNOWN));
+	BUILD_BUG_ON(is_rwsem_owner_spinnable(RWSEM_OWNER_UNKNOWN));
 
 	if (need_resched())
 		return false;
@@ -534,7 +528,7 @@ static inline enum owner_state rwsem_owner_state(unsigned long owner)
 	if (!owner)
 		return OWNER_NULL;
 
-	if (owner & RWSEM_ANONYMOUSLY_OWNED)
+	if (owner & RWSEM_NONSPINNABLE)
 		return OWNER_NONSPINNABLE;
 
 	if (owner & RWSEM_READER_OWNED)
@@ -1043,7 +1037,12 @@ static inline void __up_write(struct rw_semaphore *sem)
 {
 	long tmp;
 
-	DEBUG_RWSEMS_WARN_ON(sem->owner != current, sem);
+	/*
+	 * sem->owner may differ from current if the ownership is transferred
+	 * to an anonymous writer by setting the RWSEM_NONSPINNABLE bits.
+	 */
+	DEBUG_RWSEMS_WARN_ON((sem->owner != current) &&
+			    !((long)sem->owner & RWSEM_NONSPINNABLE), sem);
 	rwsem_clear_owner(sem);
 	tmp = atomic_long_fetch_add_release(-RWSEM_WRITER_LOCKED, &sem->count);
 	if (unlikely(tmp & RWSEM_FLAG_WAITERS))
-- 
2.18.1

