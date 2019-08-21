Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88D8D97C75
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 16:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbfHUOVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 10:21:16 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:35115 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729508AbfHUOVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 10:21:12 -0400
X-Originating-IP: 86.207.98.53
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id C3576240011;
        Wed, 21 Aug 2019 14:21:10 +0000 (UTC)
Date:   Wed, 21 Aug 2019 16:21:10 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Alexander Dahl <ada@thorsis.com>, linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.2.9-rt3
Message-ID: <20190821142110.GC27031@piout.net>
References: <20190816153616.fbridfzjkmfg4dnr@linutronix.de>
 <2182739.9IRgZpf3R8@ada>
 <20190820154418.GM3545@piout.net>
 <20190821132553.gjvya5lu6j2dfyo5@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821132553.gjvya5lu6j2dfyo5@linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/2019 15:25:54+0200, Sebastian Andrzej Siewior wrote:
> On 2019-08-20 17:44:18 [+0200], Alexandre Belloni wrote:
> > Hi,
> Hi,
> 
> > On 19/08/2019 13:03:51+0200, Alexander Dahl wrote:
> > > Hei hei,
> > > 
> > > just tried to compile this v5.2.9-rt3 for SAMA5D27-SOM1-EK1 based on 
> > > arch/arm/configs/sama5_defconfig and with running oldconfig and selecting 
> > > defaults, but that fails if CONFIG_ATMEL_TCB_CLKSRC_USE_SLOW_CLOCK is not set. 
> > > 
> > > I think this is due to changes for Atmel TCLIB in v5.2 and the not yet adapted 
> > > RT patch "clocksource: TCLIB: Allow higher clock rates for clock events", 
> > > right?
> > 
> > Patch clocksource-tclib-allow-higher-clockrates.patch needs to be
> > changed so:
> > 
> > ret = setup_clkevents(tc, best_divisor_idx);
> > 
> > becomes
> > 
> > ret = setup_clkevents(&tc, best_divisor_idx);
> > 
> 
> I will fix that locally.
> 
> > Also, I would think clocksource-tclib-add-proper-depend.patch could be
> > dropped. Instead, setup_clkevents should use atmel_tcb_divisors. It
> > would then be necessary to move its declaration before the function.
> > 
> > Sebastian, can you take care of that or do you expect a patch? In the
> > latter case, do you want a patch for the patch?
> 
> For the second part I would appreciate a patch. I can then drop
> clocksource-tclib-add-proper-depend.patch if it is not an issue.
> 

I'm not sure it is worth it as the issue is introduced by
clocksource-tclib-allow-higher-clockrates.patch. Shouldn't we fix it
directly?

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
