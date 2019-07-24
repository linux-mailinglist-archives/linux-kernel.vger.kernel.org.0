Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57A93731AC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 16:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfGXOaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 10:30:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:58904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727243AbfGXOaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 10:30:17 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1131217F4;
        Wed, 24 Jul 2019 14:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563978616;
        bh=rIcPLNA+uDJDlrIUJ0agl7S6TInb6IGvxF9wZ4XeCak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JsWkt6Hxlk0pDJcWDr/0H2LinxuM0ErbKnt4XMSSV4DtD4yrYej2z5KTId4Fy+mxz
         r4DOpW4GiKfixBQtK+dlYRV4kfEoyYBJNwA9g4HggVqR3JoLImGHHk8y07T2mc5mAC
         bXDKmMhx2THOQXYgs0lYeyaOrfNv7ML8ZB61tAzE=
Date:   Wed, 24 Jul 2019 16:30:13 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        peterz@infradead.org
Subject: Re: How to turn scheduler tick on for current nohz_full CPU?
Message-ID: <20190724143012.GB1029@lenoir>
References: <20190724115331.GA29059@linux.ibm.com>
 <20190724132257.GA1029@lenoir>
 <20190724135219.GY14271@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724135219.GY14271@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 06:52:19AM -0700, Paul E. McKenney wrote:
> On Wed, Jul 24, 2019 at 03:22:59PM +0200, Frederic Weisbecker wrote:
> > On Wed, Jul 24, 2019 at 04:53:31AM -0700, Paul E. McKenney wrote:
> > > Hello!
> > > 
> > > One of the callback-invocation forward-progress issues turns out to
> > > be nohz_full CPUs not turning their scheduling-clock interrupt back on
> > > when running in kernel mode.  Given that callback floods can cause RCU's
> > > callback-invocation loop to run for some time, it would be good for this
> > > loop to re-enable this interrupt.  Of course, this problem applies to
> > > pretty much any kernel code that might loop for an extended time period,
> > > not just RCU.
> > > 
> > > I took a quick look at kernel/time/tick-sched.c and the closest thing
> > > I found was tick_nohz_full_kick_cpu(), except that (1) it isn't clear
> > > that this does much when invoked on the current CPU and (2) it doesn't
> > > help in rcutorture TREE04.  In contrast, disabling NO_HZ_FULL and using
> > > RCU_NOCB_CPU instead works quite well.
> > > 
> > > So what should I be calling instead of tick_nohz_full_kick_cpu() to
> > > re-enable the current CPU's scheduling-clock interrupt?
> > 
> > Indeed, kernel code is assumed to be quick enough (between two extended grace
> > periods) to avoid running the tick for RCU. But some long lasting kernel code
> > may require to tick temporarily.
> > 
> > You can use tick_nohz_dep_set_cpu(cpu, TICK_DEP_MASK_RCU) with the
> > following:
> > 
> > diff --git a/include/linux/tick.h b/include/linux/tick.h
> > index f92a10b5e112..3f476e2a4bf7 100644
> > --- a/include/linux/tick.h
> > +++ b/include/linux/tick.h
> > @@ -108,7 +108,8 @@ enum tick_dep_bits {
> >  	TICK_DEP_BIT_POSIX_TIMER	= 0,
> >  	TICK_DEP_BIT_PERF_EVENTS	= 1,
> >  	TICK_DEP_BIT_SCHED		= 2,
> > -	TICK_DEP_BIT_CLOCK_UNSTABLE	= 3
> > +	TICK_DEP_BIT_CLOCK_UNSTABLE	= 3,
> > +	TICK_DEP_BIT_RCU		= 4
> >  };
> >  
> >  #define TICK_DEP_MASK_NONE		0
> > @@ -116,6 +117,7 @@ enum tick_dep_bits {
> >  #define TICK_DEP_MASK_PERF_EVENTS	(1 << TICK_DEP_BIT_PERF_EVENTS)
> >  #define TICK_DEP_MASK_SCHED		(1 << TICK_DEP_BIT_SCHED)
> >  #define TICK_DEP_MASK_CLOCK_UNSTABLE	(1 << TICK_DEP_BIT_CLOCK_UNSTABLE)
> > +#define TICK_DEP_MASK_RCU		(1 << TICK_DEP_BIT_RCU)
> >  
> >  #ifdef CONFIG_NO_HZ_COMMON
> >  extern bool tick_nohz_enabled;
> 
> I will give this a try, thank you!  (Testing will take a few days.)

Sure!

For the background: expect a self-IPI to fire which then restart the tick on IRQ exit.
Once you're later done with the work, don't forget to remove the tick dependency:

     tick_nohz_dep_clear_cpu(cpu, TICK_DEP_MASK_RCU);


Thanks.
