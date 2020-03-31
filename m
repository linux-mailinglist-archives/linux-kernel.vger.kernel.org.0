Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C05D7199FDF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 22:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgCaUSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 16:18:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33672 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbgCaUSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 16:18:52 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jJNLW-0008KN-0M; Tue, 31 Mar 2020 22:18:50 +0200
Date:   Tue, 31 Mar 2020 22:18:49 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     syzbot <syzbot+62c155c276e580cfb606@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Subject: [PATCH] lockdep: Don't access the hrtimer after the callback
Message-ID: <20200331201849.fkp2siy3vcdqvqlz@linutronix.de>
References: <000000000000b8935105a229a739@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000000000000b8935105a229a739@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A hrtimer can be released in its callback as reported by syzbot.

Retrieve the context in which the hrtimer expires before its callback is
invoked and use it in lockdep_hrtimer_exit().

Reported-by: syzbot+62c155c276e580cfb606@syzkaller.appspotmail.com
Fixes: 40db173965c0 ("lockdep: Add hrtimer context tracing bits")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/irqflags.h | 22 +++++++++++++---------
 kernel/time/hrtimer.c    |  5 +++--
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index a16adbb58f66a..808d10de852f9 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -58,16 +58,20 @@ do {						\
 } while (0)
 
 # define lockdep_hrtimer_enter(__hrtimer)		\
-	  do {						\
-		  if (!__hrtimer->is_hard)		\
-			current->irq_config = 1;	\
-	  } while (0)
+({							\
+	bool __expires_hardirq = true;			\
+	if (!__hrtimer->is_hard) {			\
+		current->irq_config = 1;		\
+		__expires_hardirq = false;		\
+	}						\
+	__expires_hardirq;				\
+})
 
-# define lockdep_hrtimer_exit(__hrtimer)		\
-	  do {						\
-		  if (!__hrtimer->is_hard)		\
+# define lockdep_hrtimer_exit(__expires_hardirq)	\
+	do {						\
+		if (__expires_hardirq == false)	\
 			current->irq_config = 0;	\
-	  } while (0)
+	} while (0)
 
 # define lockdep_posixtimer_enter()				\
 	  do {							\
@@ -102,7 +106,7 @@ do {						\
 # define trace_hardirq_exit()		do { } while (0)
 # define lockdep_softirq_enter()	do { } while (0)
 # define lockdep_softirq_exit()		do { } while (0)
-# define lockdep_hrtimer_enter(__hrtimer)		do { } while (0)
+# define lockdep_hrtimer_enter(__hrtimer)		false
 # define lockdep_hrtimer_exit(__hrtimer)		do { } while (0)
 # define lockdep_posixtimer_enter()		do { } while (0)
 # define lockdep_posixtimer_exit()		do { } while (0)
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 8cce72501aea5..817a9c7be47e3 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1481,6 +1481,7 @@ static void __run_hrtimer(struct hrtimer_cpu_base *cpu_base,
 {
 	enum hrtimer_restart (*fn)(struct hrtimer *);
 	int restart;
+	bool expires_in_hardirq;
 
 	lockdep_assert_held(&cpu_base->lock);
 
@@ -1514,11 +1515,11 @@ static void __run_hrtimer(struct hrtimer_cpu_base *cpu_base,
 	 */
 	raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
 	trace_hrtimer_expire_entry(timer, now);
-	lockdep_hrtimer_enter(timer);
+	expires_in_hardirq = lockdep_hrtimer_enter(timer);
 
 	restart = fn(timer);
 
-	lockdep_hrtimer_exit(timer);
+	lockdep_hrtimer_exit(expires_in_hardirq);
 	trace_hrtimer_expire_exit(timer);
 	raw_spin_lock_irq(&cpu_base->lock);
 
-- 
2.26.0

