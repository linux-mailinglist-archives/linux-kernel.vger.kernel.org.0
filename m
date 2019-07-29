Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F16BA789C7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 12:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387455AbfG2Kr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 06:47:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37922 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387413AbfG2Krz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 06:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Qklqaof7VmayvCqgxyeqIWUp4Ufy7CHaJ+JorFTqnjo=; b=fd191qBh6TvzNYMqEfFj14xXA
        3jqXNl+CPUzSl1/hKQ25x7zxZzyigWTbBuIq+gO8T8MmJ6CiQa2rtihR1Fvt8+7rHXuF2JISiq4nb
        j+g7GxArrR8cGnQ2LjL4t1jzY130nyGkvw5nuZtdz9a3kDGlE2IbPcQlhClC22vzcCKRu2e/2wqLb
        p98xy3O+gd4+NNtEQSpdnNr0cXt7wOGu7kGi+pEWnkM0D9MA/8tE4PI5el32QrLXfzJRJMSxo+Pxb
        rp9oberKn5txgAkW/Z/A7ztlmDkr74/Gb96/luYif3jgYEWD6IC/tOYfllP6h/DyXnd28irB64zfw
        F/FQN+hZw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hs3Bz-0006PN-FN; Mon, 29 Jul 2019 10:47:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BA5B320227078; Mon, 29 Jul 2019 12:47:45 +0200 (CEST)
Date:   Mon, 29 Jul 2019 12:47:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Guenter Roeck <linux@roeck-us.net>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>
Subject: Re: sched: Unexpected reschedule of offline CPU#2!
Message-ID: <20190729104745.GA31398@hirez.programming.kicks-ass.net>
References: <20190727164450.GA11726@roeck-us.net>
 <20190729093545.GV31381@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1907291156170.1791@nanos.tec.linutronix.de>
 <20190729101349.GX31381@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1907291235580.1791@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907291235580.1791@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 12:38:30PM +0200, Thomas Gleixner wrote:
> On Mon, 29 Jul 2019, Peter Zijlstra wrote:
> > On Mon, Jul 29, 2019 at 11:58:24AM +0200, Thomas Gleixner wrote:
> > > On Mon, 29 Jul 2019, Peter Zijlstra wrote:
> > > > On Sat, Jul 27, 2019 at 09:44:50AM -0700, Guenter Roeck wrote:
> > > > > [   61.348866] Call Trace:
> > > > > [   61.349392]  kick_ilb+0x90/0xa0
> > > > > [   61.349629]  trigger_load_balance+0xf0/0x5c0
> > > > > [   61.349859]  ? check_preempt_wakeup+0x1b0/0x1b0
> > > > > [   61.350057]  scheduler_tick+0xa7/0xd0
> > > > 
> > > > kick_ilb() iterates nohz.idle_cpus_mask to find itself an idle_cpu().
> > > > 
> > > > idle_cpus_mask() is set from nohz_balance_enter_idle() and cleared from
> > > > nohz_balance_exit_idle(). nohz_balance_enter_idle() is called from
> > > > __tick_nohz_idle_stop_tick() when entering nohz idle, this includes the
> > > > cpu_is_offline() clause of the idle loop.
> > > > 
> > > > However, when offline, cpu_active() should also be false, and this
> > > > function should no-op.
> > > 
> > > Ha. That reboot mess is not clearing cpu active as it's not going through
> > > the regular cpu hotplug path. It's using reboot IPI which 'stops' the cpus
> > > dead in their tracks after clearing cpu online....
> > 
> > $string-of-cock-compliant-curses
> > 
> > What a trainwreck...
> > 
> > So if it doesn't play by the normal rules; how does it expect to work?
> > 
> > So what do we do? 'Fix' reboot or extend the rules?
> 
> Reboot has two modes:
> 
>  - Regular reboot initiated from user space
> 
>  - Panic reboot
> 
> For the regular reboot we can make it go through proper hotplug, 

That seems sensible.

> for the panic case not so much.

It's panic, shit has already hit fan, one or two more pieces shouldn't
something anybody cares about.

