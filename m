Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8859DEE47B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 17:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbfKDQPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 11:15:05 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41128 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728957AbfKDQPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 11:15:04 -0500
Received: by mail-ot1-f66.google.com with SMTP id 94so14832170oty.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 08:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3eqXcDp0diVn2ikoFQKVnkidKfBKWj2mAxHH2itkcuU=;
        b=c4JWeCJKfS34OQa/n7F0oU4QipdjiXl5wejgnLiHb6lG8QbNOoB4hJ3woOem5iIT42
         vxtYEN5416WdoMsCnqbLwX9VyEkwVe2jtz/mn7Ifql1kDrHrpxGJWh20enEVQpgyWS2x
         nwfCfEJ0YAPg6+HsJCultqZJwLpC51KujSYjRDldmSU8uz3PiNK3+1Hc3toLR3ncFhwq
         C76AbOeK41SHlDxkJw8xlmgbcyUG1PTvLD+a57o49oc0M2vR14iZUouYmhKiUQizGGY6
         oq828b/WHChlkuo1xUsH4WSloOrJZMynLgFssyPHDAoxBI6SOKqrJrsjU9fsno+duXR0
         cexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3eqXcDp0diVn2ikoFQKVnkidKfBKWj2mAxHH2itkcuU=;
        b=hGamzrWQcWq7H/Pep7B8ojlMVV1IVgGnVWQKZAxNOknPSxJ62mKy9Qcjm8BlbMyzLW
         zy8G3G/argDbE8F6ZU+iVa5usi8sB7AXcTXReCO3xC16/tghyNtRxSNHdcgaKSYqw9wZ
         aWOjBK1VcQIfzyeMPPRu58Fes4v2H1nlUVfEG5qESQ7KSqk4SlW4PhPVfDaaGp1a9DJm
         f16ZOhM1yBFbRSsRZ87ks3HhuDigL5gLr+UrYt8VXjcW0FwQEz/faov1er2xVLqZpcdm
         D8KabD97tti3i3fG4dwbQxHWBJL2X14snjEl/efIS00E1jDA8xkF+vW5MKczxjH+Dqrw
         eZ/w==
X-Gm-Message-State: APjAAAXcBG4eK8/XyHk+q382YmyPXVlL5IDxcblD2k5r0Y/jI2KiWIBC
        wmlJ3SB+xYJdiPPvA/ExkUXtMJ3qgjhBx1hr1AQ3HKTQ3tY8JQ==
X-Google-Smtp-Source: APXvYqxxLqvrsGMop20BSVZCl8LGgPFljE/fjXI7I0VVRiQY9M50C8dlAvAoUZ/nPor2Hw6JiE9jf3mlMyfjWlTvL+M=
X-Received: by 2002:a9d:ef0:: with SMTP id 103mr18739354otj.2.1572884102964;
 Mon, 04 Nov 2019 08:15:02 -0800 (PST)
MIME-Version: 1.0
References: <000000000000b587670596839fab@google.com> <CANpmjNPpvyxZv9N042Uz1gQb7R0B1MOmCa255-czqWsc7SiOxg@mail.gmail.com>
 <20191104161152.GB20975@paulmck-ThinkPad-P72>
In-Reply-To: <20191104161152.GB20975@paulmck-ThinkPad-P72>
From:   Marco Elver <elver@google.com>
Date:   Mon, 4 Nov 2019 17:14:50 +0100
Message-ID: <CANpmjNNFQbtDpBzbf-RkBp=mzhzXCLOO=scA=oB6xSWD3X9zEw@mail.gmail.com>
Subject: Re: KCSAN: data-race in process_srcu / synchronize_srcu
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     syzbot <syzbot+08f3e9d26e5541e1ecf2@syzkaller.appspotmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>, axboe@kernel.dk,
        justin@coraid.com, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Nov 2019 at 17:11, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Mon, Nov 04, 2019 at 12:31:56PM +0100, Marco Elver wrote:
> > +RCU folks, since this is probably a data race in RCU.
> >
> > On Mon, 4 Nov 2019 at 12:29, syzbot
> > <syzbot+08f3e9d26e5541e1ecf2@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    05f22368 x86, kcsan: Enable KCSAN for x86
> > > git tree:       https://github.com/google/ktsan.git kcsan
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=17ade7ef600000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=87d111955f40591f
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=08f3e9d26e5541e1ecf2
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > >
> > > Unfortunately, I don't have any reproducer for this crash yet.
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+08f3e9d26e5541e1ecf2@syzkaller.appspotmail.com
> > >
> > > ==================================================================
> > > BUG: KCSAN: data-race in process_srcu / synchronize_srcu
> > >
> > > write to 0xffffffff8604e8a0 of 8 bytes by task 17 on cpu 1:
> > >   srcu_gp_end kernel/rcu/srcutree.c:533 [inline]
> > >   srcu_advance_state kernel/rcu/srcutree.c:1146 [inline]
> > >   process_srcu+0x207/0x780 kernel/rcu/srcutree.c:1237
> > >   process_one_work+0x3d4/0x890 kernel/workqueue.c:2269
> > >   worker_thread+0xa0/0x800 kernel/workqueue.c:2415
> > >   kthread+0x1d4/0x200 drivers/block/aoe/aoecmd.c:1253
> > >   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:352
> > >
> > > read to 0xffffffff8604e8a0 of 8 bytes by task 12515 on cpu 0:
> > >   srcu_might_be_idle kernel/rcu/srcutree.c:784 [inline]
> > >   synchronize_srcu+0x107/0x214 kernel/rcu/srcutree.c:996
> > >   fsnotify_connector_destroy_workfn+0x63/0xb0 fs/notify/mark.c:164
> > >   process_one_work+0x3d4/0x890 kernel/workqueue.c:2269
> > >   worker_thread+0xa0/0x800 kernel/workqueue.c:2415
> > >   kthread+0x1d4/0x200 drivers/block/aoe/aoecmd.c:1253
> > >   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:352
> > >
> > > Reported by Kernel Concurrency Sanitizer on:
> > > CPU: 0 PID: 12515 Comm: kworker/u4:8 Not tainted 5.4.0-rc3+ #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > > Google 01/01/2011
> > > Workqueue: events_unbound fsnotify_connector_destroy_workfn
> > > ==================================================================
> > > Kernel panic - not syncing: panic_on_warn set ...
> > > CPU: 0 PID: 12515 Comm: kworker/u4:8 Not tainted 5.4.0-rc3+ #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > > Google 01/01/2011
> > > Workqueue: events_unbound fsnotify_connector_destroy_workfn
> > > Call Trace:
> > >   __dump_stack lib/dump_stack.c:77 [inline]
> > >   dump_stack+0xf5/0x159 lib/dump_stack.c:113
> > >   panic+0x210/0x640 kernel/panic.c:221
> > >   kcsan_report.cold+0xc/0x10 kernel/kcsan/report.c:302
> > >   __kcsan_setup_watchpoint+0x32e/0x4a0 kernel/kcsan/core.c:411
> > >   __tsan_read8 kernel/kcsan/kcsan.c:36 [inline]
> > >   __tsan_read8+0x2c/0x30 kernel/kcsan/kcsan.c:36
> > >   srcu_might_be_idle kernel/rcu/srcutree.c:784 [inline]
> > >   synchronize_srcu+0x107/0x214 kernel/rcu/srcutree.c:996
> > >   fsnotify_connector_destroy_workfn+0x63/0xb0 fs/notify/mark.c:164
> > >   process_one_work+0x3d4/0x890 kernel/workqueue.c:2269
> > >   worker_thread+0xa0/0x800 kernel/workqueue.c:2415
> > >   kthread+0x1d4/0x200 drivers/block/aoe/aoecmd.c:1253
> > >   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:352
> > > Kernel Offset: disabled
> > > Rebooting in 86400 seconds..
> > >
> > >
> > > ---
> > > This bug is generated by a bot. It may contain errors.
> > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > >
> > > syzbot will keep track of this bug report. See:
> > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> Good catch!  Does the patch below help?

Looks good to me, thanks for the quick fix.

Acked-by: Marco Elver <elver@google.com>

Thanks,
-- Marco

>                                                         Thanx, Paul
>
> ------------------------------------------------------------------------
>
> commit d2ab457602a59353b8853352735dfd094d223480
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Mon Nov 4 08:08:30 2019 -0800
>
>     srcu: Apply *_ONCE() to ->srcu_last_gp_end
>
>     The ->srcu_last_gp_end field is accessed from any CPU at any time
>     by synchronize_srcu(), so non-initialization references need to use
>     READ_ONCE() and WRITE_ONCE().  This commit therefore makes that change.
>
>     Reported-by: syzbot+08f3e9d26e5541e1ecf2@syzkaller.appspotmail.com
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index d0a9d5b..657e6a7 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -530,7 +530,7 @@ static void srcu_gp_end(struct srcu_struct *ssp)
>         idx = rcu_seq_state(ssp->srcu_gp_seq);
>         WARN_ON_ONCE(idx != SRCU_STATE_SCAN2);
>         cbdelay = srcu_get_delay(ssp);
> -       ssp->srcu_last_gp_end = ktime_get_mono_fast_ns();
> +       WRITE_ONCE(ssp->srcu_last_gp_end, ktime_get_mono_fast_ns());
>         rcu_seq_end(&ssp->srcu_gp_seq);
>         gpseq = rcu_seq_current(&ssp->srcu_gp_seq);
>         if (ULONG_CMP_LT(ssp->srcu_gp_seq_needed_exp, gpseq))
> @@ -762,6 +762,7 @@ static bool srcu_might_be_idle(struct srcu_struct *ssp)
>         unsigned long flags;
>         struct srcu_data *sdp;
>         unsigned long t;
> +       unsigned long tlast;
>
>         /* If the local srcu_data structure has callbacks, not idle.  */
>         local_irq_save(flags);
> @@ -780,9 +781,9 @@ static bool srcu_might_be_idle(struct srcu_struct *ssp)
>
>         /* First, see if enough time has passed since the last GP. */
>         t = ktime_get_mono_fast_ns();
> +       tlast = READ_ONCE(ssp->srcu_last_gp_end);
>         if (exp_holdoff == 0 ||
> -           time_in_range_open(t, ssp->srcu_last_gp_end,
> -                              ssp->srcu_last_gp_end + exp_holdoff))
> +           time_in_range_open(t, tlast, tlast + exp_holdoff))
>                 return false; /* Too soon after last GP. */
>
>         /* Next, check for probable idleness. */
