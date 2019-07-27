Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4505077716
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2019 07:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbfG0F4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Jul 2019 01:56:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36658 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728574AbfG0F4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 01:56:47 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9A1C9307CDFC;
        Sat, 27 Jul 2019 05:56:47 +0000 (UTC)
Received: from t460p.redhat.com (ovpn-116-73.phx2.redhat.com [10.3.116.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A7AA719C71;
        Sat, 27 Jul 2019 05:56:46 +0000 (UTC)
From:   Scott Wood <swood@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Scott Wood <swood@redhat.com>
Subject: [PATCH RT 3/8] sched: Remove dead __migrate_disabled() check
Date:   Sat, 27 Jul 2019 00:56:33 -0500
Message-Id: <20190727055638.20443-4-swood@redhat.com>
In-Reply-To: <20190727055638.20443-1-swood@redhat.com>
References: <20190727055638.20443-1-swood@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Sat, 27 Jul 2019 05:56:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code was unreachable given the __migrate_disabled() branch
to "out" immediately beforehand.

Signed-off-by: Scott Wood <swood@redhat.com>
---
 kernel/sched/core.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6e643d656d71..99a3cfccf4d3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1242,13 +1242,6 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 	if (cpumask_test_cpu(task_cpu(p), new_mask) || __migrate_disabled(p))
 		goto out;
 
-#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
-	if (__migrate_disabled(p)) {
-		p->migrate_disable_update = 1;
-		goto out;
-	}
-#endif
-
 	dest_cpu = cpumask_any_and(cpu_valid_mask, new_mask);
 	if (task_running(rq, p) || p->state == TASK_WAKING) {
 		struct migration_arg arg = { p, dest_cpu };
-- 
1.8.3.1

