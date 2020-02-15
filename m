Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0987A15FB87
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 01:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgBOAhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 19:37:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:47680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728023AbgBOAhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 19:37:36 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69C6924650;
        Sat, 15 Feb 2020 00:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581727056;
        bh=64QHb1k1b5l5Sao9tVo4racHv6KhnJTPOsWRA6w8thg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qTBWVpTOkKxFSaECtTDAAmlsNIBBPJSz5RbeCZjh2wzWztrEG0Qnqe+Z/LwJtevpS
         +UapSsP7YRAYjJBXlAbGaEFVS5fGb/Xn4aUYtCrhA1ME9D4bTtvSj8go8pYerwP5ii
         c5oZ0Fkph232pabMAd+ZO0AXD/pIRIWFLA8UHfsQ=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 06/18] rcutorture: Suppress boottime bad-sequence warnings
Date:   Fri, 14 Feb 2020 16:36:59 -0800
Message-Id: <20200215003711.16463-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200215003634.GA16227@paulmck-ThinkPad-P72>
References: <20200215003634.GA16227@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

In normal production, an excessively long wait on a grace period
(synchronize_rcu(), for example) at boottime is often just as bad
as at any other time.  In fact, given the desire for fast boot, any
sort of long wait at boot is a bad idea.  However, heavy rcutorture
testing on large hyperthreaded systems can generate such long waits
during boot as a matter of course.  This commit therefore causes
the rcupdate.rcu_cpu_stall_suppress_at_boot kernel boot parameter to
suppress reporting of bootime bad-sequence warning due to excessively
long grace-period waits.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 16c84ec..5efd950 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1423,7 +1423,8 @@ rcu_torture_stats_print(void)
 	pr_alert("%s%s ", torture_type, TORTURE_FLAG);
 	pr_cont("rtc: %p %s: %lu tfle: %d rta: %d rtaf: %d rtf: %d ",
 		rcu_torture_current,
-		rcu_torture_current ? "ver" : "VER",
+		rcu_torture_current && !rcu_stall_is_suppressed_at_boot()
+			? "ver" : "VER",
 		rcu_torture_current_version,
 		list_empty(&rcu_torture_freelist),
 		atomic_read(&n_rcu_torture_alloc),
-- 
2.9.5

