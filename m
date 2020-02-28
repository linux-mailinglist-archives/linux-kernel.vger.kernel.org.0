Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE8C5173DFE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 18:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgB1RLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 12:11:53 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:36900 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgB1RLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 12:11:53 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1j7jB2-0005PU-EI; Fri, 28 Feb 2020 10:11:52 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1j7jB1-000751-EC; Fri, 28 Feb 2020 10:11:51 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <87k146vdw3.fsf@x220.int.ebiederm.org>
Date:   Fri, 28 Feb 2020 11:09:46 -0600
In-Reply-To: <87k146vdw3.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Fri, 28 Feb 2020 11:07:56 -0600")
Message-ID: <8736auvdt1.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1j7jB1-000751-EC;;;mid=<8736auvdt1.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/F8MLzdu+hbRbu0rDZ+lTYMp5McejlJFY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,T_TooManySym_02,XMNoVowels
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 224 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 4.5 (2.0%), b_tie_ro: 2.9 (1.3%), parse: 0.98
        (0.4%), extract_message_metadata: 12 (5.3%), get_uri_detail_list: 1.21
        (0.5%), tests_pri_-1000: 13 (6.0%), tests_pri_-950: 1.30 (0.6%),
        tests_pri_-900: 1.09 (0.5%), tests_pri_-90: 21 (9.3%), check_bayes: 19
        (8.6%), b_tokenize: 6 (2.5%), b_tok_get_all: 6 (2.9%), b_comp_prob:
        1.98 (0.9%), b_tok_touch_all: 2.7 (1.2%), b_finish: 0.74 (0.3%),
        tests_pri_0: 158 (70.7%), check_dkim_signature: 0.62 (0.3%),
        check_dkim_adsp: 2.3 (1.0%), poll_dns_idle: 0.48 (0.2%), tests_pri_10:
        2.1 (0.9%), tests_pri_500: 6 (2.8%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 3/5] posix-cpu-timers: Pass the task into arm_timer
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


We have already had to compute the task to take siglock before
calling arm_timer.  So pass the benefit of that labor into arm_timer.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/time/posix-cpu-timers.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 3b27710f9505..dbbfa88881a3 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -482,12 +482,11 @@ void posix_cpu_timers_exit_group(struct task_struct *tsk)
  * Insert the timer on the appropriate list before any timers that
  * expire later.  This must be called with the sighand lock held.
  */
-static void arm_timer(struct k_itimer *timer)
+static void arm_timer(struct k_itimer *timer, struct task_struct *p)
 {
 	int clkidx = CPUCLOCK_WHICH(timer->it_clock);
 	struct cpu_timer *ctmr = &timer->it.cpu;
 	u64 newexp = cpu_timer_getexpires(ctmr);
-	struct task_struct *p = ctmr->task;
 	struct posix_cputimer_base *base;
 
 	if (CPUCLOCK_PERTHREAD(timer->it_clock))
@@ -660,7 +659,7 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 	 */
 	cpu_timer_setexpires(ctmr, new_expires);
 	if (new_expires != 0 && val < new_expires) {
-		arm_timer(timer);
+		arm_timer(timer, p);
 	}
 
 	unlock_task_sighand(p, &flags);
@@ -981,7 +980,7 @@ static void posix_cpu_timer_rearm(struct k_itimer *timer)
 	/*
 	 * Now re-arm for the new expiry time.
 	 */
-	arm_timer(timer);
+	arm_timer(timer, p);
 	unlock_task_sighand(p, &flags);
 }
 
-- 
2.25.0

