Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBF797AB1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 15:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbfHUN0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 09:26:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55714 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbfHUNZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 09:25:59 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1i0Qcc-0004vS-8Y; Wed, 21 Aug 2019 15:25:54 +0200
Date:   Wed, 21 Aug 2019 15:25:54 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alexander Dahl <ada@thorsis.com>, linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.2.9-rt3
Message-ID: <20190821132553.gjvya5lu6j2dfyo5@linutronix.de>
References: <20190816153616.fbridfzjkmfg4dnr@linutronix.de>
 <2182739.9IRgZpf3R8@ada>
 <20190820154418.GM3545@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190820154418.GM3545@piout.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-20 17:44:18 [+0200], Alexandre Belloni wrote:
> Hi,
Hi,

> On 19/08/2019 13:03:51+0200, Alexander Dahl wrote:
> > Hei hei,
> > 
> > just tried to compile this v5.2.9-rt3 for SAMA5D27-SOM1-EK1 based on 
> > arch/arm/configs/sama5_defconfig and with running oldconfig and selecting 
> > defaults, but that fails if CONFIG_ATMEL_TCB_CLKSRC_USE_SLOW_CLOCK is not set. 
> > 
> > I think this is due to changes for Atmel TCLIB in v5.2 and the not yet adapted 
> > RT patch "clocksource: TCLIB: Allow higher clock rates for clock events", 
> > right?
> 
> Patch clocksource-tclib-allow-higher-clockrates.patch needs to be
> changed so:
> 
> ret = setup_clkevents(tc, best_divisor_idx);
> 
> becomes
> 
> ret = setup_clkevents(&tc, best_divisor_idx);
> 

I will fix that locally.

> Also, I would think clocksource-tclib-add-proper-depend.patch could be
> dropped. Instead, setup_clkevents should use atmel_tcb_divisors. It
> would then be necessary to move its declaration before the function.
> 
> Sebastian, can you take care of that or do you expect a patch? In the
> latter case, do you want a patch for the patch?

For the second part I would appreciate a patch. I can then drop
clocksource-tclib-add-proper-depend.patch if it is not an issue.

Sebastian
