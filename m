Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF60218FB0C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 18:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbgCWRMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 13:12:25 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:34862 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbgCWRMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 13:12:24 -0400
Received: by mail-vs1-f66.google.com with SMTP id m9so9278069vso.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 10:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dZW5kJGjaJLVfHgqTtdCBKkBvciSHUN1uP2ys+t7nnY=;
        b=V6na2s0THD8R1HojVheC0CZ68DIl/SEWqstGzu4lyupxHyEGOF4ZmZIJxLlEH2EEBV
         McAntr0FUpbKNDu8ttJXk/9F1N/KC7gsUYg8avKmD+ZN5ztOBFj1/0yO2dO+yJpn8cE7
         wlhYbJSS8LO6ZM+fQgYI3k2topfqAsFOa54Xjgp2F3B7b7K/NjPzXaM+HZ0Cr7EFH/TH
         0WGK5JCo1j70ttSD6Mp1ndOpb0Coo0RSygGyvl0XMkJrgiZGVTZffh8lQA3+Mi42/1tW
         riEjK5CGB/sztiAY7vgacJnbNkKjC1ToYEhTNR626cbdvV33xhxe1Ug9TiHWaUpQaX/S
         MuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dZW5kJGjaJLVfHgqTtdCBKkBvciSHUN1uP2ys+t7nnY=;
        b=EhsIIjnOu8enDSTF1eevba5RKKN++YD16ObO068eEY6VW0RBG41tf/Lr155wtWGIP+
         YqVPtRzduhaMSkrWikYMzX341X2gtYHW90iwyzlmq5JcNEW0ewyWsYnCfNWLkmBswQEd
         7ib8WCa15MC6DaMx2d/YdY4eO91UVqoAX+KSd0DjTwISOApAAzetqW7lSWxio1wEBzNW
         fDsLtXZoQAeVY4b/lU9bIGIyvgigLCLWuRc9fdyZxkoeLkFwI5egN25SF5K4g547c9OE
         qmjS1Rr+qYYsBjHZBlSdanNF7LBstzBmG/RDh54gcBNYDatIIoEUAu0eogEZCIvYydoC
         PZyw==
X-Gm-Message-State: ANhLgQ0KOXJAORDd3jvty/17Py6wZVyI9kwXL31QRP0MnirlejNA+aCU
        QYdkg8+FZ1XKvgJwOH/CaraX/v/oEH1QbAwH3BGMrQ==
X-Google-Smtp-Source: ADFU+vvhrzocxaqHGG+7TdHryCbguEw8uzoJw2Cyo3MclMMGBxwRLi9i+NAFUN4fgqG2fn9CIz/kYXlagougFxS9t7Y=
X-Received: by 2002:a05:6102:3d4:: with SMTP id n20mr1045369vsq.39.1584983541786;
 Mon, 23 Mar 2020 10:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000000bec9805a1581f05@google.com> <CACT4Y+Z_ZuQmDqq=0kKZuKAe=Dme=UsOnES6h9Y8vRmw2v3WmA@mail.gmail.com>
In-Reply-To: <CACT4Y+Z_ZuQmDqq=0kKZuKAe=Dme=UsOnES6h9Y8vRmw2v3WmA@mail.gmail.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Mon, 23 Mar 2020 10:12:09 -0700
Message-ID: <CAHRSSExC-Q4PYV629XWkbCjLN55G2A=EDB3kMLN=KK4ZoFSmCw@mail.gmail.com>
Subject: Re: INFO: task hung in blk_trace_remove
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+c07afbbb410e9f712273@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 21, 2020 at 12:15 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Sat, Mar 21, 2020 at 8:12 AM syzbot
> <syzbot+c07afbbb410e9f712273@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    fb33c651 Linux 5.6-rc6
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=140688d3e00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=9f894bd92023de02
> > dashboard link: https://syzkaller.appspot.com/bug?extid=c07afbbb410e9f712273
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+c07afbbb410e9f712273@syzkaller.appspotmail.com
>
> +ashmem maintainers

We'll have a look.

>
> From the log, ashmem spews an infinite sequence of some errors which
> probably stall the machine:
>
> [ 1094.685541][ T9460] vmscan: shrink_slab:
> ashmem_shrink_scan+0x0/0x500 negative objects to delete
> nr=-6917529027641097791
> [ 1094.701750][ T7239] vmscan: shrink_slab:
> ashmem_shrink_scan+0x0/0x500 negative objects to delete
> nr=-6917529027641383141
> [ 1094.708003][ T9576] vmscan: shrink_slab:
> ashmem_shrink_scan+0x0/0x500 negative objects to delete
> nr=-6917529027641233534
> [ 1094.723597][ T1876] vmscan: shrink_slab:
> ashmem_shrink_scan+0x0/0x500 negative objects to delete
> nr=-6917529027641083174
> [ 1094.730025][ T9460] vmscan: shrink_slab:
> ashmem_shrink_scan+0x0/0x500 negative objects to delete
> nr=-6917529027641098111
> [ 1094.745592][ T7239] vmscan: shrink_slab:
> ashmem_shrink_scan+0x0/0x500 negative objects to delete
> nr=-6917529027641383221
> [ 1094.753153][ T9576] vmscan: shrink_slab:
> ashmem_shrink_scan+0x0/0x500 negative objects to delete
> nr=-6917529027641233534
> [ 1094.767903][ T1876] vmscan: shrink_slab:
> ashmem_shrink_scan+0x0/0x500 negative objects to delete
> nr=-6917529027641084454
> [ 1094.819845][ T7239] vmscan: shrink_slab:
> ashmem_shrink_scan+0x0/0x500 negative objects to delete
> nr=-6917529027641526579
> [ 1094.830116][ T9460] vmscan: shrink_slab:
> ashmem_shrink_scan+0x0/0x500 negative objects to delete
> nr=-6917529027641098111
> [ 1094.845813][ T7239] vmscan: shrink_slab:
> ashmem_shrink_scan+0x0/0x500 negative objects to delete
> nr=-6917529027641527219
> [ 1094.852188][ T9460] vmscan: shrink_slab:
> ashmem_shrink_scan+0x0/0x500 negative objects to delete
> nr=-6917529027641098751
> [ 1094.871456][ T7239] vmscan: shrink_slab:
> ashmem_shrink_scan+0x0/0x500 negative objects to delete
> nr=-6917529027641527219
> [ 1094.874256][ T9460] vmscan: shrink_slab:
> ashmem_shrink_scan+0x0/0x500 negative objects to delete
> nr=-6917529027641098751
> [ 1094.890195][ T7239] vmscan: shrink_slab:
> ashmem_shrink_scan+0x0/0x500 negative objects to delete
> nr=-6917529027641528499
> [ 1094.895999][ T1876] vmscan: shrink_slab:
> ashmem_shrink_scan+0x0/0x500 negative objects to delete
> nr=-6917529027641087014
> [ 1094.912931][ T7239] vmscan: shrink_slab:
> ashmem_shrink_scan+0x0/0x500 negative objects to delete
> nr=-6917529027641528499
> [ 1094.918797][ T9460] vmscan: shrink_slab:
> ashmem_shrink_scan+0x0/0x500 negative objects to delete
> nr=-6917529027641100031
> [ 1094.936636][ T7239] vmscan: shrink_slab:
> ashmem_shrink_scan+0x0/0x500 negative objects to delete
> nr=-6917529027641531059
> [ 1094.941391][ T1876] vmscan: shrink_slab:
> ashmem_shrink_scan+0x0/0x500 negative objects to delete
> nr=-6917529027641081897
> [ 1094.957463][ T7239] vmscan: shrink_slab:
> ashmem_shrink_scan+0x0/0x500 negative objects to delete
> nr=-6917529027641531059
> [ 1094.963568][ T9460] vmscan: shrink_slab:
> ashmem_shrink_scan+0x0/0x500 negative objects to delete
> nr=-6917529027641100031
> [ 1094.980233][ T7239] vmscan: shrink_slab:
> ashmem_shrink_scan+0x0/0x500 negative objects to delete
> nr=-6917529027641536179
> [ 1094.985311][ T1876] vmscan: shrink_slab:
> ashmem_shrink_scan+0x0/0x500 negative objects to delete
> nr=-6917529027641081899
> [ 1095.001393][ T7239] vmscan: shrink_slab:
> ashmem_shrink_scan+0x0/0x500 negative objects to delete
> nr=-6917529027641536179
> [ 1095.008146][ T9460] vmscan: shrink_slab:
> ashmem_shrink_scan+0x0/0x500 negative objects to delete
> nr=-6917529027641102591
> [ 1095.024425][ T7239] vmscan: shrink_slab:
> ashmem_shrink_scan+0x0/0x500 negative objects to delete
> nr=-6917529027641525942
> [ 1095.029644][ T1876] vmscan: shrink_slab:
> ashmem_shrink_scan+0x0/0x500 negative objects to delete
> nr=-6917529027641081904
> [ 1095.046399][ T7239] vmscan: shrink_slab:
> ashmem_shrink_scan+0x0/0x500 negative objects to delete
> nr=-6917529027641525942
> [ 1095.052377][ T9460] vmscan: shrink_slab:
> ashmem_shrink_scan+0x0/0x500 negative objects to delete
> nr=-6917529027641102591
> [ 1095.068000][ T7239] vmscan: shrink_slab:
> ashmem_shrink_scan+0x0/0x500 negative objects to delete
> nr=-6917529027641525944
> [ 1095.073934][ T1876] vmscan: shrink_slab:
> ashmem_shrink_scan+0x0/0x500 negative objects to delete
> nr=-6917529027641081914
> [ 1095.091076][ T7239] vmscan: shrink_slab:
> ashmem_shrink_scan+0x0/0x500 negative objects to delete
> nr=-6917529027641525944
> [ 1095.096925][ T9460] vmscan: shrink_slab:
> ashmem_shrink_scan+0x0/0x500 negative objects to delete
> nr=-6917529027641107711
> [ 1095.112305][ T7239] vmscan: shrink_slab:
> ashmem_shrink_scan+0x0/0x500 negative objects to delete
> nr=-6917529027641525949
> [ 1095.118570][ T1876] vmscan: shrink_slab:
> ashmem_shrink_scan+0x0/0x500 negative objects to delete
> nr=-6917529027641081934
> [ 1095.135413][ T7239] vmscan: shrink_slab:
> ashmem_shrink_scan+0x0/0x500 negative objects to delete
> nr=-6917529027641525949
> [ 1095.141206][ T9460] vmscan: shrink_slab:
> ashmem_shrink_scan+0x0/0x500 negative objects to delete
> nr=-6917529027641107711
>
>
>
> > INFO: task syz-executor.4:7237 blocked for more than 143 seconds.
> >       Not tainted 5.6.0-rc6-syzkaller #0
> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > syz-executor.4  D26576  7237   9609 0x00004004
> > Call Trace:
> >  schedule+0xd0/0x2a0 kernel/sched/core.c:4154
> >  schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:4213
> >  __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
> >  __mutex_lock+0x7ab/0x13c0 kernel/locking/mutex.c:1103
> >  blk_trace_remove+0x1e/0x40 kernel/trace/blktrace.c:361
> >  sg_ioctl_common+0x221/0x2710 drivers/scsi/sg.c:1125
> >  sg_ioctl+0x8f/0x120 drivers/scsi/sg.c:1159
> >  vfs_ioctl fs/ioctl.c:47 [inline]
> >  ksys_ioctl+0x11a/0x180 fs/ioctl.c:763
> >  __do_sys_ioctl fs/ioctl.c:772 [inline]
> >  __se_sys_ioctl fs/ioctl.c:770 [inline]
> >  __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:770
> >  do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:294
> >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > RIP: 0033:0x45c849
> > Code: Bad RIP value.
> > RSP: 002b:00007f5ba5a3bc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 00007f5ba5a3c6d4 RCX: 000000000045c849
> > RDX: 0000000000000000 RSI: 0000000000001276 RDI: 0000000000000003
> > RBP: 000000000076bf00 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
> > R13: 000000000000022b R14: 00000000004c4526 R15: 000000000076bf0c
> > INFO: task syz-executor.4:7266 blocked for more than 146 seconds.
> >       Not tainted 5.6.0-rc6-syzkaller #0
> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > syz-executor.4  D27752  7266   9609 0x00004004
> > Call Trace:
> >  schedule+0xd0/0x2a0 kernel/sched/core.c:4154
> >  schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:4213
> >  __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
> >  __mutex_lock+0x7ab/0x13c0 kernel/locking/mutex.c:1103
> >  blk_trace_setup+0x2f/0x60 kernel/trace/blktrace.c:588
> >  sg_ioctl_common+0x2f2/0x2710 drivers/scsi/sg.c:1116
> >  sg_ioctl+0x8f/0x120 drivers/scsi/sg.c:1159
> >  vfs_ioctl fs/ioctl.c:47 [inline]
> >  ksys_ioctl+0x11a/0x180 fs/ioctl.c:763
> >  __do_sys_ioctl fs/ioctl.c:772 [inline]
> >  __se_sys_ioctl fs/ioctl.c:770 [inline]
> >  __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:770
> >  do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:294
> >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > RIP: 0033:0x45c849
> > Code: Bad RIP value.
> > RSP: 002b:00007f5ba5a1ac78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 00007f5ba5a1b6d4 RCX: 000000000045c849
> > RDX: 0000000020000080 RSI: 00000000c0481273 RDI: 0000000000000008
> > RBP: 000000000076bfa0 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
> > R13: 0000000000000228 R14: 00000000004c44eb R15: 000000000076bfac
> > INFO: task syz-executor.5:7265 blocked for more than 149 seconds.
> >       Not tainted 5.6.0-rc6-syzkaller #0
> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > syz-executor.5  D26736  7265   9613 0x00004004
> > Call Trace:
> >  schedule+0xd0/0x2a0 kernel/sched/core.c:4154
> >  schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:4213
> >  __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
> >  __mutex_lock+0x7ab/0x13c0 kernel/locking/mutex.c:1103
> >  blk_trace_setup+0x2f/0x60 kernel/trace/blktrace.c:588
> >  sg_ioctl_common+0x2f2/0x2710 drivers/scsi/sg.c:1116
> >  sg_ioctl+0x8f/0x120 drivers/scsi/sg.c:1159
> >  vfs_ioctl fs/ioctl.c:47 [inline]
> >  ksys_ioctl+0x11a/0x180 fs/ioctl.c:763
> >  __do_sys_ioctl fs/ioctl.c:772 [inline]
> >  __se_sys_ioctl fs/ioctl.c:770 [inline]
> >  __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:770
> >  do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:294
> >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > RIP: 0033:0x45c849
> > Code: Bad RIP value.
> > RSP: 002b:00007f576f48ac78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 00007f576f48b6d4 RCX: 000000000045c849
> > RDX: 0000000020000080 RSI: 00000000c0481273 RDI: 0000000000000006
> >
> >
> > ---
> > This bug is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this bug report. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > --
> > You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000000bec9805a1581f05%40google.com.
