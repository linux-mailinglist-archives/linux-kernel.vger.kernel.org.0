Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8543A6D07A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 16:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390712AbfGROwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 10:52:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41681 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727730AbfGROwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 10:52:33 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6IEq5jr2033251
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 18 Jul 2019 07:52:05 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6IEq5jr2033251
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563461525;
        bh=A3YdLeuls4rg/UNG7F4whLwwLK+7fliRjPcY2W75YgY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=eJB1Eb8zpeddDcWz5i6n14kUMN8OmNwZz0vpBcwh11I5q7LzNOYGXgRSf4pc2O1Xa
         UowH9r1hwVAsPgPQXnUfvXoBoMLKAdalBkiAf+sVElzdO96Lp66hJTKYWDBteWXrd5
         FjYSS3XI2BZ6lOxF25akIElrzydTxKz2JiWduR8Z+aD9sci62Yy+4ehQs5rSRjymOx
         SJJ+EF0m5B+GDKOOFuAy0bzNK8tbTKFzCHhAnROnjsW4u7fPPdXouNEtI3wqHk2Bsp
         V5DH5kOqNIc56u92L71E0CwdNS3mMQyVkrIeIrTTyJBYCbvOW3MW5NUywVSqBN/lw6
         p62Wm/ZglMbww==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6IEq4ba2033246;
        Thu, 18 Jul 2019 07:52:04 -0700
Date:   Thu, 18 Jul 2019 07:52:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-cac9b9a4b08304f11daace03b8b48659355e44c1@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, vegard.nossum@oracle.com,
        devel@etsukata.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
        joel@joelfernandes.org, peterz@infradead.org
Reply-To: peterz@infradead.org, joel@joelfernandes.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          vegard.nossum@oracle.com, devel@etsukata.com, tglx@linutronix.de
In-Reply-To: <20190718085754.GM3402@hirez.programming.kicks-ass.net>
References: <20190718085754.GM3402@hirez.programming.kicks-ass.net>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] stacktrace: Force USER_DS for
 stack_trace_save_user()
Git-Commit-ID: cac9b9a4b08304f11daace03b8b48659355e44c1
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_48_96,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  cac9b9a4b08304f11daace03b8b48659355e44c1
Gitweb:     https://git.kernel.org/tip/cac9b9a4b08304f11daace03b8b48659355e44c1
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Thu, 18 Jul 2019 10:47:47 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 18 Jul 2019 16:47:24 +0200

stacktrace: Force USER_DS for stack_trace_save_user()

When walking userspace stacks, USER_DS needs to be set, otherwise
access_ok() will not function as expected.

Reported-by: Vegard Nossum <vegard.nossum@oracle.com>
Reported-by: Eiichi Tsukata <devel@etsukata.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Vegard Nossum <vegard.nossum@oracle.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Link: https://lkml.kernel.org/r/20190718085754.GM3402@hirez.programming.kicks-ass.net
---
 kernel/stacktrace.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index e6a02b274b73..f5440abb7532 100644
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -226,12 +226,17 @@ unsigned int stack_trace_save_user(unsigned long *store, unsigned int size)
 		.store	= store,
 		.size	= size,
 	};
+	mm_segment_t fs;
 
 	/* Trace user stack if not a kernel thread */
 	if (current->flags & PF_KTHREAD)
 		return 0;
 
+	fs = get_fs();
+	set_fs(USER_DS);
 	arch_stack_walk_user(consume_entry, &c, task_pt_regs(current));
+	set_fs(fs);
+
 	return c.len;
 }
 #endif
