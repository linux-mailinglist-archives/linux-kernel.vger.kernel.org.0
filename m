Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60B07B50BB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 16:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbfIQOuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 10:50:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42118 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbfIQOuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 10:50:39 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iAEoN-0008Sa-Pj; Tue, 17 Sep 2019 16:50:35 +0200
Date:   Tue, 17 Sep 2019 16:50:35 +0200
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
Message-ID: <20190917145035.l6egzthsdzp7aipe@linutronix.de>
References: <20190911165729.11178-1-swood@redhat.com>
 <20190911165729.11178-6-swood@redhat.com>
 <20190912221706.GC150506@google.com>
 <500cabaa80f250b974409ee4a4fca59bf2e24564.camel@redhat.com>
 <20190917100728.wnhdvmbbzzxolef4@linutronix.de>
 <26dbecfee2c02456ddfda3647df1bcd56d9cc520.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <26dbecfee2c02456ddfda3647df1bcd56d9cc520.camel@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-09-17 09:36:22 [-0500], Scott Wood wrote:
> > On non-RT you can (but should not) use the counter part of the function
> > in random order like:
> > 	local_bh_disable();
> > 	local_irq_disable();
> > 	local_bh_enable();
> > 	local_irq_enable();
> 
> Actually even non-RT will assert if you do local_bh_enable() with IRQs
> disabled -- but the other combinations do work, and are used some places via
> spinlocks.  If they are used via direct calls to preempt_disable() or
> local_irq_disable() (or via raw spinlocks), then that will not go away on RT
> and we'll have a problem.

lockdep_assert_irqs_enabled() is a nop with CONFIG_PROVE_LOCKING=N and
RT breaks either way. 

> > Since you _can_ use it in random order Paul wants to test that the
> > random use of those function does not break RCU in any way. Since they
> > can not be used on RT in random order it has been agreed that we keep
> > the test for !RT but disable it on RT.
> 
> For now, yes.  Long term it would be good to keep track of when
> preemption/irqs would be disabled on RT, even when running a non-RT debug
> kernel, and assert when bad things are done with it (assuming an RT-capable
> arch).  Besides detecting these fairly unusual patterns, it could also
> detect earlier the much more common problem of nesting a non-raw spinlock
> inside a raw spinlock or other RT-atomic context.

you will be surprised but we have patches for that. We need first get
rid of other "false positives" before plugging this in.

> -Scott

Sebastian
