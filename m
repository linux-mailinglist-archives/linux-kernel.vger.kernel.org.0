Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2797D9EA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 01:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfD1XMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Apr 2019 19:12:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45126 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbfD1XMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 19:12:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2EA538830E;
        Sun, 28 Apr 2019 23:12:08 +0000 (UTC)
Received: from llong.remote.csb (ovpn-120-22.rdu2.redhat.com [10.10.120.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 98FEB608C2;
        Sun, 28 Apr 2019 23:12:06 +0000 (UTC)
Subject: Re: [PATCH-tip v7 00/20] locking/rwsem: Rwsem rearchitecture part 2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
References: <20190428212557.13482-1-longman@redhat.com>
 <CAHk-=whU83HbayBmOS-jbK7bQJUp87mvAYxhL=vz5wC_ARQCWA@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <3f8fd44d-1962-e309-49b5-bb16fd662312@redhat.com>
Date:   Sun, 28 Apr 2019 19:12:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=whU83HbayBmOS-jbK7bQJUp87mvAYxhL=vz5wC_ARQCWA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Sun, 28 Apr 2019 23:12:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/19 6:46 PM, Linus Torvalds wrote:
> This doesn't seem to be the full diff - looking at that patch 1 you
> seem to have taken my suggested list_cut_before() change too.
>
> I'm not against it (it does seem to be simpler and better), I just
> hope you double-checked it, since I kind of hand-waved it.
>
>                     Linus

I implemented your suggestion in patch 1 as it will produce simpler and
faster code. However, one of the changes in my patchset is to wake up
all the readers in the wait list. This means I have to jump over the
writers and wake up the readers behind them as well. See patch 11 for
details. As a result, I have to revert back to use list_add_tail() and
list_for_each_entry_safe() for the first pass. That is why the diff for
the whole patchset is just the below change. It is done on purpose, not
an omission.

Cheers,
Longman

>
> On Sun, Apr 28, 2019 at 2:26 PM Waiman Long <longman@redhat.com> wrote:
>>  v6=>v7 diff
>>  -----------
>> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
>> index 97a2334d9cd3..60783267b50d 100644
>> --- a/kernel/locking/rwsem.c
>> +++ b/kernel/locking/rwsem.c
>> @@ -693,7 +693,7 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
>>                 atomic_long_add(adjustment, &sem->count);
>>
>>         /* 2nd pass */
>> -       list_for_each_entry(waiter, &wlist, list) {
>> +       list_for_each_entry_safe(waiter, tmp, &wlist, list) {
>>                 struct task_struct *tsk;
>>
>>                 tsk = waiter->task;
>>

