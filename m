Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07798CDC67
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 09:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfJGHba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 03:31:30 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39510 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfJGHb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 03:31:29 -0400
Received: by mail-qt1-f193.google.com with SMTP id n7so17837272qtb.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 00:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PAvV9Agn0ECIwM1/ulknHtQXTqOwD/53ncNEyE+Ou54=;
        b=a3oiv9GXNiAlnJyqPDfgTP9DacZNTWxOG6LoaGGSR+7k3QzznfoMq85SG7oaqDxegN
         pegVmlD4jWH8X4OZdq/7WZyxFPoLGR5CDDiH9kfAsxmocu4s6KcszHLWBQqsZ9FOLWr/
         5u8cna13mDb0Ctvg+jZOyzqxhyiII7mTRBuzHu/Nhzw3ernPXUtZvnpCFzM+EkhJYClZ
         uyN4Xffa9VCnQzDHSjSxXcxfcgZyapvPvE22gsKIE6kmcmWmcqRCh71OuT8Gw6hpabZ5
         6THT6FKX+kMeJDuxrNvofHF0U5qWoG4brJp4Dh0q0zH/90TTmmbxDwP1M4IYwRoG1USI
         8OPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PAvV9Agn0ECIwM1/ulknHtQXTqOwD/53ncNEyE+Ou54=;
        b=N/Up7fnCKszYdRYySYyVb4vWbEPzUqYa+b5gkPNLuWSfqOo7qRNLd/XmkQ/nppmjzV
         ukBbXbjv3jsMycZIl97NenEpH5RigXeD1Pq3WrjNHkhwXo+qZ3Jzty1Nt2Ioi8YMkfrI
         /So3NSuttfdvf7TBVyTKSCO1kI5FWtYSBa5XVv6Gfpu4izD4z7n5ugKIJNxXNPbymNDU
         Ht2eyAK7duA/So5/1H4p8P4Y43UARZMXRBPUUvRcvoNgEQdIeL3qc07N81DSsWQD1K4I
         vQGGcaMA7j1xTwaiBVBukVP53OBF0WIqM5/OyR/VjyZb1qlu3s5MjhxwMMLi3LgZdDpu
         Zemg==
X-Gm-Message-State: APjAAAWK4uB+7gH4LBS2T8IygB7+YE1z6Yd3yadqY132PU9rD7DEnydu
        ieX/R78+0E904agjP1yTiidLp+5rjSyAq/yynZrTRg==
X-Google-Smtp-Source: APXvYqwyEPb2TgQ0XpuT0ryyajjMTFJzvXBMjMi6cPN+qapQSODTyKwusF/oW+iM490np0OBUP3TWwjB/sKfpyK4hjQ=
X-Received: by 2002:ac8:7642:: with SMTP id i2mr27526167qtr.57.1570433487230;
 Mon, 07 Oct 2019 00:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <20191005112806.13960-1-christian.brauner@ubuntu.com> <20191006235216.7483-1-christian.brauner@ubuntu.com>
In-Reply-To: <20191006235216.7483-1-christian.brauner@ubuntu.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 7 Oct 2019 09:31:16 +0200
Message-ID: <CACT4Y+Z95M0co_vLTvbNDxb5YjuXwMcOBwNxZnJkMb_fLCDXXg@mail.gmail.com>
Subject: Re: [PATCH] taskstats: fix data-race
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     bsingharora@gmail.com, Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 7, 2019 at 1:52 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> When assiging and testing taskstats in taskstats_exit() there's a race
> when writing and reading sig->stats when a thread-group with more than
> one thread exits:
>
> cpu0:
> thread catches fatal signal and whole thread-group gets taken down
>  do_exit()
>  do_group_exit()
>  taskstats_exit()
>  taskstats_tgid_alloc()
> The tasks reads sig->stats holding sighand lock seeing garbage.
>
> cpu1:
> task calls exit_group()
>  do_exit()
>  do_group_exit()
>  taskstats_exit()
>  taskstats_tgid_alloc()
> The task takes sighand lock and assigns new stats to sig->stats.
>
> Fix this by using READ_ONCE() and smp_store_release().
>
> Reported-by: syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
> /* v1 */
> Link: https://lore.kernel.org/r/20191005112806.13960-1-christian.brauner@ubuntu.com
>
> /* v2 */
> - Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>:
>   - fix the original double-checked locking using memory barriers
> ---
>  kernel/taskstats.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

Thanks!

> diff --git a/kernel/taskstats.c b/kernel/taskstats.c
> index 13a0f2e6ebc2..8ee046e8a792 100644
> --- a/kernel/taskstats.c
> +++ b/kernel/taskstats.c
> @@ -554,24 +554,25 @@ static int taskstats_user_cmd(struct sk_buff *skb, struct genl_info *info)
>  static struct taskstats *taskstats_tgid_alloc(struct task_struct *tsk)
>  {
>         struct signal_struct *sig = tsk->signal;
> -       struct taskstats *stats;
> +       struct taskstats *stats_new, *stats;
>
> -       if (sig->stats || thread_group_empty(tsk))
> -               goto ret;
> +       stats = READ_ONCE(sig->stats);
> +       if (stats || thread_group_empty(tsk))
> +               return stats;
>
>         /* No problem if kmem_cache_zalloc() fails */
> -       stats = kmem_cache_zalloc(taskstats_cache, GFP_KERNEL);
> +       stats_new = kmem_cache_zalloc(taskstats_cache, GFP_KERNEL);
>
>         spin_lock_irq(&tsk->sighand->siglock);
>         if (!sig->stats) {
> -               sig->stats = stats;
> -               stats = NULL;
> +               smp_store_release(&sig->stats, stats_new);
> +               stats_new = NULL;
>         }
>         spin_unlock_irq(&tsk->sighand->siglock);
>
> -       if (stats)
> -               kmem_cache_free(taskstats_cache, stats);
> -ret:
> +       if (stats_new)
> +               kmem_cache_free(taskstats_cache, stats_new);
> +
>         return sig->stats;
>  }
>
> --
> 2.23.0
>
