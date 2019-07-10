Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA88E64C9C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 21:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbfGJTPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 15:15:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48450 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbfGJTPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 15:15:52 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hlI4D-00018u-BE; Wed, 10 Jul 2019 21:15:49 +0200
Date:   Wed, 10 Jul 2019 21:15:49 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, tglx@linutronix.de
Subject: Re: [PATCH] locking/mutex: Test for initialized mutex
Message-ID: <20190710191549.thhdy62uebawbuwh@linutronix.de>
References: <20190703092125.lsdf4gpsh2plhavb@linutronix.de>
 <20190710165053.cjt7qs7kx5fwu3d4@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190710165053.cjt7qs7kx5fwu3d4@willie-the-truck>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-07-10 17:50:54 [+0100], Will Deacon wrote:
> On Wed, Jul 03, 2019 at 11:21:26AM +0200, Sebastian Andrzej Siewior wrote:
> > An uninitialized/ zeroed mutex will go unnoticed because there is no
> > check for it. There is a magic check in the unlock's slowpath path which
> > might go unnoticed if the unlock happens in the fastpath.
> > 
> > Add a ->magic check early in the mutex_lock() and mutex_trylock() path.
> > 
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> > Nothing screamed during uninitialized usage of init_mm's context->lock
> >   https://git.kernel.org/tip/32232b350d7cd93cdc65fe5a453e6a40b539e9f9
> > 
> >  kernel/locking/mutex.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> > index 0c601ae072b3f..fb1f6f1e1cc61 100644
> > --- a/kernel/locking/mutex.c
> > +++ b/kernel/locking/mutex.c
> > @@ -908,6 +908,10 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
> >  
> >  	might_sleep();
> >  
> > +#ifdef CONFIG_DEBUG_MUTEXES
> > +	DEBUG_LOCKS_WARN_ON(lock->magic != lock);
> > +#endif
> 
> Why do we need to check this so early, or could we move it into
> debug_mutex_lock_common() instead?

debug_mutex_lock_common() is too late. A few lines later, before
"preempt_disable()" would be possible. After that, there is
__mutex_trylock() which would succeed so you don't catch the
uninitialized case. By the time you get to debug_mutex_lock_common() you
need contention and then acquire ->wait_lock which should complain about
missing magic.

> Will

Sebastian
