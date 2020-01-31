Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13E4814F257
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 19:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgAaSn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 13:43:26 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60324 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgAaSn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 13:43:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=slwH4YBF+8XdLOEIEFAeY6Th3gu6ZlAMUAGcyNVOTFQ=; b=LR+NMSKhSXm99rkO+NKrNhoyX
        fqzoGbEslkDTEsm3f5yo8TSt5+femkI3FSPYROwUkvlZVGcfOGq4ESMJo+wn8ntieYOI/oB4r1opF
        9/lcH+TQqQtquw0juBsCRiVCRbRz/9cyetI8+7S6W/jOwO7tzFpPqbztlMgmKVUXVQ9Tk1fS/0sgM
        V+vTFSct+MiMeiEgZb3oczlUZHmqAtA2Gtrqi+729iicwQ22H5vKeSrjLQoxdS31CfTvpBNLI2+5Y
        GIxd84pnQ1Zd8BuoqnYUhPz5wB0A4xO8/3rh1IR9dr88JbGLqn3rJ9jrbnQubDvI/XbNBsIRPzjL8
        UbpLFaqeQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixbGF-0002oD-0G; Fri, 31 Jan 2020 18:43:23 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 90B97980E50; Fri, 31 Jan 2020 19:43:22 +0100 (CET)
Date:   Fri, 31 Jan 2020 19:43:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>
Subject: Re: Confused about hlist_unhashed_lockless()
Message-ID: <20200131184322.GA11457@worktop.programming.kicks-ass.net>
References: <20200131164308.GA5175@willie-the-truck>
 <CANn89i+CnezK81gZSLOy0w7MaZy0uT=xyxoKSTyZU3aMpzifOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89i+CnezK81gZSLOy0w7MaZy0uT=xyxoKSTyZU3aMpzifOA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 08:48:05AM -0800, Eric Dumazet wrote:
>     BUG: KCSAN: data-race in del_timer / detach_if_pending

> diff --git a/include/linux/timer.h b/include/linux/timer.h
> index 1e6650ed066d5d28251b0bd385fc37ef94c96532..0dc19a8c39c9e49a7cde3d34bfa4be8871cbc1c2
> 100644
> --- a/include/linux/timer.h
> +++ b/include/linux/timer.h
> @@ -164,7 +164,7 @@ static inline void destroy_timer_on_stack(struct
> timer_list *timer) { }
>   */
>  static inline int timer_pending(const struct timer_list * timer)
>  {
> - return timer->entry.pprev != NULL;
> + return !hlist_unhashed_lockless(&timer->entry);
>  }

That's just completely wrong.

Aside from any memory barrier issues that might or might not be there
(I'm waaaay to tired atm to tell), the above code is perfectly fine.

In fact, this is a KCSAN compiler infrastructure 'bug'.

Any load that is only compared to zero is immune to load-tearing issues.

The correct thing to do here is something like:

static inline int timer_pending(const struct timer_list *timer)
{
	/*
	 * KCSAN compiler infrastructure is insuffiently clever to
	 * realize that a 'load compared to zero' is immune to
	 * load-tearing.
	 */
	return data_race(timer->entry.pprev != NULL);
}
