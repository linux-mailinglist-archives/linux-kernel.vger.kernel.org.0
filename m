Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 155E4B3156
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2019 20:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfIOSZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Sep 2019 14:25:26 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:55844 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbfIOSZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 14:25:25 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i9ZD8-0006iw-SU; Sun, 15 Sep 2019 12:25:23 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i9ZD7-0001f2-TM; Sun, 15 Sep 2019 12:25:22 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
        Linus Torvalds <torvalds@linux-foundation.org>
References: <CAHk-=wiSFvb7djwa7D=-rVtnq3C5msh3u=CF7CVoU6hTJ=VdLw@mail.gmail.com>
        <20190830160957.GC2634@redhat.com>
        <CAHk-=wiZY53ac=mp8R0gjqyUd4ksD3tGHsUS9gvoHiJOT5_cEg@mail.gmail.com>
        <87o906wimo.fsf@x220.int.ebiederm.org>
        <20190902134003.GA14770@redhat.com>
        <87tv9uiq9r.fsf@x220.int.ebiederm.org>
        <CAHk-=wgm+JNNtFZYTBUZ_eEPzebZ0s=kSq1SS6ETr+K5v4uHwg@mail.gmail.com>
        <87k1aqt23r.fsf_-_@x220.int.ebiederm.org>
        <87muf7f4bf.fsf_-_@x220.int.ebiederm.org>
        <87ftkzdpjd.fsf_-_@x220.int.ebiederm.org>
        <20190915144129.GL30224@paulmck-ThinkPad-P72>
        <87ef0hcufl.fsf@x220.int.ebiederm.org>
Date:   Sun, 15 Sep 2019 13:25:02 -0500
In-Reply-To: <87ef0hcufl.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Sun, 15 Sep 2019 12:59:10 -0500")
Message-ID: <87v9tta03l.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1i9ZD7-0001f2-TM;;;mid=<87v9tta03l.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+M9W4LG1A1wAmEIw0ziB7E2T1GT98bHZ8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_XMDrugObfuBody_08 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;"Paul E. McKenney" <paulmck@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 430 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.5 (0.6%), b_tie_ro: 1.77 (0.4%), parse: 0.86
        (0.2%), extract_message_metadata: 11 (2.6%), get_uri_detail_list: 1.77
        (0.4%), tests_pri_-1000: 13 (3.0%), tests_pri_-950: 1.29 (0.3%),
        tests_pri_-900: 1.03 (0.2%), tests_pri_-90: 27 (6.3%), check_bayes: 25
        (5.9%), b_tokenize: 8 (1.9%), b_tok_get_all: 9 (2.0%), b_comp_prob:
        2.9 (0.7%), b_tok_touch_all: 3.1 (0.7%), b_finish: 0.76 (0.2%),
        tests_pri_0: 357 (83.0%), check_dkim_signature: 0.53 (0.1%),
        check_dkim_adsp: 2.3 (0.5%), poll_dns_idle: 0.61 (0.1%), tests_pri_10:
        2.4 (0.6%), tests_pri_500: 11 (2.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 4/4] task: RCUify the assignment of rq->curr
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> "Paul E. McKenney" <paulmck@kernel.org> writes:
>
>> So this looks good in and of itself, but I still do not see what prevents
>> the unfortunate sequence of events called out in my previous email.
>> On the other hand, if ->rcu and ->rcu_users were not allocated on top
>> of each other by a union, I would be happy to provide a Reviewed-by.
>>
>> And I am fundamentally distrusting of a refcount_dec_and_test() that
>> is immediately followed by code that clobbers the now-zero value.
>> Yes, this does have valid use cases, but it has a lot more invalid
>> use cases.  The valid use cases have excluded all increments somehow
>> else, so that the refcount_dec_and_test() call's only job is to
>> synchronize between concurrent calls to put_task_struct_rcu_user().
>> But I am not seeing the "excluded all increments somehow".
>>
>> So, what am I missing here?
>
> Probably only that the users of the task_struct in this sense are now
> quite mature.
>
> The two data structures that allow rcu access to the task_struct are
> the pid hash and the runqueue.    The practical problem is that they
> have two very different lifetimes.  So we need some kind of logic that
> let's us know when they are both done.  A recount does that job very
> well.
>
> Placing the recount on the same storage as the unused (at that point)
> rcu_head removes the need to be clever in other ways to avoid bloating
> the task_struct.
>
> If you really want a reference to the task_struct from rcu context you
> can just use get_task_struct.  Because until the grace period completes
> it is guaranteed that the task_struct has a positive count.
>
> Right now I can't imagine a use case for wanting to increase rcu_users
> anywhere or to decrease rcu_users except where we do.  If there is such
> a case most likely it will increase the reference count at
> initialization time.
>
> If anyone validly wants to increment rcu_users from an rcu critical
> section we can move it out of the union at that time.

Paul were you worrying about incrementing rcu_users because Frederic
Weisbecker brought the concept up earlier in the review?

It was his confusion that the point of rcu_users was so that it could
be incremented from an rcu critical section.  That definitely is not
the point of rcu_users.

If you were wondering about someone messing with rcu_users from an rcu
critical region independently that does suggest the code could use
a "comment saying don't do that!"  Multiple people getting confused
about the purpose of a reference count independently does suggest there
is a human factor problem in there somewhere.

Eric

