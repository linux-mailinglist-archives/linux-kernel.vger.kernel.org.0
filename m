Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40B9E173DFD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 18:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgB1RL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 12:11:26 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:36762 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgB1RL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 12:11:26 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1j7jAb-0005NM-1o; Fri, 28 Feb 2020 10:11:25 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1j7jAa-0000PO-Cf; Fri, 28 Feb 2020 10:11:24 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <87k146vdw3.fsf@x220.int.ebiederm.org>
Date:   Fri, 28 Feb 2020 11:09:19 -0600
In-Reply-To: <87k146vdw3.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Fri, 28 Feb 2020 11:07:56 -0600")
Message-ID: <878skmvdts.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1j7jAa-0000PO-Cf;;;mid=<878skmvdts.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+SwV9n8I8/1u7FVxkI999yZA6VfY+DvLA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,T_TooManySym_02,XMGappySubj_01,
        XMNoVowels,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.5 XMGappySubj_01 Very gappy subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 308 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 6 (1.9%), b_tie_ro: 3.8 (1.2%), parse: 0.91
        (0.3%), extract_message_metadata: 10 (3.2%), get_uri_detail_list: 1.46
        (0.5%), tests_pri_-1000: 11 (3.6%), tests_pri_-950: 1.08 (0.4%),
        tests_pri_-900: 0.86 (0.3%), tests_pri_-90: 22 (7.3%), check_bayes: 21
        (6.9%), b_tokenize: 6 (1.9%), b_tok_get_all: 9 (2.9%), b_comp_prob:
        1.74 (0.6%), b_tok_touch_all: 2.9 (0.9%), b_finish: 0.55 (0.2%),
        tests_pri_0: 246 (79.7%), check_dkim_signature: 0.76 (0.2%),
        check_dkim_adsp: 1.75 (0.6%), poll_dns_idle: 0.33 (0.1%),
        tests_pri_10: 1.77 (0.6%), tests_pri_500: 6 (1.9%), rewrite_mail: 0.00
        (0.0%)
Subject: [PATCH 2/5] posix-cpu-timers: Remove unnecessary locking around cpu_clock_sample_group
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


As of e78c3496790e ("time, signal: Protect resource use statistics
with seqlock") cpu_clock_sample_group no longers needs siglock
protection.  Unfortunately no one realized it at the time.

Remove the extra locking that is for cpu_clock_sample_group and not
for cpu_clock_sample.  This significantly simplifies the code.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/time/posix-cpu-timers.c | 55 +++++-----------------------------
 1 file changed, 7 insertions(+), 48 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 46cc188bf5ab..3b27710f9505 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -721,27 +721,7 @@ static void posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp
 	if (CPUCLOCK_PERTHREAD(timer->it_clock)) {
 		now = cpu_clock_sample(clkid, p);
 	} else {
-		struct sighand_struct *sighand;
-		unsigned long flags;
-
-		/*
-		 * Protect against sighand release/switch in exit/exec and
-		 * also make timer sampling safe if it ends up calling
-		 * thread_group_cputime().
-		 */
-		sighand = lock_task_sighand(p, &flags);
-		if (unlikely(sighand == NULL)) {
-			/*
-			 * The process has been reaped.
-			 * We can't even collect a sample any more.
-			 * Disarm the timer, nothing else to do.
-			 */
-			cpu_timer_setexpires(ctmr, 0);
-			return;
-		} else {
-			now = cpu_clock_sample_group(clkid, p, false);
-			unlock_task_sighand(p, &flags);
-		}
+		now = cpu_clock_sample_group(clkid, p, false);
 	}
 
 	if (now < expires) {
@@ -988,41 +968,20 @@ static void posix_cpu_timer_rearm(struct k_itimer *timer)
 	 */
 	if (CPUCLOCK_PERTHREAD(timer->it_clock)) {
 		now = cpu_clock_sample(clkid, p);
-		bump_cpu_timer(timer, now);
-		if (unlikely(p->exit_state))
-			return;
-
-		/* Protect timer list r/w in arm_timer() */
-		sighand = lock_task_sighand(p, &flags);
-		if (!sighand)
-			return;
 	} else {
-		/*
-		 * Protect arm_timer() and timer sampling in case of call to
-		 * thread_group_cputime().
-		 */
-		sighand = lock_task_sighand(p, &flags);
-		if (unlikely(sighand == NULL)) {
-			/*
-			 * The process has been reaped.
-			 * We can't even collect a sample any more.
-			 */
-			cpu_timer_setexpires(ctmr, 0);
-			return;
-		} else if (unlikely(p->exit_state) && thread_group_empty(p)) {
-			/* If the process is dying, no need to rearm */
-			goto unlock;
-		}
 		now = cpu_clock_sample_group(clkid, p, true);
-		bump_cpu_timer(timer, now);
-		/* Leave the sighand locked for the call below.  */
 	}
+	bump_cpu_timer(timer, now);
+
+	/* Protect timer list r/w in arm_timer() */
+	sighand = lock_task_sighand(p, &flags);
+	if (unlikely(sighand == NULL))
+		return;
 
 	/*
 	 * Now re-arm for the new expiry time.
 	 */
 	arm_timer(timer);
-unlock:
 	unlock_task_sighand(p, &flags);
 }
 
-- 
2.25.0

