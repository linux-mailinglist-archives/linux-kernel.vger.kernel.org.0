Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8504535EC2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 16:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbfFEOKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jun 2019 10:10:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:36230 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726442AbfFEOKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 10:10:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 60460AF1A;
        Wed,  5 Jun 2019 14:10:11 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Laurence Oberman <loberman@redhat.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH 2/3] watchdog/softlockup: Report the same softlockup regularly
Date:   Wed,  5 Jun 2019 16:09:53 +0200
Message-Id: <20190605140954.28471-3-pmladek@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190605140954.28471-1-pmladek@suse.com>
References: <20190605140954.28471-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Softlockup report means that there is no progress on the given CPU. It
might be a "short" affair where the system gets recovered. But often
the system stops being responsive and need to get rebooted.

The softlockup might be root of the problems or just a symptom. It might
be a deadlock, livelock, or often repeated state.

Regular reports help to distinguish different situations. Fortunately,
the watchdog is finally able to show correct information how long
softlockup_fn() was not scheduled.

Note that the horrible code never really worked before the accounting
was fixed. The last working timestamp was regularly lost by the many
touch*watchdog() calls.

Also note that the full report is useful to distinguish livelock
and deadlock.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/watchdog.c | 25 +------------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index bd249676ee3d..2058229ed398 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -173,10 +173,8 @@ static DEFINE_PER_CPU(unsigned long, watchdog_period_ts);
 static DEFINE_PER_CPU(struct hrtimer, watchdog_hrtimer);
 static DEFINE_PER_CPU(bool, watchdog_restart_period);
 static DEFINE_PER_CPU(bool, softlockup_touch_sync);
-static DEFINE_PER_CPU(bool, soft_watchdog_warn);
 static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts);
 static DEFINE_PER_CPU(unsigned long, soft_lockup_hrtimer_cnt);
-static DEFINE_PER_CPU(struct task_struct *, softlockup_task_ptr_saved);
 static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts_saved);
 static unsigned long soft_lockup_nmi_warn;
 
@@ -268,7 +266,6 @@ static void __touch_watchdog(void)
 {
 	__this_cpu_write(watchdog_touch_ts, get_timestamp());
 	__restart_watchdog_period();
-	__this_cpu_write(soft_watchdog_warn, false);
 }
 
 /**
@@ -429,31 +426,13 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 		if (kvm_check_and_clear_guest_paused())
 			return HRTIMER_RESTART;
 
-		/* only warn once */
-		if (__this_cpu_read(soft_watchdog_warn) == true) {
-			/*
-			 * When multiple processes are causing softlockups the
-			 * softlockup detector only warns on the first one
-			 * because the code relies on a full quiet cycle to
-			 * re-arm.  The second process prevents the quiet cycle
-			 * and never gets reported.  Use task pointers to detect
-			 * this.
-			 */
-			if (__this_cpu_read(softlockup_task_ptr_saved) !=
-			    current) {
-				__this_cpu_write(soft_watchdog_warn, false);
-				__restart_watchdog_period();
-			}
-			return HRTIMER_RESTART;
-		}
-
 		if (softlockup_all_cpu_backtrace) {
 			/* Prevent multiple soft-lockup reports if one cpu is already
 			 * engaged in dumping cpu back traces
 			 */
 			if (test_and_set_bit(0, &soft_lockup_nmi_warn)) {
 				/* Someone else will report us. Let's give up */
-				__this_cpu_write(soft_watchdog_warn, true);
+				__restart_watchdog_period();
 				return HRTIMER_RESTART;
 			}
 		}
@@ -461,7 +440,6 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 		pr_emerg("BUG: soft lockup - CPU#%d stuck for %us! [%s:%d]\n",
 			smp_processor_id(), duration,
 			current->comm, task_pid_nr(current));
-		__this_cpu_write(softlockup_task_ptr_saved, current);
 		print_modules();
 		print_irqtrace_events(current);
 		if (regs)
@@ -483,7 +461,6 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 		add_taint(TAINT_SOFTLOCKUP, LOCKDEP_STILL_OK);
 		if (softlockup_panic)
 			panic("softlockup: hung tasks");
-		__this_cpu_write(soft_watchdog_warn, true);
 	}
 
 	return HRTIMER_RESTART;
-- 
2.16.4

