Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0312F15FB2A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 00:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgBNX53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 18:57:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:37330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728202AbgBNX51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 18:57:27 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BE36222C4;
        Fri, 14 Feb 2020 23:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581724647;
        bh=Nk4+jqw8EBoCH7Z8k70fREwvdIqjrxQXbTMgrJECdbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MjQYVybysNAR9bcLqw0RvDjST/uS8p/g4MO7aA6MYSEUlNy8UKby/joVIDwGWXily
         bDXfSmjyvw0DaPgeFYmX5FPPHnOVY67rqUSPwCGF1wxwC/8xUkcuYIlIQ408or93ih
         TWCOneMJChVerfWr6FVmTB/8SeHn387z5v6QLlBo=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Amol Grover <frextrite@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 21/30] rculist: Add brackets around cond argument in __list_check_rcu macro
Date:   Fri, 14 Feb 2020 15:55:58 -0800
Message-Id: <20200214235607.13749-21-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200214235536.GA13364@paulmck-ThinkPad-P72>
References: <20200214235536.GA13364@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amol Grover <frextrite@gmail.com>

Passing a complex lockdep condition to __list_check_rcu results
in false positive lockdep splat due to incorrect expression
evaluation.

For example, a lockdep check condition `cond1 || cond2` is
evaluated as `!cond1 || cond2 && !rcu_read_lock_any_held()`
which, according to operator precedence, evaluates to
`!cond1 || (cond2 && !rcu_read_lock_any_held())`.
This would result in a lockdep splat when cond1 is false
and cond2 is true which is logically incorrect.

Signed-off-by: Amol Grover <frextrite@gmail.com>
Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rculist.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index 9f313e4..8214cdc 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -60,9 +60,9 @@ static inline void INIT_LIST_HEAD_RCU(struct list_head *list)
 #define __list_check_rcu(dummy, cond, extra...)				\
 	({								\
 	check_arg_count_one(extra);					\
-	RCU_LOCKDEP_WARN(!cond && !rcu_read_lock_any_held(),		\
+	RCU_LOCKDEP_WARN(!(cond) && !rcu_read_lock_any_held(),		\
 			 "RCU-list traversed in non-reader section!");	\
-	 })
+	})
 #else
 #define __list_check_rcu(dummy, cond, extra...)				\
 	({ check_arg_count_one(extra); })
-- 
2.9.5

