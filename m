Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C24FF15FB73
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 01:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgBOA3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 19:29:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:45240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727529AbgBOA3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 19:29:40 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A707F206D7;
        Sat, 15 Feb 2020 00:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581726579;
        bh=EJexEEpX+GQ8fYQ/Mz/rgmbw0ukwN9BOCgXLakmHZOI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mgHIuvl0TVeJ66h6B8sC5QGWe4hy1JFmcByEx7BUKTJjk+71nbZFLzhZqnPbNQe+Y
         IjsY1cfYNnaZSOtSXFJhSxAYgpTeS4aj3+AZ4FNaphueOjbCfdmgGBYQA3xZZaJ5QE
         auNZmYqUwU+RmBX/o55LI5cBz+EQyjJP/6sJV6WQ=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 1/4] srcu: Fix __call_srcu()/process_srcu() datarace
Date:   Fri, 14 Feb 2020 16:29:29 -0800
Message-Id: <20200215002932.15976-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200215002907.GA15895@paulmck-ThinkPad-P72>
References: <20200215002907.GA15895@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The srcu_node structure's ->srcu_gp_seq_needed_exp field is accessed
locklessly, so updates must use WRITE_ONCE().  This commit therefore
adds the needed WRITE_ONCE() invocations.

This data race was reported by KCSAN.  Not appropriate for backporting
due to failure being unlikely.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 657e6a7..b1edac9 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -550,7 +550,7 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 		snp->srcu_have_cbs[idx] = gpseq;
 		rcu_seq_set_state(&snp->srcu_have_cbs[idx], 1);
 		if (ULONG_CMP_LT(snp->srcu_gp_seq_needed_exp, gpseq))
-			snp->srcu_gp_seq_needed_exp = gpseq;
+			WRITE_ONCE(snp->srcu_gp_seq_needed_exp, gpseq);
 		mask = snp->srcu_data_have_cbs[idx];
 		snp->srcu_data_have_cbs[idx] = 0;
 		spin_unlock_irq_rcu_node(snp);
@@ -660,7 +660,7 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 		if (snp == sdp->mynode)
 			snp->srcu_data_have_cbs[idx] |= sdp->grpmask;
 		if (!do_norm && ULONG_CMP_LT(snp->srcu_gp_seq_needed_exp, s))
-			snp->srcu_gp_seq_needed_exp = s;
+			WRITE_ONCE(snp->srcu_gp_seq_needed_exp, s);
 		spin_unlock_irqrestore_rcu_node(snp, flags);
 	}
 
-- 
2.9.5

