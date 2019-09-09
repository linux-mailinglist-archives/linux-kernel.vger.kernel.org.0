Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B03FAD8E3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2019 14:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391117AbfIIMWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Sep 2019 08:22:43 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:43504 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387764AbfIIMWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 08:22:42 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i7Ign-0008Hq-Ke; Mon, 09 Sep 2019 06:22:37 -0600
Received: from 110.8.30.213.rev.vodafone.pt ([213.30.8.110] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i7Igm-0007N3-IS; Mon, 09 Sep 2019 06:22:37 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>, mpe@ellerman.id.au
References: <878sr6t21a.fsf_-_@x220.int.ebiederm.org>
        <20190903074117.GX2369@hirez.programming.kicks-ass.net>
        <20190903074718.GT2386@hirez.programming.kicks-ass.net>
        <87k1apqqgk.fsf@x220.int.ebiederm.org>
        <CAHk-=wjVGLr8wArT9P4MXxA-XpkG=9ZXdjM3vpemSF25vYiLoA@mail.gmail.com>
        <874l1tp7st.fsf@x220.int.ebiederm.org>
        <CAHk-=wjvyRJEdativFqqGGxzSgWnc-m7b+B04iQBMcZV4uM=hA@mail.gmail.com>
        <20190903200603.GW2349@hirez.programming.kicks-ass.net>
        <20190903213218.GG4125@linux.ibm.com>
        <87r24umryu.fsf@x220.int.ebiederm.org>
        <20190906070736.GR2349@hirez.programming.kicks-ass.net>
Date:   Mon, 09 Sep 2019 07:22:15 -0500
In-Reply-To: <20190906070736.GR2349@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Fri, 6 Sep 2019 09:07:36 +0200")
Message-ID: <87woehek20.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1i7Igm-0007N3-IS;;;mid=<87woehek20.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=213.30.8.110;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/bF52xMyFrcOFMCqlnDxmlXqGLB0RSwN0=
X-SA-Exim-Connect-IP: 213.30.8.110
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TVD_RCVD_IP,T_TM2_M_HEADER_IN_MSG,XMNoVowels,
        XM_Body_Dirty_Words autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.5 XM_Body_Dirty_Words Contains a dirty word
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Peter Zijlstra <peterz@infradead.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 516 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.0 (0.6%), b_tie_ro: 2.1 (0.4%), parse: 1.20
        (0.2%), extract_message_metadata: 14 (2.7%), get_uri_detail_list: 4.0
        (0.8%), tests_pri_-1000: 12 (2.4%), tests_pri_-950: 1.10 (0.2%),
        tests_pri_-900: 0.87 (0.2%), tests_pri_-90: 29 (5.7%), check_bayes: 28
        (5.4%), b_tokenize: 8 (1.6%), b_tok_get_all: 10 (2.0%), b_comp_prob:
        2.7 (0.5%), b_tok_touch_all: 4.5 (0.9%), b_finish: 0.67 (0.1%),
        tests_pri_0: 444 (86.0%), check_dkim_signature: 0.42 (0.1%),
        check_dkim_adsp: 2.5 (0.5%), poll_dns_idle: 1.11 (0.2%), tests_pri_10:
        1.74 (0.3%), tests_pri_500: 5 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 2/3] task: RCU protect tasks on the runqueue
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Thu, Sep 05, 2019 at 03:02:49PM -0500, Eric W. Biederman wrote:
>> Paul, what is the purpose of the barrier in rcu_assign_pointer?
>> 
>> My intuition says it is the assignment half of rcu_dereference, and that
>> anything that rcu_dereference does not need is too strong.
>
> I see that Paul has also replied, but let me give another take on it.

I appreciate his reply as well.  I don't think he picked up that we
are talking about my change to do rcu_assign_pointer(rq->curr, next)
in schedule.

> RCU does *two* different but related things. It provide object
> consistency and it provides object lifetime management.
>
> Object consistency is provided by rcu_assign_pointer() /
> rcu_dereference:
>
>  - rcu_assign_pointer() is a PUBLISH operation, it is meant to expose an
> object to the world. In that respect it needs to ensure that all
> previous stores to this object are complete before it writes the
> pointer and exposes the object.
>
> To this purpose, rcu_assign_pointer() is an smp_store_release().
>
>  - rcu_dereference() is a CONSUME operation. It matches the PUBLISH from
> above and guarantees that any further loads/stores to the observed
> object come after.
>
> Naturally this would be an smp_load_acquire(), _HOWEVER_, since we need
> the address of the object in order to construct a load/store from/to
> said object, we can rely on the address-dependency to provide this
> barrier (except for Alpha, which is fscking weird). After all if you
> haven't completed the load of the (object) base address, you cannot
> compute the object member address and issue any subsequent memops, now
> can you ;-)

I follow and agree till here.

I was definitely confused ealier on which half of the rcu_assign_pointer()
rcu_dereference was important on most cpus.   As I currently understand
things, in a normal case we need a memory barrier between the assignment
of the data to a structure and the assignment of a pointer to that
structure to ensure there is an ordering between the pointer and
the data.

That memory barrier is usually provided by rcu_assign_pointer.

> Now the thing here is that the 'rq->curr = next' assignment does _NOT_
> expose the task (our object). The task is exposed the moment it enters
> the PID hash. It is this that sets us free of the PUBLISH requirement
> and thus we can use RCU_INIT_POINTER().

So I disagree about the PID hash here.  I don't think exposure is
necessarily the right concept to think this through.

> The object lifetime thing is provided by
> rcu_read_load()/rcu_read_unlock() on the one hand and
> synchronize_rcu()/call_rcu() on the other. That ensures that if you
> observe an object inside the RCU read side section, the object storage
> must stay valid.
>
> And it is *that* properpy we wish to make use of.

I absolutely agree that object lifetime is something we want to make use
of.

> Does this make sense to you?

Not completely.

Let me see if I can explain my confusion in terms of task_numa_compare.

The function task_numa_comare now does:

	rcu_read_lock();
	cur = rcu_dereference(dst_rq->curr);

Then it proceeds to examine a few fields of cur.

	cur->flags;
        cur->cpus_ptr;
        cur->numa_group;
        cur->numa_faults[];
        cur->total_numa_faults;
        cur->se.cfs_rq;

My concern here is the ordering between setting rq->curr and and setting
those other fields.  If we read values of those fields that were not
current when we set cur than I think task_numa_compare would give an
incorrect answer.

Now in __schedule the code does:

	rq_lock(rq, &rf);
        smp_mp__after_spinlock();

	...

	next = pick_next_task(rq, prev, &rf);

	if (prev != next) {
        	rq->nr_switches++
        	rq->curr = next; // rcu_assign_pointer(rq->curr, next);
        }

Which basically leads me back to Linus's analsysis where he pointed out
that it is the actions while the task is running before it calls
scheudle that in general cause the fields to be set.

Given that we have a full memory barrier for taking the previous task
off the cpu everything for the next task is guaranteed to be ordered
with the assignment to rq->curr except whatever fields pick_next_task()
decides to change.

From what I can see pick_next_task_fair does not mess with any of
the fields that task_numa_compare uses.  So the existing memory barrier
should be more than sufficient for that case.

So I think I just need to write up a patch 4/3 that replaces the my
"rcu_assign_pointer(rq->curr, next)" with "RCU_INIT_POINTER(rq->curr,
next)".  And includes a great big comment to that effect.



Now maybe I am wrong.  Maybe we can afford to see data that was changed
before the task became rq->curr in task_numa_compare.  But I don't think
so.  I really think it is that full memory barrier just a bit earlier
in __schedule that is keeping us safe.

Am I wrong?

Eric




