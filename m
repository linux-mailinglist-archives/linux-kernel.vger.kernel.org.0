Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0B037795
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 17:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbfFFPP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 11:15:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36828 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728797AbfFFPP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 11:15:26 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9EE6430F1BC7;
        Thu,  6 Jun 2019 15:15:25 +0000 (UTC)
Received: from amt.cnet (ovpn-112-18.gru2.redhat.com [10.97.112.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D4AC10ABD8D;
        Thu,  6 Jun 2019 15:15:01 +0000 (UTC)
Received: from amt.cnet (localhost [127.0.0.1])
        by amt.cnet (Postfix) with ESMTP id 0679E10514E;
        Thu,  6 Jun 2019 12:14:40 -0300 (BRT)
Received: (from marcelo@localhost)
        by amt.cnet (8.14.7/8.14.7/Submit) id x56FEaSG003248;
        Thu, 6 Jun 2019 12:14:36 -0300
Date:   Thu, 6 Jun 2019 12:14:35 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Haris Okanovic <haris.okanovic@ni.com>
Subject: Re: [patch 2/3] timers: do not raise softirq unconditionally
 (spinlockless version)
Message-ID: <20190606151433.GA3199@amt.cnet>
References: <20190415201213.600254019@amt.cnet>
 <20190415201429.427759476@amt.cnet>
 <20190604062931.GC15459@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604062931.GC15459@xz-x1>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 06 Jun 2019 15:15:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 02:29:31PM +0800, Peter Xu wrote:
> On Mon, Apr 15, 2019 at 05:12:15PM -0300, Marcelo Tosatti wrote:
> > Check base->pending_map locklessly and skip raising timer softirq 
> > if empty.
> > 
> > What allows the lockless (and potentially racy against mod_timer) 
> > check is that mod_timer will raise another timer softirq after
> > modifying base->pending_map.
> > 
> > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> > 
> > ---
> >  kernel/time/timer.c |   18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > Index: linux-rt-devel/kernel/time/timer.c
> > ===================================================================
> > --- linux-rt-devel.orig/kernel/time/timer.c	2019-04-15 14:21:02.788704354 -0300
> > +++ linux-rt-devel/kernel/time/timer.c	2019-04-15 14:22:56.755047354 -0300
> > @@ -1776,6 +1776,24 @@
> >  		if (time_before(jiffies, base->clk))
> >  			return;
> >  	}
> > +
> > +#ifdef CONFIG_PREEMPT_RT_FULL
> > +/* On RT, irq work runs from softirq */
> > +	if (irq_work_needs_cpu())
> > +		goto raise;
> > +#endif
> > +	base = this_cpu_ptr(&timer_bases[BASE_STD]);
> > +	if (!housekeeping_cpu(base->cpu, HK_FLAG_TIMER)) {
> > +		if (!bitmap_empty(base->pending_map, WHEEL_SIZE))
> > +			goto raise;
> > +		base++;
> 
> Shall we check against CONFIG_NO_HZ_COMMON?  Otherwise the base could
> point to something else rather tha the deferred base (NR_BASES==1 if
> without nohz-common).
> 
> I see that run_local_timers() has similar pattern, actually I'm
> thinking whether we can put things like "base++" to be inside some
> "if"s of CONFIG_NO_HZ_COMMON to be clear.
> 
> Thanks,
> 
> -- 
> Peter Xu

Hi Peter,

Yes, that is a good point and needs fixing. 

I'll wait for Anna's comments before posting -v2.

