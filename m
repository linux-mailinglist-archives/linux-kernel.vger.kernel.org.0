Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE7B171594
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 12:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbgB0LBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 06:01:13 -0500
Received: from foss.arm.com ([217.140.110.172]:48580 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728765AbgB0LBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 06:01:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C74EB1FB;
        Thu, 27 Feb 2020 03:01:12 -0800 (PST)
Received: from e123648.arm.com (unknown [10.37.12.169])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A184C3F73B;
        Thu, 27 Feb 2020 03:01:10 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, lukasz.luba@arm.com,
        mgorman@techsingularity.net
Subject: [PATCH] sched/fair: Fix kernel build warning in test_idle_cores() for !SMT NUMA
Date:   Thu, 27 Feb 2020 11:00:53 +0000
Message-Id: <20200227110053.2514-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix kernel build warning in kernel/sched/fair.c when CONFIG_SCHED_SMT is
not set and CONFIG_NUMA_BALANCING is set.

kernel/sched/fair.c:1524:20: warning: ‘test_idle_cores’ declared ‘static’ but never defined [-Wunused-function]

Fixes: ff7db0bf24db9 ("sched/numa: Prefer using an idle CPU as a migration target instead of comparing tasks")
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org> (SCHED_NORMAL)
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com> (SCHED_NORMAL)
Cc: Mel Gorman <mgorman@techsingularity.net>
---

It's on top of tip [1] master branch (which has a merge of sched/urgent).

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git

 kernel/sched/fair.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4b5d5e5e701e..4441003b1ad1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1520,8 +1520,10 @@ static inline bool is_core_idle(int cpu)
 	return true;
 }
 
+#ifdef CONFIG_SCHED_SMT
 /* Forward declarations of select_idle_sibling helpers */
 static inline bool test_idle_cores(int cpu, bool def);
+#endif
 
 struct task_numa_env {
 	struct task_struct *p;
-- 
2.17.1

