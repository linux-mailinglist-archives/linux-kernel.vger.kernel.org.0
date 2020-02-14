Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFC915FB2F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 00:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgBNX5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 18:57:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:37654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727845AbgBNX5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 18:57:46 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7331E24677;
        Fri, 14 Feb 2020 23:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581724665;
        bh=I3I+R5oUSeBTQfyEXtpXDf6v2AzOh3dI8ZD6PsU2X4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HSqcqB34J0F/npSPeFlGk/yPMGtJyEm64PYHxwBWwWA3rZakGqz105pJf7A979Nwx
         McA9/JFCq4MJtXVAjGvCC6tOzHFVVz7oPJTKWy2P0h+wU5toYCJrmohufT9VsJzINX
         4kQv8aTiiMSo3A40EvDNv4Q0YsPebqyboTLw8Dw4=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 26/30] rcu: Tighten rcu_lockdep_assert_cblist_protected() check
Date:   Fri, 14 Feb 2020 15:56:03 -0800
Message-Id: <20200214235607.13749-26-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200214235536.GA13364@paulmck-ThinkPad-P72>
References: <20200214235536.GA13364@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The ->nocb_lock lockdep assertion is currently guarded by cpu_online(),
which is incorrect for no-CBs CPUs, whose callback lists must be
protected by ->nocb_lock regardless of whether or not the corresponding
CPU is online.  This situation could result in failure to detect bugs
resulting from failing to hold ->nocb_lock for offline CPUs.

This commit therefore removes the cpu_online() guard.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 3846519..70b3c0f 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1579,8 +1579,7 @@ static void rcu_nocb_unlock_irqrestore(struct rcu_data *rdp,
 static void rcu_lockdep_assert_cblist_protected(struct rcu_data *rdp)
 {
 	lockdep_assert_irqs_disabled();
-	if (rcu_segcblist_is_offloaded(&rdp->cblist) &&
-	    cpu_online(rdp->cpu))
+	if (rcu_segcblist_is_offloaded(&rdp->cblist))
 		lockdep_assert_held(&rdp->nocb_lock);
 }
 
-- 
2.9.5

