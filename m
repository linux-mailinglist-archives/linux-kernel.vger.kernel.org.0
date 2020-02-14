Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6B815FB24
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 00:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbgBNX5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 18:57:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:36934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbgBNX5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 18:57:06 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B6F724650;
        Fri, 14 Feb 2020 23:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581724625;
        bh=D6j1tXPphXZ5GajKLJ8/Pzq/9LkCUdeqMQ58e6TV40g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=geXbzF697MOrynFf1hxiWhU7GgEASH7kMrhakr3COK+Lw2TmEDfNZ5CBgCtQncZAR
         REglkGnJx4DMD17AmoY1JgqmDlkdaFD3pd8ZU14jPfichFkL1WBrJZUG3lCdC705MF
         E7MGX9ABi+10NHkX/30wlb62hFZuC6C6xAdLn+OQ=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 15/30] rcu: Add *_ONCE() to rcu_data ->rcu_forced_tick
Date:   Fri, 14 Feb 2020 15:55:52 -0800
Message-Id: <20200214235607.13749-15-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200214235536.GA13364@paulmck-ThinkPad-P72>
References: <20200214235536.GA13364@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcu_data structure's ->rcu_forced_tick field is read locklessly, so
this commit adds WRITE_ONCE() to all updates and READ_ONCE() to all
lockless reads.

This data race was reported by KCSAN.  Not appropriate for backporting
due to failure being unlikely.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e851a12..be59a5d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -818,11 +818,12 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
 		incby = 1;
 	} else if (tick_nohz_full_cpu(rdp->cpu) &&
 		   rdp->dynticks_nmi_nesting == DYNTICK_IRQ_NONIDLE &&
-		   READ_ONCE(rdp->rcu_urgent_qs) && !rdp->rcu_forced_tick) {
+		   READ_ONCE(rdp->rcu_urgent_qs) &&
+		   !READ_ONCE(rdp->rcu_forced_tick)) {
 		raw_spin_lock_rcu_node(rdp->mynode);
 		// Recheck under lock.
 		if (rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
-			rdp->rcu_forced_tick = true;
+			WRITE_ONCE(rdp->rcu_forced_tick, true);
 			tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
 		}
 		raw_spin_unlock_rcu_node(rdp->mynode);
@@ -899,7 +900,7 @@ static void rcu_disable_urgency_upon_qs(struct rcu_data *rdp)
 	WRITE_ONCE(rdp->rcu_need_heavy_qs, false);
 	if (tick_nohz_full_cpu(rdp->cpu) && rdp->rcu_forced_tick) {
 		tick_dep_clear_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
-		rdp->rcu_forced_tick = false;
+		WRITE_ONCE(rdp->rcu_forced_tick, false);
 	}
 }
 
-- 
2.9.5

