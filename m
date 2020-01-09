Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8829B13572F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 11:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgAIKjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 05:39:19 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38451 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728565AbgAIKjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 05:39:19 -0500
Received: by mail-qk1-f195.google.com with SMTP id k6so5493381qki.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 02:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9xn1JyxwI+0XYf3lA9v7eIZLbewUvsaljCIr7fZGL9k=;
        b=q1QWcwrCnl08/067UX9ehrJCgnmhtOPW1QlW69STMA/RkOsMz0a1T7zQeG0GjYT63/
         AKlg9YJ7EK89EZ3QNjPdDKWGFX06WR2NPoHHugwVbrwXPZs6yUC6YbLyc54k+CjFQJDS
         AyEZSJNCoOQ9DuXWzDL3Qx8xq+94sNQ9TBVcQSJCO+v33WrbYUQaiT5GJnZfwoWrFlxA
         ArSdz2eywNCIS4UbjzjwiCd0qmfQBntUkQftYLXWWNHTMOcQO4Qo6FtJ9C9T7NZ423+h
         kAQ7Pg/LTaccyFufr7O9T6GCDCQRj0psBPWXEE16Q1qqQpic2LOi/SiAtnC/Vv6DRn+G
         DkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9xn1JyxwI+0XYf3lA9v7eIZLbewUvsaljCIr7fZGL9k=;
        b=LRlIQiEQqFWANTbNoZnAkWuOxz7OABiF5YKspFeJen3VGGsst+lI/ReqNwswdBfkC4
         N5WQEd8OVO7rRHvlz4DGcKLpXkhzs5ctiv7LaWbdILyKgBXGVclK9FFwHtgx5Kxio0YW
         K7sa4/cVvaNyG6pvixTEzLefmLwY1PUjL1KO3IgxznzinfVYniRY2RLgMN8yLRo0uvax
         aEHzLjJHjPFra2xanQ4wKlVS5vuXenQFIDpT/I+mJH6jSFsfcyM7yIec/lyi9y4vg6Rr
         gUiC4V+CpNnRZcVf41wxO5d6Ddh01sitHEM1VXX9jeNUfuyTXbMvn9tTiAlppBFuCgrM
         Oq6g==
X-Gm-Message-State: APjAAAXDCDUGApHmra4DyuC1ou4wPoxlHLfy6Rv/1niz93cRS9K8iqm0
        3gCemeU0O8V2NT/sL2NAuGxpWEGWrQUxgJ7s0d5GLg==
X-Google-Smtp-Source: APXvYqwR10pvj9Kw+L8Bpj+xESu3TP6LqJiI8L2SY+O+b50qhoq33ZmomGs/rnUpmpLq/DiN78WrcxvrCboQbLAzqEw=
X-Received: by 2002:a37:e312:: with SMTP id y18mr8998740qki.250.1578566357984;
 Thu, 09 Jan 2020 02:39:17 -0800 (PST)
MIME-Version: 1.0
References: <00000000000036decf0598c8762e@google.com> <CACT4Y+YVMUxeLcFMray9n0+cXbVibj5X347LZr8YgvjN5nC8pw@mail.gmail.com>
 <CACT4Y+asdED7tYv462Ui2OhQVKXVUnC+=fumXR3qM1A4d6AvOQ@mail.gmail.com>
 <f7758e0a-a157-56a2-287e-3d4452d72e00@schaufler-ca.com> <87a787ekd0.fsf@dja-thinkpad.axtens.net>
 <87h81zax74.fsf@dja-thinkpad.axtens.net> <CACT4Y+b+Vx1FeCmhMAYq-g3ObHdMPOsWxouyXXUr7S5OjNiVGQ@mail.gmail.com>
 <0b60c93e-a967-ecac-07e7-67aea1a0208e@I-love.SAKURA.ne.jp>
 <6d009462-74d9-96e9-ab3f-396842a58011@schaufler-ca.com> <CACT4Y+bURugCpLm5TG37-7voFEeEoXo_Gb=3sy75_RELZotXHw@mail.gmail.com>
 <CACT4Y+avizeUd=nY2w1B_LbEC1cP5prBfpnANYaxhgS_fcL6ag@mail.gmail.com>
 <CACT4Y+Z3GCncV3G1=36NmDRX_XOZsdoRJ3UshZoornbSRSN28w@mail.gmail.com> <CACT4Y+ZyVi=ow+VXA9PaWEVE8qKj8_AKzeFsNdsmiSR9iL3FOw@mail.gmail.com>
In-Reply-To: <CACT4Y+ZyVi=ow+VXA9PaWEVE8qKj8_AKzeFsNdsmiSR9iL3FOw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 9 Jan 2020 11:39:06 +0100
Message-ID: <CACT4Y+axj5M4p=mZkFb1MyBw0MK1c6nWb-fKQcYSnYB8n1Cb8Q@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in sys_kill
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Daniel Axtens <dja@axtens.net>,
        Alexander Potapenko <glider@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+de8d933e7d153aa0c1bb@syzkaller.appspotmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 9, 2020 at 11:05 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > > > On 1/8/2020 2:25 AM, Tetsuo Handa wrote:
> > > > > > On 2020/01/08 15:20, Dmitry Vyukov wrote:
> > > > > >> I temporarily re-enabled smack instance and it produced another 50
> > > > > >> stalls all over the kernel, and now keeps spewing a dozen every hour.
> > > > >
> > > > > Do I have to be using clang to test this? I'm setting up to work on this,
> > > > > and don't want to waste time using my current tool chain if the problem
> > > > > is clang specific.
> > > >
> > > > Humm, interesting. Initially I was going to say that most likely it's
> > > > not clang-related. Bug smack instance is actually the only one that
> > > > uses clang as well (except for KMSAN of course). So maybe it's indeed
> > > > clang-related rather than smack-related. Let me try to build a kernel
> > > > with clang.
> > >
> > > +clang-built-linux, glider
> > >
> > > [clang-built linux is severe broken since early Dec]
> > >
> > > Building kernel with clang I can immediately reproduce this locally:
> > >
> > > $ syz-manager
> > > 2020/01/09 09:27:15 loading corpus...
> > > 2020/01/09 09:27:17 serving http on http://0.0.0.0:50001
> > > 2020/01/09 09:27:17 serving rpc on tcp://[::]:45851
> > > 2020/01/09 09:27:17 booting test machines...
> > > 2020/01/09 09:27:17 wait for the connection from test machine...
> > > 2020/01/09 09:29:23 machine check:
> > > 2020/01/09 09:29:23 syscalls                : 2961/3195
> > > 2020/01/09 09:29:23 code coverage           : enabled
> > > 2020/01/09 09:29:23 comparison tracing      : enabled
> > > 2020/01/09 09:29:23 extra coverage          : enabled
> > > 2020/01/09 09:29:23 setuid sandbox          : enabled
> > > 2020/01/09 09:29:23 namespace sandbox       : enabled
> > > 2020/01/09 09:29:23 Android sandbox         : /sys/fs/selinux/policy
> > > does not exist
> > > 2020/01/09 09:29:23 fault injection         : enabled
> > > 2020/01/09 09:29:23 leak checking           : CONFIG_DEBUG_KMEMLEAK is
> > > not enabled
> > > 2020/01/09 09:29:23 net packet injection    : enabled
> > > 2020/01/09 09:29:23 net device setup        : enabled
> > > 2020/01/09 09:29:23 concurrency sanitizer   : /sys/kernel/debug/kcsan
> > > does not exist
> > > 2020/01/09 09:29:23 devlink PCI setup       : PCI device 0000:00:10.0
> > > is not available
> > > 2020/01/09 09:29:27 corpus                  : 50226 (0 deleted)
> > > 2020/01/09 09:29:27 VMs 20, executed 0, cover 0, crashes 0, repro 0
> > > 2020/01/09 09:29:37 VMs 20, executed 45, cover 0, crashes 0, repro 0
> > > 2020/01/09 09:29:47 VMs 20, executed 74, cover 0, crashes 0, repro 0
> > > 2020/01/09 09:29:57 VMs 20, executed 80, cover 0, crashes 0, repro 0
> > > 2020/01/09 09:30:07 VMs 20, executed 80, cover 0, crashes 0, repro 0
> > > 2020/01/09 09:30:17 VMs 20, executed 80, cover 0, crashes 0, repro 0
> > > 2020/01/09 09:30:27 VMs 20, executed 80, cover 0, crashes 0, repro 0
> > > 2020/01/09 09:30:37 VMs 20, executed 80, cover 0, crashes 0, repro 0
> > > 2020/01/09 09:30:47 VMs 20, executed 80, cover 0, crashes 0, repro 0
> > > 2020/01/09 09:30:57 VMs 20, executed 80, cover 0, crashes 0, repro 0
> > > 2020/01/09 09:31:07 VMs 20, executed 80, cover 0, crashes 0, repro 0
> > > 2020/01/09 09:31:17 VMs 20, executed 80, cover 0, crashes 0, repro 0
> > > 2020/01/09 09:31:26 vm-10: crash: INFO: rcu detected stall in do_idle
> > > 2020/01/09 09:31:27 VMs 13, executed 80, cover 0, crashes 0, repro 0
> > > 2020/01/09 09:31:28 vm-1: crash: INFO: rcu detected stall in sys_futex
> > > 2020/01/09 09:31:29 vm-4: crash: INFO: rcu detected stall in sys_futex
> > > 2020/01/09 09:31:31 vm-0: crash: INFO: rcu detected stall in sys_getsockopt
> > > 2020/01/09 09:31:33 vm-18: crash: INFO: rcu detected stall in sys_clone3
> > > 2020/01/09 09:31:35 vm-3: crash: INFO: rcu detected stall in sys_futex
> > > 2020/01/09 09:31:36 vm-8: crash: INFO: rcu detected stall in do_idle
> > > 2020/01/09 09:31:37 VMs 7, executed 80, cover 0, crashes 6, repro 0
> > > 2020/01/09 09:31:38 vm-19: crash: INFO: rcu detected stall in schedule_tail
> > > 2020/01/09 09:31:40 vm-6: crash: INFO: rcu detected stall in schedule_tail
> > > 2020/01/09 09:31:42 vm-2: crash: INFO: rcu detected stall in schedule_tail
> > > 2020/01/09 09:31:44 vm-12: crash: INFO: rcu detected stall in sys_futex
> > > 2020/01/09 09:31:46 vm-15: crash: INFO: rcu detected stall in sys_nanosleep
> > > 2020/01/09 09:31:47 VMs 1, executed 80, cover 0, crashes 11, repro 0
> > > 2020/01/09 09:31:48 vm-16: crash: INFO: rcu detected stall in sys_futex
> > > 2020/01/09 09:31:50 vm-9: crash: INFO: rcu detected stall in schedule
> > > 2020/01/09 09:31:52 vm-13: crash: INFO: rcu detected stall in schedule_tail
> > > 2020/01/09 09:31:54 vm-11: crash: INFO: rcu detected stall in schedule_tail
> > > 2020/01/09 09:31:56 vm-17: crash: INFO: rcu detected stall in sys_futex
> > > 2020/01/09 09:31:57 VMs 0, executed 80, cover 0, crashes 16, repro 0
> > > 2020/01/09 09:31:58 vm-7: crash: INFO: rcu detected stall in sys_futex
> > > 2020/01/09 09:32:00 vm-5: crash: INFO: rcu detected stall in dput
> > > 2020/01/09 09:32:02 vm-14: crash: INFO: rcu detected stall in sys_nanosleep
> > >
> > >
> > > Then I switched LSM to selinux and I _still_ can reproduce this. So,
> > > Casey, you may relax, this is not smack-specific :)
> > >
> > > Then I disabled CONFIG_KASAN_VMALLOC and CONFIG_VMAP_STACK and it
> > > started working normally.
> > >
> > > So this is somehow related to both clang and KASAN/VMAP_STACK.
> > >
> > > The clang I used is:
> > > https://storage.googleapis.com/syzkaller/clang-kmsan-362913.tar.gz
> > > (the one we use on syzbot).
> >
> >
> > Clustering hangs, they all happen within very limited section of the code:
> >
> >       1  free_thread_stack+0x124/0x590 kernel/fork.c:284
> >       5  free_thread_stack+0x12e/0x590 kernel/fork.c:280
> >      39  free_thread_stack+0x12e/0x590 kernel/fork.c:284
> >       6  free_thread_stack+0x133/0x590 kernel/fork.c:280
> >       5  free_thread_stack+0x13d/0x590 kernel/fork.c:280
> >       2  free_thread_stack+0x141/0x590 kernel/fork.c:280
> >       6  free_thread_stack+0x14c/0x590 kernel/fork.c:280
> >       9  free_thread_stack+0x151/0x590 kernel/fork.c:280
> >       3  free_thread_stack+0x15b/0x590 kernel/fork.c:280
> >      67  free_thread_stack+0x168/0x590 kernel/fork.c:280
> >       6  free_thread_stack+0x16d/0x590 kernel/fork.c:284
> >       2  free_thread_stack+0x177/0x590 kernel/fork.c:284
> >       1  free_thread_stack+0x182/0x590 kernel/fork.c:284
> >       1  free_thread_stack+0x186/0x590 kernel/fork.c:284
> >      16  free_thread_stack+0x18b/0x590 kernel/fork.c:284
> >       4  free_thread_stack+0x195/0x590 kernel/fork.c:284
> >
> > Here is disass of the function:
> > https://gist.githubusercontent.com/dvyukov/a283d1aaf2ef7874001d56525279ccbd/raw/ac2478bff6472bc473f57f91a75f827cd72bb6bf/gistfile1.txt
> >
> > But if I am not mistaken, the function only ever jumps down. So how
> > can it loop?...
>
>
> This is a miscompilation related to static branches.
>
> objdump shows:
>
> ffffffff814878f8: 0f 1f 44 00 00        nopl   0x0(%rax,%rax,1)
>  ./arch/x86/include/asm/jump_label.h:25
> asm_volatile_goto("1:"
>
> However, the actual instruction in memory at the time is:
>
>    0xffffffff814878f8 <+408>: jmpq   0xffffffff8148787f <free_thread_stack+287>
>
> Which jumps to a wrong location in free_thread_stack and makes it loop.
>
> The static branch is this:
>
> static inline bool memcg_kmem_enabled(void)
> {
>   return static_branch_unlikely(&memcg_kmem_enabled_key);
> }
>
> static inline void memcg_kmem_uncharge(struct page *page, int order)
> {
>   if (memcg_kmem_enabled())
>     __memcg_kmem_uncharge(page, order);
> }
>
> I suspect it may have something to do with loop unrolling. It may jump
> to the right location, but in the wrong unrolled iteration.


Kernel built with clang version 10.0.0
(https://github.com/llvm/llvm-project.git
c2443155a0fb245c8f17f2c1c72b6ea391e86e81) works fine.

Alex, please update clang on syzbot machines.
