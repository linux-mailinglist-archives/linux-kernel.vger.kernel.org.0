Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80C6B176424
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 20:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgCBTie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 14:38:34 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:41060 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbgCBTid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 14:38:33 -0500
Received: by mail-vk1-f196.google.com with SMTP id y201so157267vky.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 11:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j8R94pKpSXXzNdiY8Ys1MGj7S3neBSM+zNRuq7e9bYE=;
        b=sCVmdcxblem1m25P0lhvWYwWlDFaainwSHrH5z0x63X48b3ZgW3TVWoA95efBblsYT
         o3PloGAse+JhcX//zcy14pQ9b1UZNEB5a2gIob744q2cK0Osf8QtUF8tUMIQnMf30iuI
         d6MpkUq5Yk3WwkJxOQOx3ztAIgdTmSizC+7lp/8J0rXe7dEAkysizrF+uBisE09IUtDG
         oN0iWCHpyFzJY7OUN0iiG1LivpR3o8fEJ5V8OLj4eAWkNLtJ3hoC0OiSX512iO48lSLa
         H+74KuzS39Wbca+rIJ14Pyqd7A/ZoRbywPvLR7DHRWkW2FqxQCGszA+aWNuFXqBrqxZ2
         jk/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j8R94pKpSXXzNdiY8Ys1MGj7S3neBSM+zNRuq7e9bYE=;
        b=p4rpT/pyiRj2Tr67FyzhZno3cMJVUQ6K3ZYkuMv/GUQz4pe9LjfwNliXQrl5z9mm1X
         7/lM+WipiSZUjGjfVtAzRFkJIY9GvTtG72scDpQCndt06jqQk1WEMNukgDPCeC066bxS
         grLmQMlrG1QXw8fGWSVdKeLYVpVWCNJ6AgoylBQWbLLLn3lpe7RJGQXKuYlm7rtB9Tq9
         V7m60SfKTJ21T2vI4VXFob14uJBFsVFCD/5zIqC7k3DLbEb8Bm0kh1KujBMSZ8lcl1vl
         J2YsipMJHutVw7VUzWUGikETrcrhPegDV+nfYp04W36D6VvYp4OOJtec1Ec7WvZ2EHMr
         WPpQ==
X-Gm-Message-State: ANhLgQ0vOW2Hq/0DiKaJXtuGsICwYPr5N83TJf5NMUpvK7xmi9QznaaL
        EZNc2jtqJ+6yQ2pkNDLcrMbVJAIB2aueB7pTUgAXbg==
X-Google-Smtp-Source: ADFU+vtGpbwJCJKSGTODLk1NdLLLqodSei6LUwoMrjE1vMlgz2R8nEU56d0H0ZHvSZ5s5xFk82XPCRrc+qE7d00ww4Y=
X-Received: by 2002:ac5:c914:: with SMTP id t20mr813628vkl.37.1583177911680;
 Mon, 02 Mar 2020 11:38:31 -0800 (PST)
MIME-Version: 1.0
References: <20200219014433.88424-1-minchan@kernel.org> <20200219014433.88424-6-minchan@kernel.org>
 <CAJuCfpE_T1UG_eSQMa6y7n0GXQBOQ8sE=0fcWmSo2ZhHoj4mCg@mail.gmail.com> <20200302192328.GB234476@google.com>
In-Reply-To: <20200302192328.GB234476@google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 2 Mar 2020 11:38:20 -0800
Message-ID: <CAJuCfpHUp7z9wo+rv-+_W9iMupTf41ZJJncZccW4dsiewu7MFA@mail.gmail.com>
Subject: Re: [PATCH v6 5/7] mm: support both pid and pidfd for process_madvise
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        oleksandr@redhat.com, Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>, sj38.park@gmail.com,
        alexander.h.duyck@linux.intel.com, Jann Horn <jannh@google.com>,
        Christian Brauner <christian@brauner.io>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 2, 2020 at 11:23 AM Minchan Kim <minchan@kernel.org> wrote:
>
> On Fri, Feb 28, 2020 at 02:41:07PM -0800, Suren Baghdasaryan wrote:
> > On Tue, Feb 18, 2020 at 5:44 PM Minchan Kim <minchan@kernel.org> wrote:
> > >
> > > There is a demand[1] to support pid as well pidfd for process_madvise
> > > to reduce unnecessary syscall to get pidfd if the user has control of
> > > the target process(ie, they could guarantee the process is not gone
> > > or pid is not reused. Or, it might be okay to give a hint to wrong
> > > process).
> >
> > nit: When would "give a hint to wrong process" be ok? I would just
> > remove this part.
>
> I wanted to say non destructive hints. It's already true for other
> some hints because they are just best effort so it's not critical
> to be failed. If you mind it, I will remove the phrase.

Up to you, or maybe call it a "non-fatal" error? Saying that it's ok
to hint a wrong process sounds wrong to me.

>
> Thanks.
>
> >
> > >
> > > This patch aims for supporting both options like waitid(2). So, the
> > > syscall is currently,
> > >
> > >         int process_madvise(int which, pid_t pid, void *addr,
> > >                 size_t length, int advise, unsigned long flag);
> > >
> > > @which is actually idtype_t for userspace libray and currently,
> > > it supports P_PID and P_PIDFD.
> > >
> > > [1]  https://lore.kernel.org/linux-mm/9d849087-3359-c4ab-fbec-859e8186c509@virtuozzo.com/
> > >
> > > Cc: Christian Brauner <christian@brauner.io>
> > > Suggested-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> > > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > > ---
> > >  include/linux/syscalls.h |  3 ++-
> > >  mm/madvise.c             | 34 ++++++++++++++++++++++------------
> > >  2 files changed, 24 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> > > index e4cd2c2f8bb4..f5ada20e2943 100644
> > > --- a/include/linux/syscalls.h
> > > +++ b/include/linux/syscalls.h
> > > @@ -876,7 +876,8 @@ asmlinkage long sys_munlockall(void);
> > >  asmlinkage long sys_mincore(unsigned long start, size_t len,
> > >                                 unsigned char __user * vec);
> > >  asmlinkage long sys_madvise(unsigned long start, size_t len, int behavior);
> > > -asmlinkage long sys_process_madvise(int pidfd, unsigned long start,
> > > +
> > > +asmlinkage long sys_process_madvise(int which, pid_t pid, unsigned long start,
> > >                         size_t len, int behavior, unsigned long flags);
> > >  asmlinkage long sys_remap_file_pages(unsigned long start, unsigned long size,
> > >                         unsigned long prot, unsigned long pgoff,
> > > diff --git a/mm/madvise.c b/mm/madvise.c
> > > index def1507c2030..f6d9b9e66243 100644
> > > --- a/mm/madvise.c
> > > +++ b/mm/madvise.c
> > > @@ -1182,11 +1182,10 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
> > >         return do_madvise(current, current->mm, start, len_in, behavior);
> > >  }
> > >
> > > -SYSCALL_DEFINE5(process_madvise, int, pidfd, unsigned long, start,
> > > +SYSCALL_DEFINE6(process_madvise, int, which, pid_t, upid, unsigned long, start,
> > >                 size_t, len_in, int, behavior, unsigned long, flags)
> > >  {
> > >         int ret;
> > > -       struct fd f;
> > >         struct pid *pid;
> > >         struct task_struct *task;
> > >         struct mm_struct *mm;
> > > @@ -1197,20 +1196,31 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, unsigned long, start,
> > >         if (!process_madvise_behavior_valid(behavior))
> > >                 return -EINVAL;
> > >
> > > -       f = fdget(pidfd);
> > > -       if (!f.file)
> > > -               return -EBADF;
> > > +       switch (which) {
> > > +       case P_PID:
> > > +               if (upid <= 0)
> > > +                       return -EINVAL;
> > > +
> > > +               pid = find_get_pid(upid);
> > > +               if (!pid)
> > > +                       return -ESRCH;
> > > +               break;
> > > +       case P_PIDFD:
> > > +               if (upid < 0)
> > > +                       return -EINVAL;
> > >
> > > -       pid = pidfd_pid(f.file);
> > > -       if (IS_ERR(pid)) {
> > > -               ret = PTR_ERR(pid);
> > > -               goto fdput;
> > > +               pid = pidfd_get_pid(upid);
> > > +               if (IS_ERR(pid))
> > > +                       return PTR_ERR(pid);
> > > +               break;
> > > +       default:
> > > +               return -EINVAL;
> > >         }
> > >
> > >         task = get_pid_task(pid, PIDTYPE_PID);
> > >         if (!task) {
> > >                 ret = -ESRCH;
> > > -               goto fdput;
> > > +               goto put_pid;
> > >         }
> > >
> > >         mm = mm_access(task, PTRACE_MODE_ATTACH_FSCREDS);
> > > @@ -1223,7 +1233,7 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, unsigned long, start,
> > >         mmput(mm);
> > >  release_task:
> > >         put_task_struct(task);
> > > -fdput:
> > > -       fdput(f);
> > > +put_pid:
> > > +       put_pid(pid);
> > >         return ret;
> > >  }
> > > --
> > > 2.25.0.265.gbab2e86ba0-goog
> > >
> >
> > Reviewed-by: Suren Baghdasaryan <surenb@google.com>
