Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15F3CF073A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 21:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbfKEUt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 15:49:58 -0500
Received: from foss.arm.com ([217.140.110.172]:32782 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729775AbfKEUt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 15:49:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB9D61063;
        Tue,  5 Nov 2019 12:49:56 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2462D3FF3E;
        Tue,  5 Nov 2019 03:22:22 -0800 (PST)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH] sched: core: fix compilation error when cgroup not selected
Date:   Tue,  5 Nov 2019 11:22:12 +0000
Message-Id: <20191105112212.596-1-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When cgroup is disabled the following compilation error was hit

	kernel/sched/core.c: In function ‘uclamp_update_active_tasks’:
	kernel/sched/core.c:1081:23: error: storage size of ‘it’ isn’t known
	  struct css_task_iter it;
			       ^~
	kernel/sched/core.c:1084:2: error: implicit declaration of function ‘css_task_iter_start’; did you mean ‘__sg_page_iter_start’? [-Werror=implicit-function-declaration]
	  css_task_iter_start(css, 0, &it);
	  ^~~~~~~~~~~~~~~~~~~
	  __sg_page_iter_start
	kernel/sched/core.c:1085:14: error: implicit declaration of function ‘css_task_iter_next’; did you mean ‘__sg_page_iter_next’? [-Werror=implicit-function-declaration]
	  while ((p = css_task_iter_next(&it))) {
		      ^~~~~~~~~~~~~~~~~~
		      __sg_page_iter_next
	kernel/sched/core.c:1091:2: error: implicit declaration of function ‘css_task_iter_end’; did you mean ‘get_task_cred’? [-Werror=implicit-function-declaration]
	  css_task_iter_end(&it);
	  ^~~~~~~~~~~~~~~~~
	  get_task_cred
	kernel/sched/core.c:1081:23: warning: unused variable ‘it’ [-Wunused-variable]
	  struct css_task_iter it;
			       ^~
	cc1: some warnings being treated as errors
	make[2]: *** [kernel/sched/core.o] Error 1

Fix by protetion uclamp_update_active_tasks() with
CONFIG_UCLAMP_TASK_GROUP

Fixes: babbe170e053 ("sched/uclamp: Update CPU's refcount on TG's clamp changes")
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index dd05a378631a..afd4d8028771 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1073,6 +1073,7 @@ uclamp_update_active(struct task_struct *p, enum uclamp_id clamp_id)
 	task_rq_unlock(rq, p, &rf);
 }
 
+#ifdef CONFIG_UCLAMP_TASK_GROUP
 static inline void
 uclamp_update_active_tasks(struct cgroup_subsys_state *css,
 			   unsigned int clamps)
@@ -1091,7 +1092,6 @@ uclamp_update_active_tasks(struct cgroup_subsys_state *css,
 	css_task_iter_end(&it);
 }
 
-#ifdef CONFIG_UCLAMP_TASK_GROUP
 static void cpu_util_update_eff(struct cgroup_subsys_state *css);
 static void uclamp_update_root_tg(void)
 {
-- 
2.17.1

