Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9982616A31D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 10:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbgBXJw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 04:52:56 -0500
Received: from outbound-smtp41.blacknight.com ([46.22.139.224]:35461 "EHLO
        outbound-smtp41.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726216AbgBXJw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:52:56 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp41.blacknight.com (Postfix) with ESMTPS id B04551694
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 09:52:54 +0000 (GMT)
Received: (qmail 18637 invoked from network); 24 Feb 2020 09:52:54 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPA; 24 Feb 2020 09:52:54 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 02/13] sched/numa: Trace when no candidate CPU was found on the preferred node
Date:   Mon, 24 Feb 2020 09:52:12 +0000
Message-Id: <20200224095223.13361-3-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200224095223.13361-1-mgorman@techsingularity.net>
References: <20200224095223.13361-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sched:sched_stick_numa is meant to fire when a task is unable to migrate
to the preferred node. The case where no candidate CPU could be found is
not traced which is an important gap. The tracepoint is not fired when
the task is not allowed to run on any CPU on the preferred node or the
task is already running on the target CPU but neither are interesting
corner cases.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ef3eb36ba5c4..d41a2b37694f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1848,8 +1848,10 @@ static int task_numa_migrate(struct task_struct *p)
 	}
 
 	/* No better CPU than the current one was found. */
-	if (env.best_cpu == -1)
+	if (env.best_cpu == -1) {
+		trace_sched_stick_numa(p, env.src_cpu, -1);
 		return -EAGAIN;
+	}
 
 	best_rq = cpu_rq(env.best_cpu);
 	if (env.best_task == NULL) {
-- 
2.16.4

