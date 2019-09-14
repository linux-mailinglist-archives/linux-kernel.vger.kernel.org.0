Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAF8CB2B37
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2019 14:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388030AbfINMeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Sep 2019 08:34:19 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:40272 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387893AbfINMeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 08:34:19 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i97Fp-0003nl-Kk; Sat, 14 Sep 2019 06:34:17 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i97Fo-0004mZ-MD; Sat, 14 Sep 2019 06:34:17 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20190830140805.GD13294@shell.armlinux.org.uk>
        <CAHk-=whuggNup=-MOS=7gBkuRqUigk7ABot_Pxi5koF=dM3S5Q@mail.gmail.com>
        <CAHk-=wiSFvb7djwa7D=-rVtnq3C5msh3u=CF7CVoU6hTJ=VdLw@mail.gmail.com>
        <20190830160957.GC2634@redhat.com>
        <CAHk-=wiZY53ac=mp8R0gjqyUd4ksD3tGHsUS9gvoHiJOT5_cEg@mail.gmail.com>
        <87o906wimo.fsf@x220.int.ebiederm.org>
        <20190902134003.GA14770@redhat.com>
        <87tv9uiq9r.fsf@x220.int.ebiederm.org>
        <CAHk-=wgm+JNNtFZYTBUZ_eEPzebZ0s=kSq1SS6ETr+K5v4uHwg@mail.gmail.com>
        <87k1aqt23r.fsf_-_@x220.int.ebiederm.org>
        <87muf7f4bf.fsf_-_@x220.int.ebiederm.org>
Date:   Sat, 14 Sep 2019 07:33:58 -0500
In-Reply-To: <87muf7f4bf.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Sat, 14 Sep 2019 07:30:28 -0500")
Message-ID: <87r24jdpl5.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1i97Fo-0004mZ-MD;;;mid=<87r24jdpl5.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/UzWHV//rIre7NO4oX/P2WZTptdGdk7ac=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=23 Fuz1=23 Fuz2=23]
X-Spam-DCC: XMission; sa07 1397; Body=23 Fuz1=23 Fuz2=23 
X-Spam-Combo: ;Peter Zijlstra <peterz@infradead.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 442 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.5 (0.6%), b_tie_ro: 1.78 (0.4%), parse: 0.84
        (0.2%), extract_message_metadata: 14 (3.3%), get_uri_detail_list: 2.2
        (0.5%), tests_pri_-1000: 22 (5.1%), tests_pri_-950: 1.36 (0.3%),
        tests_pri_-900: 1.06 (0.2%), tests_pri_-90: 31 (6.9%), check_bayes: 29
        (6.5%), b_tokenize: 10 (2.2%), b_tok_get_all: 9 (2.1%), b_comp_prob:
        3.2 (0.7%), b_tok_touch_all: 4.0 (0.9%), b_finish: 0.69 (0.2%),
        tests_pri_0: 356 (80.7%), check_dkim_signature: 0.56 (0.1%),
        check_dkim_adsp: 2.7 (0.6%), poll_dns_idle: 0.95 (0.2%), tests_pri_10:
        2.2 (0.5%), tests_pri_500: 7 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v2 2/4] task: Ensure tasks are available for a grace period after leaving the runqueue
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


In the ordinary case today the rcu grace period for a task_struct is
triggered when another process wait's for it's zombine and causes the
kernel to call release_task().  As the waiting task has to receive a
signal and then act upon it before this happens, typically this will
occur after the original task as been removed from the runqueue.

Unfortunaty in some cases such as self reaping tasks it can be shown
that release_task() will be called starting the grace period for
task_struct long before the task leaves the runqueue.

Therefore use put_task_struct_rcu_user in finish_task_switch to
guarantee that the there is a rcu lifetime after the task
leaves the runqueue.

Besides the change in the start of the rcu grace period for the
task_struct this change may cause perf_event_delayed_put and
trace_sched_process_free.  The function perf_event_delayed_put boils
down to just a WARN_ON for cases that I assume never show happen.  So
I don't see any problem with delaying it.

The function trace_sched_process_free is a trace point and thus
visible to user space.  Occassionally userspace has the strangest
dependencies so this has a miniscule chance of causing a regression.
This change only changes the timing of when the tracepoint is called.
The change in timing arguably gives userspace a more accurate picture
of what is going on.  So I don't expect there to be a regression.

In the case where a task self reaps we are pretty much guaranteed that
the rcu grace period is delayed.  So we should get quite a bit of
coverage in of this worst case for the change in a normal threaded
workload.  So I expect any issues to turn up quickly or not at all.

I have lightly tested this change and everything appears to work
fine.

Inspired-by: Linus Torvalds <torvalds@linux-foundation.org>
Inspired-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/fork.c       | 11 +++++++----
 kernel/sched/core.c |  2 +-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 9f04741d5c70..7a74ade4e7d6 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -900,10 +900,13 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	if (orig->cpus_ptr == &orig->cpus_mask)
 		tsk->cpus_ptr = &tsk->cpus_mask;
 
-	/* One for the user space visible state that goes away when reaped. */
-	refcount_set(&tsk->rcu_users, 1);
-	/* One for the rcu users, and one for the scheduler */
-	refcount_set(&tsk->usage, 2);
+	/*
+	 * One for the user space visible state that goes away when reaped.
+	 * One for the scheduler.
+	 */
+	refcount_set(&tsk->rcu_users, 2);
+	/* One for the rcu users */
+	refcount_set(&tsk->usage, 1);
 #ifdef CONFIG_BLK_DEV_IO_TRACE
 	tsk->btrace_seq = 0;
 #endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2b037f195473..69015b7c28da 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3135,7 +3135,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 		/* Task is done with its stack. */
 		put_task_stack(prev);
 
-		put_task_struct(prev);
+		put_task_struct_rcu_user(prev);
 	}
 
 	tick_nohz_task_switch();
-- 
2.21.0.dirty

