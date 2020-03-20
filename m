Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C19018D326
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 16:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbgCTPmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 11:42:40 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45043 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbgCTPmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 11:42:40 -0400
Received: by mail-qt1-f196.google.com with SMTP id y24so5225615qtv.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 08:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g19Z0AL+oVzZVOxsXjEEVkUP9hXqPLhiX7vvspZjbqI=;
        b=GeHU0qasNum+zVdPSku/i6ICaKR+0jlY9lNkWGfDEY88SDquDjyClFQj4YeHsCmstA
         JPJXOINAfSjzPx0s5sdkQ1RajQHqnwgfL5lpolECr6wGfFDEnlYmzqLJy9MqQnJMHR1m
         c9L6IoIscpHJ/Te5V7E9jmNwn1b3B2ZtbTtgZoYTeZ4j/SyefmoT1qyZIgnNrI15266K
         QB0OvKfeegfWue3ITp0q4NhEyJDFfJuZia5tyIvDf8vGEFp5sPmeOZE+KIvQQwYJFC4r
         yyezUkMhxMaILYd1XNLpNuATIaCIg0r6/J3qsOMblXgqTuHg045DnnzdRYva/r9hUjmm
         UjLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g19Z0AL+oVzZVOxsXjEEVkUP9hXqPLhiX7vvspZjbqI=;
        b=CwvCqahpB1ycSy3a/zQc7/ZY29umMo8PLpsrjq2K5Jx7yr32QPESs3PPgfmaczUwMh
         lwsi3JCqpIKka05D0NDhTC0PcimXJRyHypAjJidko+whFKl/HahmgyOLAPDA5VMdfgcE
         T9fyfuYqFlCFOrzRIULSH8ZDrPGxZV4+GQ9KrAtOx4hSXtD67Nae+cVwsVuG3P5yHYQ6
         V2TZQsnL55Q3IYZH6a3jymv+TUzNdIzk0qTOF619b37SceWTr5wuKdDNIKTrnbrk1YxO
         dOtlv89TxkG0c+y6GGlEHGfLSuSM9OBTxhk9OhFWkDu1Xd1D8JQM400RCU7SvcDa2Via
         h34Q==
X-Gm-Message-State: ANhLgQ2Xeu0VUIfiJBeOoIumv7ZNHWQca0LlTc+52OMUDXStHv7NsUjL
        hhEN9XvFVQz9VrIjMYRVc0pqYreWdgjnnPUWEziFBw==
X-Google-Smtp-Source: ADFU+vsrnn9HPcrtgg6UFQhymtJaLKpvGdgNd/d3WOK1WBTFnJHRkmZg7jpdDN5mXDrdEDsRekV1NLmgwILxGkOxBwI=
X-Received: by 2002:aed:2591:: with SMTP id x17mr8919616qtc.380.1584718959600;
 Fri, 20 Mar 2020 08:42:39 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ae2ab305a123f146@google.com> <CACT4Y+a_d=5TNZth0dPov0B7tB5T9bAzWXBj1HjhXdn-=0KOOg@mail.gmail.com>
 <20200318214109.GV3199@paulmck-ThinkPad-P72> <CACT4Y+ZhP_Qu+WZ4t2dLjd__H+rUKCTRCNoghvW9Uf3QQYRcNg@mail.gmail.com>
 <20200320130822.GF4650@kadam>
In-Reply-To: <20200320130822.GF4650@kadam>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 20 Mar 2020 16:42:28 +0100
Message-ID: <CACT4Y+aCAYdYx9QPLUVdAOzhvYSA-n_wASaqAD8OUTioiHgsQQ@mail.gmail.com>
Subject: Re: linux-next build error (8)
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        syzbot <syzbot+792dec47d693ccdc05a0@syzkaller.appspotmail.com>,
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

On Fri, Mar 20, 2020 at 2:11 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Thu, Mar 19, 2020 at 08:13:35AM +0100, 'Dmitry Vyukov' via syzkaller-bugs wrote:
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
> We could make a mailing list for recording it, and then just grep the
> mailbox for the file and function.

As far as I understand Paul was already aware of the breakage and both
reports. Also how do we make all kernel testing out there to respect
this new list?....

> Or we could just assume that kbuild is going to find almost all the
> build errors.

Paul mentioned that they don't sometimes ("but they seem to sometimes
get too far behind for me to
be willing to wait that long"). Lots of people mentioned this on the
last LPC as well. It's not completely transparent and not part of the
kernel project to rely on it (how do we add new configs? how do we
urgently repair it? etc).
