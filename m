Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDFE5BEC0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2019 16:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729904AbfGAOxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 10:53:45 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35946 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbfGAOxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 10:53:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AzAObMLhgIAN7TtItfsf2xFqs7oc6ydaRdn60wfX0pQ=; b=kVu6XHBfiekyeSau+zoOK7AFg
        7l9gOGg4X1eevMDcVQs91JelMMH4SNZbEmCq48XHabxYZBrYEM5R9eg2mtK6SsSsfadcC6xvCA/ko
        Wk+XfU51IkFvtha8ND9ygt8FP0xIqmM//EIfCzlVYKR9S4Afc7leMXB/ldlThWv2Wl3A0kNKju166
        qkX8Yj8UCIU8ypqwe1V8L9MrOnmh9g73PgVN9EqK+bjNW9MSVeck8OmRcvmxaTxQdyps0lBooHKHQ
        Ug3eqZdBln4cVEa4/FmSL5ufg9mG9X/1NbftZzy2r1y85dA3jChzgHxcPoFEsnGXpLRvMArPmD6LZ
        52y8YNTbw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hhxgb-0000D1-QH; Mon, 01 Jul 2019 14:53:42 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 44FE6201F98F5; Mon,  1 Jul 2019 16:53:40 +0200 (CEST)
Date:   Mon, 1 Jul 2019 16:53:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [patch V2 2/6] genirq: Fix misleading synchronize_irq()
 documentation
Message-ID: <20190701145340.GB3402@hirez.programming.kicks-ass.net>
References: <20190628111148.828731433@linutronix.de>
 <20190628111440.189241552@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628111440.189241552@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 01:11:50PM +0200, Thomas Gleixner wrote:
> The function might sleep, so it cannot be called from interrupt
> context. Not even with care.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/irq/manage.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -96,7 +96,8 @@ EXPORT_SYMBOL(synchronize_hardirq);
>   *	to complete before returning. If you use this function while
>   *	holding a resource the IRQ handler may need you will deadlock.
>   *
> - *	This function may be called - with care - from IRQ context.
> + *	Can only be called from preemptible code as it might sleep when
> + *	an interrupt thread is associated to @irq.
>   */
>  void synchronize_irq(unsigned int irq)
>  {

+	might_sleep();

?
