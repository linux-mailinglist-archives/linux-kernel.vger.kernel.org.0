Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 237D7A725D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 20:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730244AbfICSNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 14:13:41 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:36965 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfICSNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 14:13:41 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i5DJC-0000aX-Oe; Tue, 03 Sep 2019 12:13:38 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i5DJB-0003fJ-Mw; Tue, 03 Sep 2019 12:13:38 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
References: <CAHk-=wiSFvb7djwa7D=-rVtnq3C5msh3u=CF7CVoU6hTJ=VdLw@mail.gmail.com>
        <20190830160957.GC2634@redhat.com>
        <CAHk-=wiZY53ac=mp8R0gjqyUd4ksD3tGHsUS9gvoHiJOT5_cEg@mail.gmail.com>
        <87o906wimo.fsf@x220.int.ebiederm.org>
        <20190902134003.GA14770@redhat.com>
        <87tv9uiq9r.fsf@x220.int.ebiederm.org>
        <CAHk-=wgm+JNNtFZYTBUZ_eEPzebZ0s=kSq1SS6ETr+K5v4uHwg@mail.gmail.com>
        <87k1aqt23r.fsf_-_@x220.int.ebiederm.org>
        <878sr6t21a.fsf_-_@x220.int.ebiederm.org>
        <20190903074117.GX2369@hirez.programming.kicks-ass.net>
        <20190903074718.GT2386@hirez.programming.kicks-ass.net>
        <87k1apqqgk.fsf@x220.int.ebiederm.org>
        <CAHk-=wjVGLr8wArT9P4MXxA-XpkG=9ZXdjM3vpemSF25vYiLoA@mail.gmail.com>
Date:   Tue, 03 Sep 2019 13:13:22 -0500
In-Reply-To: <CAHk-=wjVGLr8wArT9P4MXxA-XpkG=9ZXdjM3vpemSF25vYiLoA@mail.gmail.com>
        (Linus Torvalds's message of "Tue, 3 Sep 2019 10:08:21 -0700")
Message-ID: <874l1tp7st.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1i5DJB-0003fJ-Mw;;;mid=<874l1tp7st.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/2VYTGBJzyqkLsGTBRilhIns2e0GjwRPg=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 450 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 5.0 (1.1%), b_tie_ro: 3.6 (0.8%), parse: 0.94
        (0.2%), extract_message_metadata: 13 (3.0%), get_uri_detail_list: 1.96
        (0.4%), tests_pri_-1000: 19 (4.2%), tests_pri_-950: 1.40 (0.3%),
        tests_pri_-900: 1.19 (0.3%), tests_pri_-90: 28 (6.2%), check_bayes: 26
        (5.8%), b_tokenize: 7 (1.6%), b_tok_get_all: 10 (2.3%), b_comp_prob:
        2.6 (0.6%), b_tok_touch_all: 3.4 (0.8%), b_finish: 0.76 (0.2%),
        tests_pri_0: 371 (82.3%), check_dkim_signature: 0.47 (0.1%),
        check_dkim_adsp: 2.8 (0.6%), poll_dns_idle: 0.31 (0.1%), tests_pri_10:
        2.0 (0.4%), tests_pri_500: 6 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 2/3] task: RCU protect tasks on the runqueue
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, Sep 3, 2019 at 9:45 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> So with a big fat comment explaining why it is safe we could potentially
>> use RCU_INIT_POINTER.  I currently don't see where the appropriate
>> barriers are so I can not write that comment or with a clear conscious
>> write the code to use RCU_INIT_POINTER instead of rcu_assign_pointer.
>
> The only difference ends up being that RCU_INIT_POINTER() is just a
> store, while rcu_assign_pointer() uses a smp_store_release().
>
> (There is some build-time special case code to make
> rcu_assign_pointer(NULL) avoid the store_release, but that is
> irrelevant for this discussion).
>
> So from a memory ordering standpoint,
> RCU_INIT_POINTER-vs-rcu_assign_pointer doesn't change what pointer you
> get (on the other CPU that does the reading), but only whether the
> stores to behind the pointer have been ordered wrt the reading too.

Which is my understanding.

> Which no existing case can care about, since it didn't use to have any
> ordering anyway before this patch series. The individual values read
> off the thread pointer had their own individual memory ordering rules
> (ie instead of making the _pointer_ be the serialization point, we
> have rules for how "p->on_cpu" is ordered wrt the rq lock etc).

Which would not be a regression if an existing case cared about it.

There are so few architectures where this is a real difference (anything
except alpha?) that we could have subtle bugs that have not been tracked
down for a long time.

I keep finding subtle bugs in much older and less subtle cases so I know
it can happen that very minor bugs can get overlooked.

> So one argument for just using RCU_INIT_POINTER is that it's the same
> ordering that we had before, and then it's up to any users of that
> pointer to order any accesses to any fields in 'struct task_struct'.

I agree that RCU_INIT_POINTER is equivalent to what we have now.

> Conversely, one argument for using rcu_assign_pointer() is that when
> we pair it with an RCU read, we get certain ordering guarantees
> automatically. So _if_ we have fields that change when a process is
> put on the run-queue, and the RCU users want to read those fields,
> then the release/acquire semantics might perform better than potential
> existing smp memory barriers we might have right now.

I think this is where I am looking a things differently than you and
Peter.  Why does it have to be ___schedule() that changes the value
in the task_struct?  Why can't it be something else that changes the
value and then proceeds to call schedule()?

What is the size of the window of changes that is relevant?

If we use RCU_INIT_POINTER if there was something that changed
task_struct and then called schedule() what ensures that a remote cpu
that has a stale copy of task_struct cached will update it's cache
after following the new value rq->curr?  Don't we need
rcu_assign_pointer to get that guarantee?

Eric
