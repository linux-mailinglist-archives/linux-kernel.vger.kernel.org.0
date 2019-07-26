Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A008377360
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 23:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfGZVYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 17:24:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50430 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728284AbfGZVYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 17:24:09 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hr7h9-00030n-I5; Fri, 26 Jul 2019 23:24:07 +0200
Message-Id: <20190726212124.302995288@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 26 Jul 2019 23:19:39 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [patch 3/8] locking: Use CONFIG_PREEMPTION
References: <20190726211936.226129163@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by
CONFIG_PREEMPT_RT. Both PREEMPT and PREEMPT_RT require the same
functionality which today depends on CONFIG_PREEMPT.

Adjust the comments in the locking code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/spinlock.h         |    2 +-
 include/linux/spinlock_api_smp.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -214,7 +214,7 @@ static inline void do_raw_spin_unlock(ra
 
 /*
  * Define the various spin_lock methods.  Note we define these
- * regardless of whether CONFIG_SMP or CONFIG_PREEMPT are set. The
+ * regardless of whether CONFIG_SMP or CONFIG_PREEMPTION are set. The
  * various methods are defined as nops in the case they are not
  * required.
  */
--- a/include/linux/spinlock_api_smp.h
+++ b/include/linux/spinlock_api_smp.h
@@ -96,7 +96,7 @@ static inline int __raw_spin_trylock(raw
 
 /*
  * If lockdep is enabled then we use the non-preemption spin-ops
- * even on CONFIG_PREEMPT, because lockdep assumes that interrupts are
+ * even on CONFIG_PREEMPTION, because lockdep assumes that interrupts are
  * not re-enabled during lock-acquire (which the preempt-spin-ops do):
  */
 #if !defined(CONFIG_GENERIC_LOCKBREAK) || defined(CONFIG_DEBUG_LOCK_ALLOC)


