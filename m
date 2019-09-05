Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEE95AACAE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 22:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731552AbfIEUDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 16:03:15 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:49198 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbfIEUDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 16:03:15 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i5xyH-0001xb-MB; Thu, 05 Sep 2019 14:03:10 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i5xyG-0007jz-QM; Thu, 05 Sep 2019 14:03:09 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
References: <CAHk-=wgm+JNNtFZYTBUZ_eEPzebZ0s=kSq1SS6ETr+K5v4uHwg@mail.gmail.com>
        <87k1aqt23r.fsf_-_@x220.int.ebiederm.org>
        <878sr6t21a.fsf_-_@x220.int.ebiederm.org>
        <20190903074117.GX2369@hirez.programming.kicks-ass.net>
        <20190903074718.GT2386@hirez.programming.kicks-ass.net>
        <87k1apqqgk.fsf@x220.int.ebiederm.org>
        <CAHk-=wjVGLr8wArT9P4MXxA-XpkG=9ZXdjM3vpemSF25vYiLoA@mail.gmail.com>
        <874l1tp7st.fsf@x220.int.ebiederm.org>
        <CAHk-=wjvyRJEdativFqqGGxzSgWnc-m7b+B04iQBMcZV4uM=hA@mail.gmail.com>
        <20190903200603.GW2349@hirez.programming.kicks-ass.net>
        <20190903213218.GG4125@linux.ibm.com>
Date:   Thu, 05 Sep 2019 15:02:49 -0500
In-Reply-To: <20190903213218.GG4125@linux.ibm.com> (Paul E. McKenney's message
        of "Tue, 3 Sep 2019 14:32:18 -0700")
Message-ID: <87r24umryu.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1i5xyG-0007jz-QM;;;mid=<87r24umryu.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+VmoE5LIizasbxQiu3HicjHrn61hokgnc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
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
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;"Paul E. McKenney" <paulmck@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 435 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.5 (0.6%), b_tie_ro: 1.81 (0.4%), parse: 0.66
        (0.2%), extract_message_metadata: 3.4 (0.8%), get_uri_detail_list: 2.1
        (0.5%), tests_pri_-1000: 3.3 (0.8%), tests_pri_-950: 1.09 (0.3%),
        tests_pri_-900: 0.87 (0.2%), tests_pri_-90: 27 (6.3%), check_bayes: 26
        (6.0%), b_tokenize: 8 (1.8%), b_tok_get_all: 10 (2.3%), b_comp_prob:
        2.4 (0.6%), b_tok_touch_all: 3.9 (0.9%), b_finish: 0.68 (0.2%),
        tests_pri_0: 383 (88.0%), check_dkim_signature: 0.39 (0.1%),
        check_dkim_adsp: 2.3 (0.5%), poll_dns_idle: 0.85 (0.2%), tests_pri_10:
        1.75 (0.4%), tests_pri_500: 4.8 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 2/3] task: RCU protect tasks on the runqueue
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" <paulmck@kernel.org> writes:

> On Tue, Sep 03, 2019 at 10:06:03PM +0200, Peter Zijlstra wrote:
>> On Tue, Sep 03, 2019 at 12:18:47PM -0700, Linus Torvalds wrote:
>> > Now, if you can point to some particular field where that ordering
>> > makes sense for the particular case of "make it active on the
>> > runqueue" vs "look up the task from the runqueue using RCU", then I do
>> > think that the whole release->acquire consistency makes sense.
>> > 
>> > But it's not clear that such a field exists, particularly when this is
>> > in no way the *common* way to even get a task pointer, and other paths
>> > do *not* use the runqueue as the serialization point.
>> 
>> Even if we could find a case (and I'm not seeing one in a hurry), I
>> would try really hard to avoid adding extra barriers here and instead
>> make the consumer a little more complicated if at all possible.
>> 
>> The Power folks got rid of a SYNC (yes, more expensive than LWSYNC) from
>> their __switch_to() implementation and that had a measurable impact.
>> 
>> 9145effd626d ("powerpc/64: Drop explicit hwsync in context switch")
>
> The patch [1] looks good to me.  And yes, if the structure pointed to by
> the second argument of rcu_assign_pointer() is already visible to readers,
> it is OK to instead use RCU_INIT_POINTER().  Yes, this loses ordering.
> But weren't these simple assignments before RCU got involved?
>
> As a very rough rule of thumb, LWSYNC is about twice as fast as SYNC.
> (Depends on workload, exact details of the hardware, timing, phase of
> the moon, you name it.)  So removing the LWSYNC is likely to provide
> measureable benefit, but I must defer to the powerpc maintainers.
> To that end, I added Michael on CC.
>
> [1] https://lore.kernel.org/lkml/878sr6t21a.fsf_-_@x220.int.ebiederm.org/

Paul, what is the purpose of the barrier in rcu_assign_pointer?

My intuition says it is the assignment half of rcu_dereference, and that
anything that rcu_dereference does not need is too strong.

My basic understanding is that only alpha ever has the memory ordering
issue that rcu_dereference deals with.  So I am a bit surprised that
this is anything other than a noop for anything except alpha.

In my patch I used rcu_assign_pointer because that is the canonically
correct way to do things.  Peter makes a good case that adding an extra
barrier in ___schedule could be detrimental to system performance.
At the same time if there is a correctness issue on alpha that we have
been overlooking because of low testing volume on alpha I don't want to
just let this slide and have very subtle bugs.

The practical concern is that people have been really wanting to do
lockless and rcu operations on tasks in the runqueue for a while and
there are several very clever pieces of code doing that now.  By
changing the location of the rcu put I am trying to make these uses
ordinary rcu uses.

The uses in question are the pieces of code I update in:
https://lore.kernel.org/lkml/8736het20c.fsf_-_@x220.int.ebiederm.org/

In short.  Why is rcu_assign_pointer() more than WRITE_ONCE() on
anything but alpha?  Do other architectures need more?  Is the trade off
worth it if we avoid using rcu_assign_pointer on performance critical
paths.

Eric

p.s. I am being slow at working through all of this as I am dealing
     with my young baby son, and busy packing for the conference.

     I might not be able to get back to this discussion until after
     I have landed in Lisbon on Saturday night.
