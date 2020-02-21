Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9859A16894F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 22:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbgBUV0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 16:26:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:39142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729066AbgBUVZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 16:25:23 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37E6124676;
        Fri, 21 Feb 2020 21:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582320322;
        bh=BodMjiPO1I2v3+3ZzPoqraWPFok3/J5zp6BF7XhVlKs=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=YTQDf/c7eZQB+xA0PPAl+2ykyp0ZaqYS2zvHOt1LMNkr4TTXkMOHBezmCOZl/x7qy
         7GWNau/jznJLjpjB0DU3ppNCSZsJgXLExK9BP8M59l1v3EUCY0NnZBDhHia0oPDN1h
         9Cx55J7YV74WubMTylnpEoIk6+hPfosKBywGKr8o=
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
Subject: [PATCH RT 08/25] sched: Remove dead __migrate_disabled() check
Date:   Fri, 21 Feb 2020 15:24:36 -0600
Message-Id: <6560961cbc09e41f13267a26f5f0951af292d59d.1582320278.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1582320278.git.zanussi@kernel.org>
References: <cover.1582320278.git.zanussi@kernel.org>
In-Reply-To: <cover.1582320278.git.zanussi@kernel.org>
References: <cover.1582320278.git.zanussi@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Scott Wood <swood@redhat.com>

v4.14.170-rt75-rc1 stable review patch.
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

