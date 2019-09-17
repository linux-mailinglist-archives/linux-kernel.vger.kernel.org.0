Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19AB9B4B87
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 12:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfIQKHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 06:07:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41162 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfIQKHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 06:07:32 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iAAOO-0001K5-MJ; Tue, 17 Sep 2019 12:07:28 +0200
Date:   Tue, 17 Sep 2019 12:07:28 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Scott Wood <swood@redhat.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT v3 5/5] rcutorture: Avoid problematic critical section
 nesting on RT
Message-ID: <20190917100728.wnhdvmbbzzxolef4@linutronix.de>
References: <20190911165729.11178-1-swood@redhat.com>
 <20190911165729.11178-6-swood@redhat.com>
 <20190912221706.GC150506@google.com>
 <500cabaa80f250b974409ee4a4fca59bf2e24564.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <500cabaa80f250b974409ee4a4fca59bf2e24564.camel@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-09-16 11:55:57 [-0500], Scott Wood wrote:
> On Thu, 2019-09-12 at 18:17 -0400, Joel Fernandes wrote:
> > On Wed, Sep 11, 2019 at 05:57:29PM +0100, Scott Wood wrote:
> > > rcutorture was generating some nesting scenarios that are not
> > > reasonable.  Constrain the state selection to avoid them.
> > > 
> > > Example #1:
> > > 
> > > 1. preempt_disable()
> > > 2. local_bh_disable()
> > > 3. preempt_enable()
> > > 4. local_bh_enable()
> > > 
> > > On PREEMPT_RT, BH disabling takes a local lock only when called in
> > > non-atomic context.  Thus, atomic context must be retained until after
> > > BH
> > > is re-enabled.  Likewise, if BH is initially disabled in non-atomic
> > > context, it cannot be re-enabled in atomic context.
> > > 
> > > Example #2:
> > > 
> > > 1. rcu_read_lock()
> > > 2. local_irq_disable()
> > > 3. rcu_read_unlock()
> > > 4. local_irq_enable()
> > 
> > If I understand correctly, these examples are not unrealistic in the real
> > world unless RCU is used in the scheduler.
> 
> I hope you mean "not realistic", at least when it comes to explicit
> preempt/irq disabling rather than spinlock variants that don't disable
> preempt/irqs on PREEMPT_RT.

We have:
- local_irq_disable() (+save)
- spin_lock()
- local_bh_disable()
- preempt_disable()

On non-RT you can (but should not) use the counter part of the function
in random order like:
	local_bh_disable();
	local_irq_disable();
	local_bh_enable();
	local_irq_enable();

The non-RT will survive this. On RT the counterpart functions have to be
used in reverse order:
	local_bh_disable();
	local_irq_disable();
	local_irq_enable();
	local_bh_enable();

or the kernel will fall apart.

Since you _can_ use it in random order Paul wants to test that the
random use of those function does not break RCU in any way. Since they
can not be used on RT in random order it has been agreed that we keep
the test for !RT but disable it on RT.

> -Scott

Sebastian
