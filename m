Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 227731999E3
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 17:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730896AbgCaPhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 11:37:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727703AbgCaPhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 11:37:39 -0400
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BB6420848;
        Tue, 31 Mar 2020 15:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585669057;
        bh=ggMm14KxXbY1mqecFv6pjM06I08zLyhqEuowrT/NApQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mGxhCt07fuJo88YbZTobkEe3mxir9Y88c89S+a3IWrsUceux7kjcXqDx/3NZydT5G
         5vFmczVbdKf8IpGOlX3+Mm/NEAHVaIG0ejNjlPjvue8c4zRqmyOm0Q+d4Jj2hUanFA
         yd7KuK/Vq2D2O7Ll3dGhk4HpgSSLabTT2hKfbZuA=
Date:   Tue, 31 Mar 2020 17:37:35 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 6/9] lockdep: Introduce wait-type checks
Message-ID: <20200331153734.GA6979@lenoir>
References: <20200313174701.148376-1-bigeasy@linutronix.de>
 <20200313174701.148376-7-bigeasy@linutronix.de>
 <CAMuHMdU6s1F=DnaguZXrV4sWzEO-EqTaGQ=N7zyhgGq1M+Q1Ug@mail.gmail.com>
 <20200331145515.GR20730@hirez.programming.kicks-ass.net>
 <20200331152850.GI20760@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331152850.GI20760@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 05:28:50PM +0200, Peter Zijlstra wrote:
> On Tue, Mar 31, 2020 at 04:55:15PM +0200, Peter Zijlstra wrote:
> > On Tue, Mar 31, 2020 at 03:25:21PM +0200, Geert Uytterhoeven wrote:
> > > On arm64 (e.g. R-Car H3 ES2.0):
> > > 
> > > +=============================
> > > +[ BUG: Invalid wait context ]
> > > +5.6.0-salvator-x-09423-gb29514ba13a9c459-dirty #679 Not tainted
> > > +-----------------------------
> > > +swapper/5/0 is trying to lock:
> > > +ffffff86ff76f398 (&pool->lock){..-.}-{3:3}, at: __queue_work+0x134/0x430
> > > +other info that might help us debug this:
> > > +1 lock held by swapper/5/0:
> > > + #0: ffffffc01103a4a0 (rcu_read_lock){....}-{1:3}, at:
> > > rcu_lock_acquire.constprop.59+0x0/0x38
> > > +stack backtrace:
> > > +CPU: 5 PID: 0 Comm: swapper/5 Not tainted
> > > 5.6.0-salvator-x-09423-gb29514ba13a9c459-dirty #679
> > > +Hardware name: Renesas Salvator-X 2nd version board based on r8a77951 (DT)
> > > +Call trace:
> > > + dump_backtrace+0x0/0x180
> > > + show_stack+0x14/0x1c
> > > + dump_stack+0xdc/0x12c
> > > + __lock_acquire+0x37c/0xf9c
> > > + lock_acquire+0x258/0x288
> > > + _raw_spin_lock+0x34/0x48
> > > + __queue_work+0x134/0x430
> > > + queue_work_on+0x48/0x8c
> > > + timers_update_nohz+0x24/0x2c
> > > + tick_nohz_activate.isra.15.part.16+0x5c/0x80
> > > + tick_setup_sched_timer+0xe0/0xf0
> > > + hrtimer_run_queues+0x88/0xf8
> > 
> > So this is complaining that it cannot take pool->lock, which is
> > WAIT_CONFIG while holding RCU, which presents a WAIT_CONFIG context.
> > 
> > This seems to implicate something is amiss, because that should be
> > allowed. The thing it doesn't print is the context, which in the above
> > case is a (hrtimer) interrupt.
> > 
> > I suspect this really is a hardirq context and the next patch won't cure
> > things. It looks nohz (full?) related.
> > 
> > Frederic, can you untangle this?
> 
> Sebastian is right; I completely forgot the workqueue thing was still
> pending.
> 

Ok good, because I had no better answer :)
