Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12C489954D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 15:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389163AbfHVNj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 09:39:59 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44308 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387619AbfHVNj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 09:39:58 -0400
Received: by mail-pf1-f195.google.com with SMTP id c81so3980484pfc.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 06:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=laipNW3j2EKDk6tHY1/Qg9ASE0QU4QNK68diornVwyk=;
        b=gUzki5iQcgN9eKgKbYbwEB8ujk1xhGm5CJx3myOWdpRsvNssZS86hS00mL8Obyavbp
         TyHWu6O9657sPIiVnBEi9oMpybv3KDtXr/w+a9NDBmTE4VSzFaiY5Alt8iMP2PBlpKez
         6Hfr02E55lUb3udv2MO4mXWh3olSeuYL4hHPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=laipNW3j2EKDk6tHY1/Qg9ASE0QU4QNK68diornVwyk=;
        b=EC2+3DiE3Q9zz3csudgoS4klrpMtpDg6geui7R9UKHFkBZ9m5eSVIcXEAnuHHULaIE
         n0hNsK/O7UQIFOyQ+BCsksAbjjAgUoFPbkoK4sdWNQ57in/Fcxu96EjV2+d681ggaxvm
         hrfq2wFfE/NmunJeHXGA1f6h/YtzxtmlA1tyO83o8Y1YoEPcmin3IGetSsPf/wPilXvH
         a2xh/k2404EOdjhuB4wX014yjQ2kreDBkx/Y4ZzJsP4O7QKLLrH4d1rYgLF5HCLss2c4
         4ocEj0Vb20muPqKr3K0E8vBSEVyPm1+T1rmZpj6JDdcq1lTCPCMBaecQvh4UY6D7T7ad
         fXbg==
X-Gm-Message-State: APjAAAVFmMOoP3Z0STg+3tL8zsrYopHD53R4Esd8Rb6UD2LFENd5CJVU
        lJIb2bs1vNXVArUePojmV4l7jQ==
X-Google-Smtp-Source: APXvYqz0A3D27GjS3wXlB2R997d/+71Javbq9sAagNY3kGdGFnFrwr7sCE/uOmcn9Ws5ftJYwGWJiA==
X-Received: by 2002:a17:90a:342d:: with SMTP id o42mr5663380pjb.27.1566481197680;
        Thu, 22 Aug 2019 06:39:57 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id n185sm24733438pga.16.2019.08.22.06.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 06:39:56 -0700 (PDT)
Date:   Thu, 22 Aug 2019 09:39:55 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Scott Wood <swood@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT v2 1/3] rcu: Acquire RCU lock when disabling BHs
Message-ID: <20190822133955.GA29841@google.com>
References: <20190821231906.4224-1-swood@redhat.com>
 <20190821231906.4224-2-swood@redhat.com>
 <20190821233358.GU28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821233358.GU28441@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 04:33:58PM -0700, Paul E. McKenney wrote:
> On Wed, Aug 21, 2019 at 06:19:04PM -0500, Scott Wood wrote:
> > A plain local_bh_disable() is documented as creating an RCU critical
> > section, and (at least) rcutorture expects this to be the case.  However,
> > in_softirq() doesn't block a grace period on PREEMPT_RT, since RCU checks
> > preempt_count() directly.  Even if RCU were changed to check
> > in_softirq(), that wouldn't allow blocked BH disablers to be boosted.
> > 
> > Fix this by calling rcu_read_lock() from local_bh_disable(), and update
> > rcu_read_lock_bh_held() accordingly.
> 
> Cool!  Some questions and comments below.
> 
> 							Thanx, Paul
> 
> > Signed-off-by: Scott Wood <swood@redhat.com>
> > ---
> > Another question is whether non-raw spinlocks are intended to create an
> > RCU read-side critical section due to implicit preempt disable.
> 
> Hmmm...  Did non-raw spinlocks act like rcu_read_lock_sched()
> and rcu_read_unlock_sched() pairs in -rt prior to the RCU flavor
> consolidation?  If not, I don't see why they should do so after that
> consolidation in -rt.

May be I am missing something, but I didn't see the connection between
consolidation and this patch. AFAICS, this patch is so that
rcu_read_lock_bh_held() works at all on -rt. Did I badly miss something?

> >                                                                  If they
> > are, then we'd need to add rcu_read_lock() there as well since RT doesn't
> > disable preemption (and rcutorture should explicitly test with a
> > spinlock).  If not, the documentation should make that clear.
> 
> True enough!
> 
> >  include/linux/rcupdate.h |  4 ++++
> >  kernel/rcu/update.c      |  4 ++++
> >  kernel/softirq.c         | 12 +++++++++---
> >  3 files changed, 17 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > index 388ace315f32..d6e357378732 100644
> > --- a/include/linux/rcupdate.h
> > +++ b/include/linux/rcupdate.h
> > @@ -615,10 +615,12 @@ static inline void rcu_read_unlock(void)
> >  static inline void rcu_read_lock_bh(void)
> >  {
> >  	local_bh_disable();
> > +#ifndef CONFIG_PREEMPT_RT_FULL
> >  	__acquire(RCU_BH);
> >  	rcu_lock_acquire(&rcu_bh_lock_map);
> >  	RCU_LOCKDEP_WARN(!rcu_is_watching(),
> >  			 "rcu_read_lock_bh() used illegally while idle");
> > +#endif
> 
> Any chance of this using "if (!IS_ENABLED(CONFIG_PREEMPT_RT_FULL))"?
> We should be OK providing a do-nothing __maybe_unused rcu_bh_lock_map
> for lockdep-enabled -rt kernels, right?

Since this function is small, I prefer if -rt defines their own
rcu_read_lock_bh() which just does the local_bh_disable(). That would be way
cleaner IMO. IIRC, -rt does similar things for spinlocks, but it has been
sometime since I look at the -rt patchset.

> >  }
> >  
> >  /*
> > @@ -628,10 +630,12 @@ static inline void rcu_read_lock_bh(void)
> >   */
> >  static inline void rcu_read_unlock_bh(void)
> >  {
> > +#ifndef CONFIG_PREEMPT_RT_FULL
> >  	RCU_LOCKDEP_WARN(!rcu_is_watching(),
> >  			 "rcu_read_unlock_bh() used illegally while idle");
> >  	rcu_lock_release(&rcu_bh_lock_map);
> >  	__release(RCU_BH);
> > +#endif
> 
> Ditto.
> 
> >  	local_bh_enable();
> >  }
> >  
> > diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> > index 016c66a98292..a9cdf3d562bc 100644
> > --- a/kernel/rcu/update.c
> > +++ b/kernel/rcu/update.c
> > @@ -296,7 +296,11 @@ int rcu_read_lock_bh_held(void)
> >  		return 0;
> >  	if (!rcu_lockdep_current_cpu_online())
> >  		return 0;
> > +#ifdef CONFIG_PREEMPT_RT_FULL
> > +	return lock_is_held(&rcu_lock_map) || irqs_disabled();
> > +#else
> >  	return in_softirq() || irqs_disabled();
> > +#endif
> 
> And globally.

And could be untangled a bit as well:

if (irqs_disabled())
	return 1;

if (IS_ENABLED(CONFIG_PREEMPT_RT_FULL))
	return lock_is_held(&rcu_lock_map);

return in_softirq();

> >  }
> >  EXPORT_SYMBOL_GPL(rcu_read_lock_bh_held);
> >  
> > diff --git a/kernel/softirq.c b/kernel/softirq.c
> > index d16d080a74f7..6080c9328df1 100644
> > --- a/kernel/softirq.c
> > +++ b/kernel/softirq.c
> > @@ -115,8 +115,10 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
> >  	long soft_cnt;
> >  
> >  	WARN_ON_ONCE(in_irq());
> > -	if (!in_atomic())
> > +	if (!in_atomic()) {
> >  		local_lock(bh_lock);
> > +		rcu_read_lock();
> > +	}
> >  	soft_cnt = this_cpu_inc_return(softirq_counter);
> >  	WARN_ON_ONCE(soft_cnt == 0);
> >  	current->softirq_count += SOFTIRQ_DISABLE_OFFSET;
> > @@ -151,8 +153,10 @@ void _local_bh_enable(void)
> >  #endif
> >  
> >  	current->softirq_count -= SOFTIRQ_DISABLE_OFFSET;
> > -	if (!in_atomic())
> > +	if (!in_atomic()) {
> > +		rcu_read_unlock();
> >  		local_unlock(bh_lock);
> > +	}
> >  }
> >  
> >  void _local_bh_enable_rt(void)
> > @@ -185,8 +189,10 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
> >  	WARN_ON_ONCE(count < 0);
> >  	local_irq_enable();
> >  
> > -	if (!in_atomic())
> > +	if (!in_atomic()) {
> > +		rcu_read_unlock();
> >  		local_unlock(bh_lock);
> > +	}
> 
> The return from in_atomic() is guaranteed to be the same at
> local_bh_enable() time as was at the call to the corresponding
> local_bh_disable()?
> 
> I could have sworn that I ran afoul of this last year.  Might these
> added rcu_read_lock() and rcu_read_unlock() calls need to check for
> CONFIG_PREEMPT_RT_FULL?

Great point! I think they should be guarded but will let Scott answer that
one.

thanks,

 - Joel

