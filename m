Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9BCE4AB1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 14:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504184AbfJYMFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 08:05:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:53076 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2504024AbfJYMFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:05:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 56049B25F;
        Fri, 25 Oct 2019 12:05:06 +0000 (UTC)
Date:   Fri, 25 Oct 2019 14:05:05 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     snazy@snazy.de
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>
Subject: Re: mlockall(MCL_CURRENT) blocking infinitely
Message-ID: <20191025120505.GG17610@dhcp22.suse.cz>
References: <4576b336-66e6-e2bb-cd6a-51300ed74ab8@snazy.de>
 <b8ff71f5-2d9c-7ebb-d621-017d4b9bc932@infradead.org>
 <20191025092143.GE658@dhcp22.suse.cz>
 <70393308155182714dcb7485fdd6025c1fa59421.camel@gmx.de>
 <20191025114633.GE17610@dhcp22.suse.cz>
 <d740f26ea94f9f1c2fc0530c1ea944f8e59aad85.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d740f26ea94f9f1c2fc0530c1ea944f8e59aad85.camel@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 25-10-19 13:55:13, Robert Stupp wrote:
> On Fri, 2019-10-25 at 13:46 +0200, Michal Hocko wrote:
> > On Fri 25-10-19 13:02:23, Robert Stupp wrote:
> > > On Fri, 2019-10-25 at 11:21 +0200, Michal Hocko wrote:
> > > > On Thu 24-10-19 16:34:46, Randy Dunlap wrote:
> > > > > [adding linux-mm + people]
> > > > >
> > > > > On 10/24/19 12:36 AM, Robert Stupp wrote:
> > > > > > Hi guys,
> > > > > >
> > > > > > I've got an issue with `mlockall(MCL_CURRENT)` after
> > > > > > upgrading
> > > > > > Ubuntu 19.04 to 19.10 - i.e. kernel version change from 5.0.x
> > > > > > to
> > > > > > 5.3.x.
> > > > > >
> > > > > > The following simple program hangs forever with one CPU
> > > > > > running
> > > > > > at 100% (kernel):
> > > >
> > > > Can you capture everal snapshots of proc/$(pidof $YOURTASK)/stack
> > > > while
> > > > this is happening?
> > >
> > > Sure,
> > >
> > > Approach:
> > > - one shell running
> > >   while true; do cat /proc/$(pidof test)/stack; done
> > > - starting ./test in another shell + ctrl-c quite some times
> > >
> > > Vast majority of all ./test invocations return an empty 'stack'
> > > file.
> > > Some tries, maybe 1 out of 20, returned these snapshots.
> > > Was running 5.3.7 for this test.
> > >
> > >
> > > [<0>] __handle_mm_fault+0x4c5/0x7a0
> > > [<0>] handle_mm_fault+0xca/0x1f0
> > > [<0>] __get_user_pages+0x230/0x770
> > > [<0>] populate_vma_page_range+0x74/0x80
> > > [<0>] __mm_populate+0xb1/0x150
> > > [<0>] __x64_sys_mlockall+0x11c/0x190
> > > [<0>] do_syscall_64+0x5a/0x130
> > > [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > [<0>] __handle_mm_fault+0x4c5/0x7a0
> > > [<0>] handle_mm_fault+0xca/0x1f0
> > > [<0>] __get_user_pages+0x230/0x770
> > > [<0>] populate_vma_page_range+0x74/0x80
> > > [<0>] __mm_populate+0xb1/0x150
> > > [<0>] __x64_sys_mlockall+0x11c/0x190
> > > [<0>] do_syscall_64+0x5a/0x130
> > > [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > >
> > >
> > > [<0>] __handle_mm_fault+0x4c5/0x7a0
> > > [<0>] handle_mm_fault+0xca/0x1f0
> > > [<0>] __get_user_pages+0x230/0x770
> > > [<0>] populate_vma_page_range+0x74/0x80
> > > [<0>] __mm_populate+0xb1/0x150
> > > [<0>] __x64_sys_mlockall+0x11c/0x190
> > > [<0>] do_syscall_64+0x5a/0x130
> > > [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > >
> > >
> > > [<0>] __do_fault+0x3c/0x130
> > > [<0>] do_fault+0x248/0x640
> > > [<0>] __handle_mm_fault+0x4c5/0x7a0
> > > [<0>] handle_mm_fault+0xca/0x1f0
> > > [<0>] __get_user_pages+0x230/0x770
> > > [<0>] populate_vma_page_range+0x74/0x80
> > > [<0>] __mm_populate+0xb1/0x150
> > > [<0>] __x64_sys_mlockall+0x11c/0x190
> > > [<0>] do_syscall_64+0x5a/0x130
> > > [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > >
> >
> > This is expected.
> >
> > > // doubt this one is relevant
> > > [<0>] __wake_up_common_lock+0x7c/0xc0
> > > [<0>] __wake_up_sync_key+0x1e/0x30
> > > [<0>] __wake_up_parent+0x26/0x30
> > > [<0>] do_notify_parent+0x1cc/0x280
> > > [<0>] do_exit+0x703/0xaf0
> > > [<0>] do_group_exit+0x47/0xb0
> > > [<0>] get_signal+0x165/0x880
> > > [<0>] do_signal+0x34/0x280
> > > [<0>] exit_to_usermode_loop+0xbf/0x160
> > > [<0>] do_syscall_64+0x10f/0x130
> > > [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >
> > Hmm, this means that the task has exited so how come there are
> > other syscalls happening. Are you sure you are collecting stacks for
> > the
> > correct task?
> 
> I guess that the `cat /proc/$(pidof test)/stack` captured the stack
> after I hit ctrl-c. Does that make sense?
> 
> Also tried `syscall(SYS_mlockall, MCL_CURRENT);` instead of
> `mlockall(MCL_CURRENT)` - same behavior.
 
This smells like something that could be runtime specific. Could you
post strace output of your testcase?

-- 
Michal Hocko
SUSE Labs
