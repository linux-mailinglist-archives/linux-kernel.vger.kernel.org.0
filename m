Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF22964DA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 17:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbfHTPoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 11:44:21 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:59791 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbfHTPoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 11:44:21 -0400
X-Originating-IP: 90.65.161.137
Received: from localhost (lfbn-1-1545-137.w90-65.abo.wanadoo.fr [90.65.161.137])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id BDB841BF207;
        Tue, 20 Aug 2019 15:44:18 +0000 (UTC)
Date:   Tue, 20 Aug 2019 17:44:18 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alexander Dahl <ada@thorsis.com>
Cc:     linux-rt-users@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.2.9-rt3
Message-ID: <20190820154418.GM3545@piout.net>
References: <20190816153616.fbridfzjkmfg4dnr@linutronix.de>
 <2182739.9IRgZpf3R8@ada>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2182739.9IRgZpf3R8@ada>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19/08/2019 13:03:51+0200, Alexander Dahl wrote:
> Hei hei,
> 
> just tried to compile this v5.2.9-rt3 for SAMA5D27-SOM1-EK1 based on 
> arch/arm/configs/sama5_defconfig and with running oldconfig and selecting 
> defaults, but that fails if CONFIG_ATMEL_TCB_CLKSRC_USE_SLOW_CLOCK is not set. 
> 
> I think this is due to changes for Atmel TCLIB in v5.2 and the not yet adapted 
> RT patch "clocksource: TCLIB: Allow higher clock rates for clock events", 
> right?

Patch clocksource-tclib-allow-higher-clockrates.patch needs to be
changed so:

ret = setup_clkevents(tc, best_divisor_idx);

becomes

ret = setup_clkevents(&tc, best_divisor_idx);


Also, I would think clocksource-tclib-add-proper-depend.patch could be
dropped. Instead, setup_clkevents should use atmel_tcb_divisors. It
would then be necessary to move its declaration before the function.

Sebastian, can you take care of that or do you expect a patch? In the
latter case, do you want a patch for the patch?

> 
> What's the recommended setting of this option for RT?
> 

Using the slow clock, will make the platform wakeup less frequently,
having a higher clock rate will give a better clockevent resolution.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
