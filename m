Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51EA315FB20
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 00:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgBNX4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 18:56:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:36664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbgBNX4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 18:56:51 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F4D42072D;
        Fri, 14 Feb 2020 23:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581724610;
        bh=LusdN1UJW4wsth9V10brAmgIfZk/VRwPHX4oDZzSg/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zxxr6D+tkx+QBe+lX88UvrN1ZcLw6/43u5z0npTTc/54Cw5jpYbzuRYVwiajmcM88
         K1zAth7UJvzuolk1kDKTTXzBvt2sCds5/RlQN5xJMhh/wXEZ9nBm2f3OxMqqJ8CCJE
         oWQX+yOb/NSM59oQ2tpLXusdE9WajZRTpFLrNPdI=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 11/30] rcu: Add READ_ONCE() to rcu_segcblist ->tails[]
Date:   Fri, 14 Feb 2020 15:55:48 -0800
Message-Id: <20200214235607.13749-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200214235536.GA13364@paulmck-ThinkPad-P72>
References: <20200214235536.GA13364@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcu_segcblist structure's ->tails[] array entries are read
locklessly, so this commit adds the READ_ONCE() to a load in order to
avoid destructive compiler optimizations.

This data race was reported by KCSAN.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu_segcblist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 5f4fd3b..426a472 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -182,7 +182,7 @@ void rcu_segcblist_offload(struct rcu_segcblist *rsclp)
 bool rcu_segcblist_ready_cbs(struct rcu_segcblist *rsclp)
 {
 	return rcu_segcblist_is_enabled(rsclp) &&
-	       &rsclp->head != rsclp->tails[RCU_DONE_TAIL];
+	       &rsclp->head != READ_ONCE(rsclp->tails[RCU_DONE_TAIL]);
 }
 
 /*
-- 
2.9.5

