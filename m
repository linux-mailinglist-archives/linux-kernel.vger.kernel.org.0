Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F141B15FB90
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 01:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgBOAlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 19:41:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:48710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgBOAlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 19:41:50 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F1E72081E;
        Sat, 15 Feb 2020 00:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581727309;
        bh=QDaV75XnBlFRQ31qZEJLn6dpbJkOPQueivDtsRfSAcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NJgNXEvwZCcaI62QHVUmj//qq9YGXWvFUsmr0ySovHgoNFVS95ZDn3y8BRni8YoC9
         74LdeAFgHxj/bPqFeiWW7bRGwjX+T/rgeOF9Uip1OzbFOD98v0fs4JxXFxzP5LQN7y
         UX0rhtsGIlAcd5qKwDstiLFx7gme6tMuJdDEaA0o=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 12/18] rcutorture: Fix stray access to rcu_fwd_cb_nodelay
Date:   Fri, 14 Feb 2020 16:41:19 -0800
Message-Id: <20200215004125.16953-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200215003634.GA16227@paulmck-ThinkPad-P72>
References: <20200215003634.GA16227@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcu_fwd_cb_nodelay variable suppresses excessively long read-side
delays while carrying out an rcutorture forward-progress test.  As such,
it is accessed both by readers and updaters, and most of the accesses
therefore use *_ONCE().  Except for one in rcu_read_delay(), which this
commit fixes.

This data race was reported by KCSAN.  Not appropriate for backporting
due to this being rcutorture.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index edd9746..124160a 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -339,7 +339,7 @@ rcu_read_delay(struct torture_random_state *rrsp, struct rt_read_seg *rtrsp)
 	 * period, and we want a long delay occasionally to trigger
 	 * force_quiescent_state. */
 
-	if (!rcu_fwd_cb_nodelay &&
+	if (!READ_ONCE(rcu_fwd_cb_nodelay) &&
 	    !(torture_random(rrsp) % (nrealreaders * 2000 * longdelay_ms))) {
 		started = cur_ops->get_gp_seq();
 		ts = rcu_trace_clock_local();
-- 
2.9.5

