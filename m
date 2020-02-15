Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDCB15FB8F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 01:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbgBOAls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 19:41:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:48644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgBOAlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 19:41:46 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C82B322314;
        Sat, 15 Feb 2020 00:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581727306;
        bh=UaNRIzw8PdKi+H1pVKj+hGEjageya5/rTyvnZCayyqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bm067/TUzBOiKDLeWS5/Je0OAv27Tw/uB9I0UtT9t7gIhsNXu//ryAK1AwyKupUNd
         kxgI82uHPlFHQsnPNPEUUoKviYlBrx0VxvYtshWVUd4jbf1AqFyqILd4c0KoayQz1r
         CfRTCuEoicLz3eQt4jiEPzWChRPCYf7quvdKuE4Y=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 11/18] rcutorture: Fix rcu_torture_one_read()/rcu_torture_writer() data race
Date:   Fri, 14 Feb 2020 16:41:18 -0800
Message-Id: <20200215004125.16953-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200215003634.GA16227@paulmck-ThinkPad-P72>
References: <20200215003634.GA16227@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The ->rtort_pipe_count field in the rcu_torture structure checks for
too-short grace periods, and is therefore read by rcutorture's readers
while being updated by rcutorture's writers.  This commit therefore
adds the needed READ_ONCE() and WRITE_ONCE() invocations.

This data race was reported by KCSAN.  Not appropriate for backporting
due to failure being unlikely and due to this being rcutorture.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 5efd950..edd9746 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -375,11 +375,12 @@ rcu_torture_pipe_update_one(struct rcu_torture *rp)
 {
 	int i;
 
-	i = rp->rtort_pipe_count;
+	i = READ_ONCE(rp->rtort_pipe_count);
 	if (i > RCU_TORTURE_PIPE_LEN)
 		i = RCU_TORTURE_PIPE_LEN;
 	atomic_inc(&rcu_torture_wcount[i]);
-	if (++rp->rtort_pipe_count >= RCU_TORTURE_PIPE_LEN) {
+	WRITE_ONCE(rp->rtort_pipe_count, i + 1);
+	if (rp->rtort_pipe_count >= RCU_TORTURE_PIPE_LEN) {
 		rp->rtort_mbtest = 0;
 		return true;
 	}
@@ -1015,7 +1016,8 @@ rcu_torture_writer(void *arg)
 			if (i > RCU_TORTURE_PIPE_LEN)
 				i = RCU_TORTURE_PIPE_LEN;
 			atomic_inc(&rcu_torture_wcount[i]);
-			old_rp->rtort_pipe_count++;
+			WRITE_ONCE(old_rp->rtort_pipe_count,
+				   old_rp->rtort_pipe_count + 1);
 			switch (synctype[torture_random(&rand) % nsynctypes]) {
 			case RTWS_DEF_FREE:
 				rcu_torture_writer_state = RTWS_DEF_FREE;
@@ -1291,7 +1293,7 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp)
 		atomic_inc(&n_rcu_torture_mberror);
 	rtrsp = rcutorture_loop_extend(&readstate, trsp, rtrsp);
 	preempt_disable();
-	pipe_count = p->rtort_pipe_count;
+	pipe_count = READ_ONCE(p->rtort_pipe_count);
 	if (pipe_count > RCU_TORTURE_PIPE_LEN) {
 		/* Should not happen, but... */
 		pipe_count = RCU_TORTURE_PIPE_LEN;
-- 
2.9.5

