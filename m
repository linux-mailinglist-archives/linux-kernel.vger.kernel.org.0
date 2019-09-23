Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60CFCBBAC5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 19:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502185AbfIWRwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 13:52:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59263 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502167AbfIWRwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 13:52:42 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iCSVm-0002JR-Cu; Mon, 23 Sep 2019 19:52:34 +0200
Date:   Mon, 23 Sep 2019 19:52:33 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Scott Wood <swood@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT v3 3/5] sched: migrate_dis/enable: Use rt_invol_sleep
Message-ID: <20190923175233.yub32stn3xcwkaml@linutronix.de>
References: <20190911165729.11178-1-swood@redhat.com>
 <20190911165729.11178-4-swood@redhat.com>
 <20190917075943.qsaakyent4dxjkq4@linutronix.de>
 <779eddcc937941e65659a11b1867c6623a2c8890.camel@redhat.com>
 <404575720cf24765e66020f15ce75352f08a0ddb.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <404575720cf24765e66020f15ce75352f08a0ddb.camel@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-09-23 11:59:23 [-0500], Scott Wood wrote:
> On Tue, 2019-09-17 at 09:06 -0500, Scott Wood wrote:
> > On Tue, 2019-09-17 at 09:59 +0200, Sebastian Andrzej Siewior wrote:
> > > On 2019-09-11 17:57:27 [+0100], Scott Wood wrote:
> > > > diff --git a/kernel/cpu.c b/kernel/cpu.c
> > > > index 885a195dfbe0..32c6175b63b6 100644
> > > > --- a/kernel/cpu.c
> > > > +++ b/kernel/cpu.c
> > > > @@ -308,7 +308,9 @@ void pin_current_cpu(void)
> > > >  	preempt_lazy_enable();
> > > >  	preempt_enable();
> > > >  
> > > > +	rt_invol_sleep_inc();
> > > >  	__read_rt_lock(cpuhp_pin);
> > > > +	rt_invol_sleep_dec();
> > > >  
> > > >  	preempt_disable();
> > > >  	preempt_lazy_disable();
> > > 
> > > I understand the other one. But now looking at it, both end up in
> > > rt_spin_lock_slowlock_locked() which would be the proper place to do
> > > that annotation. Okay.
> > 
> > FWIW, if my lazy migrate patchset is accepted, then there will be no users
> > of __read_rt_lock() outside rwlock-rt.c and it'll be moot.
> 
> I missed the "both" -- which is the "other one" that ends up in
> rt_spin_lock_slowlock_locked()?  stop_one_cpu() doesn't...

That one used here:
 __read_rt_lock()
    -> rt_spin_lock_slowlock_locked()

The official one (including the write part):
 rt_read_lock() (annotation)
   -> do_read_rt_lock()
     -> __read_rt_lock()
       -> rt_spin_lock_slowlock_locked()


and the only missing to the party of sleeping locks is:
rt_spin_lock() (annotation)
  -> rt_spin_lock_slowlock()
    -> rt_spin_lock_slowlock_locked()

> -Scott

Sebastian
