Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6120620CE4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 18:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfEPQ0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 12:26:02 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:38575 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfEPQ0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 12:26:02 -0400
Received: by mail-vs1-f65.google.com with SMTP id x184so1688344vsb.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 09:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aF7z4HMLUnakhny7k0GasKk7IF4REIlPL6fyWISpTgk=;
        b=tNqI2/n1/KRWaJC+/CpSW6dpIqwdsMYCdLezQXGYWXVbirGLs2g6o5eFI8o7yn3+fy
         zoP1qOF3qa/Ft/+eb6VML5ISPaIJxdHsZahgMeuB3cDrPgk5NlWNVi7VcgXobHzL37vA
         VYT4v1aRcr5tm9LBwLpSLP/+yE6YIGXDhlwaQiUexHLdFnVcVGcGZ6nZTw/5Mo+yHzcc
         HPFl2Juc+RnIB0MPzP0JfxkaEtrwWJK/Bnsv08I8r221StpqU1iDcSBXMUP/xw7YAinb
         T5+IC4xAPzZyHwQmvh11vFQWFg1Tz8fszmCRdto1rJaDjf1gPy1nHNTLHjuSoImf4/si
         jdng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aF7z4HMLUnakhny7k0GasKk7IF4REIlPL6fyWISpTgk=;
        b=G4itPURbCFfoZR1SKfivRh3kfpMztw/q6z2GVaSyIhjbQ7AoXgE2fwHCdJOvJYmUdD
         8wKA5UWdbqYpBXCs6vD/OnowBWW/o+LOFmhL0iJfZHMnGUaMBV+UAh1KeN9wq7x2EyAe
         7MC8cyE9NNznJAgyKoSNz/AKM7VjMhXb4UkZsECsIdY4DoBq6i7WloSZFpX0zKclgFGx
         3vRiXIBUn0WPea945gfZlzISLRYCjfFuaKab4ip7WDE/pwMRCCrf2ybuQ/o1XUs4x3J+
         OjgaXgt+3h2cWgBGkRpAAXSYxp0H7RjiX0xF39EMqrkPZFfkLk1z6SrLyNpNedyhi7+5
         HQCA==
X-Gm-Message-State: APjAAAXoFi8qpIWj5+rL/ug4n1RG3h/U5wpv3KbBBzN+JT/sjbq7+513
        +uxS+tPlKTNYqig3/w2fyiFXw0QnY9FkAZiB74o=
X-Google-Smtp-Source: APXvYqx/cc7lJi9PCpEFthV94uIkRRjAs7sIeQj5KsGC3UjX5CEfXwDS+OwvGnUgD0g4EfbKAsvbZknBvShClFQYgak=
X-Received: by 2002:a67:f6c4:: with SMTP id v4mr144463vso.182.1558023960664;
 Thu, 16 May 2019 09:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <1557844195-18882-1-git-send-email-rppt@linux.ibm.com>
In-Reply-To: <1557844195-18882-1-git-send-email-rppt@linux.ibm.com>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Thu, 16 May 2019 09:25:49 -0700
Message-ID: <CANaxB-zxz5oSeNS2cK-3m6_d9x_kw2pkwWibgOEgr+uOP6YhOA@mail.gmail.com>
Subject: Re: [PATCH] mm/gup: continue VM_FAULT_RETRY processing event for pre-faults
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 7:32 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> When get_user_pages*() is called with pages = NULL, the processing of
> VM_FAULT_RETRY terminates early without actually retrying to fault-in all
> the pages.
>
> If the pages in the requested range belong to a VMA that has userfaultfd
> registered, handle_userfault() returns VM_FAULT_RETRY *after* user space
> has populated the page, but for the gup pre-fault case there's no actual
> retry and the caller will get no pages although they are present.
>
> This issue was uncovered when running post-copy memory restore in CRIU
> after commit d9c9ce34ed5c ("x86/fpu: Fault-in user stack if
> copy_fpstate_to_sigframe() fails").
>
> After this change, the copying of FPU state to the sigframe switched from
> copy_to_user() variants which caused a real page fault to get_user_pages()
> with pages parameter set to NULL.
>
> In post-copy mode of CRIU, the destination memory is managed with
> userfaultfd and lack of the retry for pre-fault case in get_user_pages()
> causes a crash of the restored process.
>
> Making the pre-fault behavior of get_user_pages() the same as the "normal"
> one fixes the issue.
>

Tested-by: Andrei Vagin <avagin@gmail.com>

https://travis-ci.org/avagin/linux/builds/533184940

> Fixes: d9c9ce34ed5c ("x86/fpu: Fault-in user stack if copy_fpstate_to_sigframe() fails")
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  mm/gup.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/mm/gup.c b/mm/gup.c
> index 91819b8..c32ae5a 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -936,10 +936,6 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
>                         BUG_ON(ret >= nr_pages);
>                 }
>
> -               if (!pages)
> -                       /* If it's a prefault don't insist harder */
> -                       return ret;
> -
>                 if (ret > 0) {
>                         nr_pages -= ret;
>                         pages_done += ret;
> @@ -955,8 +951,12 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
>                                 pages_done = ret;
>                         break;
>                 }
> -               /* VM_FAULT_RETRY triggered, so seek to the faulting offset */
> -               pages += ret;
> +               /*
> +                * VM_FAULT_RETRY triggered, so seek to the faulting offset.
> +                * For the prefault case (!pages) we only update counts.
> +                */
> +               if (likely(pages))
> +                       pages += ret;
>                 start += ret << PAGE_SHIFT;
>
>                 /*
> @@ -979,7 +979,8 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
>                 pages_done++;
>                 if (!nr_pages)
>                         break;
> -               pages++;
> +               if (likely(pages))
> +                       pages++;
>                 start += PAGE_SIZE;
>         }
>         if (lock_dropped && *locked) {
> --
> 2.7.4
>
