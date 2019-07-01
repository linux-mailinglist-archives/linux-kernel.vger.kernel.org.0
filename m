Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA64F1C5BB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 11:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfENJM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 05:12:27 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:33246 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfENJM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 05:12:26 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hQTTv-00074b-Ee; Tue, 14 May 2019 11:12:19 +0200
Date:   Tue, 14 May 2019 11:12:19 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     minyard@acm.org, linux-rt-users@vger.kernel.org,
        Corey Minyard <cminyard@mvista.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH RT v2] Fix a lockup in wait_for_completion() and friends
Message-ID: <20190514091219.nesriqe7qplk3476@linutronix.de>
References: <20190508205728.25557-1-minyard@acm.org>
 <20190509161925.kul66w54wpjcinuc@linutronix.de>
 <20190514084356.GJ2589@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190514084356.GJ2589@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-05-14 10:43:56 [+0200], Peter Zijlstra wrote:
> Now.. that will fix it, but I think it is also wrong.
> 
> The problem being that it violates FIFO, something that might be more
> important on -RT than elsewhere.

Wouldn't -RT be more about waking the task with the highest priority
instead the one that waited the longest?

> The regular wait API seems confused/inconsistent when it uses
> autoremove_wake_function and default_wake_function, which doesn't help,
> but we can easily support this with swait -- the problematic thing is
> the custom wake functions, we musn't do that.
> 
> (also, mingo went and renamed a whole bunch of wait_* crap and didn't do
> the same to swait_ so now its named all different :/)
> 
> Something like the below perhaps.

This still violates FIFO because a task can do wait_for_completion(),
not enqueue itself on the list because it noticed a pending wake and
leave. The list order is preserved, we have that.
But this a completion list. We have probably multiple worker waiting for
something to do so all of those should be of equal priority, maybe one
for each core or so. So it shouldn't matter which one we wake up.

Corey, would it make any change which waiter is going to be woken up?

Sebastian
