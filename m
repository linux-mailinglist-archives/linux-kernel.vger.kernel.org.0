Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6FB12DEDE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 15:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfE2NvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 09:51:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41142 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfE2NvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:51:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IpEYYRtOcuoBCe0NJPft5Tkz/UAzt+RuLMsB2MN2GaE=; b=H0/es3dSmh57wK1K3O8+kBAg3
        ChXfTK85OzhoOPfgTevzcNUrAqF6pQpqmybER+BZc+AVcUbvYZpA8jiqqYbcgy/Ixvs/EXzVCBKuL
        gWbl33SyM+tWo/GpkuFb9/pJWPfbVYxYvZE5dyEpx6SY+BfMCidVAlyRjZf1/htQPJ20px3gEuHzd
        PNI6EPxn01Ft3nIv//XLyAPLpH2i8bxEJ3lkzj3fLxr4KeLindTwHAFIl6fUh+VnkWSIb6DURsTEa
        N1IRGMF+BF96BbGkldDqaqslVHn8XV2FOcH4RYBCSvu4OxxuhWfMzGibLOdXGqBwD3jU8iQtW+k8Z
        LQ1T6AKBQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVyxf-0004uF-Rj; Wed, 29 May 2019 13:49:48 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2EC04201CF1B6; Wed, 29 May 2019 15:49:46 +0200 (CEST)
Date:   Wed, 29 May 2019 15:49:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org, williams@redhat.com,
        daniel@bristot.me, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Subject: Re: [RFC 2/3] preempt_tracer: Disable IRQ while starting/stopping
 due to a preempt_counter change
Message-ID: <20190529134946.GY2623@hirez.programming.kicks-ass.net>
References: <cover.1559051152.git.bristot@redhat.com>
 <f2ca7336162b6dc45f413cfe4e0056e6aa32e7ed.1559051152.git.bristot@redhat.com>
 <20190529083357.GF2623@hirez.programming.kicks-ass.net>
 <b47631c3-d65a-4506-098a-355c8cf50601@redhat.com>
 <20190529102038.GO2623@hirez.programming.kicks-ass.net>
 <20190529083930.5541130e@oasis.local.home>
 <20190529131957.GV2623@hirez.programming.kicks-ass.net>
 <20190529094213.3e344965@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529094213.3e344965@oasis.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 09:42:13AM -0400, Steven Rostedt wrote:
> > And the preempt_irqoff tracer had better also consume the IRQ events,
> > and if it does that it can DTRT without extra bits on, even with that
> > race.
> > 
> > Consider:
> > 
> > 	preempt_disable()
> > 	  preempt_count += 1;
> > 	  <IRQ>
> > 	    trace_irq_enter();
> > 
> > 	    trace_irq_exit();
> > 	  </IRQ>
> > 	  trace_preempt_disable();
> > 
> > 	/* does stuff */
> > 
> > 	preempt_enable()
> > 	  preempt_count -= 1;
> > 	  trace_preempt_enable();
> > 
> > You're saying preempt_irqoff() fails to connect the two because of the
> > hole between trace_irq_exit() and trace_preempt_disable() ?
> > 
> > But trace_irq_exit() can see the raised preempt_count and set state
> > for trace_preempt_disable() to connect.
> 
> That's basically what I was suggesting as the solution to this ;-)

You were wanting changes to preempt_disable() and task_struct, neither
of which is required. The above only needs some per-cpu storage in the
tracer implementation.
