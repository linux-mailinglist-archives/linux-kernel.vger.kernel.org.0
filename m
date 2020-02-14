Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9917E15FB27
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 00:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgBNX5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 18:57:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:37114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbgBNX5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 18:57:17 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 321892081E;
        Fri, 14 Feb 2020 23:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581724636;
        bh=/CZ6brnT2OOOiZ54KLSqe6C3gg9LefVC3f18wiX3jVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YJwiL7dlF/ZIcOiJkKqclOfHkrOEW+ySNVvzk7WA8hr6qSlJghUSaon2yZ2WAH5Kr
         9c4GFRTbj7LruKv/0p81Yqkf8S5w9ZL133mjATpvnX2TAocXSfFDtelBhLYrMysJNS
         f5k8XJtbnOsQaxRd5Cqqw2P4JSAYcKq035meqDqo=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 18/30] rcu: Remove dead code from rcu_segcblist_insert_pend_cbs()
Date:   Fri, 14 Feb 2020 15:55:55 -0800
Message-Id: <20200214235607.13749-18-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200214235536.GA13364@paulmck-ThinkPad-P72>
References: <20200214235536.GA13364@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcu_segcblist_insert_pend_cbs() function currently (partially)
initializes the rcu_cblist that it pulls callbacks from.  However, all
the resulting stores are dead because all callers pass in the address of
an on-stack cblist that is not used afterwards.  This commit therefore
removes this pointless initialization.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu_segcblist.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 426a472..9a0f661 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -381,8 +381,6 @@ void rcu_segcblist_insert_pend_cbs(struct rcu_segcblist *rsclp,
 		return; /* Nothing to do. */
 	WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rclp->head);
 	WRITE_ONCE(rsclp->tails[RCU_NEXT_TAIL], rclp->tail);
-	rclp->head = NULL;
-	rclp->tail = &rclp->head;
 }
 
 /*
-- 
2.9.5

