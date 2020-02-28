Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64399173DFB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 18:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgB1RK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 12:10:59 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:39524 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgB1RK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 12:10:59 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1j7jAA-0002tx-41; Fri, 28 Feb 2020 10:10:58 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1j7jA1-0006uX-V7; Fri, 28 Feb 2020 10:10:57 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <87k146vdw3.fsf@x220.int.ebiederm.org>
Date:   Fri, 28 Feb 2020 11:08:45 -0600
In-Reply-To: <87k146vdw3.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Fri, 28 Feb 2020 11:07:56 -0600")
Message-ID: <87eeuevduq.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1j7jA1-0006uX-V7;;;mid=<87eeuevduq.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+vv3lF8nEhE/ocZ80NZOBuSjYvGOPrlm8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,NO_DNS_FOR_FROM,T_TooManySym_01,T_TooManySym_02,
        XMGappySubj_01,XMNoVowels,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.5 XMGappySubj_01 Very gappy subject
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 NO_DNS_FOR_FROM DNS: Envelope sender has no MX or A DNS records
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 7598 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.4 (0.0%), b_tie_ro: 1.77 (0.0%), parse: 0.61
        (0.0%), extract_message_metadata: 9 (0.1%), get_uri_detail_list: 0.68
        (0.0%), tests_pri_-1000: 2.4 (0.0%), tests_pri_-950: 0.99 (0.0%),
        tests_pri_-900: 0.79 (0.0%), tests_pri_-90: 15 (0.2%), check_bayes: 14
        (0.2%), b_tokenize: 3.7 (0.0%), b_tok_get_all: 4.9 (0.1%),
        b_comp_prob: 1.26 (0.0%), b_tok_touch_all: 2.1 (0.0%), b_finish: 0.61
        (0.0%), tests_pri_0: 6149 (80.9%), check_dkim_signature: 0.35 (0.0%),
        check_dkim_adsp: 6008 (79.1%), poll_dns_idle: 7407 (97.5%),
        tests_pri_10: 2.1 (0.0%), tests_pri_500: 1414 (18.6%), rewrite_mail:
        0.00 (0.0%)
Subject: [PATCH 1/5] posix-cpu-timers: cpu_clock_sample_group no longer needs siglock
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


As of e78c3496790e ("time, signal: Protect resource use statistics
with seqlock") cpu_clock_sample_group no longers needs siglock
protection so remove the stale comment.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/time/posix-cpu-timers.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 8ff6da77a01f..46cc188bf5ab 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -336,9 +336,7 @@ static void __thread_group_cputime(struct task_struct *tsk, u64 *samples)
 /*
  * Sample a process (thread group) clock for the given task clkid. If the
  * group's cputime accounting is already enabled, read the atomic
- * store. Otherwise a full update is required.  Task's sighand lock must be
- * held to protect the task traversal on a full update. clkid is already
- * validated.
+ * store. Otherwise a full update is required.  clkid is already validated.
  */
 static u64 cpu_clock_sample_group(const clockid_t clkid, struct task_struct *p,
 				  bool start)
-- 
2.25.0

