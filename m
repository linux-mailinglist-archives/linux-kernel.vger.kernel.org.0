Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A210A6B08C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 22:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388766AbfGPUjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 16:39:42 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:42336 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728535AbfGPUjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 16:39:42 -0400
Received: from cpe-2606-a000-111b-405a-0-0-0-162e.dyn6.twc.com ([2606:a000:111b:405a::162e] helo=localhost)
        by smtp.tuxdriver.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.63)
        (envelope-from <nhorman@tuxdriver.com>)
        id 1hnUEb-00043d-LC; Tue, 16 Jul 2019 16:39:39 -0400
Date:   Tue, 16 Jul 2019 16:39:06 -0400
From:   Neil Horman <nhorman@tuxdriver.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, djuran@redhat.com,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH] x86: Add irq spillover warning
Message-ID: <20190716203906.GC1498@hmswarspite.think-freely.org>
References: <20190716135917.15525-1-nhorman@tuxdriver.com>
 <alpine.DEB.2.21.1907161735090.1767@nanos.tec.linutronix.de>
 <20190716160745.GB1498@hmswarspite.think-freely.org>
 <alpine.DEB.2.21.1907162100190.1767@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907162100190.1767@nanos.tec.linutronix.de>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 09:05:30PM +0200, Thomas Gleixner wrote:
> Neil,
> 
> On Tue, 16 Jul 2019, Neil Horman wrote:
> > On Tue, Jul 16, 2019 at 05:57:31PM +0200, Thomas Gleixner wrote:
> > > On Tue, 16 Jul 2019, Neil Horman wrote:
> > > > If a cpu has more than this number of interrupts affined to it, they
> > > > will spill over to other cpus, which potentially may be outside of their
> > > > affinity mask.
> > > 
> > > Spill over?
> > > 
> > > The kernel decides to pick a vector on a CPU outside of the affinity when
> > > it runs out of vectors on the CPUs in the affinity mask.
> > > 
> > Yes.
> > 
> > > Please explain issues technically correct.
> > > 
> > I don't know what you mean by this.  I explained it above, and you clearly
> > understood it.
> 
> It took me a while to grok it. Simply because I first thought it's some
> hardware issue. And of course after confusion settled I knew what it is,
> but just because I know that code like the back of my hand.
> 
> > > > Given that this might cause unexpected behavior on
> > > > performance sensitive systems, warn the user should this condition occur
> > > > so that corrective action can be taken
> > > 
> > > > @@ -244,6 +244,14 @@ __visible unsigned int __irq_entry do_IRQ(struct pt_regs *regs)
> > > 
> > > Why on earth warn in the interrupt delivery hotpath? Just because it's the
> > > place which really needs extra instructions and extra cache lines on
> > > performance sensitive systems, right?
> > > 
> > Because theres already a check of the same variety in do_IRQ, but if the
> > information is available outside the hotpath, I was unaware, and am happy to
> > update this patch to refelct that.
> 
> Which check are you referring to?
> 
This one:
if (desc != VECTOR_RETRIGGERED) {
                        pr_emerg_ratelimited("%s: %d.%d No irq handler for vector\n",
                                             __func__, smp_processor_id(),
                                             vector);
I figured it was already checking one condition, another wouldn't hurt too much,
but no worries, I'm redoing this in activate_reserved now.

Best
Neil

> Thanks,
> 
> 	tglx
> 
