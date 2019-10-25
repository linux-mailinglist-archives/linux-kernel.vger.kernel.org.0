Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE756E40AE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 02:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388089AbfJYArh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 20:47:37 -0400
Received: from smtpbgsg2.qq.com ([54.254.200.128]:39417 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727108AbfJYArd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 20:47:33 -0400
X-QQ-mid: bizesmtp19t1571964441taap3ryh
Received: from localhost.localdomain (unknown [218.76.23.26])
        by esmtp10.qq.com (ESMTP) with 
        id ; Fri, 25 Oct 2019 08:47:18 +0800 (CST)
X-QQ-SSF: 01400000000000X0ZN82B00A0000000
X-QQ-FEAT: CA8XswBtnVKVNXyv6h0M2bHBT3mqQ5vV244IG9VyAZcA20rnACOd1bQve2qBq
        IniMoPDSzgVR1e81wjmU1ljnbf3iP4mvS2tx3hSYy/LLxPaIyk5HmAonQgeo+qP3oSyeBSf
        DjzVfUnjYuwVr2e0/YLOWkGIu7jLScv77C6pb2YTl+BtPiYLcyGz0WTtlZibk8TS0XUjt45
        1Z2TJ0U2qFvVwcmOYryJVxTTXRRAD7fchSQm+g2pNxcd1CFzyF0gxilJGiyHaAq0WZuRpiR
        aecy9ZcD/wfd8v3G9vbJAhCG38TNmloTjAm3bOQ16dHjq6wEMBKyY0btjFZeydFVA7RaACF
        58Dgb4ZaoLXn72u6Qg=
X-QQ-GoodBg: 2
From:   wangqi <wangqi@kylinos.cn>
To:     zhangduo@kylinos.cn
Cc:     nh@kylinos.cn, Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        wangqi <wangqi@kylinos.cn>
Subject: [PATCH v1 3/6] locking/mutex: Rework mutex::owner
Date:   Fri, 25 Oct 2019 08:46:55 +0800
Message-Id: <1571964418-215707-3-git-send-email-wangqi@kylinos.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571964418-215707-1-git-send-email-wangqi@kylinos.cn>
References: <1571964418-215707-1-git-send-email-wangqi@kylinos.cn>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

The current mutex implementation has an atomic lock word and a
non-atomic owner field.

This disparity leads to a number of issues with the current mutex code
as it means that we can have a locked mutex without an explicit owner
(because the owner field has not been set, or already cleared).

This leads to a number of weird corner cases, esp. between the
optimistic spinning and debug code. Where the optimistic spinning
code needs the owner field updated inside the lock region, the debug
code is more relaxed because the whole lock is serialized by the
wait_lock.

Also, the spinning code itself has a few corner cases where we need to
deal with a held lock without an owner field.

Furthermore, it becomes even more of a problem when trying to fix
starvation cases in the current code. We end up stacking special case
on special case.

To solve this rework the basic mutex implementation to be a single
atomic word that contains the owner and uses the low bits for extra
state.

This matches how PI futexes and rt_mutex already work. By having the
owner an integral part of the lock state a lot of the problems
dissapear and we get a better option to deal with starvation cases,
direct owner handoff.

Changing the basic mutex does however invalidate all the arch specific
mutex code; this patch leaves that unused in-place, a later patch will
remove that.

Tested-by: Jason Low <jason.low2@hpe.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Will Deacon <will.deacon@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: wangqi <wangqi@kylinos.cn>
---
 include/linux/mutex-debug.h  |  24 ---
 include/linux/mutex.h        |  46 ++++--
 kernel/locking/mutex-debug.c |  13 --
 kernel/locking/mutex-debug.h |  10 --
 kernel/locking/mutex.c       | 371 ++++++++++++++++++-------------------------
 kernel/locking/mutex.h       |  26 ---
 kernel/sched/core.c          |   2 +-
 7 files changed, 187 insertions(+), 305 deletions(-)
 delete mode 100644 include/linux/mutex-debug.h

diff --git a/include/linux/mutex-debug.h b/include/linux/mutex-debug.h
deleted file mode 100644
index 4ac8b19..0000000
--- a/include/linux/mutex-debug.h
+++ /dev/null
@@ -1,24 +0,0 @@
-#ifndef __LINUX_MUTEX_DEBUG_H
-#define __LINUX_MUTEX_DEBUG_H
-
-#include <linux/linkage.h>
-#include <linux/lockdep.h>
-#include <linux/debug_locks.h>
-
-/*
- * Mutexes - debugging helpers:
- */
-
-#define __DEBUG_MUTEX_INITIALIZER(lockname)				\
-	, .magic = &lockname
-
-#define mutex_init(mutex)						\
-do {									\
-	static struct lock_class_key __key;				\
-									\
-	__mutex_init((mutex), #mutex, &__key);				\
-} while (0)
-
-extern void mutex_destroy(struct mutex *lock);
-
-#endif
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 2cb7531..4d3bcca 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -18,6 +18,7 @@
 #include <linux/atomic.h>
 #include <asm/processor.h>
 #include <linux/osq_lock.h>
+#include <linux/debug_locks.h>
 
 /*
  * Simple, straightforward mutexes with strict semantics:
@@ -48,16 +49,12 @@
  *   locks and tasks (and only those tasks)
  */
 struct mutex {
-	/* 1: unlocked, 0: locked, negative: locked, possible waiters */
-	atomic_t		count;
+	atomic_long_t		owner;
 	spinlock_t		wait_lock;
-	struct list_head	wait_list;
-#if defined(CONFIG_DEBUG_MUTEXES) || defined(CONFIG_MUTEX_SPIN_ON_OWNER)
-	struct task_struct	*owner;
-#endif
 #ifdef CONFIG_MUTEX_SPIN_ON_OWNER
 	struct optimistic_spin_queue osq; /* Spinner MCS lock */
 #endif
+	struct list_head	wait_list;
 #ifdef CONFIG_DEBUG_MUTEXES
 	void			*magic;
 #endif
@@ -66,6 +63,11 @@ struct mutex {
 #endif
 };
 
+static inline struct task_struct *__mutex_owner(struct mutex *lock)
+{
+	return (struct task_struct *)(atomic_long_read(&lock->owner) & ~0x03);
+}
+
 /*
  * This is the control structure for tasks blocked on mutex,
  * which resides on the blocked task's kernel stack:
@@ -79,9 +81,20 @@ struct mutex_waiter {
 };
 
 #ifdef CONFIG_DEBUG_MUTEXES
-# include <linux/mutex-debug.h>
+
+#define __DEBUG_MUTEX_INITIALIZER(lockname)				\
+	, .magic = &lockname
+
+extern void mutex_destroy(struct mutex *lock);
+
 #else
+
 # define __DEBUG_MUTEX_INITIALIZER(lockname)
+
+static inline void mutex_destroy(struct mutex *lock) {}
+
+#endif
+
 /**
  * mutex_init - initialize the mutex
  * @mutex: the mutex to be initialized
@@ -90,14 +103,12 @@ struct mutex_waiter {
  *
  * It is not allowed to initialize an already locked mutex.
  */
-# define mutex_init(mutex) \
-do {							\
-	static struct lock_class_key __key;		\
-							\
-	__mutex_init((mutex), #mutex, &__key);		\
+#define mutex_init(mutex)						\
+do {									\
+	static struct lock_class_key __key;				\
+									\
+	__mutex_init((mutex), #mutex, &__key);				\
 } while (0)
-static inline void mutex_destroy(struct mutex *lock) {}
-#endif
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 # define __DEP_MAP_MUTEX_INITIALIZER(lockname) \
@@ -107,7 +118,7 @@ static inline void mutex_destroy(struct mutex *lock) {}
 #endif
 
 #define __MUTEX_INITIALIZER(lockname) \
-		{ .count = ATOMIC_INIT(1) \
+		{ .owner = ATOMIC_LONG_INIT(0) \
 		, .wait_lock = __SPIN_LOCK_UNLOCKED(lockname.wait_lock) \
 		, .wait_list = LIST_HEAD_INIT(lockname.wait_list) \
 		__DEBUG_MUTEX_INITIALIZER(lockname) \
@@ -127,7 +138,10 @@ extern void __mutex_init(struct mutex *lock, const char *name,
  */
 static inline int mutex_is_locked(struct mutex *lock)
 {
-	return atomic_read(&lock->count) != 1;
+	/*
+	 * XXX think about spin_is_locked
+	 */
+	return __mutex_owner(lock) != NULL;
 }
 
 /*
diff --git a/kernel/locking/mutex-debug.c b/kernel/locking/mutex-debug.c
index 9c951fa..9aa7136 100644
--- a/kernel/locking/mutex-debug.c
+++ b/kernel/locking/mutex-debug.c
@@ -73,21 +73,8 @@ void debug_mutex_unlock(struct mutex *lock)
 {
 	if (likely(debug_locks)) {
 		DEBUG_LOCKS_WARN_ON(lock->magic != lock);
-
-		if (!lock->owner)
-			DEBUG_LOCKS_WARN_ON(!lock->owner);
-		else
-			DEBUG_LOCKS_WARN_ON(lock->owner != current);
-
 		DEBUG_LOCKS_WARN_ON(!lock->wait_list.prev && !lock->wait_list.next);
 	}
-
-	/*
-	 * __mutex_slowpath_needs_to_unlock() is explicitly 0 for debug
-	 * mutexes so that we can do it here after we've verified state.
-	 */
-	mutex_clear_owner(lock);
-	atomic_set(&lock->count, 1);
 }
 
 void debug_mutex_init(struct mutex *lock, const char *name,
diff --git a/kernel/locking/mutex-debug.h b/kernel/locking/mutex-debug.h
index 57a871a..a459faa 100644
--- a/kernel/locking/mutex-debug.h
+++ b/kernel/locking/mutex-debug.h
@@ -27,16 +27,6 @@ extern void debug_mutex_unlock(struct mutex *lock);
 extern void debug_mutex_init(struct mutex *lock, const char *name,
 			     struct lock_class_key *key);
 
-static inline void mutex_set_owner(struct mutex *lock)
-{
-	WRITE_ONCE(lock->owner, current);
-}
-
-static inline void mutex_clear_owner(struct mutex *lock)
-{
-	WRITE_ONCE(lock->owner, NULL);
-}
-
 #define spin_lock_mutex(lock, flags)			\
 	do {						\
 		struct mutex *l = container_of(lock, struct mutex, wait_lock); \
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index a70b90d..de1ce0b 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -27,41 +27,113 @@
 #include <linux/debug_locks.h>
 #include <linux/osq_lock.h>
 
-/*
- * In the DEBUG case we are using the "NULL fastpath" for mutexes,
- * which forces all calls into the slowpath:
- */
 #ifdef CONFIG_DEBUG_MUTEXES
 # include "mutex-debug.h"
-# include <asm-generic/mutex-null.h>
-/*
- * Must be 0 for the debug case so we do not do the unlock outside of the
- * wait_lock region. debug_mutex_unlock() will do the actual unlock in this
- * case.
- */
-# undef __mutex_slowpath_needs_to_unlock
-# define  __mutex_slowpath_needs_to_unlock()	0
 #else
 # include "mutex.h"
-# include <asm/mutex.h>
 #endif
 
 void
 __mutex_init(struct mutex *lock, const char *name, struct lock_class_key *key)
 {
-	atomic_set(&lock->count, 1);
+	atomic_long_set(&lock->owner, 0);
 	spin_lock_init(&lock->wait_lock);
 	INIT_LIST_HEAD(&lock->wait_list);
-	mutex_clear_owner(lock);
 #ifdef CONFIG_MUTEX_SPIN_ON_OWNER
 	osq_lock_init(&lock->osq);
 #endif
 
 	debug_mutex_init(lock, name, key);
 }
-
 EXPORT_SYMBOL(__mutex_init);
 
+/*
+ * @owner: contains: 'struct task_struct *' to the current lock owner,
+ * NULL means not owned. Since task_struct pointers are aligned at
+ * ARCH_MIN_TASKALIGN (which is at least sizeof(void *)), we have low
+ * bits to store extra state.
+ *
+ * Bit0 indicates a non-empty waiter list; unlock must issue a wakeup.
+ */
+#define MUTEX_FLAG_WAITERS	0x01
+
+#define MUTEX_FLAGS		0x03
+
+static inline struct task_struct *__owner_task(unsigned long owner)
+{
+	return (struct task_struct *)(owner & ~MUTEX_FLAGS);
+}
+
+static inline unsigned long __owner_flags(unsigned long owner)
+{
+	return owner & MUTEX_FLAGS;
+}
+
+/*
+ * Actual trylock that will work on any unlocked state.
+ */
+static inline bool __mutex_trylock(struct mutex *lock)
+{
+	unsigned long owner, curr = (unsigned long)current;
+
+	owner = atomic_long_read(&lock->owner);
+	for (;;) { /* must loop, can race against a flag */
+		unsigned long old;
+
+		if (__owner_task(owner))
+			return false;
+
+		old = atomic_long_cmpxchg_acquire(&lock->owner, owner,
+						  curr | __owner_flags(owner));
+		if (old == owner)
+			return true;
+
+		owner = old;
+	}
+}
+
+#ifndef CONFIG_DEBUG_LOCK_ALLOC
+/*
+ * Lockdep annotations are contained to the slow paths for simplicity.
+ * There is nothing that would stop spreading the lockdep annotations outwards
+ * except more code.
+ */
+
+/*
+ * Optimistic trylock that only works in the uncontended case. Make sure to
+ * follow with a __mutex_trylock() before failing.
+ */
+static __always_inline bool __mutex_trylock_fast(struct mutex *lock)
+{
+	unsigned long curr = (unsigned long)current;
+
+	if (!atomic_long_cmpxchg_acquire(&lock->owner, 0UL, curr))
+		return true;
+
+	return false;
+}
+
+static __always_inline bool __mutex_unlock_fast(struct mutex *lock)
+{
+	unsigned long curr = (unsigned long)current;
+
+	if (atomic_long_cmpxchg_release(&lock->owner, curr, 0UL) == curr)
+		return true;
+
+	return false;
+}
+#endif
+
+static inline void __mutex_set_flag(struct mutex *lock, unsigned long flag)
+{
+	atomic_long_or(flag, &lock->owner);
+}
+
+static inline void __mutex_clear_flag(struct mutex *lock, unsigned long flag)
+{
+	atomic_long_andnot(flag, &lock->owner);
+}
+
 #ifndef CONFIG_DEBUG_LOCK_ALLOC
 /*
  * We split the mutex lock/unlock logic into separate fastpath and
@@ -69,7 +141,7 @@ EXPORT_SYMBOL(__mutex_init);
  * We also put the fastpath first in the kernel image, to make sure the
  * branch is predicted by the CPU as default-untaken.
  */
-__visible void __sched __mutex_lock_slowpath(atomic_t *lock_count);
+static void __sched __mutex_lock_slowpath(struct mutex *lock);
 
 /**
  * mutex_lock - acquire the mutex
@@ -95,14 +167,10 @@ __visible void __sched __mutex_lock_slowpath(atomic_t *lock_count);
 void __sched mutex_lock(struct mutex *lock)
 {
 	might_sleep();
-	/*
-	 * The locking fastpath is the 1->0 transition from
-	 * 'unlocked' into 'locked' state.
-	 */
-	__mutex_fastpath_lock(&lock->count, __mutex_lock_slowpath);
-	mutex_set_owner(lock);
-}
 
+	if (!__mutex_trylock_fast(lock))
+		__mutex_lock_slowpath(lock);
+}
 EXPORT_SYMBOL(mutex_lock);
 #endif
 
@@ -149,9 +217,6 @@ static __always_inline void ww_mutex_lock_acquired(struct ww_mutex *ww,
 /*
  * After acquiring lock with fastpath or when we lost out in contested
  * slowpath, set ctx and wake up any waiters so they can recheck.
- *
- * This function is never called when CONFIG_DEBUG_LOCK_ALLOC is set,
- * as the fastpath and opportunistic spinning are disabled in that case.
  */
 static __always_inline void
 ww_mutex_set_context_fastpath(struct ww_mutex *lock,
@@ -176,7 +241,7 @@ ww_mutex_set_context_fastpath(struct ww_mutex *lock,
 	/*
 	 * Check if lock is contended, if not there is nobody to wake up
 	 */
-	if (likely(atomic_read(&lock->base.count) == 0))
+	if (likely(!(atomic_long_read(&lock->base.owner) & MUTEX_FLAG_WAITERS)))
 		return;
 
 	/*
@@ -227,7 +292,7 @@ bool mutex_spin_on_owner(struct mutex *lock, struct task_struct *owner)
 	bool ret = true;
 
 	rcu_read_lock();
-	while (lock->owner == owner) {
+	while (__mutex_owner(lock) == owner) {
 		/*
 		 * Ensure we emit the owner->on_cpu, dereference _after_
 		 * checking lock->owner still matches owner. If that fails,
@@ -260,27 +325,20 @@ static inline int mutex_can_spin_on_owner(struct mutex *lock)
 		return 0;
 
 	rcu_read_lock();
-	owner = READ_ONCE(lock->owner);
+	owner = __mutex_owner(lock);
 	if (owner)
 		retval = owner->on_cpu;
 	rcu_read_unlock();
+
 	/*
-	 * if lock->owner is not set, the mutex owner may have just acquired
-	 * it and not set the owner yet or the mutex has been released.
+	 * If lock->owner is not set, the mutex has been released. Return true
+	 * such that we'll trylock in the spin path, which is a faster option
+	 * than the blocking slow path.
 	 */
 	return retval;
 }
 
 /*
- * Atomically try to take the lock when it is available
- */
-static inline bool mutex_try_to_acquire(struct mutex *lock)
-{
-	return !mutex_is_locked(lock) &&
-		(atomic_cmpxchg_acquire(&lock->count, 1, 0) == 1);
-}
-
-/*
  * Optimistic spinning.
  *
  * We try to spin for acquisition when we find that the lock owner
@@ -288,13 +346,6 @@ static inline bool mutex_try_to_acquire(struct mutex *lock)
  * need to reschedule. The rationale is that if the lock owner is
  * running, it is likely to release the lock soon.
  *
- * Since this needs the lock owner, and this mutex implementation
- * doesn't track the owner atomically in the lock field, we need to
- * track it non-atomically.
- *
- * We can't do this for DEBUG_MUTEXES because that relies on wait_lock
- * to serialize everything.
- *
  * The mutex spinners are queued up using MCS lock so that only one
  * spinner can compete for the mutex. However, if mutex spinning isn't
  * going to happen, there is no point in going through the lock/unlock
@@ -342,36 +393,17 @@ static bool mutex_optimistic_spin(struct mutex *lock,
 		 * If there's an owner, wait for it to either
 		 * release the lock or go to sleep.
 		 */
-		owner = READ_ONCE(lock->owner);
+		owner = __mutex_owner(lock);
 		if (owner && !mutex_spin_on_owner(lock, owner))
 			break;
 
 		/* Try to acquire the mutex if it is unlocked. */
-		if (mutex_try_to_acquire(lock)) {
-			lock_acquired(&lock->dep_map, ip);
-
-			if (use_ww_ctx) {
-				struct ww_mutex *ww;
-				ww = container_of(lock, struct ww_mutex, base);
-
-				ww_mutex_set_context_fastpath(ww, ww_ctx);
-			}
-
-			mutex_set_owner(lock);
+		if (__mutex_trylock(lock)) {
 			osq_unlock(&lock->osq);
 			return true;
 		}
 
 		/*
-		 * When there's no owner, we might have preempted between the
-		 * owner acquiring the lock and setting the owner field. If
-		 * we're an RT task that will live-lock because we won't let
-		 * the owner complete.
-		 */
-		if (!owner && (need_resched() || rt_task(task)))
-			break;
-
-		/*
 		 * The cpu_relax() call is a compiler barrier which forces
 		 * everything in this loop to be re-loaded. We don't need
 		 * memory barriers as we'll eventually observe the right
@@ -406,8 +438,7 @@ static bool mutex_optimistic_spin(struct mutex *lock,
 }
 #endif
 
-__visible __used noinline
-void __sched __mutex_unlock_slowpath(atomic_t *lock_count);
+static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigned long ip);
 
 /**
  * mutex_unlock - release the mutex
@@ -422,21 +453,12 @@ void __sched __mutex_unlock_slowpath(atomic_t *lock_count);
  */
 void __sched mutex_unlock(struct mutex *lock)
 {
-	/*
-	 * The unlocking fastpath is the 0->1 transition from 'locked'
-	 * into 'unlocked' state:
-	 */
-#ifndef CONFIG_DEBUG_MUTEXES
-	/*
-	 * When debugging is enabled we must not clear the owner before time,
-	 * the slow path will always be taken, and that clears the owner field
-	 * after verifying that it was indeed current.
-	 */
-	mutex_clear_owner(lock);
+#ifndef CONFIG_DEBUG_LOCK_ALLOC
+	if (__mutex_unlock_fast(lock))
+		return;
 #endif
-	__mutex_fastpath_unlock(&lock->count, __mutex_unlock_slowpath);
+	__mutex_unlock_slowpath(lock, _RET_IP_);
 }
-
 EXPORT_SYMBOL(mutex_unlock);
 
 /**
@@ -465,15 +487,7 @@ void __sched ww_mutex_unlock(struct ww_mutex *lock)
 		lock->ctx = NULL;
 	}
 
-#ifndef CONFIG_DEBUG_MUTEXES
-	/*
-	 * When debugging is enabled we must not clear the owner before time,
-	 * the slow path will always be taken, and that clears the owner field
-	 * after verifying that it was indeed current.
-	 */
-	mutex_clear_owner(&lock->base);
-#endif
-	__mutex_fastpath_unlock(&lock->base.count, __mutex_unlock_slowpath);
+	mutex_unlock(&lock->base);
 }
 EXPORT_SYMBOL(ww_mutex_unlock);
 
@@ -520,20 +534,24 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 	preempt_disable();
 	mutex_acquire_nest(&lock->dep_map, subclass, 0, nest_lock, ip);
 
-	if (mutex_optimistic_spin(lock, ww_ctx, use_ww_ctx)) {
+	if (__mutex_trylock(lock) || mutex_optimistic_spin(lock, ww_ctx, use_ww_ctx)) {
 		/* got the lock, yay! */
+		lock_acquired(&lock->dep_map, ip);
+		if (use_ww_ctx) {
+			struct ww_mutex *ww;
+			ww = container_of(lock, struct ww_mutex, base);
+
+			ww_mutex_set_context_fastpath(ww, ww_ctx);
+		}
 		preempt_enable();
 		return 0;
 	}
 
 	spin_lock_mutex(&lock->wait_lock, flags);
-
 	/*
-	 * Once more, try to acquire the lock. Only try-lock the mutex if
-	 * it is unlocked to reduce unnecessary xchg() operations.
+	 * After waiting to acquire the wait_lock, try again.
 	 */
-	if (!mutex_is_locked(lock) &&
-	    (atomic_xchg_acquire(&lock->count, 0) == 1))
+	if (__mutex_trylock(lock))
 		goto skip_wait;
 
 	debug_mutex_lock_common(lock, &waiter);
@@ -543,21 +561,13 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 	list_add_tail(&waiter.list, &lock->wait_list);
 	waiter.task = task;
 
+	if (list_first_entry(&lock->wait_list, struct mutex_waiter, list) == &waiter)
+		__mutex_set_flag(lock, MUTEX_FLAG_WAITERS);
+
 	lock_contended(&lock->dep_map, ip);
 
 	for (;;) {
-		/*
-		 * Lets try to take the lock again - this is needed even if
-		 * we get here for the first time (shortly after failing to
-		 * acquire the lock), to make sure that we get a wakeup once
-		 * it's unlocked. Later on, if we sleep, this is the
-		 * operation that gives us the lock. We xchg it to -1, so
-		 * that when we release the lock, we properly wake up the
-		 * other waiters. We only attempt the xchg if the count is
-		 * non-negative in order to avoid unnecessary xchg operations:
-		 */
-		if (atomic_read(&lock->count) >= 0 &&
-		    (atomic_xchg_acquire(&lock->count, -1) == 1))
+		if (__mutex_trylock(lock))
 			break;
 
 		/*
@@ -585,15 +595,14 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 	__set_task_state(task, TASK_RUNNING);
 
 	mutex_remove_waiter(lock, &waiter, task);
-	/* set it to 0 if there are no waiters left: */
 	if (likely(list_empty(&lock->wait_list)))
-		atomic_set(&lock->count, 0);
+		__mutex_clear_flag(lock, MUTEX_FLAG_WAITERS);
+
 	debug_mutex_free_waiter(&waiter);
 
 skip_wait:
 	/* got the lock - cleanup and rejoice! */
 	lock_acquired(&lock->dep_map, ip);
-	mutex_set_owner(lock);
 
 	if (use_ww_ctx) {
 		struct ww_mutex *ww = container_of(lock, struct ww_mutex, base);
@@ -631,7 +640,6 @@ _mutex_lock_nest_lock(struct mutex *lock, struct lockdep_map *nest)
 	__mutex_lock_common(lock, TASK_UNINTERRUPTIBLE,
 			    0, nest, _RET_IP_, NULL, 0);
 }
-
 EXPORT_SYMBOL_GPL(_mutex_lock_nest_lock);
 
 int __sched
@@ -650,7 +658,6 @@ mutex_lock_interruptible_nested(struct mutex *lock, unsigned int subclass)
 	return __mutex_lock_common(lock, TASK_INTERRUPTIBLE,
 				   subclass, NULL, _RET_IP_, NULL, 0);
 }
-
 EXPORT_SYMBOL_GPL(mutex_lock_interruptible_nested);
 
 static inline int
@@ -715,29 +722,22 @@ EXPORT_SYMBOL_GPL(__ww_mutex_lock_interruptible);
 /*
  * Release the lock, slowpath:
  */
-static inline void
-__mutex_unlock_common_slowpath(struct mutex *lock, int nested)
+static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigned long ip)
 {
-	unsigned long flags;
+	unsigned long owner, flags;
 	WAKE_Q(wake_q);
 
+	mutex_release(&lock->dep_map, 1, ip);
+
 	/*
-	 * As a performance measurement, release the lock before doing other
-	 * wakeup related duties to follow. This allows other tasks to acquire
-	 * the lock sooner, while still handling cleanups in past unlock calls.
-	 * This can be done as we do not enforce strict equivalence between the
-	 * mutex counter and wait_list.
-	 *
-	 *
-	 * Some architectures leave the lock unlocked in the fastpath failure
-	 * case, others need to leave it locked. In the later case we have to
-	 * unlock it here - as the lock counter is currently 0 or negative.
+	 * Release the lock before (potentially) taking the spinlock
+	 * such that other contenders can get on with things ASAP.
 	 */
-	if (__mutex_slowpath_needs_to_unlock())
-		atomic_set(&lock->count, 1);
+	owner = atomic_long_fetch_and_release(MUTEX_FLAGS, &lock->owner);
+	if (!__owner_flags(owner))
+		return;
 
 	spin_lock_mutex(&lock->wait_lock, flags);
-	mutex_release(&lock->dep_map, nested, _RET_IP_);
 	debug_mutex_unlock(lock);
 
 	if (!list_empty(&lock->wait_list)) {
@@ -754,17 +754,6 @@ __mutex_unlock_common_slowpath(struct mutex *lock, int nested)
 	wake_up_q(&wake_q);
 }
 
-/*
- * Release the lock, slowpath:
- */
-__visible void
-__mutex_unlock_slowpath(atomic_t *lock_count)
-{
-	struct mutex *lock = container_of(lock_count, struct mutex, count);
-
-	__mutex_unlock_common_slowpath(lock, 1);
-}
-
 #ifndef CONFIG_DEBUG_LOCK_ALLOC
 /*
  * Here come the less common (and hence less performance-critical) APIs:
@@ -789,38 +778,30 @@ __mutex_lock_interruptible_slowpath(struct mutex *lock);
  */
 int __sched mutex_lock_interruptible(struct mutex *lock)
 {
-	int ret;
-
 	might_sleep();
-	ret =  __mutex_fastpath_lock_retval(&lock->count);
-	if (likely(!ret)) {
-		mutex_set_owner(lock);
+
+	if (__mutex_trylock_fast(lock))
 		return 0;
-	} else
-		return __mutex_lock_interruptible_slowpath(lock);
+
+	return __mutex_lock_interruptible_slowpath(lock);
 }
 
 EXPORT_SYMBOL(mutex_lock_interruptible);
 
 int __sched mutex_lock_killable(struct mutex *lock)
 {
-	int ret;
-
 	might_sleep();
-	ret = __mutex_fastpath_lock_retval(&lock->count);
-	if (likely(!ret)) {
-		mutex_set_owner(lock);
+
+	if (__mutex_trylock_fast(lock))
 		return 0;
-	} else
-		return __mutex_lock_killable_slowpath(lock);
+
+	return __mutex_lock_killable_slowpath(lock);
 }
 EXPORT_SYMBOL(mutex_lock_killable);
 
-__visible void __sched
-__mutex_lock_slowpath(atomic_t *lock_count)
+static noinline void __sched
+__mutex_lock_slowpath(struct mutex *lock)
 {
-	struct mutex *lock = container_of(lock_count, struct mutex, count);
-
 	__mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, 0,
 			    NULL, _RET_IP_, NULL, 0);
 }
@@ -856,37 +837,6 @@ __ww_mutex_lock_interruptible_slowpath(struct ww_mutex *lock,
 
 #endif
 
-/*
- * Spinlock based trylock, we take the spinlock and check whether we
- * can get the lock:
- */
-static inline int __mutex_trylock_slowpath(atomic_t *lock_count)
-{
-	struct mutex *lock = container_of(lock_count, struct mutex, count);
-	unsigned long flags;
-	int prev;
-
-	/* No need to trylock if the mutex is locked. */
-	if (mutex_is_locked(lock))
-		return 0;
-
-	spin_lock_mutex(&lock->wait_lock, flags);
-
-	prev = atomic_xchg_acquire(&lock->count, -1);
-	if (likely(prev == 1)) {
-		mutex_set_owner(lock);
-		mutex_acquire(&lock->dep_map, 0, 1, _RET_IP_);
-	}
-
-	/* Set it back to 0 if there are no waiters: */
-	if (likely(list_empty(&lock->wait_list)))
-		atomic_set(&lock->count, 0);
-
-	spin_unlock_mutex(&lock->wait_lock, flags);
-
-	return prev == 1;
-}
-
 /**
  * mutex_trylock - try to acquire the mutex, without waiting
  * @lock: the mutex to be acquired
@@ -903,13 +853,12 @@ static inline int __mutex_trylock_slowpath(atomic_t *lock_count)
  */
 int __sched mutex_trylock(struct mutex *lock)
 {
-	int ret;
+	bool locked = __mutex_trylock(lock);
 
-	ret = __mutex_fastpath_trylock(&lock->count, __mutex_trylock_slowpath);
-	if (ret)
-		mutex_set_owner(lock);
+	if (locked)
+		mutex_acquire(&lock->dep_map, 0, 1, _RET_IP_);
 
-	return ret;
+	return locked;
 }
 EXPORT_SYMBOL(mutex_trylock);
 
@@ -917,36 +866,28 @@ EXPORT_SYMBOL(mutex_trylock);
 int __sched
 __ww_mutex_lock(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 {
-	int ret;
-
 	might_sleep();
 
-	ret = __mutex_fastpath_lock_retval(&lock->base.count);
-
-	if (likely(!ret)) {
+	if (__mutex_trylock_fast(&lock->base)) {
 		ww_mutex_set_context_fastpath(lock, ctx);
-		mutex_set_owner(&lock->base);
-	} else
-		ret = __ww_mutex_lock_slowpath(lock, ctx);
-	return ret;
+		return 0;
+	}
+
+	return __ww_mutex_lock_slowpath(lock, ctx);
 }
 EXPORT_SYMBOL(__ww_mutex_lock);
 
 int __sched
 __ww_mutex_lock_interruptible(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 {
-	int ret;
-
 	might_sleep();
 
-	ret = __mutex_fastpath_lock_retval(&lock->base.count);
-
-	if (likely(!ret)) {
+	if (__mutex_trylock_fast(&lock->base)) {
 		ww_mutex_set_context_fastpath(lock, ctx);
-		mutex_set_owner(&lock->base);
-	} else
-		ret = __ww_mutex_lock_interruptible_slowpath(lock, ctx);
-	return ret;
+		return 0;
+	}
+
+	return __ww_mutex_lock_interruptible_slowpath(lock, ctx);
 }
 EXPORT_SYMBOL(__ww_mutex_lock_interruptible);
 
diff --git a/kernel/locking/mutex.h b/kernel/locking/mutex.h
index 6cd6b8e..4410a4a 100644
--- a/kernel/locking/mutex.h
+++ b/kernel/locking/mutex.h
@@ -16,32 +16,6 @@
 #define mutex_remove_waiter(lock, waiter, task) \
 		__list_del((waiter)->list.prev, (waiter)->list.next)
 
-#ifdef CONFIG_MUTEX_SPIN_ON_OWNER
-/*
- * The mutex owner can get read and written to locklessly.
- * We should use WRITE_ONCE when writing the owner value to
- * avoid store tearing, otherwise, a thread could potentially
- * read a partially written and incomplete owner value.
- */
-static inline void mutex_set_owner(struct mutex *lock)
-{
-	WRITE_ONCE(lock->owner, current);
-}
-
-static inline void mutex_clear_owner(struct mutex *lock)
-{
-	WRITE_ONCE(lock->owner, NULL);
-}
-#else
-static inline void mutex_set_owner(struct mutex *lock)
-{
-}
-
-static inline void mutex_clear_owner(struct mutex *lock)
-{
-}
-#endif
-
 #define debug_mutex_wake_waiter(lock, waiter)		do { } while (0)
 #define debug_mutex_free_waiter(waiter)			do { } while (0)
 #define debug_mutex_add_waiter(lock, waiter, ti)	do { } while (0)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index af96b80..ca301de 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -74,11 +74,11 @@
 #include <linux/binfmts.h>
 #include <linux/context_tracking.h>
 #include <linux/compiler.h>
+#include <linux/mutex.h>
 
 #include <asm/switch_to.h>
 #include <asm/tlb.h>
 #include <asm/irq_regs.h>
-#include <asm/mutex.h>
 #ifdef CONFIG_PARAVIRT
 #include <asm/paravirt.h>
 #endif
-- 
2.7.4



