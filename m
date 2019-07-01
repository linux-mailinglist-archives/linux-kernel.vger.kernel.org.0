Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6C8E19CBB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2019 13:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfEJLcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 May 2019 07:32:35 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44492 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbfEJLce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 07:32:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D1E915AD;
        Fri, 10 May 2019 04:32:34 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E46153F6C4;
        Fri, 10 May 2019 04:32:31 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH v2 1/7] sched: autogroup: Make autogroup_path() always available
Date:   Fri, 10 May 2019 12:30:07 +0100
Message-Id: <20190510113013.1193-2-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510113013.1193-1-qais.yousef@arm.com>
References: <20190510113013.1193-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By removing the #ifdef CONFIG_SCHED_DEBUG

Some of the tracepoints to be introduces in later patches need to access
this function. Hence make it always available since the tracepoints are
not protected by CONFIG_SCHED_DEBUG.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 kernel/sched/autogroup.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/sched/autogroup.c b/kernel/sched/autogroup.c
index 2d4ff5353ded..2067080bb235 100644
--- a/kernel/sched/autogroup.c
+++ b/kernel/sched/autogroup.c
@@ -259,7 +259,6 @@ void proc_sched_autogroup_show_task(struct task_struct *p, struct seq_file *m)
 }
 #endif /* CONFIG_PROC_FS */
 
-#ifdef CONFIG_SCHED_DEBUG
 int autogroup_path(struct task_group *tg, char *buf, int buflen)
 {
 	if (!task_group_is_autogroup(tg))
@@ -267,4 +266,3 @@ int autogroup_path(struct task_group *tg, char *buf, int buflen)
 
 	return snprintf(buf, buflen, "%s-%ld", "/autogroup", tg->autogroup->id);
 }
-#endif
-- 
2.17.1

