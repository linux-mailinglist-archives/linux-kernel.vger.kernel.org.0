Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 735821142F0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 15:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbfLEOsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 09:48:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:50260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729187AbfLEOsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 09:48:07 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B15C21835;
        Thu,  5 Dec 2019 14:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575557285;
        bh=2v3R2r3WGK80Qxoxn6zdzaPTA5QkronQaXxmH6Y6GE0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=y5RbRcBwA5K6Fy+zLTpyhQivC7rtJQydoY/RJd8cfSLBLdXOTUE3XZw+Dr6VQeejz
         5b/iUayYR9U7B3++QBhH7q+AyDUONa/xSDDbgjsIwmwWOeMOohniorfQ6K7hVcpWfy
         f8M7wvo5gfzSOjrMHIzlrybGJ1/EOhLzHV0ME8w0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 66D6635202C9; Thu,  5 Dec 2019 06:48:05 -0800 (PST)
Date:   Thu, 5 Dec 2019 06:48:05 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tejun Heo <tj@kernel.org>, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Workqueues splat due to ending up on wrong CPU
Message-ID: <20191205144805.GR2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191126220533.GU2889@paulmck-ThinkPad-P72>
 <20191127155027.GA15170@paulmck-ThinkPad-P72>
 <20191128161823.GA24667@paulmck-ThinkPad-P72>
 <20191129155850.GA17002@paulmck-ThinkPad-P72>
 <20191202015548.GA13391@paulmck-ThinkPad-P72>
 <20191202201338.GH16681@devbig004.ftw2.facebook.com>
 <20191203095521.GH2827@hirez.programming.kicks-ass.net>
 <20191204201150.GA14040@paulmck-ThinkPad-P72>
 <20191205102928.GG2810@hirez.programming.kicks-ass.net>
 <20191205103213.GB2871@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205103213.GB2871@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 11:32:13AM +0100, Peter Zijlstra wrote:
> On Thu, Dec 05, 2019 at 11:29:28AM +0100, Peter Zijlstra wrote:
> > On Wed, Dec 04, 2019 at 12:11:50PM -0800, Paul E. McKenney wrote:
> > 
> > > And the good news is that I didn't see the workqueue splat, though my
> > > best guess is that I had about a 13% chance of not seeing it due to
> > > random chance (and I am currently trying an idea that I hope will make
> > > it more probable).  But I did get a couple of new complaints about RCU
> > > being used illegally from an offline CPU.  Splats below.
> > 
> > Shiny!

And my attempt to speed things up did succeed, but the success was limited
to finding more places where rcutorture chokes on CPUs being slow to boot.
Fixing those and trying again...

> > > Your patch did rearrange the CPU-online sequence, so let's see if I
> > > can piece things together...
> > > 
> > > RCU considers a CPU to be online at rcu_cpu_starting() time.  This is
> > > called from notify_cpu_starting(), which is called from the arch-specific
> > > CPU-bringup code.  Any RCU readers before rcu_cpu_starting() will trigger
> > > the warning I am seeing.
> > 
> > Right.
> > 
> > > The original location of the stop_machine_unpark() was in
> > > bringup_wait_for_ap(), which is called from bringup_cpu(), which is in
> > > the CPUHP_BRINGUP_CPU entry of cpuhp_hp_states[].  Which, if I am not
> > > too confused, is invoked by some CPU other than the to-be-incoming CPU.
> > 
> > Correct.
> > 
> > > The new location of the stop_machine_unpark() is in cpuhp_online_idle(),
> > > which is called from cpu_startup_entry(), which is invoked from
> > > the arch-specific bringup code that runs on the incoming CPU.
> > 
> > The new place is the final piece of bringup, it is right before where
> > the freshly woken CPU will drop into the idle loop and start scheduling
> > (for the first time).
> > 
> > > Which
> > > is the same code that invokes notify_cpu_starting(), so we need
> > > notify_cpu_starting() to be invoked before cpu_startup_entry().
> > 
> > Right, that is right before we run what used to be the CPU_STARTING
> > notifiers. This is in fact (on x86) before the CPU is marked
> > cpu_online(). It has to be before cpu_startup_entry(), before this is
> > ran with IRQs disabled, while cpu_startup_entry() demands IRQs are
> > enabled.
> > 
> > > The order is not immediately obvious on IA64.  But it looks like
> > > everything else does it in the required order, so I am a bit confused
> > > about this.
> > 
> > That makes two of us, afaict we have RCU up and running when we get to
> > the idle loop.
> 
> Or did we need rcutree_online_cpu() to have ran? Because that is ran
> much later than this...

No, rcu_cpu_starting() does the trick.  So I remain confused.

My thought is to add some printk()s or tracing to rcu_cpu_starting()
and its counterpart, rcu_report_dead().  But is there a better way?

							Thanx, Paul
