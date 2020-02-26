Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3565716FF3A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 13:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgBZMqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 07:46:01 -0500
Received: from foss.arm.com ([217.140.110.172]:35324 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbgBZMqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 07:46:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90284328;
        Wed, 26 Feb 2020 04:45:59 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5CC953FA00;
        Wed, 26 Feb 2020 04:45:58 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        Dietmar.Eggemann@arm.com, patrick.bellasi@matbug.net,
        qais.yousef@arm.com, t1zhou@aliyun.com
Subject: [PATCH v2 1/3] sched/debug: Remove redundant macro define
Date:   Wed, 26 Feb 2020 12:45:41 +0000
Message-Id: <20200226124543.31986-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200226124543.31986-1-valentin.schneider@arm.com>
References: <20200226124543.31986-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most printing macros for procfs are defined globally in debug.c, and they
are re-defined (to the exact same thing) within proc_sched_show_task().

Get rid of the duplicate defines.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/debug.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 8331bc04aea2..4670151eb131 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -868,16 +868,8 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 	SEQ_printf(m,
 		"---------------------------------------------------------"
 		"----------\n");
-#define __P(F) \
-	SEQ_printf(m, "%-45s:%21Ld\n", #F, (long long)F)
-#define P(F) \
-	SEQ_printf(m, "%-45s:%21Ld\n", #F, (long long)p->F)
 #define P_SCHEDSTAT(F) \
 	SEQ_printf(m, "%-45s:%21Ld\n", #F, (long long)schedstat_val(p->F))
-#define __PN(F) \
-	SEQ_printf(m, "%-45s:%14Ld.%06ld\n", #F, SPLIT_NS((long long)F))
-#define PN(F) \
-	SEQ_printf(m, "%-45s:%14Ld.%06ld\n", #F, SPLIT_NS((long long)p->F))
 #define PN_SCHEDSTAT(F) \
 	SEQ_printf(m, "%-45s:%14Ld.%06ld\n", #F, SPLIT_NS((long long)schedstat_val(p->F)))
 
@@ -963,11 +955,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 		P(dl.deadline);
 	}
 #undef PN_SCHEDSTAT
-#undef PN
-#undef __PN
 #undef P_SCHEDSTAT
-#undef P
-#undef __P
 
 	{
 		unsigned int this_cpu = raw_smp_processor_id();
-- 
2.24.0

