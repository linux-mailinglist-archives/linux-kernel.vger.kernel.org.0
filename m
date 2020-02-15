Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE2C115FB6E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 01:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgBOAZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 19:25:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:44568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbgBOAZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 19:25:31 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F179B20848;
        Sat, 15 Feb 2020 00:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581726331;
        bh=6O04s8fVI+hKJIC6gMrfz6NXoFSAdLOHhdNh5qtlAOE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SUcWhw2JqntqKMYbqAoY7uyBwD8ZqubcM7x5S5Z1FH6TPvUsIIfQ9GuHMOlwNClLc
         d2LUMlZzFieyZMue2IHK4KXijzPWxgQl9Y8JEO8wixFP6EQMXEJPWTTMFjJUIAMTe+
         B/I6qXi/PIR8GtuZihTJgObcrpgJjl2U1SRMEwd8=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Jules Irenge <jbi.octave@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 2/3] rcu: Add missing annotation for exit_tasks_rcu_start()
Date:   Fri, 14 Feb 2020 16:25:19 -0800
Message-Id: <20200215002520.15746-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200215002446.GA15663@paulmck-ThinkPad-P72>
References: <20200215002446.GA15663@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jules Irenge <jbi.octave@gmail.com>

Sparse reports a warning at exit_tasks_rcu_start(void)

|warning: context imbalance in exit_tasks_rcu_start() - wrong count at exit

To fix this, this commit adds an __acquires(&tasks_rcu_exit_srcu).
Given that exit_tasks_rcu_start() does actually call __srcu_read_lock(),
this not only fixes the warning but also improves on the readability of
the code.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/update.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index a27df76..a04fe54 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -801,7 +801,7 @@ static int __init rcu_spawn_tasks_kthread(void)
 core_initcall(rcu_spawn_tasks_kthread);
 
 /* Do the srcu_read_lock() for the above synchronize_srcu().  */
-void exit_tasks_rcu_start(void)
+void exit_tasks_rcu_start(void) __acquires(&tasks_rcu_exit_srcu)
 {
 	preempt_disable();
 	current->rcu_tasks_idx = __srcu_read_lock(&tasks_rcu_exit_srcu);
-- 
2.9.5

