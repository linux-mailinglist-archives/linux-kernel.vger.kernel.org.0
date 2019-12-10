Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF185118FD8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 19:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfLJSd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 13:33:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41586 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbfLJSd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 13:33:29 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iekJy-0007ko-Tq; Tue, 10 Dec 2019 19:33:19 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id D438D101165; Tue, 10 Dec 2019 19:33:17 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Problem with WARN_ON in mutex_trylock() and rxrpc
In-Reply-To: <20191205132212.GK2827@hirez.programming.kicks-ass.net>
References: <26229.1575547344@warthog.procyon.org.uk> <20191205132212.GK2827@hirez.programming.kicks-ass.net>
Date:   Tue, 10 Dec 2019 19:33:17 +0100
Message-ID: <87wob4hvyq.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

Peter Zijlstra <peterz@infradead.org> writes:
> On Thu, Dec 05, 2019 at 12:02:24PM +0000, David Howells wrote:
>> commit a0855d24fc22d49cdc25664fb224caee16998683 ("locking/mutex: Complain upon
>> mutex API misuse in IRQ contexts") is a bit of a problem for rxrpc, though
>> nothing that shouldn't be reasonably easy to solve, I think.
>> 
>> What happens is that rxrpc_new_incoming_call(), which is called in softirq
>> context, calls mutex_trylock() to prelock a new incoming call:
>> 
>> 	/* Lock the call to prevent rxrpc_kernel_send/recv_data() and
>> 	 * sendmsg()/recvmsg() inconveniently stealing the mutex once the
>> 	 * notification is generated.
>> 	 *
>> 	 * The BUG should never happen because the kernel should be well
>> 	 * behaved enough not to access the call before the first notification
>> 	 * event and userspace is prevented from doing so until the state is
>> 	 * appropriate.
>> 	 */
>> 	if (!mutex_trylock(&call->user_mutex))
>> 		BUG();
>> 
>> before publishing it.  This used to work fine, but now there are big splashy
>> warnings every time a new call comes in.
>> 
>> No one else can see the lock at this point, but I need to lock it so that
>> lockdep doesn't complain later.  However, I can't lock it in the preallocator
>> - again because that upsets lockdep.
>
> To recap the IRC discussion; the intended mutex semantics are such to
> allow Priority Inheritance. This means that the mutex must be locked and
> unlocked in the same (task) context. Otherwise there is no distinct
> owner to boost for contending mutex_lock() operations.
>
> Since (soft)irq context doesn't (necessarily) have a task context, these
> operations don't strictly make sense, and that is what the patch in
> question tries to WARN about.

Not only that. Acquiring something which is _NOT_ designed for non
thread context works by chance not by design. IOW it makes assumptions
about the underlying mutex implementation and any change to that which
actually assumes thread context will break that. So, no we don't want
I'm clever and can do that as the implementation allows, simply because
this is a blatant layering violation.

> As it happens, you do mutex_unlock() from the very same softirq context
> you do that mutex_trylock() in, so lockdep will never have had cause to
> complain, 'current' is the same at acquire and release.
>
> Now, either we're in non-preemptible softirq context and a contending
> mutex_lock() would spuriously boost a random task, which is harmless due
> to the non-preemptive nature of softirq, or we're running in ksoftirqd
> and that gets boosted, which actually makes some sense.
>
> For PREEMPT_RT (the only case that really matters, since that actually
> replaces struct mutex with rt_mutex) this would result in boosting
> whatever (soft)irq thread ended up running the thing.

Well, that'd "work". Actually in RT this makes even sense as the
contending waiter wants the owner out of the critical region ASAP>

> (Also, I'm not entire sure on the current softirq model for -RT)
>
> Is this something we want to allow?

I'm not a fan. See above.

Thanks,

        tglx
