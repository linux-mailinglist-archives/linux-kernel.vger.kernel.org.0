Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E474318D316
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 16:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbgCTPjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 11:39:07 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42056 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbgCTPjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 11:39:07 -0400
Received: by mail-qk1-f195.google.com with SMTP id e11so7236274qkg.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 08:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z8zA57JFXFt2AL+yPvN5tzHw30eT4MJB2hoBh1V9V18=;
        b=J/FM1wE7PyVDhuJik6SITHG6EEhChrCxSZp7popuFKzyG0+du4chi55EmAZeJFrNjR
         2yN+1SFs3HcNSqfepPFivsIBZuKVe/e59mSVCxtO/O4K18wvtxZTp5cx+PHDth3YAUGH
         rF2Nb1b2p/6rgFl3ZfJ9I+E8Q8BRsjliko2/LB4RWUoi96Q7MsZDrIYlArj3guZJqzzK
         tIC/9Gc8HQQDIPVd66NjMRArGV6PfF1zcOWPTV09YcnwaS6DQtS/jPBsiiBU51C3p44a
         V3/jJuuG1PyK7dHeceEszYGn6Kfg7GSbH6BkK6GWJi/DXZ+a3B/OPEp5W/Arb/jQujqY
         pvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z8zA57JFXFt2AL+yPvN5tzHw30eT4MJB2hoBh1V9V18=;
        b=kquOxvm37/qADM48J5VpJNNd4uJjKTwz2ncHma9FxvrD4L+v73al+gzAYn2CNM21GF
         omudOmootV9ZU/FIK7kvoQuXIcyPYIBAO8mftxCyvImo/T/zF0GEprBZ2+ggSs6fMNmy
         C3zhhDuB8qqsVOn3EvWlPWvikF8WFRU1oNA6SKCLP2EVs99B/gLaxhi8Rl0+zI47tkST
         tRYK+oNRZrSyf69V4EWwVT9DiHUsLbpjuWfhveAAd+tBvi92AUBqGiVKsfz9DCTd1iJH
         YvYlZHRlJWRZLLNJOc0Ii9UNqe56QQyMlDn5EN5W/O2kFGU0DC2wEdUxOIHxOm2nB64q
         DXuw==
X-Gm-Message-State: ANhLgQ0piy22v6R847XVG5HHQrdQUcruRnrCJT3nGO0hxiwbOraOJOGH
        Q1jIeGNVMlAL/4Y5H1GctGjj+HqtUmIgnTdmm1nFSQ==
X-Google-Smtp-Source: ADFU+vs6O3hBD5D5FUXIPjT/NoUSSgRPlXoDQIj1C0Vra25tDqR64QkbSZFmDjSl+nLRZKGz3KYkZpv5ryEJxhXzPqM=
X-Received: by 2002:a37:7c47:: with SMTP id x68mr8753821qkc.8.1584718745750;
 Fri, 20 Mar 2020 08:39:05 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ae2ab305a123f146@google.com> <CACT4Y+a_d=5TNZth0dPov0B7tB5T9bAzWXBj1HjhXdn-=0KOOg@mail.gmail.com>
 <20200318214109.GV3199@paulmck-ThinkPad-P72> <CACT4Y+ZhP_Qu+WZ4t2dLjd__H+rUKCTRCNoghvW9Uf3QQYRcNg@mail.gmail.com>
 <20200319150414.GD3199@paulmck-ThinkPad-P72>
In-Reply-To: <20200319150414.GD3199@paulmck-ThinkPad-P72>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 20 Mar 2020 16:38:54 +0100
Message-ID: <CACT4Y+YHQQWeeW44NYAxX+fFU6RyvFbbmcig1q8NSE7yV0zgjA@mail.gmail.com>
Subject: Re: linux-next build error (8)
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     syzbot <syzbot+792dec47d693ccdc05a0@syzkaller.appspotmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 4:04 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Thu, Mar 19, 2020 at 08:13:35AM +0100, Dmitry Vyukov wrote:
> > On Wed, Mar 18, 2020 at 10:41 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Wed, Mar 18, 2020 at 09:54:07PM +0100, Dmitry Vyukov wrote:
> > > > On Wed, Mar 18, 2020 at 5:57 PM syzbot
> > > > <syzbot+792dec47d693ccdc05a0@syzkaller.appspotmail.com> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > syzbot found the following crash on:
> > > > >
> > > > > HEAD commit:    47780d78 Add linux-next specific files for 20200318
> > > > > git tree:       linux-next
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=14228745e00000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=b68b7b89ad96c62a
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=792dec47d693ccdc05a0
> > > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > >
> > > > > Unfortunately, I don't have any reproducer for this crash yet.
> > > > >
> > > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > > Reported-by: syzbot+792dec47d693ccdc05a0@syzkaller.appspotmail.com
> > > > >
> > > > > kernel/rcu/tasks.h:1070:37: error: 'rcu_tasks_rude' undeclared (first use in this function); did you mean 'rcu_tasks_qs'?
> > > >
> > > > +rcu maintainers
> > >
> > > The kbuild test robot beat you to it, and apologies for the hassle.
> > > Fixed in -rcu on current "dev" branch.
> >
> > If the kernel dev process would only have a way to avoid dups from all
> > test systems...
>
> I do significant testing before pushing to -next, but triggering this
> one requires a combination of Kconfig options that are incompatible
> with rcutorture.  :-/
>
> I suppose one strategy would be to give kbuild test robot some time before
> passing to -next, but they seem to sometimes get too far behind for me to
> be willing to wait that long.  So my current approach is to push my "dev"
> branch, run moderate rcutorture testing (three hours per scenario other
> than TREE10, which gets only one hour), and if that passes, push to -next.
>
> I suppose that I could push to -next only commits that are at least three
> days old or some such.  But I get in trouble pushing to -next too slowly
> as often as I get in trouble pushing too quickly, so I suspect that my
> current approach is in roughly the right place.
>
> > Now we need to spend time and deal with it. What has fixed it?
>
> It is fixed by commit c6ef38e4d595 ("rcu-tasks: Add RCU tasks to
> rcutorture writer stall output") and some of its predecessors.
>
> Perhaps more useful to you, this commit is included in next-20200319
> from the -next tree.  ;-)

Let's tell syzbot about the fix:

#syz fix: rcu-tasks: Add RCU tasks to rcutorture writer stall output

I think what you are doing is the best possible option in the current situation.
I don't think requiring all human maintainers to do more manual
repetitive work, which is not well defined and even without a way to
really require something from them is scalable nor reliable nor the
right approach.

We would consume something like LKGR [1] if it existed for the kernel.
But it would require tighter integration of testing systems with
kernel dev processes, or of course throwing more manual labor at it to
track all uncoordinated testing systems and publishing LKGR tags.

[1] https://chromium.googlesource.com/chromiumos/docs/+/master/glossary.md
