Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7D89141010
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 18:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbgAQRlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 12:41:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:40622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729276AbgAQRld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 12:41:33 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E82442464B;
        Fri, 17 Jan 2020 17:41:32 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1isVch-000Qb3-S9; Fri, 17 Jan 2020 12:41:31 -0500
Message-Id: <20200117174131.757396978@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 17 Jan 2020 12:41:40 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Dick Hollenbeck <dick@softplc.com>
Subject: [PATCH RT 29/32] sched/core: migrate_enable() must access takedown_cpu_task on
 !HOTPLUG_CPU
References: <20200117174111.282847363@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19.94-rt39-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit a61d1977f692e46bad99a100f264981ba08cb4bd ]

The variable takedown_cpu_task is never declared/used on !HOTPLUG_CPU
except for migrate_enable(). This leads to a link error.

Don't use takedown_cpu_task in !HOTPLUG_CPU.

Reported-by: Dick Hollenbeck <dick@softplc.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/cpu.c        | 2 ++
 kernel/sched/core.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 5366c8c69c2f..b9d7ac61d707 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -846,7 +846,9 @@ static int take_cpu_down(void *_param)
 	return 0;
 }
 
+#ifdef CONFIG_PREEMPT_RT_BASE
 struct task_struct *takedown_cpu_task;
+#endif
 
 static int takedown_cpu(unsigned int cpu)
 {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e465381b464d..cbd76324babd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7314,9 +7314,11 @@ void migrate_enable(void)
 
 	p->migrate_disable = 0;
 	rq->nr_pinned--;
+#ifdef CONFIG_HOTPLUG_CPU
 	if (rq->nr_pinned == 0 && unlikely(!cpu_active(cpu)) &&
 	    takedown_cpu_task)
 		wake_up_process(takedown_cpu_task);
+#endif
 
 	if (!p->migrate_disable_scheduled)
 		goto out;
-- 
2.24.1


