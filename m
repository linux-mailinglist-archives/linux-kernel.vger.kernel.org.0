Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF2642A29D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2019 05:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfEYDdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 23:33:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:42984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbfEYDdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 23:33:17 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A07D21851;
        Sat, 25 May 2019 03:33:17 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hUNQq-0002HI-5h; Fri, 24 May 2019 23:33:16 -0400
Message-Id: <20190525033316.065666249@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 24 May 2019 23:32:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, stable-rt@vger.kernel.org,
        Corey Minyard <cminyard@mvista.com>
Subject: [PATCH RT 5/6] sched/completion: Fix a lockup in wait_for_completion()
References: <20190525033232.795741612@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19.37-rt20-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Corey Minyard <cminyard@mvista.com>

Consider following race:

  T0                    T1                       T2
  wait_for_completion()
   do_wait_for_common()
    __prepare_to_swait()
     schedule()
                        complete()
                         x->done++ (0 -> 1)
                         raw_spin_lock_irqsave()
                         swake_up_locked()       wait_for_completion()
                          wake_up_process(T0)
                          list_del_init()
                         raw_spin_unlock_irqrestore()
                                                  raw_spin_lock_irq(&x->wait.lock)
  raw_spin_lock_irq(&x->wait.lock)                x->done != UINT_MAX, 1 -> 0
                                                  raw_spin_unlock_irq(&x->wait.lock)
                                                  return 1
   while (!x->done && timeout),
   continue loop, not enqueued
   on &x->wait

Basically, the problem is that the original wait queues used in
completions did not remove the item from the queue in the wakeup
function, but swake_up_locked() does.

Fix it by adding the thread to the wait queue inside the do loop.
The design of swait detects if it is already in the list and doesn't
do the list add again.

Cc: stable-rt@vger.kernel.org
Fixes: a04ff6b4ec4ee7e ("completion: Use simple wait queues")
Signed-off-by: Corey Minyard <cminyard@mvista.com>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
[bigeasy: shorten commit message ]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/sched/completion.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index 755a58084978..49c14137988e 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -72,12 +72,12 @@ do_wait_for_common(struct completion *x,
 	if (!x->done) {
 		DECLARE_SWAITQUEUE(wait);
 
-		__prepare_to_swait(&x->wait, &wait);
 		do {
 			if (signal_pending_state(state, current)) {
 				timeout = -ERESTARTSYS;
 				break;
 			}
+			__prepare_to_swait(&x->wait, &wait);
 			__set_current_state(state);
 			raw_spin_unlock_irq(&x->wait.lock);
 			timeout = action(timeout);
-- 
2.20.1


