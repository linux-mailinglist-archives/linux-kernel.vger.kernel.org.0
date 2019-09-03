Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F26EA70DA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 18:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730170AbfICQpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 12:45:18 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:50993 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729113AbfICQpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:45:17 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i5Bvf-0008V0-BG; Tue, 03 Sep 2019 10:45:15 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i5Bve-0002aV-Co; Tue, 03 Sep 2019 10:45:15 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
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
Date:   Tue, 03 Sep 2019 11:44:59 -0500
In-Reply-To: <20190903074718.GT2386@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Tue, 3 Sep 2019 09:47:18 +0200")
Message-ID: <87k1apqqgk.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1i5Bve-0002aV-Co;;;mid=<87k1apqqgk.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19nXS5xUr8YG/IUjeLegM3tJoyhsEy4Gig=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4970]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Peter Zijlstra <peterz@infradead.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 344 ms - load_scoreonly_sql: 0.02 (0.0%),
        signal_user_changed: 2.3 (0.7%), b_tie_ro: 1.69 (0.5%), parse: 0.65
        (0.2%), extract_message_metadata: 9 (2.5%), get_uri_detail_list: 1.31
        (0.4%), tests_pri_-1000: 12 (3.6%), tests_pri_-950: 1.01 (0.3%),
        tests_pri_-900: 0.85 (0.2%), tests_pri_-90: 29 (8.5%), check_bayes: 28
        (8.2%), b_tokenize: 6 (1.9%), b_tok_get_all: 12 (3.4%), b_comp_prob:
        1.99 (0.6%), b_tok_touch_all: 3.5 (1.0%), b_finish: 0.55 (0.2%),
        tests_pri_0: 280 (81.4%), check_dkim_signature: 0.41 (0.1%),
        check_dkim_adsp: 1.77 (0.5%), poll_dns_idle: 0.46 (0.1%),
        tests_pri_10: 1.74 (0.5%), tests_pri_500: 4.8 (1.4%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH 2/3] task: RCU protect tasks on the runqueue
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Tue, Sep 03, 2019 at 09:41:17AM +0200, Peter Zijlstra wrote:
>> On Mon, Sep 02, 2019 at 11:52:01PM -0500, Eric W. Biederman wrote:
>> 
>> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> > index 2b037f195473..802958407369 100644
>> > --- a/kernel/sched/core.c
>> > +++ b/kernel/sched/core.c
>> 
>> > @@ -3857,7 +3857,7 @@ static void __sched notrace __schedule(bool preempt)
>> >  
>> >  	if (likely(prev != next)) {
>> >  		rq->nr_switches++;
>> > -		rq->curr = next;
>> > +		rcu_assign_pointer(rq->curr, next);
>> >  		/*
>> >  		 * The membarrier system call requires each architecture
>> >  		 * to have a full memory barrier after updating
>> 
>> This one is sad; it puts a (potentially) expensive barrier in here. And
>> I'm not sure I can explain the need for it. That is, we've not changed
>> @next before this and don't need to 'publish' it as such.
>> 
>> Can we use RCU_INIT_POINTER() or simply WRITE_ONCE(), here?
>
> That is, I'm thinking we qualify for point 3 (both a and b) of
> RCU_INIT_POINTER().

I don't think point (b) is a concern on any widely visible architecture.
After taking a quick skim through the users it does appear to me that
we almost definitely have changes to the task_struct since the last time
another cpu say that structure (3 a) and that we have cases where
reading stale values in the task_struct will result in incorrect
operation of the code.

The concern of point (b) is the old alpha caching case where you could
dereference a pointer and get a stale copy of the data structure.  This
is a concern when an you are following the pointer from another cpu.

From my quick skim the cases I can see where point (b) might apply are
in fair.c:task_numa_compare lots of fields in task_struct are read.  It
looks like reading a stale (old/wrong) value of cur->numa_group could be
very inexplicable and weird.  Similarly in the membarrier code reading a
pre-exec version of cur->mm could give completely inexplicable results.
Finally in rcuwait_wake_up reading a stale version of the process
cur->state could cause incorrect or missed wake ups in wake_up_process.


There might already be enough barriers in the scheduler that the barrier
in rcu_update_pointer is redundant.  The comment about membarrier at
least suggests that for processes that return to userspace we have a
full memory barrier.

So with a big fat comment explaining why it is safe we could potentially
use RCU_INIT_POINTER.  I currently don't see where the appropriate
barriers are so I can not write that comment or with a clear conscious
write the code to use RCU_INIT_POINTER instead of rcu_assign_pointer.

Eric

