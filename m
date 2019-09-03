Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCD4A6051
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 06:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfICEu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 00:50:57 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:55938 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfICEu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 00:50:57 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i50mK-0005Xs-T6; Mon, 02 Sep 2019 22:50:52 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i50mK-0003mY-2W; Mon, 02 Sep 2019 22:50:52 -0600
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
Date:   Mon, 02 Sep 2019 23:50:32 -0500
In-Reply-To: <CAHk-=wgm+JNNtFZYTBUZ_eEPzebZ0s=kSq1SS6ETr+K5v4uHwg@mail.gmail.com>
        (Linus Torvalds's message of "Mon, 2 Sep 2019 10:34:46 -0700")
Message-ID: <87k1aqt23r.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1i50mK-0003mY-2W;;;mid=<87k1aqt23r.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/madnelSCO1LJd1mfgR0YFedlxlzUthKM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,XMNoVowels,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 400 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 3.9 (1.0%), b_tie_ro: 2.6 (0.7%), parse: 1.45
        (0.4%), extract_message_metadata: 4.4 (1.1%), get_uri_detail_list:
        1.35 (0.3%), tests_pri_-1000: 6 (1.5%), tests_pri_-950: 1.91 (0.5%),
        tests_pri_-900: 1.58 (0.4%), tests_pri_-90: 27 (6.9%), check_bayes: 25
        (6.3%), b_tokenize: 9 (2.3%), b_tok_get_all: 7 (1.8%), b_comp_prob:
        2.9 (0.7%), b_tok_touch_all: 3.5 (0.9%), b_finish: 0.78 (0.2%),
        tests_pri_0: 333 (83.2%), check_dkim_signature: 0.61 (0.2%),
        check_dkim_adsp: 3.0 (0.7%), poll_dns_idle: 0.99 (0.2%), tests_pri_10:
        2.2 (0.5%), tests_pri_500: 6 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 0/3] task: Making tasks on the runqueue rcu protected
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I have split this work into 3 simple patches, so the code is straight
forward to review and so that if any mistakes slip in it is easy to
bisect them.  In the process of review what it takes to remove
task_rcu_dereference I found yet another user of tasks on the
runqueue in rcu context; the rcuwait_event code.  That code only needs
it now unnecessary limits removed.

I have lightly tested it, and read through everything I can think of
that might be an issue.

Peter would this be a good fit for your scheduler tree?  If not I will
toss it onto a branch someplace and send it to Linus when the merge
window opens.

Oleg do you have any issues with this code?

Eric W. Biederman (3):
      task: Add a count of task rcu users
      task: RCU protect tasks on the runqueue
      task: Clean house now that tasks on the runqueue are rcu protected

 include/linux/rcuwait.h    | 20 +++----------
 include/linux/sched.h      |  5 +++-
 include/linux/sched/task.h |  2 +-
 kernel/exit.c              | 74 ++++------------------------------------------
 kernel/fork.c              |  8 +++--
 kernel/sched/core.c        |  7 +++--
 kernel/sched/fair.c        |  2 +-
 kernel/sched/membarrier.c  |  4 +--
 8 files changed, 27 insertions(+), 95 deletions(-)

Eric
