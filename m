Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC2822D337
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 03:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbfE2BWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 21:22:05 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:34684 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfE2BWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 21:22:04 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hVnI2-0006Nu-JG; Tue, 28 May 2019 19:22:02 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hVnI1-0006bg-Ei; Tue, 28 May 2019 19:22:02 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     arnd@arndb.de, christian@brauner.io, deepa.kernel@gmail.com,
        glider@google.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        Oleg Nesterov <oleg@redhat.com>,
        syzbot <syzbot+0d602a1b0d8c95bdf299@syzkaller.appspotmail.com>,
        Andrei Vagin <avagin@gmail.com>
References: <000000000000410d500588adf637@google.com>
        <87woia5vq3.fsf@xmission.com>
        <20190528124746.ac703cd668ca9409bb79100b@linux-foundation.org>
Date:   Tue, 28 May 2019 20:21:53 -0500
In-Reply-To: <20190528124746.ac703cd668ca9409bb79100b@linux-foundation.org>
        (Andrew Morton's message of "Tue, 28 May 2019 12:47:46 -0700")
Message-ID: <87pno23vim.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hVnI1-0006bg-Ei;;;mid=<87pno23vim.fsf_-_@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/T4NCzU3tLfZqu3MG9V5m6cAEXyeUSV48=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4997]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Andrew Morton <akpm@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 746 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 2.4 (0.3%), b_tie_ro: 1.61 (0.2%), parse: 1.21
        (0.2%), extract_message_metadata: 27 (3.6%), get_uri_detail_list: 3.4
        (0.5%), tests_pri_-1000: 21 (2.9%), tests_pri_-950: 1.30 (0.2%),
        tests_pri_-900: 1.06 (0.1%), tests_pri_-90: 25 (3.4%), check_bayes: 24
        (3.2%), b_tokenize: 8 (1.0%), b_tok_get_all: 8 (1.1%), b_comp_prob:
        2.5 (0.3%), b_tok_touch_all: 3.7 (0.5%), b_finish: 0.57 (0.1%),
        tests_pri_0: 307 (41.1%), check_dkim_signature: 0.69 (0.1%),
        check_dkim_adsp: 2.3 (0.3%), poll_dns_idle: 343 (46.0%), tests_pri_10:
        2.3 (0.3%), tests_pri_500: 354 (47.4%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH] signal/ptrace: Don't leak unitialized kernel memory with PTRACE_PEEK_SIGINFO
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Recently syzbot in conjunction with KMSAN reported that
ptrace_peek_siginfo can copy an uninitialized siginfo to userspace.
Inspecting ptrace_peek_siginfo confirms this.

The problem is that off when initialized from args.off can be
initialized to a negaive value.  At which point the "if (off >= 0)"
test to see if off became negative fails because off started off
negative.

Prevent the core problem by adding a variable found that is only true
if a siginfo is found and copied to a temporary in preparation for
being copied to userspace.

Prevent args.off from being truncated when being assigned to off by
testing that off is <= the maximum possible value of off.  Convert off
to an unsigned long so that we should not have to truncate args.off,
we have well defined overflow behavior so if we add another check we
won't risk fighting undefined compiler behavior, and so that we have a
type whose maximum value is easy to test for.

Cc: Andrei Vagin <avagin@gmail.com>
Cc: stable@vger.kernel.org
Reported-by: syzbot+0d602a1b0d8c95bdf299@syzkaller.appspotmail.com
Fixes: 84c751bd4aeb ("ptrace: add ability to retrieve signals without removing from a queue (v4)")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---

Comments?
Concerns?

Otherwise I will queue this up and send it to Linus.

 kernel/ptrace.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 6f357f4fc859..4c2b24a885d3 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -704,6 +704,10 @@ static int ptrace_peek_siginfo(struct task_struct *child,
 	if (arg.nr < 0)
 		return -EINVAL;
 
+	/* Ensure arg.off fits in an unsigned */
+	if (arg.off > ULONG_MAX)
+		return 0;
+
 	if (arg.flags & PTRACE_PEEKSIGINFO_SHARED)
 		pending = &child->signal->shared_pending;
 	else
@@ -711,18 +715,20 @@ static int ptrace_peek_siginfo(struct task_struct *child,
 
 	for (i = 0; i < arg.nr; ) {
 		kernel_siginfo_t info;
-		s32 off = arg.off + i;
+		unsigned long off = arg.off + i;
+		bool found = false;
 
 		spin_lock_irq(&child->sighand->siglock);
 		list_for_each_entry(q, &pending->list, list) {
 			if (!off--) {
+				found = true;
 				copy_siginfo(&info, &q->info);
 				break;
 			}
 		}
 		spin_unlock_irq(&child->sighand->siglock);
 
-		if (off >= 0) /* beyond the end of the list */
+		if (!found) /* beyond the end of the list */
 			break;
 
 #ifdef CONFIG_COMPAT
-- 
2.21.0.dirty

