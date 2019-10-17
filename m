Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC1D3DB63A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 20:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404708AbfJQSdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Oct 2019 14:33:12 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37352 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731227AbfJQSdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 14:33:12 -0400
Received: by mail-oi1-f195.google.com with SMTP id i16so3034092oie.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 11:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SeNS1mszIYg47Gf6phLQe9gpL6k5/Daun7T9IBCmzZE=;
        b=MWYc6PciC370wUG/bLJf6TqLQ5PqzHBkTVMqSRY+biAIl26gaCA3FSQBOa5a4E5Pzz
         hg5eG0h3O89uEXNugIwgmO0I44gjmMbKSwjnlnBOH45xfzzvg50cAFdxMLOrYP7DG34I
         04NwlZLj/jK2XTvyNRCw4SRNh3zDkKFyuQFJp8zgQu9EcMLnsDjSdyWUfnu2MqVSD7ue
         08O2t6N3YFmoEG78mhAvvKK47AW4BCbAWSqLNLCNGWM2gsXgHn51ASSkdF/Ea8ls/KV8
         sTQA20kgHpSKEbY+sFsyggvimw41r6SEblKtBYZOQJtFc4xQxikhK+iR23Gj1irfwSq0
         6WkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SeNS1mszIYg47Gf6phLQe9gpL6k5/Daun7T9IBCmzZE=;
        b=Tu2E6rrJGtiZ6c+/39ywMMvWUSx1Y0pU0JgtRZDg3jO7WLVuq4E7SXdN+CXWratj0o
         1CphUfT0E7Go5JL9CZ9O6Ibxp2oIWuey7TdPzQ8MhdL1r1LcsGm9n8raDuHY07we1YB+
         G5VsapNSh/rnlHjlM8zxHtpyWfc+QQu8CCmCyapHRdK+zSucasJCX/hcfpryaJGWzLmk
         pKax46Jd9+rFfTgC5qQGFNoRix717Nfc+c0FVYjje2kuP6DXY4b1Jy9mLqL9Ro7tGBwR
         Gs0gkREZMpx+oI5SyqGcDlrOoKqarvIJHu1pqJ/K6oXrudUSuVuyHF66LzdVEGrw/aZ/
         R5Kw==
X-Gm-Message-State: APjAAAW6b2H6IWZixf244HYXRI/cIJ8sIorsIVucHB7CTcVXYayXJKtK
        2B5CIaIhZd29tGUKqDoN9hPectpEAWQwFqJISajG1u7qSPuF1A==
X-Google-Smtp-Source: APXvYqybNjA3gcf3SlQhlkGWIifNuAAwnhq/fO6+CZ6yApLMowZCl6h0aR3AQnhyjXPXh+8I6YvFq14hu/TCorbCje0=
X-Received: by 2002:aca:f1a:: with SMTP id 26mr4519807oip.172.1571337189006;
 Thu, 17 Oct 2019 11:33:09 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000328b2905951a7667@google.com> <CANpmjNPoBBJgMKLEAXs+bPhitF+WygseHgTkSJsuiK8WcsB==g@mail.gmail.com>
 <20191017181709.GA5312@avx2>
In-Reply-To: <20191017181709.GA5312@avx2>
From:   Marco Elver <elver@google.com>
Date:   Thu, 17 Oct 2019 20:32:57 +0200
Message-ID: <CANpmjNOkpOQsmQKYLAJ1iuj6UYJqyY6PRaYXSyWbF=omfnj6Uw@mail.gmail.com>
Subject: Re: KCSAN: data-race in task_dump_owner / task_dump_owner
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     syzbot <syzbot+e392f8008a294fdf8891@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        casey@schaufler-ca.com, christian@brauner.io,
        Kees Cook <keescook@chromium.org>, kent.overstreet@gmail.com,
        khlebnikov@yandex-team.ru, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, mhocko@suse.com,
        Shakeel Butt <shakeelb@google.com>,
        syzkaller-bugs@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Oct 2019 at 20:17, Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> On Thu, Oct 17, 2019 at 02:56:47PM +0200, Marco Elver wrote:
> > Hi,
> >
> > On Thu, 17 Oct 2019 at 14:36, syzbot
> > <syzbot+e392f8008a294fdf8891@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    d724f94f x86, kcsan: Enable KCSAN for x86
> > > git tree:       https://github.com/google/ktsan.git kcsan
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=17884db3600000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=c0906aa620713d80
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=e392f8008a294fdf8891
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > >
> > > Unfortunately, I don't have any reproducer for this crash yet.
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+e392f8008a294fdf8891@syzkaller.appspotmail.com
> > >
> > > ==================================================================
> > > BUG: KCSAN: data-race in task_dump_owner / task_dump_owner
> > >
> > > write to 0xffff8881255bb7fc of 4 bytes by task 7804 on cpu 0:
> > >   task_dump_owner+0xd8/0x260 fs/proc/base.c:1742
> > >   pid_update_inode+0x3c/0x70 fs/proc/base.c:1818
> > >   pid_revalidate+0x91/0xd0 fs/proc/base.c:1841
> > >   d_revalidate fs/namei.c:765 [inline]
> > >   d_revalidate fs/namei.c:762 [inline]
> > >   lookup_fast+0x7cb/0x7e0 fs/namei.c:1613
> > >   walk_component+0x6d/0xe80 fs/namei.c:1804
> > >   link_path_walk.part.0+0x5d3/0xa90 fs/namei.c:2139
> > >   link_path_walk fs/namei.c:2070 [inline]
> > >   path_openat+0x14f/0x3530 fs/namei.c:3532
> > >   do_filp_open+0x11e/0x1b0 fs/namei.c:3563
> > >   do_sys_open+0x3b3/0x4f0 fs/open.c:1089
> > >   __do_sys_open fs/open.c:1107 [inline]
> > >   __se_sys_open fs/open.c:1102 [inline]
> > >   __x64_sys_open+0x55/0x70 fs/open.c:1102
> > >   do_syscall_64+0xcf/0x2f0 arch/x86/entry/common.c:296
> > >   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > >
> > > write to 0xffff8881255bb7fc of 4 bytes by task 7813 on cpu 1:
> > >   task_dump_owner+0xd8/0x260 fs/proc/base.c:1742
> > >   pid_update_inode+0x3c/0x70 fs/proc/base.c:1818
> > >   pid_revalidate+0x91/0xd0 fs/proc/base.c:1841
> > >   d_revalidate fs/namei.c:765 [inline]
> > >   d_revalidate fs/namei.c:762 [inline]
> > >   lookup_fast+0x7cb/0x7e0 fs/namei.c:1613
> > >   walk_component+0x6d/0xe80 fs/namei.c:1804
> > >   lookup_last fs/namei.c:2271 [inline]
> > >   path_lookupat.isra.0+0x13a/0x5a0 fs/namei.c:2316
> > >   filename_lookup+0x145/0x2d0 fs/namei.c:2346
> > >   user_path_at_empty+0x4c/0x70 fs/namei.c:2606
> > >   user_path_at include/linux/namei.h:60 [inline]
> > >   vfs_statx+0xd9/0x190 fs/stat.c:187
> > >   vfs_stat include/linux/fs.h:3188 [inline]
> > >   __do_sys_newstat+0x51/0xb0 fs/stat.c:341
> > >   __se_sys_newstat fs/stat.c:337 [inline]
> > >   __x64_sys_newstat+0x3a/0x50 fs/stat.c:337
> > >   do_syscall_64+0xcf/0x2f0 arch/x86/entry/common.c:296
> > >   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > >
> > > Reported by Kernel Concurrency Sanitizer on:
> > > CPU: 1 PID: 7813 Comm: ps Not tainted 5.3.0+ #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > > Google 01/01/2011
> > > ==================================================================
> >
> > My understanding is, that for every access to /proc/<pid>,
> > d_revalidate is called, and /proc-fs implementation simply says that
> > pid_revalidate always revalidates by rewriting uid/gid because "owning
> > task may have performed a setuid(), etc." presumably so every access
> > to a /proc/<pid> entry always has the right uid/gid (in effect
> > updating /proc/<pid> lazily via d_revalidate).
> >
> > Is it possible that one of the tasks above could be preempted after
> > doing its writes to *ruid/*rgid, another thread writing some other
> > values (after setuid / seteuid), and then the preempted thread seeing
> > the other values? Assertion here should never fail:
> > === TASK 1 ===
> > | seteuid(1000);
> > | seteuid(0);
> > | stat("/proc/<pid-of-task-1>", &fstat);
> > | assert(fstat.st_uid == 0);
> > === TASK 2 ===
> > | stat("/proc/<pid-of-task-1>", ...);
>
> Is it the same as
> pid_revalidate() snapshots (uid,gid) correctly
> but writeback is done in any order?

Yes, I think so. Snapshot is done in RCU reader critical section, but
the writes can race with another thread. Is there logic that ensures
this doesn't lead to the observable outcome above?
