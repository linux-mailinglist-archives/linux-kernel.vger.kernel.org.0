Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1FB4175A9B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 13:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgCBMfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 07:35:04 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:41555 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbgCBMfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 07:35:03 -0500
Received: by mail-vk1-f196.google.com with SMTP id y201so2879072vky.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 04:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uzcQiw5bmowt4+ulow/RplAnqB+Uaeou/IGgfRNu6BY=;
        b=fO7oLiXzPRKQPba+voegh2apwnuQlM/BjsEMB5z3mgFhslsVplpSFNRCJQ1xwtsZ6G
         Mk1tqFJHS7WArliEtpqf4A+y5AZy7OnwGrJ8V3Tt85OXKyAAQ/G+JZf/5LycM89GzxtF
         yO7+dWorbsSIin6ccAB79DTVSRBfWH7jPqt1k6E6+d/dSpvshtFxpj9g0bZweNa8BLC8
         9RZs1j0xaR/CYCPUFJ0gKkoRhchY0l1Irfm7I5NLaprd0LOUZFuuBGLMYf/TEvX9V4df
         OLgfu/DVEJZ8VhNnBsMrTQK7xBwt6clX/spAK0iRpcuChoUpJ0YgCbODYY5M11C+wMpF
         SrUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uzcQiw5bmowt4+ulow/RplAnqB+Uaeou/IGgfRNu6BY=;
        b=dMwSTsGyTY6nf5l5WpX+TcrM/vDPWaTK9Bm7j00syrmiVmsOt4TtKU1QfFx2hT/Wgx
         s4xBsld+9jsqLoZcIyDs+6xkeW6W1rJHOONn3qaVGkqzb19GgopNU7PpVst6SYkS+adm
         OZvM/dS3u8XHf0zHck1DX3j5XwYkqy0hGc+Ajh3pdzat0sW4vg2egwaJT4R2PGtAXiJB
         sChis2x1djnr6BR/+TCghj7TJkkm/Z0Ek6W47CZaL/+ah1PDCKEH3okcECb6wdKLQJXs
         whrZzTO+KqXXSAnwi16WQYzpIZc+FdfGFDMMRFh3ZVDT6BdsK4v0nLr62ycc/FoSKZFV
         Kq7w==
X-Gm-Message-State: ANhLgQ3s6/WO89KjFvoja1uoI1ufkyS+XIzSzCkoZ4yirnDQla6mVJVA
        DV8cisLxOyxoxN1ldh7Mr3fDRl2+hgOmcQJ5N4pQEA==
X-Google-Smtp-Source: ADFU+vv1Ix4lqUJj1Zwh8N0IaleUdxli6lUO6WccegGqHmVmzk7zMOAn34MAm7qmk0j/zN7sxXbwHPZwYq8L0HLp4CE=
X-Received: by 2002:a1f:9d8a:: with SMTP id g132mr8967505vke.39.1583152500830;
 Mon, 02 Mar 2020 04:35:00 -0800 (PST)
MIME-Version: 1.0
References: <000000000000d3e319059fcfdc98@google.com> <CAOQ4uxh=tLw1p8vsbzTTqrTzLSqr33WtVHek+Jhbi5C2HKQLTA@mail.gmail.com>
 <CACT4Y+YBOm-VeHXuRnk4mLgwsEMx2MYrOnQ-FJpBjg5dDU_YzQ@mail.gmail.com> <CAOQ4uxh=3XWOfKAJMeJBrsfouLEDo3oqTNoYBMZ2f46mVRigvA@mail.gmail.com>
In-Reply-To: <CAOQ4uxh=3XWOfKAJMeJBrsfouLEDo3oqTNoYBMZ2f46mVRigvA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 2 Mar 2020 13:34:49 +0100
Message-ID: <CACT4Y+aBvofv8AQqiWr7M77FODSUqruMMoVcHHA5ROfv5VN7tw@mail.gmail.com>
Subject: Re: WARNING: bad unlock balance in ovl_llseek
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     syzbot <syzbot+66a9752fa927f745385e@syzkaller.appspotmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Miklos Szeredi <mszeredi@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 2, 2020 at 1:10 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > On Sun, Mar 1, 2020 at 9:13 PM syzbot
> > > <syzbot+66a9752fa927f745385e@syzkaller.appspotmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > syzbot found the following crash on:
> > > >
> > > > HEAD commit:    f8788d86 Linux 5.6-rc3
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=13c5f8f9e00000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=5d2e033af114153f
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=66a9752fa927f745385e
> > > > compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=131d9a81e00000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14117a81e00000
> > > >
> > >
> > > Dmitry,
> > >
> > > There is something strange about the C repro.
> > > It passes an invalid address for the first arg of mount syscall:
> > >
> > >     syscall(__NR_mount, 0x400000ul, 0x20000000ul, 0x20000080ul, 0ul,
> > >             0x20000100ul);
> > >
> > > With this address mount syscall returns -EFAULT on my system.
> > > I fixed this manually, but repro did not trigger the reported bug on my system.
> >
> > Hi Amir,
> >
> > This is not strange in the context of fuzzer, it's goal is to pass
> > random data. Generally if it says 0x400000ul, that's what it is, don't
> > fix it, or you are running a different program that may not reproduce
> > the bug. If syzbot attaches a reproducer, the bug was triggered by
> > precisely this program.
> >
>
> What's strange it that a bug in overlay code cannot be triggered if overlay
> isn't mounted and as it is the repro couldn't mount overlayfs at all, at
> lease with my kernel config.

Can it depend on kernel config? The bug was triggered by the program
provided somehow.

Separate question: why is it failing? Isn't src unused for overlayfs?
Where/how does vfs code look at src?

> The bounds check that causes mount failure is in vfs code, not in
> overlayfs code,
> so not sure what exactly went on there.
>
>
> > The reason why it passes non-pointers here is we think the src
> > argument of overlay mount is unused:
> > https://github.com/google/syzkaller/blob/4a4e0509de520c7139ca2b5606712cbadc550db2/sys/linux/filesystem.txt#L12
> > If it's not true, it needs to be fixed (or almost all overlay mounts
> > fail with EFAULT during fuzzing).
> >
> >
> > > > The bug was bisected to:
> > > >
> > > > commit b1f9d3858f724ed45b279b689fb5b400d91352e3
> > > > Author: Amir Goldstein <amir73il@gmail.com>
> > > > Date:   Sat Dec 21 09:42:29 2019 +0000
> > > >
> > > >     ovl: use ovl_inode_lock in ovl_llseek()
> > > >
> > > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16ff3bede00000
> > > > final crash:    https://syzkaller.appspot.com/x/report.txt?x=15ff3bede00000
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=11ff3bede00000
> > > >
> > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > Reported-by: syzbot+66a9752fa927f745385e@syzkaller.appspotmail.com
> > > > Fixes: b1f9d3858f72 ("ovl: use ovl_inode_lock in ovl_llseek()")
> > > >
> > > > =====================================
> > > > WARNING: bad unlock balance detected!
> > > > 5.6.0-rc3-syzkaller #0 Not tainted
> > > > -------------------------------------
> > > > syz-executor194/8947 is trying to release lock (&ovl_i_lock_key[depth]) at:
> > > > [<ffffffff828b7835>] ovl_inode_unlock fs/overlayfs/overlayfs.h:328 [inline]
> > > > [<ffffffff828b7835>] ovl_llseek+0x215/0x2c0 fs/overlayfs/file.c:193
> > > > but there are no more locks to release!
> > > >
> > >
> > > This is strange. I don't see how that can happen nor how my change would
> > > have caused this regression. If anything, the lock chance may have brought
> > > a bug in stack file ops to light, but don't see the bug.
> > >
> > > The repro is multi-threaded but when I ran the repro, a single thread did:
> > > - open lower file (pre copy up)
> > > - lchown file (copy up)
> > > - llseek the open file (so llseek is on a temporary ovl_open_realfile())
> > >
> > > Perhaps when bug was triggered ops above were executed by different
> > > threads?
> >
> > Perfectly possible.
> >
> > > Dmitry, I may have asked this before - how hard would it be to attach an
> > > strace of the repro to a bug report?
> >
> > This is tracked in https://github.com/google/syzkaller/issues/197 but
> > no progress so far.
> > What exactly were the main pain points in this case? But note that
> > strace is not atomic with actual execution, so it may lead you down
> > even worse rabbit hole...
>
> Sure, but it can add more insight for analysis.
>
> Thanks,
> Amir.
