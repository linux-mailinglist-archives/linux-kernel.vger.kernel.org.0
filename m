Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64146117EC4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 05:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfLJEIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 23:08:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:43344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726953AbfLJEHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:07:46 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8782B20828;
        Tue, 10 Dec 2019 04:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575950866;
        bh=QRuENrWQsFO86orF+hIXkaucxBWb5Zr3So7jpgEhebI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z1eiiqPq2UyLmPivJP63F3Eit/vmiwIqZrH7VtOOHe++vBqI4oTU21phur/uKnBR8
         kSn9cj8VicRfNE9sA3c+/JkbnoX+31uG1QO0dPi8NBdvbiBgLiRqGNQSRmuFSSUDzk
         sqvueU3uu/N5Hu+wEPsZmcImbLurNtduQYl1POKo=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 04/12] rcu: Fix tracepoint tracking RCU CPU kthread utilization
Date:   Mon,  9 Dec 2019 20:07:33 -0800
Message-Id: <20191210040741.2943-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210040714.GA2715@paulmck-ThinkPad-P72>
References: <20191210040714.GA2715@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

In the call to trace_rcu_utilization() at the start of the loop in
rcu_cpu_kthread(), "rcu_wait" is incorrect, plus this trace event needs
to be hoisted above the loop to balance with either the "rcu_wait" or
"rcu_yield", depending on how the loop exits.  This commit therefore
makes these changes.

Signed-off-by: Lai Jiangshan <jiangshanlai@gmail.com>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index dd8cfc3..ba154a3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2474,8 +2474,8 @@ static void rcu_cpu_kthread(unsigned int cpu)
 	char work, *workp = this_cpu_ptr(&rcu_data.rcu_cpu_has_work);
 	int spincnt;
 
+	trace_rcu_utilization(TPS("Start CPU kthread@rcu_run"));
 	for (spincnt = 0; spincnt < 10; spincnt++) {
-		trace_rcu_utilization(TPS("Start CPU kthread@rcu_wait"));
 		local_bh_disable();
 		*statusp = RCU_KTHREAD_RUNNING;
 		local_irq_disable();
-- 
2.9.5

