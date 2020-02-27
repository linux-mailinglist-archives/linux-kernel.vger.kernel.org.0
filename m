Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26F87171F5E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 15:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388804AbgB0Oep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 09:34:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:45284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732925AbgB0OeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:34:18 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C8E8246BC;
        Thu, 27 Feb 2020 14:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582814058;
        bh=gMfrwv6RHSJ4VB1zJJfyxToAQD1Aw5mPKIjS+nBgdHY=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Al50Yy0hvsU18UVtTF2Sqh0BhUul3kzNsKZq+oxHh0DLCAaMqpBW6TYQ1VcDg8wHx
         iOCpVYMTKphUs+GTDryJ4ges7Hrewr54tIsaKQ61Id/Ps9kYCtDGiCEocLfCPvDw5B
         U4vLhu0FXnDWim5JzAwVTVXbhEFfCTco5BdAl+DM=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 19/23] sched/core: migrate_enable() must access takedown_cpu_task on !HOTPLUG_CPU
Date:   Thu, 27 Feb 2020 08:33:30 -0600
Message-Id: <fc234fb7e45164ddd61e0dbf1f8455a8252994c3.1582814004.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1582814004.git.zanussi@kernel.org>
References: <cover.1582814004.git.zanussi@kernel.org>
In-Reply-To: <cover.1582814004.git.zanussi@kernel.org>
References: <cover.1582814004.git.zanussi@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v4.14.170-rt75-rc2 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit a61d1977f692e46bad99a100f264981ba08cb4bd ]

The variable takedown_cpu_task is never declared/used on !HOTPLUG_CPU
except for migrate_enable(). This leads to a link error.

Don't use takedown_cpu_task in !HOTPLUG_CPU.

Reported-by: Dick Hollenbeck <dick@softplc.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/cpu.c        | 2 ++
 kernel/sched/core.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 17b1ed41bc06..861712ebb81d 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -858,7 +858,9 @@ static int take_cpu_down(void *_param)
 	return 0;
 }
 
+#ifdef CONFIG_PREEMPT_RT_BASE
 struct task_struct *takedown_cpu_task;
+#endif
 
 static int takedown_cpu(unsigned int cpu)
 {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ceddb1e27caf..e10e3956bb29 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6987,9 +6987,11 @@ void migrate_enable(void)
 
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
2.14.1

