Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE4844D78
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 22:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbfFMUco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 16:32:44 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:44441 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfFMUco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 16:32:44 -0400
Received: by mail-ua1-f65.google.com with SMTP id 8so48555uaz.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 13:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XnwdqEB/zxSUoi8AX3TTUKJIQzqvpn/EDnWBDbRAeC0=;
        b=mh0Rc495xOBUVTnnEmr4AY5NBwVSaqzX7zqV6Dc0pZhAdBBMh97ij8pz/2/iyufp6F
         ooJ45PQgHYRytRZez//z7awy8/LfcteuyU4iQPzoIaxepq7w2liWukbsUhe7AVsGV2m4
         cGRVK2X2wHvYVrnO3N3b1vRlOqgAy1SA4v+7JmfMJIywOp9HK3ygvJWCv7tbo6q745j4
         w7aNSUQU4VPwQ+rzdjFOPSxICgPxP25z9gSYvI9Fr4DHolTZx7l7s1QyHkMnZG2KUxWG
         2/hwjxPew43xbKjCW3en5tfPSloSM/x9hxBFVQ0j+Y7gNVoK1FrgVaKF+OIkIdmaZH4p
         Ua2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XnwdqEB/zxSUoi8AX3TTUKJIQzqvpn/EDnWBDbRAeC0=;
        b=GrlLopzh1nLW/kZjJkdPRR/i0Hu/qzkAaywNsuQpY6wT3Jd6qyu+MWaRbTdy6x+pKU
         ebLDyGKDxRKrGa3zGnElQnGxpKky6CuCHDxCEW+OcbHP3D91X2wy/V9KOfNKnGCu8lFG
         Ia+homfY7fKWQU6quu9FWtVhMR70c0PHxzAB3JHMxyg8U9pdmexovYVvaTEcEtywSR5I
         xxpEzWJyLzrny9PDe7RvVdXsE0hdJGKa1NGFocbpdH4rL+jOOFv39v10+yt+Wub6pMI5
         pzzfVDaYfFwD1G9NSAsQ8iqrgcuf6yiDO8dRZeX32uMSqQ5Q7VuLVKIwxJu4QUyr7UY5
         qN7g==
X-Gm-Message-State: APjAAAXkk5CIz3EX1Wofft1MkxhM/bV52/gMnJdr9UsYmWtowHdaAGiW
        0m1uBlR6u/FnJEkRgH6INGifuCboMz32Rw4r7VvxZr/zJt7bSQ==
X-Google-Smtp-Source: APXvYqwYSC5celn0/YY56qS1Ya7QSTRLAhhjVJF5SlLdd0JuZboIS3qB8YqgOjoOCvVdt0mtU6tXdL4lZWb7/Se6XdM=
X-Received: by 2002:ab0:6619:: with SMTP id r25mr3232042uam.33.1560457962568;
 Thu, 13 Jun 2019 13:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <156007465229.3335.10259979070641486905.stgit@buzz>
 <156007493995.3335.9595044802115356911.stgit@buzz> <20190612231426.GA3639@gmail.com>
 <f15478b5-098f-e1be-0928-62f46cff77e7@yandex-team.ru>
In-Reply-To: <f15478b5-098f-e1be-0928-62f46cff77e7@yandex-team.ru>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Thu, 13 Jun 2019 13:32:31 -0700
Message-ID: <CANaxB-xUADVJx7HL6uHNRLDLNC19urcp-NY6RnyrckuH2neaAw@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] proc: use down_read_killable mmap_sem for /proc/pid/map_files
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Roman Gushchin <guro@fb.com>, Dmitry Safonov <dima@arista.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 1:15 AM Konstantin Khlebnikov
<khlebnikov@yandex-team.ru> wrote:
>
> On 13.06.2019 2:14, Andrei Vagin wrote:
> > On Sun, Jun 09, 2019 at 01:09:00PM +0300, Konstantin Khlebnikov wrote:
> >> Do not stuck forever if something wrong.
> >> Killable lock allows to cleanup stuck tasks and simplifies investigation.
> >
> > This patch breaks the CRIU project, because stat() returns EINTR instead
> > of ENOENT:
> >
> > [root@fc24 criu]# stat /proc/self/map_files/0-0
> > stat: cannot stat '/proc/self/map_files/0-0': Interrupted system call
>
> Good catch.
>
> It seems CRIU tests has good coverage for darkest corners of kernel API.
> Kernel CI projects should use it. I suppose you know how to promote this. =)

I remember Mike was trying to add the CRIU test suite into kernel-ci,
but it looks like this ended up with nothing.

The good thing here is that we have our own kernel-ci:
https://travis-ci.org/avagin/linux/builds

Travis-CI doesn't allow to replace the kernel, so we use CRIU to
dump/restore a ssh session and travis doesn't notice when we kexec a
new kernel.

>
> >
> > Here is one inline comment with the fix for this issue.
> >
> >>
> >> It seems ->d_revalidate() could return any error (except ECHILD) to
> >> abort validation and pass error as result of lookup sequence.
> >>
> >> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> >> Reviewed-by: Roman Gushchin <guro@fb.com>
> >> Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>
> >> Reviewed-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> >
> > It was nice to see all four of you in one place :).
> >
> >> Acked-by: Michal Hocko <mhocko@suse.com>
> >> ---
> >>   fs/proc/base.c |   27 +++++++++++++++++++++------
> >>   1 file changed, 21 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/fs/proc/base.c b/fs/proc/base.c
> >> index 9c8ca6cd3ce4..515ab29c2adf 100644
> >> --- a/fs/proc/base.c
> >> +++ b/fs/proc/base.c
> >> @@ -1962,9 +1962,12 @@ static int map_files_d_revalidate(struct dentry *dentry, unsigned int flags)
> >>              goto out;
> >>
> >>      if (!dname_to_vma_addr(dentry, &vm_start, &vm_end)) {
> >> -            down_read(&mm->mmap_sem);
> >> -            exact_vma_exists = !!find_exact_vma(mm, vm_start, vm_end);
> >> -            up_read(&mm->mmap_sem);
> >> +            status = down_read_killable(&mm->mmap_sem);
> >> +            if (!status) {
> >> +                    exact_vma_exists = !!find_exact_vma(mm, vm_start,
> >> +                                                        vm_end);
> >> +                    up_read(&mm->mmap_sem);
> >> +            }
> >>      }
> >>
> >>      mmput(mm);
> >> @@ -2010,8 +2013,11 @@ static int map_files_get_link(struct dentry *dentry, struct path *path)
> >>      if (rc)
> >>              goto out_mmput;
> >>
> >> +    rc = down_read_killable(&mm->mmap_sem);
> >> +    if (rc)
> >> +            goto out_mmput;
> >> +
> >>      rc = -ENOENT;
> >> -    down_read(&mm->mmap_sem);
> >>      vma = find_exact_vma(mm, vm_start, vm_end);
> >>      if (vma && vma->vm_file) {
> >>              *path = vma->vm_file->f_path;
> >> @@ -2107,7 +2113,10 @@ static struct dentry *proc_map_files_lookup(struct inode *dir,
> >>      if (!mm)
> >>              goto out_put_task;
> >>
> >> -    down_read(&mm->mmap_sem);
> >> +    result = ERR_PTR(-EINTR);
> >> +    if (down_read_killable(&mm->mmap_sem))
> >> +            goto out_put_mm;
> >> +
> >
> >       result = ERR_PTR(-ENOENT);
> >
> >>      vma = find_exact_vma(mm, vm_start, vm_end);
> >>      if (!vma)
> >>              goto out_no_vma;
> >> @@ -2118,6 +2127,7 @@ static struct dentry *proc_map_files_lookup(struct inode *dir,
> >>
> >>   out_no_vma:
> >>      up_read(&mm->mmap_sem);
> >> +out_put_mm:
> >>      mmput(mm);
> >>   out_put_task:
> >>      put_task_struct(task);
> >> @@ -2160,7 +2170,12 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
> >>      mm = get_task_mm(task);
> >>      if (!mm)
> >>              goto out_put_task;
> >> -    down_read(&mm->mmap_sem);
> >> +
> >> +    ret = down_read_killable(&mm->mmap_sem);
> >> +    if (ret) {
> >> +            mmput(mm);
> >> +            goto out_put_task;
> >> +    }
> >>
> >>      nr_files = 0;
> >>
