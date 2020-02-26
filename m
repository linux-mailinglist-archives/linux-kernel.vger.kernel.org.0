Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE13F17081F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 19:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbgBZS4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 13:56:34 -0500
Received: from mail.efficios.com ([167.114.26.124]:34144 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbgBZS4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 13:56:34 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id ABF1F26E72A;
        Wed, 26 Feb 2020 13:56:32 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id MgB_hmMXI-gH; Wed, 26 Feb 2020 13:56:32 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3271126E729;
        Wed, 26 Feb 2020 13:56:32 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3271126E729
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1582743392;
        bh=AaWHMsVxqEO40R+7Obvkl70ZB66jfl+RHfB+BDzGT7w=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Th3O1dzzmbSYfm6YVypEDu0zMdd+kIoLzQfR8ssQUwZ9JLXAuLmkcl1723yYqnMNU
         QUxy7NpwEFrO5G4KfiuGnqofhayzKSaS4niWldrtNiM/lfmyba0/cZI8cUgY73uTD2
         WzlupplqNmZJPwBJkYrrVQAE0rayGzkrCiz+ox3rxPWe9wjGpaU+RxDyJOWMhraRU3
         HhDoZ7/e1A1dGWkNHOL5ybb6lpadXUXKyos+oNfKg3KERaKIm/Fdd/Kl6lcA5or4q8
         LdMrG015IKfqpa4Krz6wGOEfn94Dv9hD+WL8ySdWapNpsLjI6WIF+9EqrU61MOEWc2
         7YkQIudGvxWRg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VX874F4E7k9S; Wed, 26 Feb 2020 13:56:32 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 2413026E98D;
        Wed, 26 Feb 2020 13:56:32 -0500 (EST)
Date:   Wed, 26 Feb 2020 13:56:32 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Chris Kennelly <ckennelly@google.com>
Cc:     "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Paul Turner <pjt@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Carlos O'Donell <codonell@redhat.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Brian Geffon <bgeffon@google.com>
Message-ID: <982202794.8791.1582743392060.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAEE+ybkTs4U7h-Js818k1QEqpVfHwAHSTXaEwHs3g37LwOsjLQ@mail.gmail.com>
References: <1503467992.2999.1582234410317.JavaMail.zimbra@efficios.com> <20200221154923.GC194360@google.com> <1683022606.3452.1582301632640.JavaMail.zimbra@efficios.com> <CAEXW_YRT7AjaJs7mPyNd=J6fhBicYwGbQMK2Senwm3cBhFvWPw@mail.gmail.com> <CAEE+ybmQb02u-=c1sHozkJ+RXOi2Hno6qYJ0Vx9rOpKjSQ4fPQ@mail.gmail.com> <1089333712.8657.1582736509318.JavaMail.zimbra@efficios.com> <CAEE+ybkTs4U7h-Js818k1QEqpVfHwAHSTXaEwHs3g37LwOsjLQ@mail.gmail.com>
Subject: Re: Rseq registration: Google tcmalloc vs glibc
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3901 (ZimbraWebClient - FF72 (Linux)/8.8.15_GA_3895)
Thread-Topic: Rseq registration: Google tcmalloc vs glibc
Thread-Index: GYBVveEgq8jJE8V5NPTEaBBY3L1pYA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Feb 26, 2020, at 12:27 PM, Chris Kennelly ckennelly@google.com wrote:

> On Wed, Feb 26, 2020 at 12:01 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> ----- On Feb 25, 2020, at 10:38 PM, Chris Kennelly ckennelly@google.com wrote:
>>
>> > On Tue, Feb 25, 2020 at 10:25 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>> >>
>> >> On Fri, Feb 21, 2020 at 11:13 AM Mathieu Desnoyers
>> >> <mathieu.desnoyers@efficios.com> wrote:
>> >> >
>> >> > ----- On Feb 21, 2020, at 10:49 AM, Joel Fernandes, Google
>> >> > joel@joelfernandes.org wrote:
>> >> >
>> >> > [...]
>> >> > >>
>> >> > >> 3) Use the  __rseq_abi TLS cpu_id field to know whether Rseq has been
>> >> > >> registered.
>> >> > >>
>> >> > >> - Current protocol in the most recent glibc integration patch set.
>> >> > >> - Not supported yet by Linux kernel rseq selftests,
>> >> > >> - Not supported yet by tcmalloc,
>> >> > >>
>> >> > >> Use the per-thread state to figure out whether each thread need to register
>> >> > >> Rseq individually.
>> >> > >>
>> >> > >> Works for integration between a library which exists for the entire lifetime
>> >> > >> of the executable (e.g. glibc) and other libraries. However, it does not
>> >> > >> allow a set of libraries which are dlopen'd/dlclose'd to co-exist without
>> >> > >> having a library like glibc handling the registration present.
>> >> > >
>> >> > > Mathieu, could you share more details about why during dlopen/close
>> >> > > libraries we cannot use the same __rseq_abi TLS to detect that rseq was
>> >> > > registered?
>> >> >
>> >> > Sure,
>> >> >
>> >> > A library which is only loaded and never closed during the execution of the
>> >> > program can let the kernel implicitly unregister rseq at thread exit. For
>> >> > the dlopen/dlclose use-case, we need to be able to explicitly unregister
>> >> > each thread's __rseq_abi which sit in a library which is going to be
>> >> > dlclose'd.
>> >>
>> >> Mathieu, Thanks a lot for the explanation, it makes complete sense. It
>> >> sounds from Chris's reply that tcmalloc already checks
>> >> __rseq_abi.cpu_id and is not dlopened/closed. Considering these, it
>> >> seems to already handle things properly - CMIIW.
>> >
>> > I'll make a note about this, since we can probably benefit from some
>> > more comments about the assumptions/invariants the fastpath uses.
>>
>> I suspect the integration with glibc and with dlopen'd/dlclose'd libraries will
>> not
>> behave correctly with the current tcmalloc implementation.
>>
>> Based on the tcmalloc code-base, InitFastPerCpu is only called from IsFast. As
>> long
>> as this is the only expected caller, having IsFast comparing the RseqCpuId
>> detects
>> whether glibc (or some other library) has already registered rseq for the
>> current
>> thread.
>>
>> However, if the application chooses to invoke InitFastPerCpu() directly, things
>> become
>> expected, because it invokes:
>>
>>   absl::base_internal::LowLevelCallOnce(&init_per_cpu_once, InitPerCpu);
>>
>> which AFAIU invokes InitPerCpu once after execution of the current program.
>> Which
>> does:
>>
>> static bool InitThreadPerCpu() {
>>   if (__rseq_refcount++ > 0) {
>>     return true;
>>   }
>>
>>   auto ret = syscall(__NR_rseq, &__rseq_abi, sizeof(__rseq_abi), 0,
>>                      PERCPU_RSEQ_SIGNATURE);
>>   if (ret == 0) {
>>     return true;
>>   } else {
>>     __rseq_refcount--;
>>   }
>>
>>   return false;
>> }
>>
>> static void InitPerCpu() {
>>   // Based on the results of successfully initializing the first thread, mark
>>   // init_status to initialize all subsequent threads.
>>   if (InitThreadPerCpu()) {
>>     init_status = kFastMode;
>>   }
>> }
>>
>> In a scenario where glibc has already registered Rseq, the __rseq_refcount will
>> be incremented, the __NR_rseq syscall will fail with -1, errno=EBUSY, so the
>> refcount
>> will be immediately decremented and it will return false. Therefore,
>> "init_status" will
>> never be set fo kFastMode, leaving it in kSlowMode for the entire lifetime of
>> this
>> program. That being said, even though this state can come as a surprise, it
>> seems to
>> be entirely bypassed by the fast-paths IsFast() and IsFastNoInit(), so maybe it
>> won't
>> have any observable side-effects other than leaving init_status in a state that
>> does not
>> match reality.
> 
> I agree that this could potentially violate inviarants, but
> InitFastPerCpu is not intended to be called by the application.

OK, explicitly documenting this would be a good thing. In my own projects,
I prefix those symbols with double-underscores (__) to indicate that those
are not meant to be called by other means than the static inlines in the API.

There may be use-cases which justify exposing InitFastPerCpu as a public API for
applications though, especially for those which require some level of
real-time guarantees from the malloc/free APIs. I've run into this situation
with liburcu which I maintain.

> 
>> In the other use-case where tcmalloc co-exist with a dlopened/dlclosed library,
>> but glibc
>> does not provide Rseq registration, we run into issues as well if the dlopened
>> library
>> registers rseq first for a given thread. The IsFastNoInit() expects that if Rseq
>> has been
>> observed as registered in the past for a thread, it stays registered. However,
>> if a
>> dlclosed library unregisters Rseq, we need to be prepared to re-register it. So
>> either
>> tcmalloc needs to express its use of Rseq by incrementing __rseq_refcount even
>> when Rseq
>> is registered (this would hurt the fast-path however, and I would hate to have
>> to do this),
>> or tcmalloc needs to be able to handle the fact that Rseq may be unregistered by
>> a dlclosed
>> library which was the actual owner of the Rseq registration.
> 
> We have a bit of an opportunity to figure out whether this is the
> first time--from TCMalloc's perspective--a thread is doing per-CPU and
> bump the __rseq_count accordingly.  I think this could be done off of
> the fast path.

Is there an explicit tcmalloc API call that each thread need to do before starting
to use tcmalloc to allocate and free memory ? If not, you'll probably need to add
at least a load of __rseq_refcount (or some other TLS variable), test and conditional
branch on the fast-path, which is an additional cost I would ideally prefer to avoid.
Or do you have something else in mind ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
