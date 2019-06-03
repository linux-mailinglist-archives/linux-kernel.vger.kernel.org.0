Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A873B330A0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 15:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfFCNIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 09:08:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45803 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbfFCNIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:08:44 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53D8YN4604764
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:08:34 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53D8YN4604764
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559567314;
        bh=axMoRurCx7P5uez1cqcSaps+epjAuRjig1jTffexH1g=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=dQA1fCugfZHcedq/r4rLlbx+TQmOUYuPKAuKDKHBkR0Db8bCchz8Lf7/Il4aoOb0/
         VWfhlG8Tkn1mmiMN1T+Y55kzw62s/ea1AzzlRdeuuCaGIAdDzqqp5E2qUGcx5Uz9Ra
         /4sfL2Ml3mxHp+RdIjkNp2qUEscyRrItMpAq3t/eF0m27fDv6S6NgYiF3CU+jQnZB4
         Y2hBlkQ3mM9V4MdsyYw4UsKEAI9Wbj8EBlXtBsSjx4fqKcaDKhmu8sJ66tEO3X6sG3
         6F5kgUWWaQ7DQGpP6vjfN9xn3eNDLEhuNOZ7aXrOXYRHUQ3wWgujMhKM6RTkJ3Hj8u
         RInt/jHKpTx0A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53D8X4m604761;
        Mon, 3 Jun 2019 06:08:33 -0700
Date:   Mon, 3 Jun 2019 06:08:33 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yuyang Du <tipbot@zytor.com>
Message-ID: <tip-e7a38f63ba50dc95426dd50c43383dfecaa35d7f@git.kernel.org>
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        duyuyang@gmail.com, tglx@linutronix.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: tglx@linutronix.de, duyuyang@gmail.com, peterz@infradead.org,
          torvalds@linux-foundation.org, hpa@zytor.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190506081939.74287-5-duyuyang@gmail.com>
References: <20190506081939.74287-5-duyuyang@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Remove useless conditional
 macro
Git-Commit-ID: e7a38f63ba50dc95426dd50c43383dfecaa35d7f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.3 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FORGED_REPLYTO autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  e7a38f63ba50dc95426dd50c43383dfecaa35d7f
Gitweb:     https://git.kernel.org/tip/e7a38f63ba50dc95426dd50c43383dfecaa35d7f
Author:     Yuyang Du <duyuyang@gmail.com>
AuthorDate: Mon, 6 May 2019 16:19:20 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 11:55:35 +0200

locking/lockdep: Remove useless conditional macro

Since #defined(CONFIG_PROVE_LOCKING) is used in the scope of #ifdef
CONFIG_PROVE_LOCKING, it can be removed.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bvanassche@acm.org
Cc: frederic@kernel.org
Cc: ming.lei@redhat.com
Cc: will.deacon@arm.com
Link: https://lkml.kernel.org/r/20190506081939.74287-5-duyuyang@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index a033df00fd1d..3c477018e184 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1674,7 +1674,7 @@ check_redundant(struct lock_list *root, struct lock_class *target,
 	return result;
 }
 
-#if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
+#ifdef CONFIG_TRACE_IRQFLAGS
 
 static inline int usage_accumulate(struct lock_list *entry, void *mask)
 {
@@ -2152,7 +2152,7 @@ static inline void inc_chains(void)
 	nr_process_chains++;
 }
 
-#endif
+#endif /* CONFIG_TRACE_IRQFLAGS */
 
 static void
 print_deadlock_scenario(struct held_lock *nxt, struct held_lock *prv)
@@ -2829,7 +2829,7 @@ static inline int validate_chain(struct task_struct *curr,
 {
 	return 1;
 }
-#endif
+#endif /* CONFIG_PROVE_LOCKING */
 
 /*
  * We are building curr_chain_key incrementally, so double-check
