Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B15B7CD181
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2019 12:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfJFK7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Oct 2019 06:59:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53464 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfJFK7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 06:59:36 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iH4GB-0007pU-N7; Sun, 06 Oct 2019 10:59:31 +0000
Date:   Sun, 6 Oct 2019 12:59:31 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com>,
        bsingharora@gmail.com, Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH] taskstats: fix data-race
Message-ID: <20191006105930.5a5jxislaqpzmo22@wittgenstein>
References: <0000000000009b403005942237bf@google.com>
 <20191005112806.13960-1-christian.brauner@ubuntu.com>
 <CACT4Y+YiVE52xkADKgpfzRgofHbVxtRpcbKo_RU81jjOV_0TvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+YiVE52xkADKgpfzRgofHbVxtRpcbKo_RU81jjOV_0TvA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 06, 2019 at 12:00:32PM +0200, Dmitry Vyukov wrote:
> On Sat, Oct 5, 2019 at 1:28 PM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > When assiging and testing taskstats in taskstats
> > taskstats_exit() there's a race around writing and reading sig->stats.
> >
> > cpu0:
> > task calls exit()
> > do_exit()
> >         -> taskstats_exit()
> >                 -> taskstats_tgid_alloc()
> > The task takes sighand lock and assigns new stats to sig->stats.
> >
> > cpu1:
> > task catches signal
> > do_exit()
> >         -> taskstats_tgid_alloc()
> >                 -> taskstats_exit()
> > The tasks reads sig->stats __without__ holding sighand lock seeing
> > garbage.
> >
> > Fix this by taking sighand lock when reading sig->stats.
> >
> > Reported-by: syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > ---
> >  kernel/taskstats.c | 28 +++++++++++++++++-----------
> >  1 file changed, 17 insertions(+), 11 deletions(-)
> >
> > diff --git a/kernel/taskstats.c b/kernel/taskstats.c
> > index 13a0f2e6ebc2..58b145234c4a 100644
> > --- a/kernel/taskstats.c
> > +++ b/kernel/taskstats.c
> > @@ -553,26 +553,32 @@ static int taskstats_user_cmd(struct sk_buff *skb, struct genl_info *info)
> >
> >  static struct taskstats *taskstats_tgid_alloc(struct task_struct *tsk)
> >  {
> > +       int empty;
> > +       struct taskstats *stats_new, *stats = NULL;
> >         struct signal_struct *sig = tsk->signal;
> > -       struct taskstats *stats;
> > -
> > -       if (sig->stats || thread_group_empty(tsk))
> > -               goto ret;
> >
> >         /* No problem if kmem_cache_zalloc() fails */
> > -       stats = kmem_cache_zalloc(taskstats_cache, GFP_KERNEL);
> > +       stats_new = kmem_cache_zalloc(taskstats_cache, GFP_KERNEL);
> 
> This seems to be over-pessimistic wrt performance b/c:
> 1. We always allocate the object and free it on every call, even if
> the stats are already allocated, whereas currently we don't.
> 2. We always allocate the object and free it if thread_group_empty,
> whereas currently we don't.
> 3. We do lock/unlock on every call.
> 
> I would suggest to fix the double-checked locking properly.

As I said in my reply to Marco: I'm integrating this. I just haven't
had time to update the patch.

Christian
