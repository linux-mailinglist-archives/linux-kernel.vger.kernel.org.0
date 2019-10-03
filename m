Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92D33C964D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 03:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbfJCBjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 21:39:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727127AbfJCBjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:39:06 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0709222C4;
        Thu,  3 Oct 2019 01:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570066746;
        bh=FpL5YvkDdg4RVG52mRZHGhleRA1CCuTWDAmisi5oPRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nn5I8KdOBbZD7onKrQJi5gaT/xj6j4d0WvUkv2dXzUiPqFrjAgAaPO5mnQrIsf5Zd
         dhtSyYFF96V59kLkGgVbllxli+YoV6flPCJp7FOE0maJf03uD2EHfzpGzh0c1wG63w
         1xvHzAeJTV2MayQaxrk4EUGriiTbXs89RxsOlFqY=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 02/12] time: Export tick start/stop functions for rcutorture
Date:   Wed,  2 Oct 2019 18:38:53 -0700
Message-Id: <20191003013903.13079-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003013834.GA12927@paulmck-ThinkPad-P72>
References: <20191003013834.GA12927@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.ibm.com>

It turns out that rcutorture needs to ensure that the scheduling-clock
interrupt is enabled in CONFIG_NO_HZ_FULL kernels before starting on
CPU-bound in-kernel processing.  This commit therefore exports
tick_nohz_dep_set_task(), tick_nohz_dep_clear_task(), and
tick_nohz_full_setup() to GPL kernel modules.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/time/tick-sched.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index d1b0a84..1ffdb4b 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -172,6 +172,7 @@ static void tick_sched_handle(struct tick_sched *ts, struct pt_regs *regs)
 #ifdef CONFIG_NO_HZ_FULL
 cpumask_var_t tick_nohz_full_mask;
 bool tick_nohz_full_running;
+EXPORT_SYMBOL_GPL(tick_nohz_full_running);
 static atomic_t tick_dep_mask;
 
 static bool check_tick_dependency(atomic_t *dep)
@@ -351,11 +352,13 @@ void tick_nohz_dep_set_task(struct task_struct *tsk, enum tick_dep_bits bit)
 	 */
 	tick_nohz_dep_set_all(&tsk->tick_dep_mask, bit);
 }
+EXPORT_SYMBOL_GPL(tick_nohz_dep_set_task);
 
 void tick_nohz_dep_clear_task(struct task_struct *tsk, enum tick_dep_bits bit)
 {
 	atomic_andnot(BIT(bit), &tsk->tick_dep_mask);
 }
+EXPORT_SYMBOL_GPL(tick_nohz_dep_clear_task);
 
 /*
  * Set a per-taskgroup tick dependency. Posix CPU timers need this in order to elapse
@@ -404,6 +407,7 @@ void __init tick_nohz_full_setup(cpumask_var_t cpumask)
 	cpumask_copy(tick_nohz_full_mask, cpumask);
 	tick_nohz_full_running = true;
 }
+EXPORT_SYMBOL_GPL(tick_nohz_full_setup);
 
 static int tick_nohz_cpu_down(unsigned int cpu)
 {
-- 
2.9.5

