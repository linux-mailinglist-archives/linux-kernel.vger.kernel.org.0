Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C947A171F52
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 15:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388514AbgB0OeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 09:34:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:45194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387774AbgB0OeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:34:12 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE913246BA;
        Thu, 27 Feb 2020 14:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582814051;
        bh=Zkc7OTubL7ZofJcFmaZdqja1Ms10TSr7KzZjfj/2mig=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=ml6+dh+ISU5bWvPtfK+oMIXuMfTuk1i40PQqZt9RySS9tb2PfdKZ4XAOjKRtNZgL0
         h2hcbykENjr0rMzvZj+SPOv0xD4cArKAbBl5igvhstB9nUK2cBu/61OTAyXqz6yQYf
         Ow2adBLv1pXHxv+1az2kAKr/wAePz53mnaAeppuM=
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
Subject: [PATCH RT 15/23] locking: Make spinlock_t and rwlock_t a RCU section on RT
Date:   Thu, 27 Feb 2020 08:33:26 -0600
Message-Id: <186fec3947a0cc8b99cbf8211a91c52140813302.1582814004.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1582814004.git.zanussi@kernel.org>
References: <cover.1582814004.git.zanussi@kernel.org>
In-Reply-To: <cover.1582814004.git.zanussi@kernel.org>
References: <cover.1582814004.git.zanussi@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v4.14.170-rt75-rc2 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit 84440022a0e1c8c936d61f8f97593674a295d409 ]

On !RT a locked spinlock_t and rwlock_t disables preemption which
implies a RCU read section. There is code that relies on that behaviour.

Add an explicit RCU read section on RT while a sleeping lock (a lock
which would disables preemption on !RT) acquired.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/locking/rtmutex.c   | 6 ++++++
 kernel/locking/rwlock-rt.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 4bc01a2a9a88..848d9ed6f053 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1142,6 +1142,7 @@ void __sched rt_spin_lock_slowunlock(struct rt_mutex *lock)
 void __lockfunc rt_spin_lock(spinlock_t *lock)
 {
 	sleeping_lock_inc();
+	rcu_read_lock();
 	migrate_disable();
 	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
 	rt_spin_lock_fastlock(&lock->lock, rt_spin_lock_slowlock);
@@ -1157,6 +1158,7 @@ void __lockfunc __rt_spin_lock(struct rt_mutex *lock)
 void __lockfunc rt_spin_lock_nested(spinlock_t *lock, int subclass)
 {
 	sleeping_lock_inc();
+	rcu_read_lock();
 	migrate_disable();
 	spin_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
 	rt_spin_lock_fastlock(&lock->lock, rt_spin_lock_slowlock);
@@ -1170,6 +1172,7 @@ void __lockfunc rt_spin_unlock(spinlock_t *lock)
 	spin_release(&lock->dep_map, 1, _RET_IP_);
 	rt_spin_lock_fastunlock(&lock->lock, rt_spin_lock_slowunlock);
 	migrate_enable();
+	rcu_read_unlock();
 	sleeping_lock_dec();
 }
 EXPORT_SYMBOL(rt_spin_unlock);
@@ -1201,6 +1204,7 @@ int __lockfunc rt_spin_trylock(spinlock_t *lock)
 	ret = __rt_mutex_trylock(&lock->lock);
 	if (ret) {
 		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
+		rcu_read_lock();
 	} else {
 		migrate_enable();
 		sleeping_lock_dec();
@@ -1217,6 +1221,7 @@ int __lockfunc rt_spin_trylock_bh(spinlock_t *lock)
 	ret = __rt_mutex_trylock(&lock->lock);
 	if (ret) {
 		sleeping_lock_inc();
+		rcu_read_lock();
 		migrate_disable();
 		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
 	} else
@@ -1233,6 +1238,7 @@ int __lockfunc rt_spin_trylock_irqsave(spinlock_t *lock, unsigned long *flags)
 	ret = __rt_mutex_trylock(&lock->lock);
 	if (ret) {
 		sleeping_lock_inc();
+		rcu_read_lock();
 		migrate_disable();
 		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
 	}
diff --git a/kernel/locking/rwlock-rt.c b/kernel/locking/rwlock-rt.c
index c3b91205161c..0ae8c62ea832 100644
--- a/kernel/locking/rwlock-rt.c
+++ b/kernel/locking/rwlock-rt.c
@@ -310,6 +310,7 @@ int __lockfunc rt_read_trylock(rwlock_t *rwlock)
 	ret = do_read_rt_trylock(rwlock);
 	if (ret) {
 		rwlock_acquire_read(&rwlock->dep_map, 0, 1, _RET_IP_);
+		rcu_read_lock();
 	} else {
 		migrate_enable();
 		sleeping_lock_dec();
@@ -327,6 +328,7 @@ int __lockfunc rt_write_trylock(rwlock_t *rwlock)
 	ret = do_write_rt_trylock(rwlock);
 	if (ret) {
 		rwlock_acquire(&rwlock->dep_map, 0, 1, _RET_IP_);
+		rcu_read_lock();
 	} else {
 		migrate_enable();
 		sleeping_lock_dec();
@@ -338,6 +340,7 @@ EXPORT_SYMBOL(rt_write_trylock);
 void __lockfunc rt_read_lock(rwlock_t *rwlock)
 {
 	sleeping_lock_inc();
+	rcu_read_lock();
 	migrate_disable();
 	rwlock_acquire_read(&rwlock->dep_map, 0, 0, _RET_IP_);
 	do_read_rt_lock(rwlock);
@@ -347,6 +350,7 @@ EXPORT_SYMBOL(rt_read_lock);
 void __lockfunc rt_write_lock(rwlock_t *rwlock)
 {
 	sleeping_lock_inc();
+	rcu_read_lock();
 	migrate_disable();
 	rwlock_acquire(&rwlock->dep_map, 0, 0, _RET_IP_);
 	do_write_rt_lock(rwlock);
@@ -358,6 +362,7 @@ void __lockfunc rt_read_unlock(rwlock_t *rwlock)
 	rwlock_release(&rwlock->dep_map, 1, _RET_IP_);
 	do_read_rt_unlock(rwlock);
 	migrate_enable();
+	rcu_read_unlock();
 	sleeping_lock_dec();
 }
 EXPORT_SYMBOL(rt_read_unlock);
@@ -367,6 +372,7 @@ void __lockfunc rt_write_unlock(rwlock_t *rwlock)
 	rwlock_release(&rwlock->dep_map, 1, _RET_IP_);
 	do_write_rt_unlock(rwlock);
 	migrate_enable();
+	rcu_read_unlock();
 	sleeping_lock_dec();
 }
 EXPORT_SYMBOL(rt_write_unlock);
-- 
2.14.1

