Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F26E77719
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2019 07:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbfG0F5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Jul 2019 01:57:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36632 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728683AbfG0F4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 01:56:50 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C99C03082DDD;
        Sat, 27 Jul 2019 05:56:50 +0000 (UTC)
Received: from t460p.redhat.com (ovpn-116-73.phx2.redhat.com [10.3.116.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D660B19C71;
        Sat, 27 Jul 2019 05:56:49 +0000 (UTC)
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
Subject: [PATCH RT 6/8] sched: migrate_enable: Set state to TASK_RUNNING
Date:   Sat, 27 Jul 2019 00:56:36 -0500
Message-Id: <20190727055638.20443-7-swood@redhat.com>
In-Reply-To: <20190727055638.20443-1-swood@redhat.com>
References: <20190727055638.20443-1-swood@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Sat, 27 Jul 2019 05:56:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If migrate_enable() is called while a task is preparing to sleep
(state != TASK_RUNNING), that triggers a debug check in stop_one_cpu().
Explicitly reset state to acknowledge that we're accepting the spurious
wakeup.

Signed-off-by: Scott Wood <swood@redhat.com>
---
 kernel/sched/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 38a9a9df5638..eb27a9bf70d7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7396,6 +7396,14 @@ void migrate_enable(void)
 			unpin_current_cpu();
 			preempt_lazy_enable();
 			preempt_enable();
+
+			/*
+			 * Avoid sleeping with an existing non-running
+			 * state.  This will result in a spurious wakeup
+			 * for the calling context.
+			 */
+			__set_current_state(TASK_RUNNING);
+
 			sleeping_lock_inc();
 			stop_one_cpu(task_cpu(p), migration_cpu_stop, &arg);
 			sleeping_lock_dec();
-- 
1.8.3.1

