Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA8FFE421E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 05:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388011AbfJYDif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 23:38:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:43458 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727145AbfJYDif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 23:38:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E8373B25C;
        Fri, 25 Oct 2019 03:38:33 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     mingo@kernel.org
Cc:     peterz@infradead.org, dave@stgolabs.net,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH -tip] locking/mutex: Complain upon api misuse wrt interrupt context
Date:   Thu, 24 Oct 2019 20:36:34 -0700
Message-Id: <20191025033634.3330-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sprinkle warning checks, under CONFIG_DEBUG_MUTEXES. While the mutex
rules and semantics are explicitly documented, this allows to expose
any abusers and robustifies the whole thing. While trylock and unlock
are non-blocking, calling from irq context is still forbidden (lock
must be within the same context as unlock).

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 kernel/locking/mutex.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 468a9b8422e3..7e9c316c646c 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -733,6 +733,9 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
  */
 void __sched mutex_unlock(struct mutex *lock)
 {
+#ifdef CONFIG_DEBUG_MUTEXES
+	WARN_ON(in_interrupt());
+#endif
 #ifndef CONFIG_DEBUG_LOCK_ALLOC
 	if (__mutex_unlock_fast(lock))
 		return;
@@ -1413,6 +1416,7 @@ int __sched mutex_trylock(struct mutex *lock)
 
 #ifdef CONFIG_DEBUG_MUTEXES
 	DEBUG_LOCKS_WARN_ON(lock->magic != lock);
+	WARN_ON(in_interrupt());
 #endif
 
 	locked = __mutex_trylock(lock);
-- 
2.16.4

