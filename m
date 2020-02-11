Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C99B15933D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 16:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgBKPfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 10:35:13 -0500
Received: from merlin.infradead.org ([205.233.59.134]:46326 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728891AbgBKPfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 10:35:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DkJ4O4HEaLCtdiUQDugfFLF48Xt0ZWH9KERNJAjjRPc=; b=a7Pi/QQqaoDuHxbuAkEn1FvSg0
        xVhFBK6idJV0lBXUwl3nfX2TADRuAptsKokrGV02Pa6iFWI2N11V8Ek3/PQ/WIbZCU3iuk/nPUHVG
        cWyTHSecmanx+qhHdarn94LsjJQtxCIe8qfi1OvPp7Y7NyU2zOV9W9bVj3f6c/DDmkjQmcN+An/ex
        OtkVc1vlIGc3w6w1Boq/GLd7C7n076KJ3z0Kxn2a/Bz+sdNWGx2M3PPVVHq1NT+BNmow1eNgg1/fi
        0DaW2gFQU+pXTcA/ZddhTI1QaO6XANjuRDfBG2XgysS3AEhCYnIINNRpu56o5wnobDfeuERlrb2N4
        RoMOORZw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1XYs-0006pz-T0; Tue, 11 Feb 2020 15:34:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4BB913013A4;
        Tue, 11 Feb 2020 16:33:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 18A632B91E725; Tue, 11 Feb 2020 16:34:52 +0100 (CET)
Date:   Tue, 11 Feb 2020 16:34:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH v2] tracing/perf: Move rcu_irq_enter/exit_irqson() to
 perf trace point hook
Message-ID: <20200211153452.GW14914@hirez.programming.kicks-ass.net>
References: <20200211095047.58ddf750@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211095047.58ddf750@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 09:50:47AM -0500, Steven Rostedt wrote:
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 455451d24b4a..0abbf5e2ee62 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -8941,6 +8941,7 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
>  {
>  	struct perf_sample_data data;
>  	struct perf_event *event;
> +	bool rcu_watching = rcu_is_watching();
>  
>  	struct perf_raw_record raw = {
>  		.frag = {
> @@ -8949,6 +8950,17 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
>  		},
>  	};
>  
> +	if (!rcu_watching) {
> +		/*
> +		 * If nmi_enter() is traced, it is possible that
> +		 * RCU may not be watching "yet", and this is called.
> +		 * We can not call rcu_irq_enter_irqson() in this case.
> +		 */
> +		if (unlikely(in_nmi()))
> +			goto out;

unless I'm mistaken, we can simply do rcu_nmi_enter() in this case, and
rcu_nmi_exit() on the other end.

> +		rcu_irq_enter_irqson();
> +	}
> +
>  	perf_sample_data_init(&data, 0, 0);
>  	data.raw = &raw;
>  
> @@ -8985,8 +8997,11 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
>  unlock:
>  		rcu_read_unlock();
>  	}
> -
> +	if (!rcu_watching)
> +		rcu_irq_exit_irqson();
> +out:
>  	perf_swevent_put_recursion_context(rctx);
> +
>  }
