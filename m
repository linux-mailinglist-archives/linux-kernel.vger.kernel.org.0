Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8466D15FB95
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 01:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgBOAmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 19:42:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:49150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727602AbgBOAmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 19:42:07 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47E8924676;
        Sat, 15 Feb 2020 00:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581727327;
        bh=3I1QvKFofAfB+tFcEzBsREVF7ffuxDVlm5uIPAXPc60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MgKGW7NPTQVWPthdhRGGQJUpafnmIW7J3dWpjVBkVPBgjwR3l1CiYQ9UwTC19fhZm
         tEgj+J4Obxeza72XVFv8Gi/cXO1VN3Zwn2P8UROrq9QZSkXXOQ+ottwE85Owu2fglv
         4zdVWlMEVElFZoeD8ktAzYs1mc8391HkLLvzYG+8=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 17/18] rcutorture: Manually clean up after rcu_barrier() failure
Date:   Fri, 14 Feb 2020 16:41:24 -0800
Message-Id: <20200215004125.16953-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200215003634.GA16227@paulmck-ThinkPad-P72>
References: <20200215003634.GA16227@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, if rcu_barrier() returns too soon, the test waits 100ms and
then does another instance of the test.  However, if rcu_barrier() were
to have waited for more than 100ms too short a time, this could cause
the test's rcu_head structures to be reused while they were still on
RCU's callback lists.  This can result in knock-on errors that obscure
the original rcu_barrier() test failure.

This commit therefore adds code that attempts to wait until all of
the test's callbacks have been invoked.  Of course, if RCU completely
lost track of the corresponding rcu_head structures, this wait could be
forever.  This commit therefore also complains if this attempted recovery
takes more than one second, and it also gives up when the test ends.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index f82515c..5453bd5 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2124,7 +2124,21 @@ static int rcu_torture_barrier(void *arg)
 			pr_err("barrier_cbs_invoked = %d, n_barrier_cbs = %d\n",
 			       atomic_read(&barrier_cbs_invoked),
 			       n_barrier_cbs);
-			WARN_ON_ONCE(1);
+			WARN_ON(1);
+			// Wait manually for the remaining callbacks
+			i = 0;
+			do {
+				if (WARN_ON(i++ > HZ))
+					i = INT_MIN;
+				schedule_timeout_interruptible(1);
+				cur_ops->cb_barrier();
+			} while (atomic_read(&barrier_cbs_invoked) !=
+				 n_barrier_cbs &&
+				 !torture_must_stop());
+			smp_mb(); // Can't trust ordering if broken.
+			if (!torture_must_stop())
+				pr_err("Recovered: barrier_cbs_invoked = %d\n",
+				       atomic_read(&barrier_cbs_invoked));
 		} else {
 			n_barrier_successes++;
 		}
-- 
2.9.5

