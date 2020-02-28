Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE38173E2F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 18:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgB1RRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 12:17:10 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:38402 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB1RRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 12:17:10 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1j7jG8-0005zl-St; Fri, 28 Feb 2020 10:17:09 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1j7jG7-00085e-NR; Fri, 28 Feb 2020 10:17:08 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <87k146vdw3.fsf@x220.int.ebiederm.org>
Date:   Fri, 28 Feb 2020 11:15:03 -0600
In-Reply-To: <87k146vdw3.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Fri, 28 Feb 2020 11:07:56 -0600")
Message-ID: <87o8tityzs.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1j7jG7-00085e-NR;;;mid=<87o8tityzs.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/6Mp/s2UzF6BGRfn5dOIV57tKb1lFp07s=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4994]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 238 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.9 (1.2%), b_tie_ro: 1.97 (0.8%), parse: 0.79
        (0.3%), extract_message_metadata: 11 (4.6%), get_uri_detail_list: 1.08
        (0.5%), tests_pri_-1000: 14 (6.0%), tests_pri_-950: 1.30 (0.5%),
        tests_pri_-900: 1.03 (0.4%), tests_pri_-90: 24 (10.1%), check_bayes:
        23 (9.6%), b_tokenize: 5 (2.2%), b_tok_get_all: 8 (3.2%), b_comp_prob:
        2.0 (0.9%), b_tok_touch_all: 2.8 (1.2%), b_finish: 0.61 (0.3%),
        tests_pri_0: 171 (72.1%), check_dkim_signature: 0.50 (0.2%),
        check_dkim_adsp: 2.1 (0.9%), poll_dns_idle: 0.48 (0.2%), tests_pri_10:
        2.1 (0.9%), tests_pri_500: 6 (2.6%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 5/5] posix-cpu-timers: Stop disabling timers on mt-exec
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The reasons Oleg added the extra posix_cpu_timers_exit_group are not
entirely clear from his commit message.  Today all that
posix_cpu_timers_exit_group does is stop timers that are tracking the
task from firing.  Every other operation on those timers is still
allowed.

The practical implication of this is posix_cpu_timer_del which could
not get the siglock after the thread group leader has exited (because
sighand == NULL) would be able to run successfully because the timer
was already dequeued.

With that locking issue fixed there is no point in disabling all
of the timers.  So remove Oleg's ``tempoary'' hack.

Fixes: e0a70217107e ("posix-cpu-timers: workaround to suppress the problems with mt exec")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/exit.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 502b4995b688..c7f32101c2c8 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -103,17 +103,8 @@ static void __exit_signal(struct task_struct *tsk)
 
 #ifdef CONFIG_POSIX_TIMERS
 	posix_cpu_timers_exit(tsk);
-	if (group_dead) {
+	if (group_dead)
 		posix_cpu_timers_exit_group(tsk);
-	} else {
-		/*
-		 * This can only happen if the caller is de_thread().
-		 * FIXME: this is the temporary hack, we should teach
-		 * posix-cpu-timers to handle this case correctly.
-		 */
-		if (unlikely(has_group_leader_pid(tsk)))
-			posix_cpu_timers_exit_group(tsk);
-	}
 #endif
 
 	if (group_dead) {
-- 
2.25.0

