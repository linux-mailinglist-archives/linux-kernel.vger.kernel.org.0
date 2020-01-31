Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC65614EF67
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 16:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbgAaPSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 10:18:20 -0500
Received: from merlin.infradead.org ([205.233.59.134]:47960 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbgAaPSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 10:18:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=e7rqjkbopsUW6U2lYWOJhPHwWEF9kRXrphHwNsGwOLc=; b=p57DTyI+bxU0pL3/UOgea/UD4r
        /jQPoYmbbr6Wd3rTIleD6jGJUT0WVaAePo0PU0Hw0K6tw9DHoJ4dmsYIFWmelLScZ5bwg+JO080iS
        6Iyzq5wa40HmxQOONXi1EFzW5DTmN/b3F7HXm1XNrXl10tCnd/JGLYnGDlwzDXeNdZCyHzhJwZ9g7
        3ZlBT/Xp3CpD6FEm3D1pkP8JrjsdvBgdZaqZpp9YOqGFW7DnHr/Mu0Ee0XVVkLfuDIfa/ZRdNMka2
        Be7yxLYXss25SGJczJP45VXSUHHTHeWBlnwAH+3XvLUQu7iJ1ROaRz3HGV8iMlqAFWg6e6mqIO/Ty
        8rBXUtlQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixY3V-0006kb-H7; Fri, 31 Jan 2020 15:18:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F0AD83011E8;
        Fri, 31 Jan 2020 16:16:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B36FC2024716E; Fri, 31 Jan 2020 16:17:58 +0100 (CET)
Message-Id: <20200131151539.927625541@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 31 Jan 2020 16:07:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     peterz@infradead.org, mingo@kernel.org, will@kernel.org
Cc:     oleg@redhat.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, juri.lelli@redhat.com, williams@redhat.com,
        bristot@redhat.com, longman@redhat.com, dave@stgolabs.net,
        jack@suse.com
Subject: [PATCH -v2 1/7] locking/percpu-rwsem, lockdep: Make percpu-rwsem use its own lockdep_map
References: <20200131150703.194229898@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As preparation for replacing the embedded rwsem, give percpu-rwsem its
own lockdep_map.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
---
 include/linux/percpu-rwsem.h  |   29 +++++++++++++++++++----------
 kernel/cpu.c                  |    4 ++--
 kernel/locking/percpu-rwsem.c |   16 ++++++++++++----
 kernel/locking/rwsem.c        |    4 ++--
 kernel/locking/rwsem.h        |    2 ++
 5 files changed, 37 insertions(+), 18 deletions(-)

--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -15,8 +15,17 @@ struct percpu_rw_semaphore {
 	struct rw_semaphore	rw_sem; /* slowpath */
 	struct rcuwait          writer; /* blocked writer */
 	int			readers_block;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map	dep_map;
+#endif
 };
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#define __PERCPU_RWSEM_DEP_MAP_INIT(lockname)	.dep_map = { .name = #lockname },
+#else
+#define __PERCPU_RWSEM_DEP_MAP_INIT(lockname)
+#endif
+
 #define __DEFINE_PERCPU_RWSEM(name, is_static)				\
 static DEFINE_PER_CPU(unsigned int, __percpu_rwsem_rc_##name);		\
 is_static struct percpu_rw_semaphore name = {				\
@@ -24,7 +33,9 @@ is_static struct percpu_rw_semaphore nam
 	.read_count = &__percpu_rwsem_rc_##name,			\
 	.rw_sem = __RWSEM_INITIALIZER(name.rw_sem),			\
 	.writer = __RCUWAIT_INITIALIZER(name.writer),			\
+	__PERCPU_RWSEM_DEP_MAP_INIT(name)				\
 }
+
 #define DEFINE_PERCPU_RWSEM(name)		\
 	__DEFINE_PERCPU_RWSEM(name, /* not static */)
 #define DEFINE_STATIC_PERCPU_RWSEM(name)	\
@@ -37,7 +48,7 @@ static inline void percpu_down_read(stru
 {
 	might_sleep();
 
-	rwsem_acquire_read(&sem->rw_sem.dep_map, 0, 0, _RET_IP_);
+	rwsem_acquire_read(&sem->dep_map, 0, 0, _RET_IP_);
 
 	preempt_disable();
 	/*
@@ -76,13 +87,15 @@ static inline int percpu_down_read_trylo
 	 */
 
 	if (ret)
-		rwsem_acquire_read(&sem->rw_sem.dep_map, 0, 1, _RET_IP_);
+		rwsem_acquire_read(&sem->dep_map, 0, 1, _RET_IP_);
 
 	return ret;
 }
 
 static inline void percpu_up_read(struct percpu_rw_semaphore *sem)
 {
+	rwsem_release(&sem->dep_map, _RET_IP_);
+
 	preempt_disable();
 	/*
 	 * Same as in percpu_down_read().
@@ -92,8 +105,6 @@ static inline void percpu_up_read(struct
 	else
 		__percpu_up_read(sem); /* Unconditional memory barrier */
 	preempt_enable();
-
-	rwsem_release(&sem->rw_sem.dep_map, _RET_IP_);
 }
 
 extern void percpu_down_write(struct percpu_rw_semaphore *);
@@ -110,15 +121,13 @@ extern void percpu_free_rwsem(struct per
 	__percpu_init_rwsem(sem, #sem, &rwsem_key);		\
 })
 
-#define percpu_rwsem_is_held(sem) lockdep_is_held(&(sem)->rw_sem)
-
-#define percpu_rwsem_assert_held(sem)				\
-	lockdep_assert_held(&(sem)->rw_sem)
+#define percpu_rwsem_is_held(sem)	lockdep_is_held(sem)
+#define percpu_rwsem_assert_held(sem)	lockdep_assert_held(sem)
 
 static inline void percpu_rwsem_release(struct percpu_rw_semaphore *sem,
 					bool read, unsigned long ip)
 {
-	lock_release(&sem->rw_sem.dep_map, ip);
+	lock_release(&sem->dep_map, ip);
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 	if (!read)
 		atomic_long_set(&sem->rw_sem.owner, RWSEM_OWNER_UNKNOWN);
@@ -128,7 +137,7 @@ static inline void percpu_rwsem_release(
 static inline void percpu_rwsem_acquire(struct percpu_rw_semaphore *sem,
 					bool read, unsigned long ip)
 {
-	lock_acquire(&sem->rw_sem.dep_map, 0, 1, read, 1, NULL, ip);
+	lock_acquire(&sem->dep_map, 0, 1, read, 1, NULL, ip);
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 	if (!read)
 		atomic_long_set(&sem->rw_sem.owner, (long)current);
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -331,12 +331,12 @@ void lockdep_assert_cpus_held(void)
 
 static void lockdep_acquire_cpus_lock(void)
 {
-	rwsem_acquire(&cpu_hotplug_lock.rw_sem.dep_map, 0, 0, _THIS_IP_);
+	rwsem_acquire(&cpu_hotplug_lock.dep_map, 0, 0, _THIS_IP_);
 }
 
 static void lockdep_release_cpus_lock(void)
 {
-	rwsem_release(&cpu_hotplug_lock.rw_sem.dep_map, _THIS_IP_);
+	rwsem_release(&cpu_hotplug_lock.dep_map, _THIS_IP_);
 }
 
 /*
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -11,7 +11,7 @@
 #include "rwsem.h"
 
 int __percpu_init_rwsem(struct percpu_rw_semaphore *sem,
-			const char *name, struct lock_class_key *rwsem_key)
+			const char *name, struct lock_class_key *key)
 {
 	sem->read_count = alloc_percpu(int);
 	if (unlikely(!sem->read_count))
@@ -19,9 +19,13 @@ int __percpu_init_rwsem(struct percpu_rw
 
 	/* ->rw_sem represents the whole percpu_rw_semaphore for lockdep */
 	rcu_sync_init(&sem->rss);
-	__init_rwsem(&sem->rw_sem, name, rwsem_key);
+	init_rwsem(&sem->rw_sem);
 	rcuwait_init(&sem->writer);
 	sem->readers_block = 0;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	debug_check_no_locks_freed((void *)sem, sizeof(*sem));
+	lockdep_init_map(&sem->dep_map, name, key, 0);
+#endif
 	return 0;
 }
 EXPORT_SYMBOL_GPL(__percpu_init_rwsem);
@@ -142,10 +146,12 @@ static bool readers_active_check(struct
 
 void percpu_down_write(struct percpu_rw_semaphore *sem)
 {
+	rwsem_acquire(&sem->dep_map, 0, 0, _RET_IP_);
+
 	/* Notify readers to take the slow path. */
 	rcu_sync_enter(&sem->rss);
 
-	down_write(&sem->rw_sem);
+	__down_write(&sem->rw_sem);
 
 	/*
 	 * Notify new readers to block; up until now, and thus throughout the
@@ -168,6 +174,8 @@ EXPORT_SYMBOL_GPL(percpu_down_write);
 
 void percpu_up_write(struct percpu_rw_semaphore *sem)
 {
+	rwsem_release(&sem->dep_map, _RET_IP_);
+
 	/*
 	 * Signal the writer is done, no fast path yet.
 	 *
@@ -183,7 +191,7 @@ void percpu_up_write(struct percpu_rw_se
 	/*
 	 * Release the write lock, this will allow readers back in the game.
 	 */
-	up_write(&sem->rw_sem);
+	__up_write(&sem->rw_sem);
 
 	/*
 	 * Once this completes (at least one RCU-sched grace period hence) the
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1383,7 +1383,7 @@ static inline int __down_read_trylock(st
 /*
  * lock for writing
  */
-static inline void __down_write(struct rw_semaphore *sem)
+inline void __down_write(struct rw_semaphore *sem)
 {
 	long tmp = RWSEM_UNLOCKED_VALUE;
 
@@ -1446,7 +1446,7 @@ inline void __up_read(struct rw_semaphor
 /*
  * unlock after writing
  */
-static inline void __up_write(struct rw_semaphore *sem)
+inline void __up_write(struct rw_semaphore *sem)
 {
 	long tmp;
 
--- a/kernel/locking/rwsem.h
+++ b/kernel/locking/rwsem.h
@@ -6,5 +6,7 @@
 
 extern void __down_read(struct rw_semaphore *sem);
 extern void __up_read(struct rw_semaphore *sem);
+extern void __down_write(struct rw_semaphore *sem);
+extern void __up_write(struct rw_semaphore *sem);
 
 #endif /* __INTERNAL_RWSEM_H */


