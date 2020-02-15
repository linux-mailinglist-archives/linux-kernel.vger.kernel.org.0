Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1CA15FB2D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 00:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgBNX5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 18:57:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:37520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727845AbgBNX5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 18:57:38 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E3EC206B6;
        Fri, 14 Feb 2020 23:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581724658;
        bh=M2QIl4R2+y70JLwauMmmxsOQRVpxxDa9kJXJqIIRjFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cY4B4raWyO9kzXQ9R3Du08hr6E/RBATVQ94QKcOKGbxH5A2Ctl+LfR6E4r0GudfGT
         ZG1hg2BHX4/gSbWABcCR2ixLJaWrTkkCJBYhj1tE15ZTHF5JePuT8eCBytPWnSr2ve
         anEjTADyesuLmmUa2C6cOR7jk/3Ess+ErqboVx9k=
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
Subject: [PATCH tip/core/rcu 24/30] rcu/nocb: Add missing annotation for rcu_nocb_bypass_unlock()
Date:   Fri, 14 Feb 2020 15:56:01 -0800
Message-Id: <20200214235607.13749-24-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200214235536.GA13364@paulmck-ThinkPad-P72>
References: <20200214235536.GA13364@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jules Irenge <jbi.octave@gmail.com>

Sparse reports warning at rcu_nocb_bypass_unlock()

warning: context imbalance in rcu_nocb_bypass_unlock() - unexpected unlock

The root cause is a missing annotation of rcu_nocb_bypass_unlock()
which causes the warning.

This commit therefore adds the missing __releases(&rdp->nocb_bypass_lock)
annotation.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/tree_plugin.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 6db2cad..3846519 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1530,6 +1530,7 @@ static bool rcu_nocb_bypass_trylock(struct rcu_data *rdp)
  * Release the specified rcu_data structure's ->nocb_bypass_lock.
  */
 static void rcu_nocb_bypass_unlock(struct rcu_data *rdp)
+	__releases(&rdp->nocb_bypass_lock)
 {
 	lockdep_assert_irqs_disabled();
 	raw_spin_unlock(&rdp->nocb_bypass_lock);
-- 
2.9.5

