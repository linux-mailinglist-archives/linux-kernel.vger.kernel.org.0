Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A64D117EA8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 05:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfLJECC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 23:02:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:41488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726950AbfLJEB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:01:59 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31CFD20726;
        Tue, 10 Dec 2019 04:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575950518;
        bh=zlW+ViAIq4hy7RxkkBHIUvjRG95s5I6WyajCmWgrfwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pnQjhudpZHgGx96aU9zBkoTxvXHCN2cqowLmpb1MSvoWkDB7egX7L1ZHNB716Dl3V
         AwnOpshyMrG9UAtAcF3nH92TuBQXawXiBTtsy6qgIRuCwtrcytCG2y1BF/dwSuhtvl
         QTQAFRN982RdUefnh2VqqSsPxmFy1sdvlayWdiX8=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 04/10] rcu: Substitute lookup for bit-twiddling in sync_rcu_exp_select_node_cpus()
Date:   Mon,  9 Dec 2019 20:01:48 -0800
Message-Id: <20191210040154.2498-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210040122.GA2419@paulmck-ThinkPad-P72>
References: <20191210040122.GA2419@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The code in sync_rcu_exp_select_node_cpus() calculates the current
CPU's mask within its rcu_node structure's bitmasks, but this has
already been computed in the ->grpmask field of that CPU's rcu_data
structure.  This commit therefore just uses this ->grpmask field.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 6a6f328..3b59c3e 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -345,8 +345,8 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
 	/* Each pass checks a CPU for identity, offline, and idle. */
 	mask_ofl_test = 0;
 	for_each_leaf_node_cpu_mask(rnp, cpu, rnp->expmask) {
-		unsigned long mask = leaf_node_cpu_bit(rnp, cpu);
 		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+		unsigned long mask = rdp->grpmask;
 		int snap;
 
 		if (raw_smp_processor_id() == cpu ||
@@ -373,8 +373,8 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
 
 	/* IPI the remaining CPUs for expedited quiescent state. */
 	for_each_leaf_node_cpu_mask(rnp, cpu, mask_ofl_ipi) {
-		unsigned long mask = leaf_node_cpu_bit(rnp, cpu);
 		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+		unsigned long mask = rdp->grpmask;
 
 retry_ipi:
 		if (rcu_dynticks_in_eqs_since(rdp, rdp->exp_dynticks_snap)) {
-- 
2.9.5

