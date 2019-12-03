Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7591101B5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 17:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfLCQB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 11:01:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:54096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbfLCQB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 11:01:26 -0500
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B040A20803;
        Tue,  3 Dec 2019 16:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575388886;
        bh=UYQUIS4VEh9FgjKXlL/TghxQGzex5f/+EUkRGQy7vzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KMQQy47m22EVQ2Nu7sKQPWT0kJ+SzD1yKxNkhBRG3Uhmuti3+pRD+H4uKx5Aq0tM/
         MuBng/iGTK1RACBGDZsYrRAdQvS++wroZK/Qkf6JaLeOsN6IucIaOKl84fM2VoENau
         7Jqb3sNL1Fw4oQ5celiX0Ql5utbIzDtnQD6RHiHY=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 2/2] sched: Use fair:prio_changed() instead of ad-hoc implementation
Date:   Tue,  3 Dec 2019 17:01:06 +0100
Message-Id: <20191203160106.18806-3-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191203160106.18806-1-frederic@kernel.org>
References: <20191203160106.18806-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set_user_nice() implements its own version of fair::prio_changed() and
therefore misses a specific optimization towards nohz_full CPUs that
avoid sending an resched IPI to a reniced task running alone. Use the
proper callback instead.

Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/sched/core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 90e4b00ace89..66d1af94455e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4540,17 +4540,17 @@ void set_user_nice(struct task_struct *p, long nice)
 	p->prio = effective_prio(p);
 	delta = p->prio - old_prio;
 
-	if (queued) {
+	if (queued)
 		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
-		/*
-		 * If the task increased its priority or is running and
-		 * lowered its priority, then reschedule its CPU:
-		 */
-		if (delta < 0 || (delta > 0 && task_running(rq, p)))
-			resched_curr(rq);
-	}
+
 	if (running)
 		set_next_task(rq, p);
+	/*
+	 * If the task increased its priority or is running and
+	 * lowered its priority, then reschedule its CPU:
+	 */
+	p->sched_class->prio_changed(rq, p, old_prio);
+
 out_unlock:
 	task_rq_unlock(rq, p, &rf);
 }
-- 
2.23.0

