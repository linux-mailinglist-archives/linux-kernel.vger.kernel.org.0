Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60302DC0F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 08:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfD2Gif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 02:38:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56131 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfD2Gif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 02:38:35 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3T6cNrK783955
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 28 Apr 2019 23:38:23 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3T6cNrK783955
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556519904;
        bh=ttPw3dg9hQ47u8vro+sKr1xSCBN2zpzosj4tjgr9WqQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=BIH4Dsnu0vc/8ODmHWeNzDbEWwWEXXzgwQUGu6XMQ8CU1lXtkGXolXWfA6LRp0DHj
         eJJuKmEL41GT4ho1XXzr5sOBG22YXRGOpFV1zpFMYc9sx5z0FFr9CnTcdmngy0Y6+x
         B9inO6fTCGmHQoLXdNMzCZkFcFKA2lhLR70WbWyFb6gdODuQAtGiVaZa0ukVjds8nX
         el+PoPeXdHPS9bSK/biRd/RcofN0/K3ZnPOzhsf1Lm+5GlrFEDOdll/ZUE4lvFyi94
         HsFyAWx6aSffvtqCVCaLi4X1HuYO+zQit993SxHHjde1TKJy87CbrrBGrahBDwQcOX
         gXEp117L47ScA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3T6cNJX783951;
        Sun, 28 Apr 2019 23:38:23 -0700
Date:   Sun, 28 Apr 2019 23:38:23 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nicholas Piggin <tipbot@zytor.com>
Message-ID: <tip-9b019acb72e4b5741d88e8936d6f200ed44b66b2@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, npiggin@gmail.com,
        tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        peterz@infradead.org
Reply-To: mingo@kernel.org, tglx@linutronix.de, npiggin@gmail.com,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          fweisbec@gmail.com, hpa@zytor.com, torvalds@linux-foundation.org
In-Reply-To: <20190412042613.28930-1-npiggin@gmail.com>
References: <20190412042613.28930-1-npiggin@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/nohz: Run NOHZ idle load balancer on
 HK_FLAG_MISC CPUs
Git-Commit-ID: 9b019acb72e4b5741d88e8936d6f200ed44b66b2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FORGED_REPLYTO,T_DATE_IN_FUTURE_96_Q autolearn=no
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  9b019acb72e4b5741d88e8936d6f200ed44b66b2
Gitweb:     https://git.kernel.org/tip/9b019acb72e4b5741d88e8936d6f200ed44b66b2
Author:     Nicholas Piggin <npiggin@gmail.com>
AuthorDate: Fri, 12 Apr 2019 14:26:13 +1000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 29 Apr 2019 08:27:03 +0200

sched/nohz: Run NOHZ idle load balancer on HK_FLAG_MISC CPUs

The NOHZ idle balancer runs on the lowest idle CPU. This can
interfere with isolated CPUs, so confine it to HK_FLAG_MISC
housekeeping CPUs.

HK_FLAG_SCHED is not used for this because it is not set anywhere
at the moment. This could be folded into HK_FLAG_SCHED once that
option is fixed.

The problem was observed with increased jitter on an application
running on CPU0, caused by NOHZ idle load balancing being run on
CPU1 (an SMT sibling).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190412042613.28930-1-npiggin@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 13bafe350abf..7b0da7007da3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9519,22 +9519,26 @@ static inline int on_null_domain(struct rq *rq)
  * - When one of the busy CPUs notice that there may be an idle rebalancing
  *   needed, they will kick the idle load balancer, which then does idle
  *   load balancing for all the idle CPUs.
+ * - HK_FLAG_MISC CPUs are used for this task, because HK_FLAG_SCHED not set
+ *   anywhere yet.
  */
 
 static inline int find_new_ilb(void)
 {
-	int ilb = cpumask_first(nohz.idle_cpus_mask);
+	int ilb;
 
-	if (ilb < nr_cpu_ids && idle_cpu(ilb))
-		return ilb;
+	for_each_cpu_and(ilb, nohz.idle_cpus_mask,
+			      housekeeping_cpumask(HK_FLAG_MISC)) {
+		if (idle_cpu(ilb))
+			return ilb;
+	}
 
 	return nr_cpu_ids;
 }
 
 /*
- * Kick a CPU to do the nohz balancing, if it is time for it. We pick the
- * nohz_load_balancer CPU (if there is one) otherwise fallback to any idle
- * CPU (if there is one).
+ * Kick a CPU to do the nohz balancing, if it is time for it. We pick any
+ * idle CPU in the HK_FLAG_MISC housekeeping set (if there is one).
  */
 static void kick_ilb(unsigned int flags)
 {
