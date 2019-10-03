Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5985EC9639
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 03:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbfJCBdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 21:33:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:42442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbfJCBdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:33:09 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32843222C7;
        Thu,  3 Oct 2019 01:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570066388;
        bh=Rr8e9ht2VrnIxX1RK/ddKcZ5ghHw5GNdkouYG8OsgKc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KdHM0x7WI8mx+uaXYKpspyU6KGbA1OQmO5VIqsXEFdCBg+Qr6ngZRiEoV55nI3sEo
         qs6zQDBkzIkd9Xz5+zzViCRy4eE953HrVscrzBSMuXq/hBiAK+k/bUS89eSn+KXAz8
         GIflB22LrpXeLCEiNbcYg4m0gEO4Z3oEicCHM60g=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 4/8] rcu: Ensure that ->rcu_urgent_qs is set before resched IPI
Date:   Wed,  2 Oct 2019 18:33:01 -0700
Message-Id: <20191003013305.12854-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003013243.GA12705@paulmck-ThinkPad-P72>
References: <20191003013243.GA12705@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

The RCU-specific resched_cpu() function sends a resched IPI to the
specified CPU, which can be used to force the tick on for a given
nohz_full CPU.  This is needed when this nohz_full CPU is looping in the
kernel while blocking the current grace period.  However, for the tick
to actually be forced on in all cases, that CPU's rcu_data structure's
->rcu_urgent_qs flag must be set beforehand.  This commit therefore
causes rcu_implicit_dynticks_qs() to set this flag prior to invoking
resched_cpu() on a holdout nohz_full CPU.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8110514..0d83b19 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1073,6 +1073,7 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 	if (tick_nohz_full_cpu(rdp->cpu) &&
 		   time_after(jiffies,
 			      READ_ONCE(rdp->last_fqs_resched) + jtsq * 3)) {
+		WRITE_ONCE(*ruqp, true);
 		resched_cpu(rdp->cpu);
 		WRITE_ONCE(rdp->last_fqs_resched, jiffies);
 	}
-- 
2.9.5

