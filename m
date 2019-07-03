Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70F165E0E8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 11:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfGCJV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 05:21:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51213 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfGCJV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 05:21:29 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hibSA-000854-2g; Wed, 03 Jul 2019 11:21:26 +0200
Date:   Wed, 3 Jul 2019 11:21:26 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        tglx@linutronix.de
Subject: [PATCH] locking/mutex: Test for initialized mutex
Message-ID: <20190703092125.lsdf4gpsh2plhavb@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An uninitialized/ zeroed mutex will go unnoticed because there is no
check for it. There is a magic check in the unlock's slowpath path which
might go unnoticed if the unlock happens in the fastpath.

Add a ->magic check early in the mutex_lock() and mutex_trylock() path.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
Nothing screamed during uninitialized usage of init_mm's context->lock
  https://git.kernel.org/tip/32232b350d7cd93cdc65fe5a453e6a40b539e9f9

 kernel/locking/mutex.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 0c601ae072b3f..fb1f6f1e1cc61 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -908,6 +908,10 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 
 	might_sleep();
 
+#ifdef CONFIG_DEBUG_MUTEXES
+	DEBUG_LOCKS_WARN_ON(lock->magic != lock);
+#endif
+
 	ww = container_of(lock, struct ww_mutex, base);
 	if (use_ww_ctx && ww_ctx) {
 		if (unlikely(ww_ctx == READ_ONCE(ww->ctx)))
@@ -1379,8 +1383,13 @@ __ww_mutex_lock_interruptible_slowpath(struct ww_mutex *lock,
  */
 int __sched mutex_trylock(struct mutex *lock)
 {
-	bool locked = __mutex_trylock(lock);
+	bool locked;
 
+#ifdef CONFIG_DEBUG_MUTEXES
+	DEBUG_LOCKS_WARN_ON(lock->magic != lock);
+#endif
+
+	locked = __mutex_trylock(lock);
 	if (locked)
 		mutex_acquire(&lock->dep_map, 0, 1, _RET_IP_);
 
-- 
2.20.1

