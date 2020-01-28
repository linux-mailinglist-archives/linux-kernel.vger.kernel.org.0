Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 415EB14B96D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 15:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387655AbgA1Obp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 09:31:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48415 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733290AbgA1O11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:27:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580221645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uz5iTTZryQ40hZAZjoTBqtZNtWwhUBvAhd35nKHJyVo=;
        b=JnrcL8AQHNK5sT2T7oDXPzuqzNwcQSjrZ0H+9qLDvwRQhaUFfmWeccigLNYcfxUBj5DXKd
        s3FHsPj58eu4KagyLnpLfPrxTw3RYubG3sh5kEQWAxPuPQWNImOUmH9FjkXF57I+l8Vtjv
        iAOJZy8PdC2d5uFkC0pvXJCn9J+YWfQ=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-HMkP0WQWNuuxIEtfywpE3g-1; Tue, 28 Jan 2020 09:27:09 -0500
X-MC-Unique: HMkP0WQWNuuxIEtfywpE3g-1
Received: by mail-ot1-f71.google.com with SMTP id b10so8093165otp.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 06:27:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uz5iTTZryQ40hZAZjoTBqtZNtWwhUBvAhd35nKHJyVo=;
        b=cjIyNmLPAP3n0CW07RVQhGvMOMPUwA2mfitjRG4AoJ4TUOTiLb6gxZj6vRc/FoC897
         EkCPFEo8beQXJ8dMsOF6ZKdT/v/0u5JWipCUGBLxxnP+jQ4QwoB+X7WbMxa42b8JXfdC
         epYDcyFGzC9k+PhXOx0Khq/lVLT2ewOi1kd7ku7nWwnokOgHBI9hQyi9nTQmnv6x9yTD
         VP+pTC6tuulFcgMC4rPLqpLRpUgVBLs9hq4GrG7ic8hBYJ5JpgsI4/Ul4WZ1jDRVEJpr
         Ev4WcbcvQdRj/Ar0Wz69nZU9wLpJ0cUhIDEbedz0dbJ0+LNSIMsSpFh/OT1/JDeeybe8
         QCTA==
X-Gm-Message-State: APjAAAXQcuOlAVtriSNdlbFU7IjQfw07p4l35AxlmURaStZOs/ncM72j
        ttvZ8UyyirVnE1f4P6kt3Y9oYJjvnYE+QxHMmXxdp6EfMWwqXqr3ddwIwZiV8Ue3vP2wlhYWvtY
        UnvqgVbjjmNXRMb0yk8DBCIV8h3c3mr8oSbb+aLzb
X-Received: by 2002:aca:1108:: with SMTP id 8mr3000105oir.127.1580221626620;
        Tue, 28 Jan 2020 06:27:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqy1oqWxk8WE9rSgioxFxJCCAHjVKW+NVHIlx32OrOXS+dfOAYNDWsovMJZrFK6DSYhUT5eDK9YvN5NIS9/9sNY=
X-Received: by 2002:aca:1108:: with SMTP id 8mr3000076oir.127.1580221626277;
 Tue, 28 Jan 2020 06:27:06 -0800 (PST)
MIME-Version: 1.0
References: <000000000000143de7059d2ba3e5@google.com> <000000000000fdbd71059d32a906@google.com>
 <CAHC9VhS_Bfywhp+6H03bY7LrQsBz+io672pSS0DpiZKFiz4L6g@mail.gmail.com> <850873b8-8a30-58e5-ad3c-86fb35296130@tycho.nsa.gov>
In-Reply-To: <850873b8-8a30-58e5-ad3c-86fb35296130@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 28 Jan 2020 15:26:55 +0100
Message-ID: <CAFqZXNuxFTKXVZDpPGCTHifn_AeCdVmP+PZrMDKDOYiLOWtsUA@mail.gmail.com>
Subject: Re: possible deadlock in sidtab_sid2str_put
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Paul Moore <paul@paul-moore.com>,
        Jeff Vander Stoep <jeffv@google.com>,
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

On Tue, Jan 28, 2020 at 2:44 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 1/28/20 8:39 AM, Paul Moore wrote:
> > On Tue, Jan 28, 2020 at 7:50 AM syzbot
> > <syzbot+61cba5033e2072d61806@syzkaller.appspotmail.com> wrote:
> >>
> >> syzbot has found a reproducer for the following crash on:
> >>
> >> HEAD commit:    b0be0eff Merge tag 'x86-pti-2020-01-28' of git://git.kerne..
> >> git tree:       upstream
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=1432aebee00000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=9784e57c96a92f20
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=61cba5033e2072d61806
> >> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10088e95e00000
> >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13fa605ee00000
> >>
> >> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> >> Reported-by: syzbot+61cba5033e2072d61806@syzkaller.appspotmail.com
> >>
> >> =====================================================
> >> WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
> >> 5.5.0-syzkaller #0 Not tainted
> >> -----------------------------------------------------
> >> syz-executor305/10624 [HC0[0]:SC0[2]:HE1:SE0] is trying to acquire:
> >> ffff888098c14098 (&(&s->cache_lock)->rlock){+.+.}, at: spin_lock include/linux/spinlock.h:338 [inline]
> >> ffff888098c14098 (&(&s->cache_lock)->rlock){+.+.}, at: sidtab_sid2str_put.part.0+0x36/0x880 security/selinux/ss/sidtab.c:533
> >>
> >> and this task is already holding:
> >> ffffffff89865770 (&(&nf_conntrack_locks[i])->rlock){+.-.}, at: spin_lock include/linux/spinlock.h:338 [inline]
> >> ffffffff89865770 (&(&nf_conntrack_locks[i])->rlock){+.-.}, at: nf_conntrack_lock+0x17/0x70 net/netfilter/nf_conntrack_core.c:91
> >> which would create a new lock dependency:
> >>   (&(&nf_conntrack_locks[i])->rlock){+.-.} -> (&(&s->cache_lock)->rlock){+.+.}
> >>
> >> but this new dependency connects a SOFTIRQ-irq-safe lock:
> >>   (&(&nf_conntrack_locks[i])->rlock){+.-.}
> >>
> >> ... which became SOFTIRQ-irq-safe at:
> >>    lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4484
> >>    __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
> >>    _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:151
> >>    spin_lock include/linux/spinlock.h:338 [inline]
> >>    nf_conntrack_lock+0x17/0x70 net/netfilter/nf_conntrack_core.c:91
> >
> > ...
> >
> >> to a SOFTIRQ-irq-unsafe lock:
> >>   (&(&s->cache_lock)->rlock){+.+.}
> >>
> >> ... which became SOFTIRQ-irq-unsafe at:
> >> ...
> >>    lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4484
> >>    __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
> >>    _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:151
> >>    spin_lock include/linux/spinlock.h:338 [inline]
> >>    sidtab_sid2str_put.part.0+0x36/0x880 security/selinux/ss/sidtab.c:533
> >>    sidtab_sid2str_put+0xa0/0xc0 security/selinux/ss/sidtab.c:566
> >>    sidtab_entry_to_string security/selinux/ss/services.c:1279 [inline]
> >>    sidtab_entry_to_string+0xf2/0x110 security/selinux/ss/services.c:1266
> >>    security_sid_to_context_core+0x2c6/0x3c0 security/selinux/ss/services.c:1361
> >>    security_sid_to_context+0x34/0x40 security/selinux/ss/services.c:1384
> >>    avc_audit_post_callback+0x102/0x790 security/selinux/avc.c:709
> >>    common_lsm_audit+0x5ac/0x1e00 security/lsm_audit.c:466
> >>    slow_avc_audit+0x16a/0x1f0 security/selinux/avc.c:782
> >>    avc_audit security/selinux/include/avc.h:140 [inline]
> >>    avc_has_perm+0x543/0x610 security/selinux/avc.c:1185
> >>    inode_has_perm+0x1a8/0x230 security/selinux/hooks.c:1631
> >>    selinux_mmap_file+0x10a/0x1d0 security/selinux/hooks.c:3701
> >>    security_mmap_file+0xa4/0x1e0 security/security.c:1482
> >>    vm_mmap_pgoff+0xf0/0x230 mm/util.c:502
> >
> > ...
> >
> >> other info that might help us debug this:
> >>
> >>   Possible interrupt unsafe locking scenario:
> >>
> >>         CPU0                    CPU1
> >>         ----                    ----
> >>    lock(&(&s->cache_lock)->rlock);
> >>                                 local_irq_disable();
> >>                                 lock(&(&nf_conntrack_locks[i])->rlock);
> >>                                 lock(&(&s->cache_lock)->rlock);
> >>    <Interrupt>
> >>      lock(&(&nf_conntrack_locks[i])->rlock);
> >>
> >>   *** DEADLOCK ***
> >>
> >> 4 locks held by syz-executor305/10624:
> >>   #0: ffffffff8c1acc68 (&table[i].mutex){+.+.}, at: nfnl_lock net/netfilter/nfnetlink.c:62 [inline]
> >>   #0: ffffffff8c1acc68 (&table[i].mutex){+.+.}, at: nfnetlink_rcv_msg+0x9ee/0xfb0 net/netfilter/nfnetlink.c:224
> >>   #1: ffff8880836415d8 (nlk_cb_mutex-NETFILTER){+.+.}, at: netlink_dump+0xe7/0xfb0 net/netlink/af_netlink.c:2199
> >>   #2: ffffffff89865770 (&(&nf_conntrack_locks[i])->rlock){+.-.}, at: spin_lock include/linux/spinlock.h:338 [inline]
> >>   #2: ffffffff89865770 (&(&nf_conntrack_locks[i])->rlock){+.-.}, at: nf_conntrack_lock+0x17/0x70 net/netfilter/nf_conntrack_core.c:91
> >>   #3: ffffffff8b7df008 (&selinux_ss.policy_rwlock){.+.?}, at: security_sid_to_context_core+0x1ca/0x3c0 security/selinux/ss/services.c:1344
> >
> > I think this is going to be tricky to fix due to the differing
> > contexts from which sidtab_sid2str_put() may be called.  We already
> > have a check for !in_task() in sidtab_sid2str_put(), do we want to add
> > a check for !in_serving_softirq() too?
>
> No, we should just use spin_lock_irqsave/unlock_irqrestore() IMHO, but
> that then means we need to re-evaluate the performance gain of this change.

I just tested a patch that switches to the IRQ-disabling locking under
the systemd-journald scenario from [1] and the impact seems not that
bad - the security_secid_to_secctx() function only takes up 3.18% of
total run time vs. ~2% I reported in the original patch
(d97bd23c2d7d). I'll post the patch shortly.

[1] https://bugzilla.redhat.com/show_bug.cgi?id=1733259, i.e.:
    cat /dev/urandom | base64 | logger &
    timeout 30s perf record -p $(pidof systemd-journald) -a -g

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

