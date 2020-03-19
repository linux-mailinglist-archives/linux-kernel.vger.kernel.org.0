Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0E718AD32
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 08:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbgCSHNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 03:13:49 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38984 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbgCSHNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 03:13:48 -0400
Received: by mail-qk1-f196.google.com with SMTP id t17so1670005qkm.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 00:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rH9XkrtMe7HI6VnpexBxHYP1li78F1+6ZSnrUVBDTCw=;
        b=prPUHVlxVd+bHnSt25R24pQe+7i7O9R1n3DEuULFVAUvo3IiUm9SO3mMtIEaRPGkvz
         lKFp3mkHdQdETyKa5GlARoh4QXgZ+tKH8X2ph3Hb3vfbjQ2+qYluAggjgQRlLSsd52bT
         F6xky0J+wLpGQWN5BDv1nVOQM0RIska5/S0L3eeZtDnd19ABYyhiASRMtwy3c8MUDgdg
         MueSMeN4QycaC90Cs2AtPu8eP5Zj1GA+rOjdD+FDFsYeyLdGxrooicFD+2s/R7LK6p44
         zb0L9GAp/knpAygSvvb9iA4E3xHqP8l52hMGSF/zPbcoj8c3wbqhkisuq1D9Yf61+fms
         za4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rH9XkrtMe7HI6VnpexBxHYP1li78F1+6ZSnrUVBDTCw=;
        b=a/MHA4zl3TXNlD0WYO43tHcEtGOwdvIrhcx+LXUH13QnYUQMKF4Dq64UnHrrdN6QI/
         SJf/7WX77Q41U99djIQGYdhWyxf8320NJ5jgQhzCHCjMYuTehk0zUdzYHrSBaLFM0pu+
         Xd/TI6IhR2bHmkZYWSMru/eggu1eXCmEN9LQ8m5XzTcG+MDmjkpkicEVuoe1Z1sQsXxV
         TO3ldKZAK1AQuu7+hgUM8v4NNmF5gKy3cccSHBDCwjnbVaXCjkm3IesPGO9Vp4/ju0JX
         fiiIPkkX0EH8wkx5JQ89/oqTdkv/NMKSWZiyOHnEXOD9LT2R5rLL4Qr36fC0U5FkEXfm
         JQJA==
X-Gm-Message-State: ANhLgQ2CAWGuXkLcglXUpEbL5w2FHd9wTpwbYLfgOc9f5VjQ0sjstBkT
        AxgsrfhNyoSmWoVHrQmrk5nVhH8APXx9jVWzNK2iHw==
X-Google-Smtp-Source: ADFU+vvRD/fu9oNydL2plK4iDRAkvvrhZlF6/7O+wy46FW3Kp9+qbKsulg4yL1lxcZZPurOY/plBmaFmtqpvf/If4vA=
X-Received: by 2002:a37:6115:: with SMTP id v21mr1538768qkb.43.1584602027025;
 Thu, 19 Mar 2020 00:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ae2ab305a123f146@google.com> <CACT4Y+a_d=5TNZth0dPov0B7tB5T9bAzWXBj1HjhXdn-=0KOOg@mail.gmail.com>
 <20200318214109.GV3199@paulmck-ThinkPad-P72>
In-Reply-To: <20200318214109.GV3199@paulmck-ThinkPad-P72>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 19 Mar 2020 08:13:35 +0100
Message-ID: <CACT4Y+ZhP_Qu+WZ4t2dLjd__H+rUKCTRCNoghvW9Uf3QQYRcNg@mail.gmail.com>
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

On Wed, Mar 18, 2020 at 10:41 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Wed, Mar 18, 2020 at 09:54:07PM +0100, Dmitry Vyukov wrote:
> > On Wed, Mar 18, 2020 at 5:57 PM syzbot
> > <syzbot+792dec47d693ccdc05a0@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    47780d78 Add linux-next specific files for 20200318
> > > git tree:       linux-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=14228745e00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=b68b7b89ad96c62a
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=792dec47d693ccdc05a0
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > >
> > > Unfortunately, I don't have any reproducer for this crash yet.
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+792dec47d693ccdc05a0@syzkaller.appspotmail.com
> > >
> > > kernel/rcu/tasks.h:1070:37: error: 'rcu_tasks_rude' undeclared (first use in this function); did you mean 'rcu_tasks_qs'?
> >
> > +rcu maintainers
>
> The kbuild test robot beat you to it, and apologies for the hassle.
> Fixed in -rcu on current "dev" branch.

If the kernel dev process would only have a way to avoid dups from all
test systems...
Now we need to spend time and deal with it. What has fixed it?
