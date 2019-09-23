Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3864BB8EF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 18:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387844AbfIWQBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 12:01:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58980 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732862AbfIWQBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 12:01:44 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iCQmT-0000UU-6u; Mon, 23 Sep 2019 18:01:41 +0200
Date:   Mon, 23 Sep 2019 18:01:41 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH RT] posix-timers: Unlock expiry lock in the early return
Message-ID: <20190923160141.oqsv7vwhw5pof6f2@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch ("posix-timers: Add expiry lock") acquired a lock in
run_posix_cpu_timers() but didn't drop the lock in the early return.

Unlock the lock in the early return path.

Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/time/posix-cpu-timers.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 20cd92a8b9785..a045813c37021 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1167,8 +1167,10 @@ static void __run_posix_cpu_timers(struct task_struct *tsk)
 	expiry_lock = this_cpu_ptr(&cpu_timer_expiry_lock);
 	spin_lock(expiry_lock);
 
-	if (!lock_task_sighand(tsk, &flags))
+	if (!lock_task_sighand(tsk, &flags)) {
+		spin_unlock(expiry_lock);
 		return;
+	}
 	/*
 	 * Here we take off tsk->signal->cpu_timers[N] and
 	 * tsk->cpu_timers[N] all the timers that are firing, and
-- 
2.23.0
