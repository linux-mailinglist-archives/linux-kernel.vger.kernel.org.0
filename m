Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E38511960FD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 23:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgC0WZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 18:25:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:42686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727848AbgC0WZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 18:25:05 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4348120748;
        Fri, 27 Mar 2020 22:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585347905;
        bh=vQe8NVEMs1r1iIdW79nChbeEufogMpa18G/zwHFEoSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SQiiUl5hDCl4F4W5UrTIKu284R2qZVNjSmhtQ2LuOLwHq2Vi7RxFpkjGaBpt8Fqc1
         35iaRZVOIFutS9ooRUWswhZyjl1s6JhHSkKuGfw2XGXuDYkBXPZ85dtPDacW2OGKYZ
         QrWa1lZ5oMSpCAyqSRJLDh+l5NLCK4wuwuuKxicc=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v3 tip/core/rcu 21/34] rcu-tasks: Add a grace-period start time for throttling and debug
Date:   Fri, 27 Mar 2020 15:24:43 -0700
Message-Id: <20200327222456.12470-21-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200327222346.GA12082@paulmck-ThinkPad-P72>
References: <20200327222346.GA12082@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds a place to record the grace-period start in jiffies.
This will be used by later commits for debugging purposes and to throttle
IPIs early in the grace period.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index cbc9905..fa9c069 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -46,6 +46,7 @@ struct rcu_tasks {
 	raw_spinlock_t cbs_lock;
 	int gp_state;
 	unsigned long gp_jiffies;
+	unsigned long gp_start;
 	struct task_struct *kthread_ptr;
 	rcu_tasks_gp_func_t gp_func;
 	pregp_func_t pregp_func;
@@ -200,6 +201,7 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 
 		// Wait for one grace period.
 		set_tasks_gp_state(rtp, RTGS_WAIT_GP);
+		rtp->gp_start = jiffies;
 		rtp->gp_func(rtp);
 
 		/* Invoke the callbacks. */
-- 
2.9.5

