Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F08FC15FB76
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 01:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgBOA3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 19:29:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:45446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727567AbgBOA3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 19:29:47 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97EF42187F;
        Sat, 15 Feb 2020 00:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581726586;
        bh=AM7BWBBRULXhHF5jNwhG2VL7NvzrkRoAiUsPNZ5Bbbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=foExSxWZabAGXAuD2q9Vizf0A2nLrwgCLQC8AE026UtTPhXLritza7vMrianNw9ta
         RShVuyeZ0ACTiZT5++qIOB4FlYvCl1Cfd3eAu6as6GoNX2D4lz1pOuoIMOP0EHBswf
         DtdMSHSrMIbbbqlVOz5ueVvd9iGUrhPZhECWO1Jo=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 3/4] srcu: Fix process_srcu()/srcu_batches_completed() datarace
Date:   Fri, 14 Feb 2020 16:29:31 -0800
Message-Id: <20200215002932.15976-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200215002907.GA15895@paulmck-ThinkPad-P72>
References: <20200215002907.GA15895@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The srcu_struct structure's ->srcu_idx field is accessed locklessly,
so reads must use READ_ONCE().  This commit therefore adds the needed
READ_ONCE() invocation where it was missed.

This data race was reported by KCSAN.  Not appropriate for backporting
due to failure being unlikely.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 79848f7d..119a373 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1079,7 +1079,7 @@ EXPORT_SYMBOL_GPL(srcu_barrier);
  */
 unsigned long srcu_batches_completed(struct srcu_struct *ssp)
 {
-	return ssp->srcu_idx;
+	return READ_ONCE(ssp->srcu_idx);
 }
 EXPORT_SYMBOL_GPL(srcu_batches_completed);
 
-- 
2.9.5

