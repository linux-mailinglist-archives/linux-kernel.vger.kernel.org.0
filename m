Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD0A330BB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 15:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbfFCNNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 09:13:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35307 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfFCNNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:13:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53DDdWU605699
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:13:39 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53DDdWU605699
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559567620;
        bh=iqoyqc/NdHYKAOJ/my9vvngtYiLdowTu1U7S6kROfsM=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=gTVKkWX2hw98JU/ogeEPt/Lta0OgnWncsWWQJRo8yXWYRXHAmbawHPlGLdmmFQlwi
         PSOg71SuaXPvbJDxH43xwiTgN9Y1yNyGKs+Qzsh+CXCeDX8urKiQxmKSiPzItVAojr
         pACSFoh+L2gQtRQZfGF9nT+kiRbkGvKYDeKuOE8FL6UQueQBzh8DHLYpKwEVKM8Ptj
         Y/wwZJbOCwkBf0hq3PgsPC89G9g3HjvrAp3X8VkgLCqt1IZTMKddze+xsD5TYu8M0h
         +z1DOuqt4U/D5u9O82E/b2PgGQYmBYrJM5AmxKehXoPUtI8dhzrd4FamdZLzSCgI1A
         ot7xd7AZ4z6iQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53DDd8C605696;
        Mon, 3 Jun 2019 06:13:39 -0700
Date:   Mon, 3 Jun 2019 06:13:39 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yuyang Du <tipbot@zytor.com>
Message-ID: <tip-31a490e5c54f5499aa744f8524611e2a4b19f8ba@git.kernel.org>
Cc:     duyuyang@gmail.com, hpa@zytor.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        peterz@infradead.org, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
          peterz@infradead.org, tglx@linutronix.de, duyuyang@gmail.com,
          hpa@zytor.com, mingo@kernel.org
In-Reply-To: <20190506081939.74287-12-duyuyang@gmail.com>
References: <20190506081939.74287-12-duyuyang@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Update comment
Git-Commit-ID: 31a490e5c54f5499aa744f8524611e2a4b19f8ba
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

Commit-ID:  31a490e5c54f5499aa744f8524611e2a4b19f8ba
Gitweb:     https://git.kernel.org/tip/31a490e5c54f5499aa744f8524611e2a4b19f8ba
Author:     Yuyang Du <duyuyang@gmail.com>
AuthorDate: Mon, 6 May 2019 16:19:27 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 11:55:44 +0200

locking/lockdep: Update comment

A leftover comment is removed. While at it, add more explanatory
comments. Such a trivial patch!

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bvanassche@acm.org
Cc: frederic@kernel.org
Cc: ming.lei@redhat.com
Cc: will.deacon@arm.com
Link: https://lkml.kernel.org/r/20190506081939.74287-12-duyuyang@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 6cf14c84eb6d..a9799f9ed093 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2811,10 +2811,16 @@ static int validate_chain(struct task_struct *curr,
 		 * - is softirq-safe, if this lock is hardirq-unsafe
 		 *
 		 * And check whether the new lock's dependency graph
-		 * could lead back to the previous lock.
+		 * could lead back to the previous lock:
 		 *
-		 * any of these scenarios could lead to a deadlock. If
-		 * All validations
+		 * - within the current held-lock stack
+		 * - across our accumulated lock dependency records
+		 *
+		 * any of these scenarios could lead to a deadlock.
+		 */
+		/*
+		 * The simple case: does the current hold the same lock
+		 * already?
 		 */
 		int ret = check_deadlock(curr, hlock, hlock->read);
 
