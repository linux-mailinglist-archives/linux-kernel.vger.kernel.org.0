Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0CF516EE31
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 19:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731645AbgBYSka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 13:40:30 -0500
Received: from foss.arm.com ([217.140.110.172]:54624 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731547AbgBYSka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 13:40:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E89E328;
        Tue, 25 Feb 2020 09:52:54 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E061D3F6CF;
        Tue, 25 Feb 2020 09:52:52 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        Dietmar.Eggemann@arm.com, patrick.bellasi@matbug.net,
        qais.yousef@arm.com
Subject: [PATCH 3/3] sched/debug: Add task uclamp values to SCHED_DEBUG procfs
Date:   Tue, 25 Feb 2020 17:52:27 +0000
Message-Id: <20200225175227.22090-4-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200225175227.22090-1-valentin.schneider@arm.com>
References: <20200225175227.22090-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Requested and effective uclamp values can be a bit tricky to decipher when
playing with cgroup hierarchies. Add them to a task's procfs when
SCHED_DEBUG is enabled.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/debug.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 47411a85087c..4086bdd9915d 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -946,6 +946,12 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 	P(se.avg.last_update_time);
 	P(se.avg.util_est.ewma);
 	P(se.avg.util_est.enqueued);
+#endif
+#ifdef CONFIG_UCLAMP_TASK
+	__PS("uclamp.min", p->uclamp[UCLAMP_MIN].value);
+	__PS("uclamp.max", p->uclamp[UCLAMP_MAX].value);
+	__PS("effective uclamp.min", uclamp_eff_value(p, UCLAMP_MIN));
+	__PS("effective uclamp.max", uclamp_eff_value(p, UCLAMP_MAX));
 #endif
 	P(policy);
 	P(prio);
-- 
2.24.0

