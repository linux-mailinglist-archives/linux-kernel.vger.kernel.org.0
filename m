Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12366C9649
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 03:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbfJCBjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 21:39:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728464AbfJCBjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:39:09 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A9B6222CB;
        Thu,  3 Oct 2019 01:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570066748;
        bh=0pOwz065UlX565s8gDHe52+a8FGdnMAl9FGz7Fqy6cY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0M6VdiOiCFeQ7gBheVSzVN1OOdjctEqoV14Z6rQintzkUL9f1sfCeCa/Jl9A33mXs
         taRZ65sv9AjRyHTMEXT/hn8q6i80uN2KcASlJ7BI1u5Qj4yggeUPhq7YykJ90CLg/2
         09u7hlrbE3VpIeft3UjFCfCjTZ7u33UGHfSh9IIM=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 09/12] rcu: Force nohz_full tick on upon irq enter instead of exit
Date:   Wed,  2 Oct 2019 18:39:00 -0700
Message-Id: <20191003013903.13079-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003013834.GA12927@paulmck-ThinkPad-P72>
References: <20191003013834.GA12927@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.ibm.com>

There is interrupt-exit code that forces on the tick for nohz_full CPUs
failing to respond to the current grace period in a timely fashion.
However, this code must compare ->dynticks_nmi_nesting to the value 2
in the interrupt-exit fastpath.  This commit therefore moves this code
to the interrupt-entry fastpath, where a lighter-weight comparison to
zero may be used.

Reported-by: Joel Fernandes <joel@joelfernandes.org>
[ paulmck: Apply Joel Fernandes TICK_DEP_MASK_RCU->TICK_DEP_BIT_RCU fix. ]
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 621cc06..1601fa6 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -650,12 +650,6 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
 	 */
 	if (rdp->dynticks_nmi_nesting != 1) {
 		trace_rcu_dyntick(TPS("--="), rdp->dynticks_nmi_nesting, rdp->dynticks_nmi_nesting - 2, rdp->dynticks);
-		if (tick_nohz_full_cpu(rdp->cpu) &&
-		    rdp->dynticks_nmi_nesting == 2 &&
-		    rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
-			rdp->rcu_forced_tick = true;
-			tick_dep_set_cpu(rdp->cpu, TICK_DEP_MASK_RCU);
-		}
 		WRITE_ONCE(rdp->dynticks_nmi_nesting, /* No store tearing. */
 			   rdp->dynticks_nmi_nesting - 2);
 		return;
@@ -830,6 +824,11 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
 			rcu_cleanup_after_idle();
 
 		incby = 1;
+	} else if (tick_nohz_full_cpu(rdp->cpu) &&
+		   rdp->dynticks_nmi_nesting == DYNTICK_IRQ_NONIDLE &&
+		   rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
+		rdp->rcu_forced_tick = true;
+		tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
 	}
 	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
 			  rdp->dynticks_nmi_nesting,
-- 
2.9.5

