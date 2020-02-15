Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D223115FB1F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 00:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbgBNX4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 18:56:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:36592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727959AbgBNX4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 18:56:47 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87BBD2467E;
        Fri, 14 Feb 2020 23:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581724606;
        bh=YJsKqtq5hgtJjA3M1Egg6/HLjFJpeqz3ZuMIDCW7JrM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wdiPAqx6p49VpCnPfC6hRdpN6AZlt0pblNL8FqBA305vSh7B8D5Wuo302nmv6FM0Z
         THBOWT25H2xBXsvmIU1VHvcYMweZuWutLekYjleqfkcEpFsLi7lMAC/wuzNxvCmFRN
         4gYjEzAmd4WIvFxjqhFxo85BLxBp1WCWnbkvLOG4=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Subject: [PATCH tip/core/rcu 10/30] locking/rtmutex: rcu: Add WRITE_ONCE() to rt_mutex ->owner
Date:   Fri, 14 Feb 2020 15:55:47 -0800
Message-Id: <20200214235607.13749-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200214235536.GA13364@paulmck-ThinkPad-P72>
References: <20200214235536.GA13364@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The rt_mutex structure's ->owner field is read locklessly, so this
commit adds the WRITE_ONCE() to an update in order to provide proper
documentation and READ_ONCE()/WRITE_ONCE() pairing.

This data race was reported by KCSAN.  Not appropriate for backporting
due to failure being unlikely.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
---
 kernel/locking/rtmutex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 851bbb1..c9f090d 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -57,7 +57,7 @@ rt_mutex_set_owner(struct rt_mutex *lock, struct task_struct *owner)
 	if (rt_mutex_has_waiters(lock))
 		val |= RT_MUTEX_HAS_WAITERS;
 
-	lock->owner = (struct task_struct *)val;
+	WRITE_ONCE(lock->owner, (struct task_struct *)val);
 }
 
 static inline void clear_rt_mutex_waiters(struct rt_mutex *lock)
-- 
2.9.5

