Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10CCC24262
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 22:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfETU7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 16:59:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42174 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbfETU7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 16:59:52 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F150159474;
        Mon, 20 May 2019 20:59:46 +0000 (UTC)
Received: from llong.com (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 81399643D6;
        Mon, 20 May 2019 20:59:43 +0000 (UTC)
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
Subject: [PATCH v8 01/19] locking/rwsem: Make owner available even if !CONFIG_RWSEM_SPIN_ON_OWNER
Date:   Mon, 20 May 2019 16:59:00 -0400
Message-Id: <20190520205918.22251-2-longman@redhat.com>
In-Reply-To: <20190520205918.22251-1-longman@redhat.com>
References: <20190520205918.22251-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 20 May 2019 20:59:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The owner field in the rw_semaphore structure is used primarily for
optimistic spinning. However, identifying the rwsem owner can also be
helpful in debugging as well as tracing locking related issues when
analyzing crash dump. The owner field may also store state information
that can be important to the operation of the rwsem.

So the owner field is now made a permanent member of the rw_semaphore
structure irrespective of CONFIG_RWSEM_SPIN_ON_OWNER.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/rwsem.h       |  9 +++++----
 kernel/locking/rwsem-xadd.c |  2 +-
 kernel/locking/rwsem.h      | 23 -----------------------
 lib/Kconfig.debug           |  8 ++++----
 4 files changed, 10 insertions(+), 32 deletions(-)

diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 2ea18a3def04..148983e21d47 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -34,12 +34,12 @@
  */
 struct rw_semaphore {
 	atomic_long_t count;
-#ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 	/*
-	 * Write owner. Used as a speculative check to see
-	 * if the owner is running on the cpu.
+	 * Write owner or one of the read owners. Can be used as a
+	 * speculative check to see if the owner is running on the cpu.
 	 */
 	struct task_struct *owner;
+#ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 	struct optimistic_spin_queue osq; /* spinner MCS lock */
 #endif
 	raw_spinlock_t wait_lock;
@@ -73,13 +73,14 @@ static inline int rwsem_is_locked(struct rw_semaphore *sem)
 #endif
 
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
-#define __RWSEM_OPT_INIT(lockname) , .osq = OSQ_LOCK_UNLOCKED, .owner = NULL
+#define __RWSEM_OPT_INIT(lockname) , .osq = OSQ_LOCK_UNLOCKED
 #else
 #define __RWSEM_OPT_INIT(lockname)
 #endif
 
 #define __RWSEM_INITIALIZER(name)				\
 	{ __RWSEM_INIT_COUNT(name),				\
+	  .owner = NULL,					\
 	  .wait_list = LIST_HEAD_INIT((name).wait_list),	\
 	  .wait_lock = __RAW_SPIN_LOCK_UNLOCKED(name.wait_lock)	\
 	  __RWSEM_OPT_INIT(name)				\
diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 0b1f77957240..c0500679fd2f 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -86,8 +86,8 @@ void __init_rwsem(struct rw_semaphore *sem, const char *name,
 	atomic_long_set(&sem->count, RWSEM_UNLOCKED_VALUE);
 	raw_spin_lock_init(&sem->wait_lock);
 	INIT_LIST_HEAD(&sem->wait_list);
-#ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 	sem->owner = NULL;
+#ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 	osq_lock_init(&sem->osq);
 #endif
 }
diff --git a/kernel/locking/rwsem.h b/kernel/locking/rwsem.h
index 64877f5294e3..eb9c8534299b 100644
--- a/kernel/locking/rwsem.h
+++ b/kernel/locking/rwsem.h
@@ -61,7 +61,6 @@
 #define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
 #define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
 
-#ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 /*
  * All writes to owner are protected by WRITE_ONCE() to make sure that
  * store tearing can't happen as optimistic spinners may read and use
@@ -126,7 +125,6 @@ static inline bool rwsem_has_anonymous_owner(struct task_struct *owner)
  * real owner or one of the real owners. The only exception is when the
  * unlock is done by up_read_non_owner().
  */
-#define rwsem_clear_reader_owned rwsem_clear_reader_owned
 static inline void rwsem_clear_reader_owned(struct rw_semaphore *sem)
 {
 	unsigned long val = (unsigned long)current | RWSEM_READER_OWNED
@@ -135,28 +133,7 @@ static inline void rwsem_clear_reader_owned(struct rw_semaphore *sem)
 		cmpxchg_relaxed((unsigned long *)&sem->owner, val,
 				RWSEM_READER_OWNED | RWSEM_ANONYMOUSLY_OWNED);
 }
-#endif
-
 #else
-static inline void rwsem_set_owner(struct rw_semaphore *sem)
-{
-}
-
-static inline void rwsem_clear_owner(struct rw_semaphore *sem)
-{
-}
-
-static inline void __rwsem_set_reader_owned(struct rw_semaphore *sem,
-					   struct task_struct *owner)
-{
-}
-
-static inline void rwsem_set_reader_owned(struct rw_semaphore *sem)
-{
-}
-#endif
-
-#ifndef rwsem_clear_reader_owned
 static inline void rwsem_clear_reader_owned(struct rw_semaphore *sem)
 {
 }
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index eae43952902e..60efaef4b6b2 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1094,7 +1094,7 @@ config PROVE_LOCKING
 	select DEBUG_SPINLOCK
 	select DEBUG_MUTEXES
 	select DEBUG_RT_MUTEXES if RT_MUTEXES
-	select DEBUG_RWSEMS if RWSEM_SPIN_ON_OWNER
+	select DEBUG_RWSEMS
 	select DEBUG_WW_MUTEX_SLOWPATH
 	select DEBUG_LOCK_ALLOC
 	select TRACE_IRQFLAGS
@@ -1198,10 +1198,10 @@ config DEBUG_WW_MUTEX_SLOWPATH
 
 config DEBUG_RWSEMS
 	bool "RW Semaphore debugging: basic checks"
-	depends on DEBUG_KERNEL && RWSEM_SPIN_ON_OWNER
+	depends on DEBUG_KERNEL
 	help
-	  This debugging feature allows mismatched rw semaphore locks and unlocks
-	  to be detected and reported.
+	  This debugging feature allows mismatched rw semaphore locks
+	  and unlocks to be detected and reported.
 
 config DEBUG_LOCK_ALLOC
 	bool "Lock debugging: detect incorrect freeing of live locks"
-- 
2.18.1

