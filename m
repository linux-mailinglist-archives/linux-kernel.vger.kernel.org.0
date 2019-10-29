Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3B3E8F7A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 19:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731075AbfJ2Sq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 14:46:59 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38048 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729528AbfJ2Sq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 14:46:58 -0400
Received: by mail-ot1-f66.google.com with SMTP id r14so5928281otn.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 11:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ReWNXiQSJHk1Ohmt4ko0ZYhBstNAojS1cH/ggSlVoAI=;
        b=Kn3CZE3xBzziKVWaQmk/w5rlpZO2GbLA16umwkgVooj88NX/DmIyNIa6Isn2UqLS3F
         Fm+cD+GDopHSMsxgxlBeiPULD6tNKXBO67r0TMwCr/VOs30OEn5etwD5cMzd76l9ADJv
         bEPEN4IhS26FRzf4+PXqg5MERXrdSITqMRw5E2dC1/uboYjloD56iI96ELRsUrcpxLP5
         yc1s6tD8CjoBQyxKweBAhpoGiE7mzUtYafmLLspCafldR8G622VHkePlx/x8soweCzFX
         PCQ7ktRLpjSRRT04ctRSkLGV/puDZijKegMjGo+KDZNPPwCZYRTuI5e1XHQlrNwIo8QJ
         DbXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ReWNXiQSJHk1Ohmt4ko0ZYhBstNAojS1cH/ggSlVoAI=;
        b=egsW72tRX00sdPnNcbTqvkmgPav5Sdw6z2QdkL+6lnW/oxcd8pE3kBWs9Wh/JeCeLR
         /FQVFBFSs4xbSfln+A8BKgaaZMJm6Kkc0cTvDaY/wJ35pe6j26zHuM9MiECCSsHLGol1
         0Z9XSjUr/OrmlWBpJC3JxX0NHw/GZon4hl5qJvVHZEZU4P9LbJXvqA23vPKNNHJK4uL2
         Z57+gKekyQX/yFKogKqeNJfZs7HAHe9RIBHD7Ay+oGtTHLlD1N2A0jqxr3z4R9AJ6raI
         YXb5/czh3ibQ/I5JqTh6a9jIxgtCYRCtXhhE7V/h2aYEL31Q1Rdwgs0tLtBnNQ3gtQzf
         5KqA==
X-Gm-Message-State: APjAAAUgd/DuB4ENLuQo/7Af18MZPhWaSVyzdSOvJs9Shsi3NccuYXYs
        P/5akUX4Htl8jvPnSgae0MSlihv3NJy3VJulolfU4Q==
X-Google-Smtp-Source: APXvYqwoXXMB6jQHL01y3ti03FRq/3phCHL6sPdA/P1ffR5g9Hi0PMIpVSujjn/UUi7eJJGETGQD8n0OnIo+4nmy1DA=
X-Received: by 2002:a05:6830:1e8c:: with SMTP id n12mr4813345otr.360.1572374817658;
 Tue, 29 Oct 2019 11:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <20191029005405.201986-1-shakeelb@google.com> <20191029090347.GG31513@dhcp22.suse.cz>
 <CALvZod648GRvjd_LqViFzLRwxnzSrLZzjaNBOJju4xkDQkvrXw@mail.gmail.com> <20191029182802.GA193152@google.com>
In-Reply-To: <20191029182802.GA193152@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 29 Oct 2019 11:46:46 -0700
Message-ID: <CALvZod7npAH0okM5HnsR-F6N6EF5eT6sfX-XVusrXVuBgZfh6Q@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: fix data race in mem_cgroup_select_victim_node
To:     Marco Elver <elver@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Greg Thelen <gthelen@google.com>,
        syzbot+13f93c99c06988391efe@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 11:28 AM Marco Elver <elver@google.com> wrote:
>
>
>
> On Tue, 29 Oct 2019, Shakeel Butt wrote:
>
> > +Marco
> >
> > On Tue, Oct 29, 2019 at 2:03 AM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Mon 28-10-19 17:54:05, Shakeel Butt wrote:
> > > > Syzbot reported the following bug:
> > > >
> > > > BUG: KCSAN: data-race in mem_cgroup_select_victim_node / mem_cgroup_select_victim_node
> > > >
> > > > write to 0xffff88809fade9b0 of 4 bytes by task 8603 on cpu 0:
> > > >  mem_cgroup_select_victim_node+0xb5/0x3d0 mm/memcontrol.c:1686
> > > >  try_to_free_mem_cgroup_pages+0x175/0x4c0 mm/vmscan.c:3376
> > > >  reclaim_high.constprop.0+0xf7/0x140 mm/memcontrol.c:2349
> > > >  mem_cgroup_handle_over_high+0x96/0x180 mm/memcontrol.c:2430
> > > >  tracehook_notify_resume include/linux/tracehook.h:197 [inline]
> > > >  exit_to_usermode_loop+0x20c/0x2c0 arch/x86/entry/common.c:163
> > > >  prepare_exit_to_usermode+0x180/0x1a0 arch/x86/entry/common.c:194
> > > >  swapgs_restore_regs_and_return_to_usermode+0x0/0x40
> > > >
> > > > read to 0xffff88809fade9b0 of 4 bytes by task 7290 on cpu 1:
> > > >  mem_cgroup_select_victim_node+0x92/0x3d0 mm/memcontrol.c:1675
> > > >  try_to_free_mem_cgroup_pages+0x175/0x4c0 mm/vmscan.c:3376
> > > >  reclaim_high.constprop.0+0xf7/0x140 mm/memcontrol.c:2349
> > > >  mem_cgroup_handle_over_high+0x96/0x180 mm/memcontrol.c:2430
> > > >  tracehook_notify_resume include/linux/tracehook.h:197 [inline]
> > > >  exit_to_usermode_loop+0x20c/0x2c0 arch/x86/entry/common.c:163
> > > >  prepare_exit_to_usermode+0x180/0x1a0 arch/x86/entry/common.c:194
> > > >  swapgs_restore_regs_and_return_to_usermode+0x0/0x40
> > > >
> > > > mem_cgroup_select_victim_node() can be called concurrently which reads
> > > > and modifies memcg->last_scanned_node without any synchrnonization. So,
> > > > read and modify memcg->last_scanned_node with READ_ONCE()/WRITE_ONCE()
> > > > to stop potential reordering.
>
> Strictly speaking, READ_ONCE/WRITE_ONCE alone avoid various bad compiler
> optimizations, including store tearing, load tearing, etc. This does not
> add memory barriers to constrain memory ordering.  (If this code needs
> some memory ordering guarantees w.r.t. previous loads/stores then this
> alone is not enough.)
>
> > > I am sorry but I do not understand the problem and the fix. Why does the
> > > race happen and why does _ONCE fixes it? There is still no
> > > synchronization. Do you want to prevent from memcg->last_scanned_node
> > > reloading?
> > >
> >
> > The problem is memcg->last_scanned_node can read and modified
> > concurrently. Though to me it seems like a tolerable race and not
> > worth to add an explicit lock. My aim was to make KCSAN happy here to
> > look elsewhere for the concurrency bugs. However I see that it might
> > complain next on memcg->scan_nodes.
>
> The plain concurrent reads/writes are a data race, which may manifest in
> various undefined behaviour due to compiler optimizations. The _ONCE
> will prevent these (KCSAN only reports data races).  Note that, "data
> race" does not necessarily imply "race condition"; some data races are
> race conditions (usually the more interesting bugs) -- but not *all*
> data races are race conditions. If there is no race condition here that
> warrants heavier synchronization (locking etc.), then this patch is all
> that should be needed.
>
> I can't comment on the rest.
>

Thanks Marco for the explanation.
