Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5E4915FB2E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 00:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgBNX5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 18:57:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:37588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727845AbgBNX5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 18:57:42 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB3DF2072D;
        Fri, 14 Feb 2020 23:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581724662;
        bh=aRTqVsj3wNQHTJXkrDNowSUys3T5iSvPRmwZP0SNvrM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uCylDB17ngFJyQ6+0mngWYTKH5RUCc+JGpU45TGLnVMXAn3CATd5v05aqgq1Ux5mk
         9DdqOhBdjy4hUVsS8qeQ/lGv9vQ7YQUZI5X6PCZVqLtyxlfpWOJbxEhzm9thxOzqHQ
         yTeH6AHdBmEpdgCS4rvALs1cqqb4EADUbt5kZodc=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 25/30] rcu: Optimize and protect atomic_cmpxchg() loop
Date:   Fri, 14 Feb 2020 15:56:02 -0800
Message-Id: <20200214235607.13749-25-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200214235536.GA13364@paulmck-ThinkPad-P72>
References: <20200214235536.GA13364@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit reworks the atomic_cmpxchg() loop in rcu_eqs_special_set()
to do only the initial read from the current CPU's rcu_data structure's
->dynticks field explicitly.  On subsequent passes, this value is instead
retained from the failing atomic_cmpxchg() operation.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 5ee5657..4146207 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -342,14 +342,17 @@ bool rcu_eqs_special_set(int cpu)
 {
 	int old;
 	int new;
+	int new_old;
 	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
 
+	new_old = atomic_read(&rdp->dynticks);
 	do {
-		old = atomic_read(&rdp->dynticks);
+		old = new_old;
 		if (old & RCU_DYNTICK_CTRL_CTR)
 			return false;
 		new = old | RCU_DYNTICK_CTRL_MASK;
-	} while (atomic_cmpxchg(&rdp->dynticks, old, new) != old);
+		new_old = atomic_cmpxchg(&rdp->dynticks, old, new);
+	} while (new_old != old);
 	return true;
 }
 
-- 
2.9.5

