Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08A0D15FB92
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 01:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgBOAl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 19:41:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:48854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgBOAl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 19:41:57 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C49724650;
        Sat, 15 Feb 2020 00:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581727316;
        bh=wHCYNG1g5RB7afQ5AaWVI2CdEZ7GpMl67jlwoCJC5yc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DNUKfZK5eT8po8hZSb5OIs6s69I3ivfGr+yUldqon9gblEnQHRu0njgLLxZq6/+Rp
         FbS1VQJHdIue12lnQy7hD3xL2NJjnpdYbAfdy814DM7wIs6+wGFq+MqRQZJFKktTQQ
         ZV/Dpw1OWVTEbSRwfEtb3w24Fhb4/aM83G1FGB04=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 14/18] rcutorture: Annotation lockless accesses to rcu_torture_current
Date:   Fri, 14 Feb 2020 16:41:21 -0800
Message-Id: <20200215004125.16953-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200215003634.GA16227@paulmck-ThinkPad-P72>
References: <20200215003634.GA16227@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcutorture global variable rcu_torture_current is accessed locklessly,
so it must use the RCU pointer load/store primitives.  This commit
therefore adds several that were missed.

This data race was reported by KCSAN.  Not appropriate for backporting due
to failure being unlikely and due to this being used only by rcutorture.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 0b9ce9a..7e01e9a 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1407,6 +1407,7 @@ rcu_torture_stats_print(void)
 	int i;
 	long pipesummary[RCU_TORTURE_PIPE_LEN + 1] = { 0 };
 	long batchsummary[RCU_TORTURE_PIPE_LEN + 1] = { 0 };
+	struct rcu_torture *rtcp;
 	static unsigned long rtcv_snap = ULONG_MAX;
 	static bool splatted;
 	struct task_struct *wtp;
@@ -1423,10 +1424,10 @@ rcu_torture_stats_print(void)
 	}
 
 	pr_alert("%s%s ", torture_type, TORTURE_FLAG);
+	rtcp = rcu_access_pointer(rcu_torture_current);
 	pr_cont("rtc: %p %s: %lu tfle: %d rta: %d rtaf: %d rtf: %d ",
-		rcu_torture_current,
-		rcu_torture_current && !rcu_stall_is_suppressed_at_boot()
-			? "ver" : "VER",
+		rtcp,
+		rtcp && !rcu_stall_is_suppressed_at_boot() ? "ver" : "VER",
 		rcu_torture_current_version,
 		list_empty(&rcu_torture_freelist),
 		atomic_read(&n_rcu_torture_alloc),
@@ -1482,7 +1483,8 @@ rcu_torture_stats_print(void)
 	if (cur_ops->stats)
 		cur_ops->stats();
 	if (rtcv_snap == rcu_torture_current_version &&
-	    rcu_torture_current != NULL && !rcu_stall_is_suppressed()) {
+	    rcu_access_pointer(rcu_torture_current) &&
+	    !rcu_stall_is_suppressed()) {
 		int __maybe_unused flags = 0;
 		unsigned long __maybe_unused gp_seq = 0;
 
-- 
2.9.5

