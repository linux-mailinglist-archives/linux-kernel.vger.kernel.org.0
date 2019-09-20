Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F140B8C83
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 10:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395189AbfITIVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Sep 2019 04:21:37 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43713 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393179AbfITIVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 04:21:37 -0400
Received: by mail-qt1-f196.google.com with SMTP id c3so7675491qtv.10
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 01:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SEkk5jaulZecNO9tlUK672C+YvmCS9LBnVyF5GwNaNA=;
        b=WnE34QUFwKi0aouGcb6T+AqAjWrECsqe5PBbUa2LfZWTw2ZuF927fVhEEPbQbJcZ1f
         j0qXvjaQRoZra9M/fjzl+16koAQZgaHWXiH+/3bO9xNAta8XgVsTO5p7XF5GqOO3/OAD
         eITFaCkX2T3lspupOP2h/b9AXIvkOLFzXD1YE6ImWVdVjQm1Jp4ICqaxNL1H3xdUH+HR
         U9sGZy7vSyFELBFRiJv7h9cUWt6h6M3w/00ZUGUBogCItXhpy1r2ivLyeqd5OufcY+TM
         f/1fy9Ki73Fpq2VpRZnS2MG6KEguTKNK+ucEWpaMKGw9JxbUNq0bXJC3VjtuCztHyDAa
         UHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SEkk5jaulZecNO9tlUK672C+YvmCS9LBnVyF5GwNaNA=;
        b=JGHVbf5WsgoPUaj6ykEAWr0XEhOj87C6lH0YTur1uw6ROc4SJtQZ9NtrCl/k3LUcGV
         KKoctmn4q33ofpKS556Wu/OGsxqj8z8dGY1xAYE93NFIljQORJB5J8VQbv0DDq3MBGwV
         YptST54evBhnKdOLbaLLGBiomQ71KbeDyvupMmCUD//QNEXr488g0kSTllyqmLDdKLN0
         usME8b+IvYhlYmA0dJRBTWMROMRLlbIRv/XNAZvAGd9bBHTRdhaL1hCEVP7GFo/ZTReP
         hEwAcME71Mo/b1Dh1VKgfkxUuQyGZmcECSShFAN1cC/f/JuOaa6PuPIwoUe7/x8qPb72
         m0hA==
X-Gm-Message-State: APjAAAWrM9s60Sd7Ro4beD3U/C2DA+OpvHXiBwBMcPuMLWiJQwKW7hFJ
        3DtJJ59YpI+TXa+ufXqbmqZXVkzQxDeWqjspTzhHMg==
X-Google-Smtp-Source: APXvYqxrfg7nsiECtbj1i96TvwMtINQBUG2kBRfbTOnqCJHkdNc8EuDO4rg7VZT2PECrZEW8B66lA3WQ7dvv8NNyf4E=
X-Received: by 2002:ac8:7646:: with SMTP id i6mr2095920qtr.50.1568967694728;
 Fri, 20 Sep 2019 01:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000674b3d0592d2015b@google.com> <CACT4Y+YX3yNz7Fc8wUKsVR-rzusqmTnzP6ysZx+=3CzhVHk36w@mail.gmail.com>
 <20190919170750.GO30224@paulmck-ThinkPad-P72> <CACT4Y+bHcy1ZOstVvSGezs+3Q=jccdWTeikm6mnZiXYCBi+Nyw@mail.gmail.com>
 <20190919201200.GP30224@paulmck-ThinkPad-P72> <CACT4Y+YdodVKL2h-Z4Svjyd6kug2ORmfiP4jripSC9PpYw4RiA@mail.gmail.com>
 <CACT4Y+YLZeMSz1F_YEmbNVF=cxBJcOMOC6KNDXCddei49JMs4Q@mail.gmail.com> <CACT4Y+apU3vQXKDYYhx=soj2bNrRyk-V__rk3wB_8OdAMZwLmw@mail.gmail.com>
In-Reply-To: <CACT4Y+apU3vQXKDYYhx=soj2bNrRyk-V__rk3wB_8OdAMZwLmw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 20 Sep 2019 10:21:23 +0200
Message-ID: <CACT4Y+aNDvPhsKvR9EpLpuaf7HpCospOvJ9DNyj3+VDCP=3TpQ@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in sys_exit_group
To:     paulmck@kernel.org
Cc:     syzbot <syzbot+18379f2a19bc62c12565@syzkaller.appspotmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, avagin@gmail.com,
        Christian Brauner <christian@brauner.io>, dbueso@suse.de,
        LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, prsood@codeaurora.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 10:03 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Fri, Sep 20, 2019 at 9:54 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > >  On Thu, Sep 19, 2019 at 10:12 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > On Thu, Sep 19, 2019 at 07:39:03PM +0200, Dmitry Vyukov wrote:
> > > > > On Thu, Sep 19, 2019 at 7:07 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > >
> > > > > > On Wed, Sep 18, 2019 at 05:05:26PM +0200, Dmitry Vyukov wrote:
> > > > > > > On Wed, Sep 18, 2019 at 1:19 PM syzbot
> > > > > > > <syzbot+18379f2a19bc62c12565@syzkaller.appspotmail.com> wrote:
> > > > > > > >
> > > > > > > > Hello,
> > > > > > > >
> > > > > > > > syzbot found the following crash on:
> > > > > > > >
> > > > > > > > HEAD commit:    a7f89616 Merge branch 'for-5.3-fixes' of git://git.kernel...
> > > > > > > > git tree:       upstream
> > > > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=15c33079600000
> > > > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=861a6f31647968de
> > > > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=18379f2a19bc62c12565
> > > > > > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1066bb85600000
> > > > > > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e9f75e600000
> > > > > > > >
> > > > > > > > Bisection is inconclusive: the bug happens on the oldest tested release.
> > > > > > > >
> > > > > > > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=154d4969600000
> > > > > > > > final crash:    https://syzkaller.appspot.com/x/report.txt?x=174d4969600000
> > > > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=134d4969600000
> > > > > > > >
> > > > > > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > > > > > Reported-by: syzbot+18379f2a19bc62c12565@syzkaller.appspotmail.com
> > > > > > > >
> > > > > > > > rcu: INFO: rcu_preempt self-detected stall on CPU
> > > > > > > > rcu:    1-...!: (10499 ticks this GP) idle=63a/1/0x4000000000000002
> > > > > > > > softirq=10978/10978 fqs=0
> > > > > > > >         (t=10501 jiffies g=10601 q=227)
> > > > > > > > rcu: rcu_preempt kthread starved for 10502 jiffies! g10601 f0x0
> > > > > >
> > > > > > The key point is the above line: RCU's grace-period kthread has not
> > > > > > had a chance to run for 10,502 jiffies.
> > > > > >
> > > > > > > > RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=0
> > > > > >
> > > > > > And it is sleeping normally.  The "RCU_GP_WAIT_FQS(5)" says that it was
> > > > > > doing a fixed-time wait, which is normally for three jiffies, but never
> > > > > > 10,000 of them.  Note that this kthread last ran on CPU 0.
> > > > > >
> > > > > > > > rcu: RCU grace-period kthread stack dump:
> > > > > > > > rcu_preempt     I29040    10      2 0x80004000
> > > > > > > > Call Trace:
> > > > > > > >   context_switch kernel/sched/core.c:3254 [inline]
> > > > > > > >   __schedule+0x755/0x1580 kernel/sched/core.c:3880
> > > > > > > >   schedule+0xd9/0x260 kernel/sched/core.c:3947
> > > > > > > >   schedule_timeout+0x486/0xc50 kernel/time/timer.c:1807
> > > > > > > >   rcu_gp_fqs_loop kernel/rcu/tree.c:1611 [inline]
> > > > > > > >   rcu_gp_kthread+0x9b2/0x18c0 kernel/rcu/tree.c:1768
> > > > > > > >   kthread+0x361/0x430 kernel/kthread.c:255
> > > > > > > >   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> > > > > >
> > > > > > This stack trace is expected:  The RCU grace-period kthread is doing
> > > > > > a fixed-time wait.  Note that this is a stack trace of this kthread,
> > > > > > not necessarily of the CPU it was last running on.
> > > > > >
> > > > > > > > Sending NMI from CPU 1 to CPUs 0:
> > > > > > > > INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.403
> > > > > > > > msecs
> > > > > >
> > > > > > This is surprising.  Is this a guest OS?  If so, is the vCPU for CPU 0
> > > > > > stuck somehow?  Did it get a SIGSTOP or some such?
> > > > > >
> > > > > > Clearly, if CPU 0 isn't running, RCU's grace-period kthread, which was
> > > > > > last seen on CPU 0, might not be doing so well.
> > > > > >
> > > > > > OK, but we eventually did get a stack trace:
> > > > > >
> > > > > > > > NMI backtrace for cpu 0
> > > > > > > > CPU: 0 PID: 10344 Comm: syz-executor933 Not tainted 5.3.0-rc8+ #0
> > > > > > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > > > > > > > Google 01/01/2011
> > > > > > > > RIP: 0010:hhf_dequeue+0x552/0xa20 net/sched/sch_hhf.c:436
> > > > > > > > Code: ff ff 45 31 ff e9 b0 02 00 00 e8 49 05 ac fb 48 8d 43 f0 41 be 01 00
> > > > > > > > 00 00 49 8d 95 c0 02 00 00 48 39 c2 74 34 e8 2e 05 ac fb <49> 8d bd ac 03
> > > > > > > > 00 00 48 89 f8 48 c1 e8 03 42 0f b6 14 20 48 89 f8
> > > > > > > > RSP: 0018:ffff8880ae809038 EFLAGS: 00000206
> > > > > > > > RAX: ffff8880a3970100 RBX: ffff8880a8b1d538 RCX: ffffffff85c66b39
> > > > > > > > RDX: 0000000000000100 RSI: ffffffff85c66fd2 RDI: 0000000000000005
> > > > > > > > RBP: ffff8880ae809088 R08: ffff8880a3970100 R09: 0000000000000000
> > > > > > > > R10: fffffbfff134afaf R11: ffff8880a3970100 R12: dffffc0000000000
> > > > > > > > R13: ffff8880a8b1d240 R14: 0000000000000001 R15: 0000000000000000
> > > > > > > > FS:  0000000000000000(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
> > > > > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > > > > CR2: 00000000006dab10 CR3: 0000000008c6d000 CR4: 00000000001406f0
> > > > > > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > > > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > > > > > Call Trace:
> > > > > > > >   <IRQ>
> > > > > > > >   dequeue_skb net/sched/sch_generic.c:258 [inline]
> > > > > > > >   qdisc_restart net/sched/sch_generic.c:361 [inline]
> > > > > > > >   __qdisc_run+0x1e7/0x19d0 net/sched/sch_generic.c:379
> > > > > > > >   __dev_xmit_skb net/core/dev.c:3533 [inline]
> > > > > > > >   __dev_queue_xmit+0x16f1/0x3650 net/core/dev.c:3838
> > > > > > > >   dev_queue_xmit+0x18/0x20 net/core/dev.c:3902
> > > > > > > >   br_dev_queue_push_xmit+0x3f3/0x5c0 net/bridge/br_forward.c:52
> > > > > > > >   NF_HOOK include/linux/netfilter.h:305 [inline]
> > > > > > > >   NF_HOOK include/linux/netfilter.h:299 [inline]
> > > > > > > >   br_forward_finish+0xfa/0x400 net/bridge/br_forward.c:65
> > > > > > > >   NF_HOOK include/linux/netfilter.h:305 [inline]
> > > > > > > >   NF_HOOK include/linux/netfilter.h:299 [inline]
> > > > > > > >   __br_forward+0x641/0xb00 net/bridge/br_forward.c:109
> > > > > > > >   deliver_clone+0x61/0xc0 net/bridge/br_forward.c:125
> > > > > > > >   maybe_deliver+0x2c7/0x390 net/bridge/br_forward.c:181
> > > > > > > >   br_flood+0x13a/0x3d0 net/bridge/br_forward.c:223
> > > > > > > >   br_dev_xmit+0x98c/0x15a0 net/bridge/br_device.c:100
> > > > > > > >   __netdev_start_xmit include/linux/netdevice.h:4406 [inline]
> > > > > > > >   netdev_start_xmit include/linux/netdevice.h:4420 [inline]
> > > > > > > >   xmit_one net/core/dev.c:3280 [inline]
> > > > > > > >   dev_hard_start_xmit+0x1a3/0x9c0 net/core/dev.c:3296
> > > > > > > >   __dev_queue_xmit+0x2b15/0x3650 net/core/dev.c:3869
> > > > > > > >   dev_queue_xmit+0x18/0x20 net/core/dev.c:3902
> > > > > > > >   neigh_hh_output include/net/neighbour.h:500 [inline]
> > > > > > > >   neigh_output include/net/neighbour.h:509 [inline]
> > > > > > > >   ip_finish_output2+0x1726/0x2570 net/ipv4/ip_output.c:228
> > > > > > > >   __ip_finish_output net/ipv4/ip_output.c:308 [inline]
> > > > > > > >   __ip_finish_output+0x5fc/0xb90 net/ipv4/ip_output.c:290
> > > > > > > >   ip_finish_output+0x38/0x1f0 net/ipv4/ip_output.c:318
> > > > > > > >   NF_HOOK_COND include/linux/netfilter.h:294 [inline]
> > > > > > > >   ip_output+0x21f/0x640 net/ipv4/ip_output.c:432
> > > > > > > >   dst_output include/net/dst.h:436 [inline]
> > > > > > > >   ip_local_out+0xbb/0x190 net/ipv4/ip_output.c:125
> > > > > > > >   igmpv3_sendpack+0x1b5/0x2c0 net/ipv4/igmp.c:426
> > > > > > > >   igmpv3_send_cr net/ipv4/igmp.c:721 [inline]
> > > > > > > >   igmp_ifc_timer_expire+0x687/0xa00 net/ipv4/igmp.c:809
> > > > > >
> > > > > > So this stack trace leads me to ask if networking has been hogging
> > > > > > the CPU for the past 10,000 jiffies.  Perhaps there is a corner case
> > > > > > that is not being addressed by the code that is supposed to move
> > > > > > long-term processing from softirq to ksoftirqd?  Or perhaps more
> > > > > > likely, the networking code isn't exiting its softirq handler, thus
> > > > > > preventing the timer softirq handler from running, thus preventing
> > > > > > RCU's grace-period kthread's sleep from ever ending.
> > > > > >
> > > > > > Is this consistent with what you are seeing?
> > > > > >
> > > > > > > This should have been parsed as "INFO: rcu detected stall in
> > > > > > > igmp_ifc_timer_expire" which was already reported:
> > > > > > > https://syzkaller.appspot.com/bug?id=330ce4f7626354cc6444c457c9a5e82d8a8c5055
> > > > > > > So let's do:
> > > > > > > #syz fix: sch_hhf: ensure quantum and hhf_non_hh_weight are non-zero
> > > > > > >
> > > > > > > +Paul, Tetsuo
> > > > > > >
> > > > > > > However, I cannot make sense of this kernel output (nor syzbot).
> > > > > > > Here is full console output:
> > > > > > > https://syzkaller.appspot.com/x/log.txt?x=15c33079600000
> > > > > >
> > > > > > I will bite...  What are all the "executing program" outputs?
> > > > > >
> > > > > > > This is "self-detected stall" which was detected in rcu_gp_kthread (?
> > > > > > > usually these are detected in interrupts, no?)
> > > > > >
> > > > > > They are detected by the scheduling-clock interrupt handler, but
> > > > > > stalls can be generated both at process and at interrupt levels.
> > > > > >
> > > > > > > and then the kthread runs on CPU 1 on top of the igmp_ifc_timer_expire
> > > > > > > handler running in an interrupt (how can a kthread run on the
> > > > > > > interrupt stack?)
> > > > > > > and then it does NMI traceback for CPU 0, but that runs on CPU 1
> > > > > > > (shouldn't NMI traceback run on CPU 0 too?)
> > > > > > >
> > > > > > > Any ideas what exactly happened here and how one can make sense of
> > > > > > > such output to attribute it to some kernel activity that caused the
> > > > > > > stall?
> > > > > >
> > > > > > My best guess based on what I am seeing is that a softirq handler
> > > > > > is running for about ten seconds, which is too long.
> > > > > >
> > > > > > Do you have means for tracking softirq-handler durations?
> > > > >
> > > > > The "executing program" are produced by userspace. Kernel and
> > > > > userspace outputs are multiplexed later to restore order of events.
> > > > > Kernel output is prefixed with "[  351.648071][    C1]".
> > > > >
> > > > > Yes, the networking is stuck dead in an infinite loop. That's a known
> > > > > bug, already fixed by:
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d4d6ec6dac07f263f06d847d6f732d6855522845
> > > > >
> > > > > But I am interested why this report looks not like all other rcu
> > > > > stalls and who should be the parsing logic to conclude that the stall
> > > > > happened in igmp_ifc_timer_expire?
> > > >
> > > > Because the infinite loop happened to prevent the RCU grace-period
> > > > kthread from making progress.  The odds of that are a bit low, so
> > > > most of the stall warnings would look different.
> > >
> > > But isn't it happens in all cases of infinite loops? Yet most other
> > > reports look different and don't mention kthread. What's different
> > > here?
> > > Or is it another case of flaky reporting? We had that other case where
> > > self-stall or remote-stall had the same timeout, so were reported
> > > non-deterministically, or worse intermixed at the same time.
> > >
> > >
> > > > I do expect to be revisiting the RCU CPU stall warning logic at some
> > > > point.  Or are you asking how you could modify a script that figures
> > > > this out?
> > >
> > > Both. Fixing parsing may be easier and will fix all old kernels too.
> > > You know nobody uses kernel HEAD, people use down to 3.18 and maybe
> > > older. You are not going to backport these changes all the way back,
> > > right? :)
> > >
> > > > > Why it's detected by the kthread?
> > > >
> > > > It is not detected by the kthread.  The kthread has been interrupted
> > > > indefinitely by the softirq processing, so is not in a position to
> > > > detect much of anything.  It is instead detected as usual by the
> > > > scheduling-clock interrupt.
> > >
> > > I don't see any rcu-liveness-checking interrupt handler in any
> > > tracebacks. Where is it? Is it useful to traceback the ktread in such
> > > case at all?
> > >
> > > What we do is the following, we find first apic_timer_interrupt on the
> > > current CPU (presumably that the rcu-health-checking interrupt) and
> > > then take the next "anchor" frame after that. This does not work in
> > > this case, because the rcu-health-checking interrupt in missing.
> > >
> > >
> > > > What is different is that the scheduling-clock interrupt detected
> > > > that the grace-period kthread had not been running for an extended
> > > > period of time.  It can detect this because the grace period kthread
> > > > stores timestamps before each activity it undertakes.
> > > >
> > > > >                                   How it runs on top of an interrupt?
> > > >
> > > > It is not running on top of an interrupt.  Its stack was dumped
> > > > separately.
> > >
> > > I see. Usually the first stack is the traceback of the current stack.
> > > So I was confused.
> > >
> > > > > And why one cpu tracebacks another one?
> > > >
> > > > The usual reason is because neither CPU's quiescent state was reported
> > > > to the RCU core, so the stall-warning code dumped both stacks.
> > >
> > > But should the other CPU traceback _itself_? Rather than being traced
> > > back by another CPU?
> > > E.g. see this report:
> > > https://github.com/google/syzkaller/blob/master/pkg/report/testdata/linux/report/350#L61-L83
> > > Here the overall problem was detected by C2, but then C1 traces back itself.
> > >
> > > ... however even in that case C0 and C3 are traced by C2:
> > > https://github.com/google/syzkaller/blob/master/pkg/report/testdata/linux/report/350#L84-L149
> > > I can't understand this...
> > > This makes understanding what happened harder because it's not easy to
> > > exclude things on other CPUs.
> > >
> > >
> > >
> > > >
> > > > My turn.  Why dothere appear to be multiple levels of interrupt, as
> > > > in one interrupt interrupting another interrupt?
> > >
> > > I don't understand the question.
> > > I see 1 apic_timer_interrupt on CPU 0 and 1 apic_timer_interrupt on CPU 1.
> > >
> > > > > As of now syzkaller parsed it as "in sys_exit_group", which lead to
> > > > > the creation of a new bug and another email, which is suboptimal.
> > > >
> > > > I suggest having syzkaller look for something like "rcu: rcu_[a-z]*
> > > > kthread starved for".
> > >
> > > And then what do we need to do to detect this as "in igmp_ifc_timer_expire"?
> >
> > Another thing in this report that confuses me is this:
> > The machine has 2 CPUs. The report contains 2 NMI tracebacks, both for
> > CPU 0 and CPU 1. A CPU generally does not do NMI traceback for itself
> > (right? it could do just traceback). The question is: what CPU the
> > code that prints this runs on then?
>
> Oh, I think I start understanding what happened here.
> The rcu-health-checking interrupt which prints all of this is
> rcu_sched_clock_irq, which is at the very bottom of the report (why?
> the current traceback is at the top in all other cases).  It also
> tracebacks itself with "NMI backtrace for cpu 1" message (why? why not
> the normal "Call Trace:"?).
> Then, CPU 1 is in spinlock lock at hhf_change (presumably the timer
> handler on CPU 0 holds the lock).
> So this should have been detected as "spinlock lockup in hhf_change".

We have CONFIG_DEBUG_SPINLOCK=y

The spinlock lockups now seem to be detected by normal watchdog:
/*
 * We are now relying on the NMI watchdog to detect lockup instead of doing
 * the detection here with an unfair lock which can cause problem of its own.
 */
void do_raw_spin_lock(raw_spinlock_t *lock)

That's  kernel.watchdog_thresh = 55 that we have.

But then softlock period is actually twice as long (110):

static int get_softlockup_thresh(void)
{
    return watchdog_thresh * 2;
}

But for rcu we have 100:

CONFIG_RCU_CPU_STALL_TIMEOUT=100

So our current assumption is that rcu should have been detected this
in some parsable way.

Presumably if the rcu kthread is starving, rcu overall is starving
from all other sides as well, right? So couldn't it produce the normal
stall message?

Wait, why is this just 2 seconds?

static void rcu_check_gp_kthread_starvation(void)
{
    struct task_struct *gpk = rcu_state.gp_kthread;
    unsigned long j;
    j = jiffies - READ_ONCE(rcu_state.gp_activity);
    if (j > 2 * HZ) {
        pr_err("%s kthread starved for %ld jiffies! g%ld f%#x %s(%d)
->state=%#lx ->cpu=%d\n",

Is it? 2 seconds is too short period for any checks on heavily debug
kernel (as heavily as you can possibly imaging with tons of compiler
instrumentation), running under insanely heavy stress workload.
We bump all timeouts towards 100-300 seconds. But this one does not
seem to be tunable.
Or I am missing something? It says "starved for 10502 jiffies" and we
have CONFIG_HZ=100, so that's 10.5 seconds...
