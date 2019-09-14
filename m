Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC195B2B35
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2019 14:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387877AbfINMd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Sep 2019 08:33:57 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:59682 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387462AbfINMd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 08:33:56 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i97FS-0006jT-8i; Sat, 14 Sep 2019 06:33:54 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i97FR-00031y-6n; Sat, 14 Sep 2019 06:33:54 -0600
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
Date:   Sat, 14 Sep 2019 07:33:34 -0500
In-Reply-To: <87muf7f4bf.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Sat, 14 Sep 2019 07:30:28 -0500")
Message-ID: <87woebdplt.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1i97FR-00031y-6n;;;mid=<87woebdplt.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18ju2EoLw9jf/diOYqu9SGCe93FWMdnTJw=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=23 Fuz1=23 Fuz2=58]
X-Spam-DCC: XMission; sa06 1397; Body=23 Fuz1=23 Fuz2=58 
X-Spam-Combo: ;Peter Zijlstra <peterz@infradead.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 559 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.7 (0.5%), b_tie_ro: 1.91 (0.3%), parse: 0.98
        (0.2%), extract_message_metadata: 15 (2.7%), get_uri_detail_list: 1.96
        (0.4%), tests_pri_-1000: 22 (3.9%), tests_pri_-950: 1.30 (0.2%),
        tests_pri_-900: 1.10 (0.2%), tests_pri_-90: 30 (5.4%), check_bayes: 28
        (5.1%), b_tokenize: 10 (1.7%), b_tok_get_all: 9 (1.6%), b_comp_prob:
        3.2 (0.6%), b_tok_touch_all: 4.1 (0.7%), b_finish: 0.73 (0.1%),
        tests_pri_0: 474 (84.8%), check_dkim_signature: 0.61 (0.1%),
        check_dkim_adsp: 2.5 (0.4%), poll_dns_idle: 0.67 (0.1%), tests_pri_10:
        2.2 (0.4%), tests_pri_500: 7 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v2 1/4] task: Add a count of task rcu users
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Add a count of the number of rcu users (currently 1) of the task
struct so that we can later add the scheduler case and get rid of the
very subtle task_rcu_dereference, and just use rcu_dereference.

As suggested by Oleg have the count overlap rcu_head so that no
additional space in task_struct is required.

Inspired-by: Linus Torvalds <torvalds@linux-foundation.org>
Inspired-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/sched.h      | 5 ++++-
 include/linux/sched/task.h | 1 +
 kernel/exit.c              | 7 ++++++-
 kernel/fork.c              | 7 +++----
 4 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9f51932bd543..99a4518b9b17 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1142,7 +1142,10 @@ struct task_struct {
 
 	struct tlbflush_unmap_batch	tlb_ubc;
 
-	struct rcu_head			rcu;
+	union {
+		refcount_t		rcu_users;
+		struct rcu_head		rcu;
+	};
 
 	/* Cache last used pipe for splice(): */
 	struct pipe_inode_info		*splice_pipe;
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 0497091e40c1..4c44c37236b2 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -116,6 +116,7 @@ static inline void put_task_struct(struct task_struct *t)
 }
 
 struct task_struct *task_rcu_dereference(struct task_struct **ptask);
+void put_task_struct_rcu_user(struct task_struct *task);
 
 #ifdef CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT
 extern int arch_task_struct_size __read_mostly;
diff --git a/kernel/exit.c b/kernel/exit.c
index 5b4a5dcce8f8..2e259286f4e7 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -182,6 +182,11 @@ static void delayed_put_task_struct(struct rcu_head *rhp)
 	put_task_struct(tsk);
 }
 
+void put_task_struct_rcu_user(struct task_struct *task)
+{
+	if (refcount_dec_and_test(&task->rcu_users))
+		call_rcu(&task->rcu, delayed_put_task_struct);
+}
 
 void release_task(struct task_struct *p)
 {
@@ -222,7 +227,7 @@ void release_task(struct task_struct *p)
 
 	write_unlock_irq(&tasklist_lock);
 	release_thread(p);
-	call_rcu(&p->rcu, delayed_put_task_struct);
+	put_task_struct_rcu_user(p);
 
 	p = leader;
 	if (unlikely(zap_leader))
diff --git a/kernel/fork.c b/kernel/fork.c
index 2852d0e76ea3..9f04741d5c70 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -900,10 +900,9 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	if (orig->cpus_ptr == &orig->cpus_mask)
 		tsk->cpus_ptr = &tsk->cpus_mask;
 
-	/*
-	 * One for us, one for whoever does the "release_task()" (usually
-	 * parent)
-	 */
+	/* One for the user space visible state that goes away when reaped. */
+	refcount_set(&tsk->rcu_users, 1);
+	/* One for the rcu users, and one for the scheduler */
 	refcount_set(&tsk->usage, 2);
 #ifdef CONFIG_BLK_DEV_IO_TRACE
 	tsk->btrace_seq = 0;
-- 
2.21.0.dirty

