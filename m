Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC5B15C280
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2019 20:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfGASB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 14:01:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41979 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfGASB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 14:01:27 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hi0cH-0006BF-7c; Mon, 01 Jul 2019 20:01:25 +0200
Date:   Mon, 1 Jul 2019 20:01:24 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [patch V2 2/6] genirq: Fix misleading synchronize_irq()
 documentation
In-Reply-To: <20190701145340.GB3402@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1907011959410.1802@nanos.tec.linutronix.de>
References: <20190628111148.828731433@linutronix.de> <20190628111440.189241552@linutronix.de> <20190701145340.GB3402@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jul 2019, Peter Zijlstra wrote:

> On Fri, Jun 28, 2019 at 01:11:50PM +0200, Thomas Gleixner wrote:
> > The function might sleep, so it cannot be called from interrupt
> > context. Not even with care.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > ---
> >  kernel/irq/manage.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > --- a/kernel/irq/manage.c
> > +++ b/kernel/irq/manage.c
> > @@ -96,7 +96,8 @@ EXPORT_SYMBOL(synchronize_hardirq);
> >   *	to complete before returning. If you use this function while
> >   *	holding a resource the IRQ handler may need you will deadlock.
> >   *
> > - *	This function may be called - with care - from IRQ context.
> > + *	Can only be called from preemptible code as it might sleep when
> > + *	an interrupt thread is associated to @irq.
> >   */
> >  void synchronize_irq(unsigned int irq)
> >  {
> 
> +	might_sleep();
> 
> ?

  ....

	wait_event()
	  might_sleep() ...

?

