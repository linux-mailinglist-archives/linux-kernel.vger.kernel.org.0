Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8FCB1472B1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 21:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbgAWUkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jan 2020 15:40:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:45974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729355AbgAWUjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 15:39:48 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E74724695;
        Thu, 23 Jan 2020 20:39:47 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1iujGU-000mh5-AE; Thu, 23 Jan 2020 15:39:46 -0500
Message-Id: <20200123203946.200669575@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 23 Jan 2020 15:39:57 -0500
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
Subject: [PATCH RT 27/30] sched/core: migrate_enable() must access takedown_cpu_task on
 !HOTPLUG_CPU
References: <20200123203930.646725253@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19.94-rt39-rc2 stable review patch.
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


