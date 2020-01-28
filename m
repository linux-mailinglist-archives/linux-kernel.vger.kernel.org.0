Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F16C14B55E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 14:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgA1Nvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 08:51:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43757 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726129AbgA1Nvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 08:51:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580219489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xYwXigMHs9ibErg+EUOIdW+B0ZNS8vmFHtUCpU8Vzfc=;
        b=diQxNiIKcOHqccAVuWVqUdGnUfcIv8e5qkU1Svej2C/VJICbs6ns1EcxOWXsWuau/EsR7p
        sb/bi2hjYeSkkFDACZP5wxS6ecpSPC5ZUaH87uI1BCSbTaiLOooHWJMcI+rOW0KKQq+q/9
        L2+L8xq5si+zq7AXCH2GIMXbv49ufsg=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-d9vOXxcUOB6wcq6wWdvghA-1; Tue, 28 Jan 2020 08:51:25 -0500
X-MC-Unique: d9vOXxcUOB6wcq6wWdvghA-1
Received: by mail-oi1-f200.google.com with SMTP id m127so3303859oig.19
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 05:51:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xYwXigMHs9ibErg+EUOIdW+B0ZNS8vmFHtUCpU8Vzfc=;
        b=khZVnwBAG5NgK5PJOmnc5ZNMHbaB9e6r/lwO53pyT5o4w7gSxypZEmxwoD9GAkwrK4
         PaWHMF/jwR8lw8fDEj0PfNPrxdpTcA9xml990jXgflI7oS9yfu2PBcHOvQVXmG0DpLXA
         7TioMgshNZrKbL+Hy5VvseNO3KILbZ6v/LYgWMQWecxtuQkWfZvwPYKCOU0+KqOlezdg
         lZ1W0bfXGkgYDIn3YcAiNhfZ17Zhdfd+ZTB9B6CACpBvkVuQXdHwyL/xB8AZ/WmlNaKM
         E/mGFu3dcelTpqB0OD+g6K1VPtGlcQ9/3Ya7rj8j2GRtDUAMfSNPJbwl3wlcvemuAmzu
         J1qg==
X-Gm-Message-State: APjAAAWXlLO2ZJsXWfaXNth/e+BarAbANr42ouGsS7wwXhKMW1bBf8iK
        jj5UFR4+P80Jpcp7Rok69Nr++Yea+Nl80zQ8GlAl4rySioIH+ZKkwzGFJvHiJNJUtLvWLT8JX8P
        Pnweg9/xldn+nJKJyxHlleEUo5UuHnwhhvjqFzJAs
X-Received: by 2002:a9d:7ccc:: with SMTP id r12mr17105161otn.22.1580219483345;
        Tue, 28 Jan 2020 05:51:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqwRvQI1gr/NFgoti/hhT7JXmXbeDFLVnhKG/bADBQcuYLCllybAUzHF3MW9GatHixvAK2KOIfLcBws0vdYKGo8=
X-Received: by 2002:a9d:7ccc:: with SMTP id r12mr17105143otn.22.1580219483054;
 Tue, 28 Jan 2020 05:51:23 -0800 (PST)
MIME-Version: 1.0
References: <000000000000143de7059d2ba3e5@google.com> <000000000000fdbd71059d32a906@google.com>
 <CAHC9VhS_Bfywhp+6H03bY7LrQsBz+io672pSS0DpiZKFiz4L6g@mail.gmail.com>
In-Reply-To: <CAHC9VhS_Bfywhp+6H03bY7LrQsBz+io672pSS0DpiZKFiz4L6g@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 28 Jan 2020 14:51:11 +0100
Message-ID: <CAFqZXNsevSVXroCCBMaWHiVG9sh3Sb9ZDy3tYGDs=ONV8Mc25A@mail.gmail.com>
Subject: Re: possible deadlock in sidtab_sid2str_put
To:     Paul Moore <paul@paul-moore.com>
Cc:     Jeff Vander Stoep <jeffv@google.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+61cba5033e2072d61806@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 2:39 PM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Jan 28, 2020 at 7:50 AM syzbot
> <syzbot+61cba5033e2072d61806@syzkaller.appspotmail.com> wrote:
> >
> > syzbot has found a reproducer for the following crash on:
> >
> > HEAD commit:    b0be0eff Merge tag 'x86-pti-2020-01-28' of git://git.kerne..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1432aebee00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=9784e57c96a92f20
> > dashboard link: https://syzkaller.appspot.com/bug?extid=61cba5033e2072d61806
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10088e95e00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13fa605ee00000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+61cba5033e2072d61806@syzkaller.appspotmail.com
> >
> > =====================================================
> > WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
> > 5.5.0-syzkaller #0 Not tainted
> > -----------------------------------------------------
> > syz-executor305/10624 [HC0[0]:SC0[2]:HE1:SE0] is trying to acquire:
> > ffff888098c14098 (&(&s->cache_lock)->rlock){+.+.}, at: spin_lock include/linux/spinlock.h:338 [inline]
> > ffff888098c14098 (&(&s->cache_lock)->rlock){+.+.}, at: sidtab_sid2str_put.part.0+0x36/0x880 security/selinux/ss/sidtab.c:533
> >
> > and this task is already holding:
> > ffffffff89865770 (&(&nf_conntrack_locks[i])->rlock){+.-.}, at: spin_lock include/linux/spinlock.h:338 [inline]
> > ffffffff89865770 (&(&nf_conntrack_locks[i])->rlock){+.-.}, at: nf_conntrack_lock+0x17/0x70 net/netfilter/nf_conntrack_core.c:91
> > which would create a new lock dependency:
> >  (&(&nf_conntrack_locks[i])->rlock){+.-.} -> (&(&s->cache_lock)->rlock){+.+.}
> >
> > but this new dependency connects a SOFTIRQ-irq-safe lock:
> >  (&(&nf_conntrack_locks[i])->rlock){+.-.}
> >
> > ... which became SOFTIRQ-irq-safe at:
> >   lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4484
> >   __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
> >   _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:151
> >   spin_lock include/linux/spinlock.h:338 [inline]
> >   nf_conntrack_lock+0x17/0x70 net/netfilter/nf_conntrack_core.c:91
>
> ...
>
> > to a SOFTIRQ-irq-unsafe lock:
> >  (&(&s->cache_lock)->rlock){+.+.}
> >
> > ... which became SOFTIRQ-irq-unsafe at:
> > ...
> >   lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4484
> >   __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
> >   _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:151
> >   spin_lock include/linux/spinlock.h:338 [inline]
> >   sidtab_sid2str_put.part.0+0x36/0x880 security/selinux/ss/sidtab.c:533
> >   sidtab_sid2str_put+0xa0/0xc0 security/selinux/ss/sidtab.c:566
> >   sidtab_entry_to_string security/selinux/ss/services.c:1279 [inline]
> >   sidtab_entry_to_string+0xf2/0x110 security/selinux/ss/services.c:1266
> >   security_sid_to_context_core+0x2c6/0x3c0 security/selinux/ss/services.c:1361
> >   security_sid_to_context+0x34/0x40 security/selinux/ss/services.c:1384
> >   avc_audit_post_callback+0x102/0x790 security/selinux/avc.c:709
> >   common_lsm_audit+0x5ac/0x1e00 security/lsm_audit.c:466
> >   slow_avc_audit+0x16a/0x1f0 security/selinux/avc.c:782
> >   avc_audit security/selinux/include/avc.h:140 [inline]
> >   avc_has_perm+0x543/0x610 security/selinux/avc.c:1185
> >   inode_has_perm+0x1a8/0x230 security/selinux/hooks.c:1631
> >   selinux_mmap_file+0x10a/0x1d0 security/selinux/hooks.c:3701
> >   security_mmap_file+0xa4/0x1e0 security/security.c:1482
> >   vm_mmap_pgoff+0xf0/0x230 mm/util.c:502
>
> ...
>
> > other info that might help us debug this:
> >
> >  Possible interrupt unsafe locking scenario:
> >
> >        CPU0                    CPU1
> >        ----                    ----
> >   lock(&(&s->cache_lock)->rlock);
> >                                local_irq_disable();
> >                                lock(&(&nf_conntrack_locks[i])->rlock);
> >                                lock(&(&s->cache_lock)->rlock);
> >   <Interrupt>
> >     lock(&(&nf_conntrack_locks[i])->rlock);
> >
> >  *** DEADLOCK ***
> >
> > 4 locks held by syz-executor305/10624:
> >  #0: ffffffff8c1acc68 (&table[i].mutex){+.+.}, at: nfnl_lock net/netfilter/nfnetlink.c:62 [inline]
> >  #0: ffffffff8c1acc68 (&table[i].mutex){+.+.}, at: nfnetlink_rcv_msg+0x9ee/0xfb0 net/netfilter/nfnetlink.c:224
> >  #1: ffff8880836415d8 (nlk_cb_mutex-NETFILTER){+.+.}, at: netlink_dump+0xe7/0xfb0 net/netlink/af_netlink.c:2199
> >  #2: ffffffff89865770 (&(&nf_conntrack_locks[i])->rlock){+.-.}, at: spin_lock include/linux/spinlock.h:338 [inline]
> >  #2: ffffffff89865770 (&(&nf_conntrack_locks[i])->rlock){+.-.}, at: nf_conntrack_lock+0x17/0x70 net/netfilter/nf_conntrack_core.c:91
> >  #3: ffffffff8b7df008 (&selinux_ss.policy_rwlock){.+.?}, at: security_sid_to_context_core+0x1ca/0x3c0 security/selinux/ss/services.c:1344
>
> I think this is going to be tricky to fix due to the differing
> contexts from which sidtab_sid2str_put() may be called.  We already
> have a check for !in_task() in sidtab_sid2str_put(), do we want to add
> a check for !in_serving_softirq() too?

I don't think that is going to fix it. The issue here is that an
interrupt may happen while we are holding the lock and in that
interrupt we try to take some other lock, which another thread has
taken before the cache lock... I'm afraid using the irqsave/irqrestore
locking is the only possible fix here... (Either that or giving up on
the proper least-recently-used logic.)

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

