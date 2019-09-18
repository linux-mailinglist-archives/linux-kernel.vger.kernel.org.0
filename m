Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22486B5DCF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 09:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbfIRHMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 03:12:16 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42495 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfIRHMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 03:12:15 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iAU8A-0006lM-5z; Wed, 18 Sep 2019 09:12:02 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iAU86-0004ei-Uk; Wed, 18 Sep 2019 09:11:58 +0200
Date:   Wed, 18 Sep 2019 09:11:58 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Regression in dbdda842fe96 ("printk: Add console owner and waiter
 logic to load balance console writes") [Was: Regression in fd5f7cde1b85
 ("...")]
Message-ID: <20190918071158.rtw45jch2roa2wum@pengutronix.de>
References: <20190917141034.gvjg7bgylqbbxyv7@pengutronix.de>
 <20190918013032.GA2895@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190918013032.GA2895@jagdpanzerIV>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sergey,

On Wed, Sep 18, 2019 at 10:30:32AM +0900, Sergey Senozhatsky wrote:
> On (09/17/19 16:10), Uwe Kleine-K�nig wrote:
> > Hello,
> >
> > Today it saw sysrq on an UART driven by drivers/tty/serial/imx.c report
> > a lockdep issue. Bisecting pointed to
> >
> > 	fd5f7cde1b85 ("printk: Never set console_may_schedule in console_trylock()")
> 
> Hmmm...
> 
> I don't see how this patch can affect anything. It simply
> disables preemption in printk().

I rechecked and indeed fd5f7cde1b85's parent has the problem, too, so I
did a mistake during my bisection :-|

Redoing the bisection (a bit quicker this time) points to

dbdda842fe96 ("printk: Add console owner and waiter logic to load balance console writes")

Sorry for the confusion.

> > When I type <break>t I get:
> > 
> > [   87.940104] sysrq: SysRq : This sysrq operation is disabled.
> > [   87.948752] 
> > [   87.948772] ======================================================
> > [   87.948787] WARNING: possible circular locking dependency detected
> > [   87.948798] 4.14.0-12954-gfd5f7cde1b85 #26 Not tainted
> > [   87.948813] ------------------------------------------------------
> > [   87.948822] swapper/0 is trying to acquire lock:
> > [   87.948829]  (console_owner){-...}, at: [<c015e438>] console_unlock+0x110/0x598
> > [   87.948861] 
> > [   87.948869] but task is already holding lock:
> > [   87.948874]  (&port_lock_key){-.-.}, at: [<c048d5b0>] imx_rxint+0x2c/0x290
> > [   87.948902] 
> > [   87.948911] which lock already depends on the new lock.
> > [   87.948917] 
> > [   87.948923] 
> > [   87.948932] the existing dependency chain (in reverse order) is:
> > [   87.948938] 
> > [   87.948943] -> #1 (&port_lock_key){-.-.}:
> > [   87.948975]        _raw_spin_lock_irqsave+0x5c/0x70
> > [   87.948983]        imx_console_write+0x138/0x15c
> > [   87.948991]        console_unlock+0x204/0x598
> > [   87.949000]        register_console+0x21c/0x3e8
> > [   87.949008]        uart_add_one_port+0x3e4/0x4dc
> > [   87.949019]        platform_drv_probe+0x3c/0x78
> > [   87.949027]        driver_probe_device+0x25c/0x47c
> > [   87.949035]        __driver_attach+0xec/0x114
> > [   87.949044]        bus_for_each_dev+0x80/0xb0
> > [   87.949054]        bus_add_driver+0x1d4/0x264
> > [   87.949062]        driver_register+0x80/0xfc
> > [   87.949069]        imx_serial_init+0x28/0x48
> > [   87.949078]        do_one_initcall+0x44/0x18c
> > [   87.949087]        kernel_init_freeable+0x11c/0x1cc
> > [   87.949095]        kernel_init+0x10/0x114
> > [   87.949103]        ret_from_fork+0x14/0x30
> 
> This is "normal" locking path
> 
> 	console_sem -> port->lock
> 
> 	printk()
> 	 lock console_sem
> 	  imx_console_write()
> 	   lock port->lock
> 
> > [   87.949113] -> #0 (console_owner){-...}:
> > [   87.949145]        lock_acquire+0x100/0x23c
> > [   87.949154]        console_unlock+0x1a4/0x598
> > [   87.949162]        vprintk_emit+0x1a4/0x45c
> > [   87.949171]        vprintk_default+0x28/0x30
> > [   87.949180]        printk+0x28/0x38
> > [   87.949189]        __handle_sysrq+0x1c4/0x244
> > [   87.949196]        imx_rxint+0x258/0x290
> > [   87.949206]        imx_int+0x170/0x178
> > [   87.949216]        __handle_irq_event_percpu+0x78/0x418
> > [   87.949225]        handle_irq_event_percpu+0x24/0x6c
> > [   87.949233]        handle_irq_event+0x40/0x64
> > [   87.949242]        handle_level_irq+0xb4/0x138
> > [   87.949252]        generic_handle_irq+0x28/0x3c
> > [   87.949261]        __handle_domain_irq+0x50/0xb0
> > [   87.949269]        avic_handle_irq+0x3c/0x5c
> > [   87.949277]        __irq_svc+0x6c/0xa4
> > [   87.949287]        arch_cpu_idle+0x30/0x40
> > [   87.949297]        arch_cpu_idle+0x30/0x40
> > [   87.949305]        do_idle+0xa0/0x104
> > [   87.949313]        cpu_startup_entry+0x14/0x18
> > [   87.949323]        start_kernel+0x30c/0x368
> 
> This one is a "reverse" locking path...
> 
> 	port->lock -> console_sem
> 
> There is more to it:
> 
>  imxint()
>   lock port->lock
>    uart_handle_sysrq_char()
>     handle_sysrq()
>      printk()
>       lock conosole_sem
>        imx_console_write()
>         lock port->lock			[boom]
> 
> This path re-enters serial driver. But it doesn't deadlock, because
> uart_handle_sysrq_char() sets a special flag port->sysrq, and serial
> consoles are expected to make sure that they don't lock port->lock
> in this case. Otherwise we will kill the system:
> 
> 	void serial_console_write(...)
> 	{
> 	...
>           if (sport->port.sysrq)
>                   locked = 0;
>           else if (oops_in_progress)
>                   locked = spin_trylock_irqsave(&sport->port.lock, flags);
>           else
>                   spin_lock_irqsave(&sport->port.lock, flags);
>  	...
> 	}
> 
> So I'd say that lockdep is correct, but there are several hacks which
> prevent actual deadlock.

Just to make sure, I got you right: With the way lockdep works it is
right to assume there is a problem, but in fact there isn't?
This is IMHO unfortunate because such false positives reduces the
usefulness of lockdep considerably. :-|

> No idea why bisection has pointed at fd5f7cde1b85, it really doesn't
> change the locking patterns.

See above. I bent off wrongly during bisection and dbdda842fe96
("printk: Add console owner and waiter logic to load balance console
writes") is the first commit that issues the lockdep splat. I guess that
doesn't change what you said above though.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K�nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
