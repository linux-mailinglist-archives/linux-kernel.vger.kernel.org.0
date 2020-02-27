Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91C33171F59
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 15:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387832AbgB0OeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 09:34:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:45042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387559AbgB0OeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:34:03 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2CF8246B5;
        Thu, 27 Feb 2020 14:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582814042;
        bh=0cRiHDjg/zFYOP3ScRzQ8pBy26vmofMa73wNOqpm/3I=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=dq/9tXPTXZKNhgRaSp+m31BmJwxWtgqxda59Ew4j22PHqixTtNxprSYUjlNG7dmQz
         tadkNnliJQGNcqCbzOiLHpW8gSa0VxDYuPHgfbT2EzBl0kgm3lQ6jurnEb6qoRzHNG
         ZAQZBInHqRNoS7VPS7OUclXXeAY+99298c2E/n4c=
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
Subject: [PATCH RT 07/23] sched: Remove dead __migrate_disabled() check
Date:   Thu, 27 Feb 2020 08:33:18 -0600
Message-Id: <20499dc2581f16f080d212e97721992565f57669.1582814004.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1582814004.git.zanussi@kernel.org>
References: <cover.1582814004.git.zanussi@kernel.org>
In-Reply-To: <cover.1582814004.git.zanussi@kernel.org>
References: <cover.1582814004.git.zanussi@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Scott Wood <swood@redhat.com>

v4.14.170-rt75-rc2 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit 14d9272d534ea91262e15db99443fc5995c7c016 ]

This code was unreachable given the __migrate_disabled() branch
to "out" immediately beforehand.

Signed-off-by: Scott Wood <swood@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>

 Conflicts:
	kernel/sched/core.c
---
 kernel/sched/core.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8d6badac9225..4708129e8df1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1217,13 +1217,6 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 	if (cpumask_test_cpu(task_cpu(p), new_mask) || __migrate_disabled(p))
 		goto out;
 
-#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
-	if (__migrate_disabled(p)) {
-		p->migrate_disable_update = 1;
-		goto out;
-	}
-#endif
-
 	if (task_running(rq, p) || p->state == TASK_WAKING) {
 		struct migration_arg arg = { p, dest_cpu };
 		/* Need help from migration thread: drop lock and wait. */
-- 
2.14.1

