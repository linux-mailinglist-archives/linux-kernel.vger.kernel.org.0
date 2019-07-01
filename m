Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCF7954D1D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 13:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbfFYLDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 07:03:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37062 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfFYLDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 07:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=542HpBtIxMw7m821MDGhNcvG3Hp3ks6DyM341W05HKE=; b=bF+QFKxbPSnle9UAvXDU6eRA7
        2TPlDKOFhkrsh1hxhtRJx3ov0pkdxOCNzAhip4QrCdep6tZFZ25uSsI4/8TzJSvkqzCMuF7fsITkx
        S0oolCLV4PQfoCZIviuHWbMq5e+mhr4o/zfriCpMFZL2c2Ihn5tQwMY7RrpifSh5v6ZJPvZWirJ7+
        YgV+4c9v5CpcODIq2+IEhf9AiCbi+TJpXRt1Cmezv3eFvqmdCohWLnGE6P0Ak8I7fnr6v4ymB/AZO
        XOBAbIKN/EAgi2I/JXb6Y0DrHl+WYMD/HfMPRmugaqvgrZEk+cvtsPnJVUK8xRDcjBIaegprwKASW
        Q2CP++nXw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfjE7-0002ts-2p; Tue, 25 Jun 2019 11:03:03 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8F29F209FD684; Tue, 25 Jun 2019 13:03:01 +0200 (CEST)
Date:   Tue, 25 Jun 2019 13:03:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     syzbot <syzbot+a861f52659ae2596492b@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Subject: Re: WARNING in mark_lock
Message-ID: <20190625110301.GX3419@hirez.programming.kicks-ass.net>
References: <0000000000005aedf1058c1bf7e8@google.com>
 <alpine.DEB.2.21.1906250820060.32342@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1906250820060.32342@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 08:20:56AM +0200, Thomas Gleixner wrote:
> On Mon, 24 Jun 2019, syzbot wrote:

> > syzbot found the following crash on:
> > 
> > HEAD commit:    dc636f5d Add linux-next specific files for 20190620
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=162b68b1a00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=99c104b0092a557b
> > dashboard link: https://syzkaller.appspot.com/bug?extid=a861f52659ae2596492b
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=110b24f6a00000
> > 
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+a861f52659ae2596492b@syzkaller.appspotmail.com
> > 
> > ------------[ cut here ]------------
> > DEBUG_LOCKS_WARN_ON(1)
> > WARNING: CPU: 0 PID: 9968 at kernel/locking/lockdep.c:167 hlock_class
> > kernel/locking/lockdep.c:167 [inline]
> > WARNING: CPU: 0 PID: 9968 at kernel/locking/lockdep.c:167 hlock_class
> > kernel/locking/lockdep.c:156 [inline]
> > WARNING: CPU: 0 PID: 9968 at kernel/locking/lockdep.c:167
> > mark_lock+0x22b/0x11e0 kernel/locking/lockdep.c:3594
> > Kernel panic - not syncing: panic_on_warn set ...
> > CPU: 0 PID: 9968 Comm: syz-executor.2 Not tainted 5.2.0-rc5-next-20190620 #19
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google
> > 01/01/2011
> > Call Trace:
> > <IRQ>
> > __dump_stack lib/dump_stack.c:77 [inline]
> > dump_stack+0x172/0x1f0 lib/dump_stack.c:113
> > panic+0x2dc/0x755 kernel/panic.c:219
> > __warn.cold+0x20/0x4c kernel/panic.c:576
> > report_bug+0x263/0x2b0 lib/bug.c:186
> > fixup_bug arch/x86/kernel/traps.c:179 [inline]
> > fixup_bug arch/x86/kernel/traps.c:174 [inline]
> > do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
> > do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
> > invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:986
> > RIP: 0010:hlock_class kernel/locking/lockdep.c:167 [inline]
> > RIP: 0010:hlock_class kernel/locking/lockdep.c:156 [inline]
> > RIP: 0010:mark_lock+0x22b/0x11e0 kernel/locking/lockdep.c:3594
> > Code: d0 7c 08 84 d2 0f 85 33 0f 00 00 44 8b 15 4d 14 4a 08 45 85 d2 75 b6 48
> > c7 c6 c0 a6 8b 87 48 c7 c7 00 a7 8b 87 e8 ad e6 eb ff <0f> 0b 31 db e9 a8 fe
> > ff ff 48 c7 c7 80 71 86 8a e8 f0 95 53 00 e9
> > RSP: 0018:ffff8880ae809ad0 EFLAGS: 00010082
> > RAX: 0000000000000000 RBX: 0000000000000f1d RCX: 0000000000000000
> > RDX: 0000000000010000 RSI: ffffffff815b37e6 RDI: ffffed1015d0134c
> > RBP: ffff8880ae809b20 R08: ffff88808662e0c0 R09: fffffbfff11b3285
> > R10: fffffbfff11b3284 R11: ffffffff88d99423 R12: 0000000000000000
> > R13: ffff88808662e9c8 R14: 000000000000004f R15: 00000000000c4f1d
> > mark_usage kernel/locking/lockdep.c:3485 [inline]
> > __lock_acquire+0x1e1a/0x4680 kernel/locking/lockdep.c:3839
> > lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4418
> > __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
> > _raw_spin_lock_irqsave+0x95/0xcd kernel/locking/spinlock.c:159
> > try_to_wake_up+0x90/0x1430 kernel/sched/core.c:2000
> > wake_up_process+0x10/0x20 kernel/sched/core.c:2114

That's trying to acquire p->pi_lock, and the DEBUG_LOCKS_WARN_ON() that
triggers has the comment:

  /*
   * Someone passed in garbage, we give up.
   */

Which seems to indicate we triggered some use-after-free or other
corruption scenario (@p is buggered in any case).

> > hrtimer_wakeup+0x48/0x60 kernel/time/hrtimer.c:1636
> > __run_hrtimer kernel/time/hrtimer.c:1388 [inline]
> > __hrtimer_run_queues+0x364/0xe40 kernel/time/hrtimer.c:1450
> > hrtimer_interrupt+0x314/0x770 kernel/time/hrtimer.c:1508
> > local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1041 [inline]
> > smp_apic_timer_interrupt+0x12a/0x5b0 arch/x86/kernel/apic/apic.c:1066
> > apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:806
> > </IRQ>
> > Kernel Offset: disabled
> > Rebooting in 86400 seconds..

If we look at the 'console output' provided above, we'll see that
there's two CPUs going *splat* at the same time, the above is first, but
the second does:

[   93.859778][ T9977] kasan: GPF could be caused by NULL-ptr deref or user memory access
[   93.869482][ T9977] general protection fault: 0000 [#1] PREEMPT SMP KASAN
[   93.881836][ T9977] CPU: 1 PID: 9977 Comm: syz-executor.4 Not tainted 5.2.0-rc5-next-20190620 #19

[   94.102920][ T9977]  do_exit+0x81b/0x2f60

which also indicates things went sideways fast.

I'm not sure I've got enough hints to figure out where it goes
side-ways, but it sure did.

Maybe someone forgot to cancel a timer before freeing?
