Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCD91742EC
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Feb 2020 00:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgB1XUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 18:20:10 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:41252 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgB1XUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 18:20:09 -0500
Received: by mail-ua1-f67.google.com with SMTP id f7so1611600uaa.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 15:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VU34bwckjyg5xsCO6OcehkGprELR+hgQrM6MHlc+k24=;
        b=p712VrGqlJPpzao7YD3m5WX0LwQXtasWycAZR6Qv7IV0othNqCEH71tVJM2dopv6af
         sSO8BQuwI9/or54uFHbjxF2CZdx+mBayfoBqjtGedEVeI+as7B6KM8lW8g0A2yYN3KPf
         Bt5nJiuIcPY6xqYfFiU1su+u2LEuGh6MVdzDcI9oEmRy3zU0uimpQkB2C6GNcZp1ThKW
         ftlwSgDHO7rZaaPNKsUOMofgpJYnyN2NrPVF2PrRfd/HdlhYG0NSDq+3O5nSutE6lrIM
         0nrGXHCVT0QfVmQkePA2n2I4pNWldsh6VIbF1ZbvzPNJCW5aIIzLigynVqrzxFeuH8Qc
         G/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VU34bwckjyg5xsCO6OcehkGprELR+hgQrM6MHlc+k24=;
        b=pt1sdFFXzuGBMj8sdkhx1Q7hyaSACiChhytNzCopoQCMsTVYzsaYSj3J7lqO5rDkVl
         FguHd5a+ephIrpFSgCumgXI7nK2H7lkWXMyHBU1+sJO+TtXoMqEVfODBxfL/1DoNe7bk
         OY8oQKiMgTYqoxJ0fab6qkUW0iqYhbaGCJVMoZFKAkAgySslLdQ8jbsPbdu4xZ/VUvU7
         QjQXnvYh70Wxm+VlwtOhK3Td/0ThnfcKkGhW0w/pjaqKF2PuW6VV69kg8v2bpD0C8Vm9
         OqBg3vnJ1Xgd3O2/jcGVFJubkzl5Y3yqkkU1eIt99yZrFhKoV8bWFggUTHROCL4P/Ucx
         LEHg==
X-Gm-Message-State: ANhLgQ3krvMp2vH7vRPizxn8187cDrl3L6GC5DdgbzxiNbmOmIIz9Rfu
        W1SvbOw1bL6s+Cry/LLx4ozjKA7NkR6wZl4NJs/aaKwENvU=
X-Google-Smtp-Source: ADFU+vu77RknxSN0Qez7GxUaCFdomtgxWWwgBofJYgMiqzYUzWYSNhzh9gQeVE9ot63IVGGE/yy38i9GzlZhRohTM4M=
X-Received: by 2002:ab0:32cf:: with SMTP id f15mr3393489uao.42.1582932006884;
 Fri, 28 Feb 2020 15:20:06 -0800 (PST)
MIME-Version: 1.0
References: <20200219014433.88424-1-minchan@kernel.org> <20200219014433.88424-7-minchan@kernel.org>
In-Reply-To: <20200219014433.88424-7-minchan@kernel.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 28 Feb 2020 15:19:55 -0800
Message-ID: <CAJuCfpE=7aqwegMb5i3EwWb=xcphXSNE33dCCUvt=WS0Sr-wfg@mail.gmail.com>
Subject: Re: [PATCH v6 6/7] mm/madvise: employ mmget_still_valid for write lock
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
        alexander.h.duyck@linux.intel.com, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 5:44 PM Minchan Kim <minchan@kernel.org> wrote:
>
> From: Oleksandr Natalenko <oleksandr@redhat.com>
>
> Do the very same trick as we already do since 04f5866e41fb. KSM hints
> will require locking mmap_sem for write since they modify vm_flags, so
> for remote KSM hinting this additional check is needed.
>
> Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>  mm/madvise.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/madvise.c b/mm/madvise.c
> index f6d9b9e66243..c55a18fe71f9 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1118,6 +1118,8 @@ int do_madvise(struct task_struct *target_task, struct mm_struct *mm,
>         if (write) {
>                 if (down_write_killable(&mm->mmap_sem))
>                         return -EINTR;
> +               if (current->mm != mm && !mmget_still_valid(mm))

mmget_still_valid() seems pretty light-weight, so why not just use
that without checking that the mm belongs to the current process
first?

> +                       goto skip_mm;
>         } else {
>                 down_read(&mm->mmap_sem);
>         }
> @@ -1169,6 +1171,7 @@ int do_madvise(struct task_struct *target_task, struct mm_struct *mm,
>         }
>  out:
>         blk_finish_plug(&plug);
> +skip_mm:
>         if (write)
>                 up_write(&mm->mmap_sem);
>         else
> --
> 2.25.0.265.gbab2e86ba0-goog
>
