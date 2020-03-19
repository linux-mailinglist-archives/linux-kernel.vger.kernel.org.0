Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD12D18BA48
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 16:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgCSPEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 11:04:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726943AbgCSPEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 11:04:15 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60B0D20B1F;
        Thu, 19 Mar 2020 15:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584630254;
        bh=9sUASwv1aMChcKHb0XASQjQ5NOWCpnD5MZGu0WxshnI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cJ5Pjon91GBI/OWfWNukcN6NxQ+ZlVgfo/Z2l4i50rCQc6rrGxgzq6XaI0z8cH23b
         00sKf3HuoWcg7JZJfdM5YU8NoXaUlRs8Cykk5SpC0jTHrWwrXEMmJEmzt7ljqctyAG
         dPjEroclYW96zMbNaGEHIBOYZHwdlGiazPx2cTVU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 23C373520F2A; Thu, 19 Mar 2020 08:04:14 -0700 (PDT)
Date:   Thu, 19 Mar 2020 08:04:14 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+792dec47d693ccdc05a0@syzkaller.appspotmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: linux-next build error (8)
Message-ID: <20200319150414.GD3199@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <000000000000ae2ab305a123f146@google.com>
 <CACT4Y+a_d=5TNZth0dPov0B7tB5T9bAzWXBj1HjhXdn-=0KOOg@mail.gmail.com>
 <20200318214109.GV3199@paulmck-ThinkPad-P72>
 <CACT4Y+ZhP_Qu+WZ4t2dLjd__H+rUKCTRCNoghvW9Uf3QQYRcNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZhP_Qu+WZ4t2dLjd__H+rUKCTRCNoghvW9Uf3QQYRcNg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 08:13:35AM +0100, Dmitry Vyukov wrote:
> On Wed, Mar 18, 2020 at 10:41 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Wed, Mar 18, 2020 at 09:54:07PM +0100, Dmitry Vyukov wrote:
> > > On Wed, Mar 18, 2020 at 5:57 PM syzbot
> > > <syzbot+792dec47d693ccdc05a0@syzkaller.appspotmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > syzbot found the following crash on:
> > > >
> > > > HEAD commit:    47780d78 Add linux-next specific files for 20200318
> > > > git tree:       linux-next
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=14228745e00000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=b68b7b89ad96c62a
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=792dec47d693ccdc05a0
> > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > >
> > > > Unfortunately, I don't have any reproducer for this crash yet.
> > > >
> > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > Reported-by: syzbot+792dec47d693ccdc05a0@syzkaller.appspotmail.com
> > > >
> > > > kernel/rcu/tasks.h:1070:37: error: 'rcu_tasks_rude' undeclared (first use in this function); did you mean 'rcu_tasks_qs'?
> > >
> > > +rcu maintainers
> >
> > The kbuild test robot beat you to it, and apologies for the hassle.
> > Fixed in -rcu on current "dev" branch.
> 
> If the kernel dev process would only have a way to avoid dups from all
> test systems...

I do significant testing before pushing to -next, but triggering this
one requires a combination of Kconfig options that are incompatible
with rcutorture.  :-/

I suppose one strategy would be to give kbuild test robot some time before
passing to -next, but they seem to sometimes get too far behind for me to
be willing to wait that long.  So my current approach is to push my "dev"
branch, run moderate rcutorture testing (three hours per scenario other
than TREE10, which gets only one hour), and if that passes, push to -next.

I suppose that I could push to -next only commits that are at least three
days old or some such.  But I get in trouble pushing to -next too slowly
as often as I get in trouble pushing too quickly, so I suspect that my
current approach is in roughly the right place.

> Now we need to spend time and deal with it. What has fixed it?

It is fixed by commit c6ef38e4d595 ("rcu-tasks: Add RCU tasks to
rcutorture writer stall output") and some of its predecessors.

Perhaps more useful to you, this commit is included in next-20200319
from the -next tree.  ;-)

							Thanx, Paul
