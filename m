Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86EDB1101B4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 17:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfLCQB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 11:01:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:54088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbfLCQBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 11:01:25 -0500
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CFAC206E4;
        Tue,  3 Dec 2019 16:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575388885;
        bh=rU+HF5joAYjKANT6XLlY3AiAp4KOT4nVjTtAT4oN2bE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EIcF8Dbb1dTHdivi9a5OhBIhR372gMaCttg64dcyvO5eJu8A2SR8j7QOwxjLdip3X
         y6E6llxfGoCel/AlIh7WGiaWuv2ivuybY9JCVqLGZ3bTPTAob6RUJz/M6rpYvjEq7V
         mFTGYLA9Rqb2fERSWiWOtQR1rIctUVYCYVnZ6gLQ=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 1/2] sched: Spare resched IPI when prio changes on a single fair task
Date:   Tue,  3 Dec 2019 17:01:05 +0100
Message-Id: <20191203160106.18806-2-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191203160106.18806-1-frederic@kernel.org>
References: <20191203160106.18806-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The runqueue of a fair task being remotely reniced is going to get a
resched IPI in order to reassess which task should be the current
running on the CPU. However that evaluation is useless if the fair task
is running alone, in which case we can spare that IPI, preventing
nohz_full CPUs from being disturbed.

Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/sched/fair.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 08a233e97a01..6d2560cb24f0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10322,6 +10322,8 @@ prio_changed_fair(struct rq *rq, struct task_struct *p, int oldprio)
 	if (!task_on_rq_queued(p))
 		return;
 
+	if (rq->cfs.nr_running == 1)
+		return;
 	/*
 	 * Reschedule if we are currently running on this runqueue and
 	 * our priority decreased, or if we are not currently running on
-- 
2.23.0

