Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6958677715
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2019 07:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbfG0F4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Jul 2019 01:56:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37464 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728399AbfG0F4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 01:56:46 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8B1FE81F13;
        Sat, 27 Jul 2019 05:56:46 +0000 (UTC)
Received: from t460p.redhat.com (ovpn-116-73.phx2.redhat.com [10.3.116.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9636E19C71;
        Sat, 27 Jul 2019 05:56:45 +0000 (UTC)
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
Subject: [PATCH RT 2/8] sched: __set_cpus_allowed_ptr: Check cpus_mask, not cpus_ptr
Date:   Sat, 27 Jul 2019 00:56:32 -0500
Message-Id: <20190727055638.20443-3-swood@redhat.com>
In-Reply-To: <20190727055638.20443-1-swood@redhat.com>
References: <20190727055638.20443-1-swood@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Sat, 27 Jul 2019 05:56:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is concerned with the long-term cpu mask, not the
transitory mask the task might have while migrate disabled.  Before
this patch, if a task was migrate disabled at the time
__set_cpus_allowed_ptr() was called, and the new mask happened to be
equal to the cpu that the task was running on, then the mask update
would be lost.

Signed-off-by: Scott Wood <swood@redhat.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c3407707e367..6e643d656d71 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1218,7 +1218,7 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 		goto out;
 	}
 
-	if (cpumask_equal(p->cpus_ptr, new_mask))
+	if (cpumask_equal(&p->cpus_mask, new_mask))
 		goto out;
 
 	if (!cpumask_intersects(new_mask, cpu_valid_mask)) {
-- 
1.8.3.1

