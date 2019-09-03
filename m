Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53106A6054
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 06:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfICEwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 00:52:19 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:53120 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfICEwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 00:52:18 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i50nh-00026d-2Q; Mon, 02 Sep 2019 22:52:17 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i50ng-0003qV-4H; Mon, 02 Sep 2019 22:52:16 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
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
Date:   Mon, 02 Sep 2019 23:52:01 -0500
In-Reply-To: <87k1aqt23r.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Mon, 02 Sep 2019 23:50:32 -0500")
Message-ID: <878sr6t21a.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1i50ng-0003qV-4H;;;mid=<878sr6t21a.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19YUXs76k4Q08j1l/tfqck24htknfoJwtk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,XMNoVowels autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 501 ms - load_scoreonly_sql: 0.02 (0.0%),
        signal_user_changed: 3.1 (0.6%), b_tie_ro: 2.3 (0.5%), parse: 1.11
        (0.2%), extract_message_metadata: 17 (3.4%), get_uri_detail_list: 3.3
        (0.7%), tests_pri_-1000: 20 (4.0%), tests_pri_-950: 1.09 (0.2%),
        tests_pri_-900: 0.85 (0.2%), tests_pri_-90: 27 (5.4%), check_bayes: 26
        (5.1%), b_tokenize: 8 (1.5%), b_tok_get_all: 9 (1.9%), b_comp_prob:
        2.5 (0.5%), b_tok_touch_all: 4.2 (0.8%), b_finish: 0.64 (0.1%),
        tests_pri_0: 419 (83.7%), check_dkim_signature: 0.41 (0.1%),
        check_dkim_adsp: 2.2 (0.4%), poll_dns_idle: 0.84 (0.2%), tests_pri_10:
        2.9 (0.6%), tests_pri_500: 6 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 2/3] task: RCU protect tasks on the runqueue
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


In the ordinary case today the rcu grace period of a task comes when a
task is reaped, well after the task has left the runqueue.  This
change guarantees that the rcu grace period always happens after a
task has left the runqueue.  As this is something that usaually happens
today I do not expect any code correctness problems with this change.
At most I anticipate timing challenges.

The only code that will run later are the functions
perf_event_delayed_put, and trace-sched_process_free.  The function
perf_event_delayed_put in the final analysis is just a WARN_ON for
cases that I assume should never happen.  So I don't see any problem
with delaying it.

The function trace_sched_process_free is a trace point and thus user
space visible.   The strangest dependencies can happen but short
of the bizarre it appears to me that trace_sched_process_free is
getting a slightly more accurate picture of when a task struct
is free.  As it is now guaranteed that the process will not be
on the runqueue.

Resources for a process are freed in release_task or in __put_task_struct
when the reference count goes to 0.  Both of which are happening at
effectively the same time as before.  The rcu grace period is just
potentially happening a little bit later in the timeline.

In the common case of a process being reaped after it leaves the
runqueue everything will happen exactly as before.

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
 kernel/sched/core.c |  7 ++++---
 2 files changed, 11 insertions(+), 7 deletions(-)

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
index 2b037f195473..802958407369 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3135,7 +3135,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 		/* Task is done with its stack. */
 		put_task_stack(prev);
 
-		put_task_struct(prev);
+		put_task_struct_rcu_user(prev);
 	}
 
 	tick_nohz_task_switch();
@@ -3857,7 +3857,7 @@ static void __sched notrace __schedule(bool preempt)
 
 	if (likely(prev != next)) {
 		rq->nr_switches++;
-		rq->curr = next;
+		rcu_assign_pointer(rq->curr, next);
 		/*
 		 * The membarrier system call requires each architecture
 		 * to have a full memory barrier after updating
@@ -5863,7 +5863,8 @@ void init_idle(struct task_struct *idle, int cpu)
 	__set_task_cpu(idle, cpu);
 	rcu_read_unlock();
 
-	rq->curr = rq->idle = idle;
+	rq->idle = idle;
+	rcu_assign_pointer(rq->curr, idle);
 	idle->on_rq = TASK_ON_RQ_QUEUED;
 #ifdef CONFIG_SMP
 	idle->on_cpu = 1;
-- 
2.21.0.dirty

