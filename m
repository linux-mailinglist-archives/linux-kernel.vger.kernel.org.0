Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEC3760B9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 10:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfGZI3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 04:29:44 -0400
Received: from foss.arm.com ([217.140.110.172]:39508 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726508AbfGZI3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 04:29:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76F1915A2;
        Fri, 26 Jul 2019 01:29:38 -0700 (PDT)
Received: from e107985-lin.arm.com (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4F7F63F71A;
        Fri, 26 Jul 2019 01:29:37 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Luca Abeni <luca.abeni@santannapisa.it>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Qais Yousef <Qais.Yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] sched/deadline: Use __sub_running_bw() throughout dl_change_utilization()
Date:   Fri, 26 Jul 2019 09:27:54 +0100
Message-Id: <20190726082756.5525-4-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726082756.5525-1-dietmar.eggemann@arm.com>
References: <20190726082756.5525-1-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dl_change_utilization() has a BUG_ON() to check that no schedutil
kthread (sugov) is entering this function. So instead of calling
sub_running_bw() which checks for the special entity related to a
sugov thread, call the underlying function __sub_running_bw().

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 99d4c24a8637..1fa005f79307 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -164,7 +164,7 @@ void dl_change_utilization(struct task_struct *p, u64 new_bw)
 
 	rq = task_rq(p);
 	if (p->dl.dl_non_contending) {
-		sub_running_bw(&p->dl, &rq->dl);
+		__sub_running_bw(p->dl.dl_bw, &rq->dl);
 		p->dl.dl_non_contending = 0;
 		/*
 		 * If the timer handler is currently running and the
-- 
2.17.1

