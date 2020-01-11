Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89A5E13836D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jan 2020 21:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731129AbgAKUCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jan 2020 15:02:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:55978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730994AbgAKUCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 15:02:07 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E67782087F;
        Sat, 11 Jan 2020 20:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578772926;
        bh=jpdg2/uTSGn1V3fe46VCeKShPYJOks94jP1Y0vH1Om4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AP7vKHRUmy2TTZzgeVSyBsOhfJuwPa12hqfDU10g+ipPt7bTUxueuuune2UDUflDq
         n/T1e/X2Skjy4EY75MRsjImHIzaV60d/Rqh4x0yvJMLaKHHpvDo7exl2fQkhyslYEN
         0aXpaGgNrBaC/E20RUv70Md7qM69S6rmqbOmMevY=
Date:   Sat, 11 Jan 2020 20:47:12 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RESEND] ttyprintk: fix a potential sleeping in interrupt
 context issue
Message-ID: <20200111194712.GA438314@kroah.com>
References: <20200103034541.5302-1-zhenzhong.duan@gmail.com>
 <20200103084339.GA855576@kroah.com>
 <CAFH1YnN4_BSP8OywYpLfBHnRRThpk27PEmfYe4baaOkO6FQaNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFH1YnN4_BSP8OywYpLfBHnRRThpk27PEmfYe4baaOkO6FQaNA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2020 at 10:44:42AM +0800, Zhenzhong Duan wrote:
> On Fri, Jan 3, 2020 at 4:43 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Jan 03, 2020 at 11:45:41AM +0800, Zhenzhong Duan wrote:
> > > Google syzbot reports:
> > > BUG: sleeping function called from invalid context at
> > > kernel/locking/mutex.c:938
> > > in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper/1
> > > 1 lock held by swapper/1/0:
> > > ...
> > > Call Trace:
> > >   <IRQ>
> > >   dump_stack+0x197/0x210
> > >   ___might_sleep.cold+0x1fb/0x23e
> > >   __might_sleep+0x95/0x190
> > >   __mutex_lock+0xc5/0x13c0
> > >   mutex_lock_nested+0x16/0x20
> > >   tpk_write+0x5d/0x340
> > >   resync_tnc+0x1b6/0x320
> > >   call_timer_fn+0x1ac/0x780
> > >   run_timer_softirq+0x6c3/0x1790
> > >   __do_softirq+0x262/0x98c
> > >   irq_exit+0x19b/0x1e0
> > >   smp_apic_timer_interrupt+0x1a3/0x610
> > >   apic_timer_interrupt+0xf/0x20
> > >   </IRQ>
> > >
> > > Fix it by using spinlock in process context instead of mutex and having
> > > interrupt disabled in critical section.
> > >
> > > Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  drivers/char/ttyprintk.c | 15 +++++++++------
> > >  1 file changed, 9 insertions(+), 6 deletions(-)
> >
> > Why was this resent?  What differs from the first version that required
> > it to be resent?
> >
> > Always give us a clue here please :)
> Sorry, I should have done that.
> patch-bot told me my last version is malformed(tabs converted to
> spaces) which may be due to I used gmail web browser to send patch.
> Now I have direct access to smtp.gmail.com and use 'git send-email',
> so that's not an issue now. No functional changes compared to last
> version.

Ok, then this is a v2 patch, and it needs to be described what changed
below the --- line.  Please always do that, when you resend this again.

> > > diff --git a/drivers/char/ttyprintk.c b/drivers/char/ttyprintk.c
> > > index 4f24e46ebe7c..56db949a7b70 100644
> > > --- a/drivers/char/ttyprintk.c
> > > +++ b/drivers/char/ttyprintk.c
> > > @@ -15,10 +15,11 @@
> > >  #include <linux/serial.h>
> > >  #include <linux/tty.h>
> > >  #include <linux/module.h>
> > > +#include <linux/spinlock.h>
> > >
> > >  struct ttyprintk_port {
> > >       struct tty_port port;
> > > -     struct mutex port_write_mutex;
> > > +     spinlock_t spinlock;
> > >  };
> > >
> > >  static struct ttyprintk_port tpk_port;
> > > @@ -99,11 +100,12 @@ static int tpk_open(struct tty_struct *tty, struct file *filp)
> > >  static void tpk_close(struct tty_struct *tty, struct file *filp)
> > >  {
> > >       struct ttyprintk_port *tpkp = tty->driver_data;
> > > +     unsigned long flags;
> > >
> > > -     mutex_lock(&tpkp->port_write_mutex);
> > > +     spin_lock_irqsave(&tpkp->spinlock, flags);
> > >       /* flush tpk_printk buffer */
> > >       tpk_printk(NULL, 0);
> >
> > Are you sure you can call this with a spinlock held?
> I think so.
> 
> >
> > Doesn't your trace above show the opposite?
> That's why I use spin_lock_irqsave() variants rather than spin_lock()
> 
> The issue here is tpk_write()/tpk_close() could be interrupted when
> holding a mutex, then in timer handler tpk_write() is called again
> trying to acquire same mutex, lead to dead lock.
> 
> With spin_lock_irqsave(), interrupt is disabled in process context, so
> no such issue.
> 
> >
> > What is wrong with sleeping during the mutex you currently have?  How is
> > syzbot reporting this error, is there a reproducer somewhere?
> See https://syzkaller.appspot.com/bug?extid=2eeef62ee31f9460ad65
> 
> I didn't reproduce the dead lock locally, not even for the warning
> syzbot reported, but syzbot does.

If this is a syzbot found issue, please include in the changelog text
that information and the proper link to how to have it marked that way
(it's in the syzkaller information.)

Fix that up and resend a v3 please.

thanks,

greg k-h
