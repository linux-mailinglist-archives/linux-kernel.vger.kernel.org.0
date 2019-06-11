Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFB903DBC7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 22:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406513AbfFKUXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 16:23:54 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:42393 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406489AbfFKUXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 16:23:54 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hanJA-0007e5-Hf; Tue, 11 Jun 2019 14:23:52 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hanJ0-0004Mt-F4; Tue, 11 Jun 2019 14:23:52 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Jann Horn <jannh@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Andrei Vagin <avagin@gmail.com>
Date:   Tue, 11 Jun 2019 15:23:27 -0500
Message-ID: <87d0jj6fcw.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hanJ0-0004Mt-F4;;;mid=<87d0jj6fcw.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX189A/VSwxzSPDX2+S4ja+GoE9kSbIKyFe0=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMSubMetaSxObfu_03,XMSubMetaSx_00
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 9689 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.0 (0.0%), b_tie_ro: 2.1 (0.0%), parse: 1.00
        (0.0%), extract_message_metadata: 12 (0.1%), get_uri_detail_list: 2.9
        (0.0%), tests_pri_-1000: 3.3 (0.0%), tests_pri_-950: 1.13 (0.0%),
        tests_pri_-900: 0.87 (0.0%), tests_pri_-90: 22 (0.2%), check_bayes: 20
        (0.2%), b_tokenize: 6 (0.1%), b_tok_get_all: 7 (0.1%), b_comp_prob:
        1.81 (0.0%), b_tok_touch_all: 3.5 (0.0%), b_finish: 0.63 (0.0%),
        tests_pri_0: 3518 (36.3%), check_dkim_signature: 0.61 (0.0%),
        check_dkim_adsp: 3196 (33.0%), poll_dns_idle: 9309 (96.1%),
        tests_pri_10: 1.65 (0.0%), tests_pri_500: 6124 (63.2%), rewrite_mail:
        0.00 (0.0%)
Subject: [GIT PULL] Minor ptrace fixes for v5.2-rc5
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the for-linus branch from the git tree:

   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git for-linus

   HEAD:f6581f5b55141a95657ef5742cf6a6bfa20a109f ptrace: restore smp_rmb() in __ptrace_may_access()

This is just two very minor fixes.  Preventing ptrace from reading
unitialized kernel memory found twice by syzkaller, and restoring a
missing smp_rmb in ptrace_may_access and commening it so it is not
removed by accident again.

Apologies for being a little slow about getting this to you, I am still
figuring out how to develop with a little baby in the house.


Eric W. Biederman (1):
      signal/ptrace: Don't leak unitialized kernel memory with PTRACE_PEEK_SIGINFO

Jann Horn (1):
      ptrace: restore smp_rmb() in __ptrace_may_access()

 kernel/cred.c   |  9 +++++++++
 kernel/ptrace.c | 20 ++++++++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/kernel/cred.c b/kernel/cred.c
index 45d77284aed0..07e069d00696 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -450,6 +450,15 @@ int commit_creds(struct cred *new)
 		if (task->mm)
 			set_dumpable(task->mm, suid_dumpable);
 		task->pdeath_signal = 0;
+		/*
+		 * If a task drops privileges and becomes nondumpable,
+		 * the dumpability change must become visible before
+		 * the credential change; otherwise, a __ptrace_may_access()
+		 * racing with this change may be able to attach to a task it
+		 * shouldn't be able to attach to (as if the task had dropped
+		 * privileges without becoming nondumpable).
+		 * Pairs with a read barrier in __ptrace_may_access().
+		 */
 		smp_wmb();
 	}
 
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 6f357f4fc859..c9b4646ad375 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -323,6 +323,16 @@ static int __ptrace_may_access(struct task_struct *task, unsigned int mode)
 	return -EPERM;
 ok:
 	rcu_read_unlock();
+	/*
+	 * If a task drops privileges and becomes nondumpable (through a syscall
+	 * like setresuid()) while we are trying to access it, we must ensure
+	 * that the dumpability is read after the credentials; otherwise,
+	 * we may be able to attach to a task that we shouldn't be able to
+	 * attach to (as if the task had dropped privileges without becoming
+	 * nondumpable).
+	 * Pairs with a write barrier in commit_creds().
+	 */
+	smp_rmb();
 	mm = task->mm;
 	if (mm &&
 	    ((get_dumpable(mm) != SUID_DUMP_USER) &&
@@ -704,6 +714,10 @@ static int ptrace_peek_siginfo(struct task_struct *child,
 	if (arg.nr < 0)
 		return -EINVAL;
 
+	/* Ensure arg.off fits in an unsigned long */
+	if (arg.off > ULONG_MAX)
+		return 0;
+
 	if (arg.flags & PTRACE_PEEKSIGINFO_SHARED)
 		pending = &child->signal->shared_pending;
 	else
@@ -711,18 +725,20 @@ static int ptrace_peek_siginfo(struct task_struct *child,
 
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



Eric
