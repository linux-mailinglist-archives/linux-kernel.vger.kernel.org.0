Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9A7BEAD2B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 11:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfJaKJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 06:09:24 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:53860 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726193AbfJaKJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 06:09:23 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0Tgm6rct_1572516503;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0Tgm6rct_1572516503)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 31 Oct 2019 18:08:23 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>, rcu@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 00/11] rcu: introduce percpu rcu_preempt_depth
Date:   Thu, 31 Oct 2019 10:07:55 +0000
Message-Id: <20191031100806.1326-1-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My mind was occupied with percpu rcu_preempt_depth for
several years since Peter introduced percu preempt_count.
But it was stopped by no good way to avoid the scheduler deadlocks.
Now we have deferred_qs to avoid the deadlocks, it is time to implement it.

During the work, I found two possible? drawbacks (fixed by patch1/2
but patch2 is reverted by patch8 which is a better way).

And my not noticing the order of handling special.b.deferred_qs
ate many debuging energy (patch7).

The percpu rcu_preempt_depth patch is the last patch, patch11.

x86 is the only beneficial arch. But other arch can put
->rcu_read_lock_nesting and ->rcu_read_unlock_special to
thread_info to avoid the function call after we have patch8/9.

CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: x86@kernel.org
CC: "Paul E. McKenney" <paulmck@kernel.org>
CC: Josh Triplett <josh@joshtriplett.org>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: Lai Jiangshan <jiangshanlai@gmail.com>
CC: Joel Fernandes <joel@joelfernandes.org>
CC: Peter Zijlstra <peterz@infradead.org>
CC: linux-kernel@vger.kernel.org
CC: rcu@vger.kernel.org

Lai Jiangshan (11):
  rcu: avoid leaking exp_deferred_qs into next GP
  rcu: fix bug when rcu_exp_handler() in nested interrupt
  rcu: clean up rcu_preempt_deferred_qs_irqrestore()
  rcu: cleanup rcu_preempt_deferred_qs()
  rcu: clean all rcu_read_unlock_special after report qs
  rcu: clear t->rcu_read_unlock_special in one go
  rcu: set special.b.deferred_qs before wake_up()
  rcu: don't use negative ->rcu_read_lock_nesting
  rcu: wrap usages of rcu_read_lock_nesting
  rcu: clear the special.b.need_qs in rcu_note_context_switch()
  x86,rcu: use percpu rcu_preempt_depth

 arch/x86/Kconfig                         |   2 +
 arch/x86/include/asm/rcu_preempt_depth.h |  87 +++++++++++++++
 arch/x86/kernel/cpu/common.c             |   7 ++
 arch/x86/kernel/process_32.c             |   2 +
 arch/x86/kernel/process_64.c             |   2 +
 include/linux/rcupdate.h                 |  24 +++++
 init/init_task.c                         |   2 +-
 kernel/fork.c                            |   2 +-
 kernel/rcu/Kconfig                       |   3 +
 kernel/rcu/tree_exp.h                    |  58 ++++------
 kernel/rcu/tree_plugin.h                 | 130 +++++++++++++----------
 11 files changed, 220 insertions(+), 99 deletions(-)
 create mode 100644 arch/x86/include/asm/rcu_preempt_depth.h

-- 
2.20.1

