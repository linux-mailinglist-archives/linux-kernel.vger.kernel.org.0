Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBF9997E8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 17:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389518AbfHVPSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 11:18:47 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43675 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732532AbfHVPSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 11:18:47 -0400
Received: by mail-io1-f65.google.com with SMTP id 18so12540034ioe.10
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 08:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ucbMC5erml7tFi/vSKgs7cW+rQvFN8BeI/aLj2HiGCA=;
        b=YZYTmMTTAUoOOm7zx6b8VkiKIgXdfcyNMBNzJf1Tp1aK74EHJ6WpyOPgC8F7mErT9y
         CdjdKGw80pxYRkvnrKtEbdPeKVcUxu46hvc/UoO0h5Id0XFLumdbv99KM/mujNRftI6p
         Qvj4MPl2Usvr1Wm5DhDc4gwPnXB2xFvT4IJvx/Ygq8gTldqRtXqgxJ9W68Vrd3O8AA/a
         2DlkVF13FqTrH13tM2JPhppfC+YzRfUmpB7HEJWNIi+6RF6byJeicuzlWa6cEYCW4N3p
         F8xoBxrOBkG2uUCT0Hyas8VCHzh1gidg+7iaSJ8qn0XFKig9EwRQ4wPAjvLBEhEGaIZ8
         C87Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ucbMC5erml7tFi/vSKgs7cW+rQvFN8BeI/aLj2HiGCA=;
        b=PMs2ppS+PFtg14oKWfg8/btY/OWGrQUQeS1pmIfCPTS2bxKODErDbfhECT9FbH9NPo
         kSQlipNeK6KDVob1c0c7oTrw3KgA4UaUEUwxgAQp7YwF7p2MbkUD85GXOf+HtZCObury
         xEZjm1SRpvUsQyJnMZL6M5k0HOQKM8lZwBGkLFlKfvkKIIcRQmSFPPIDE7rGHjf8thxv
         hEwuTxm+3GUsoylBAqXQ5ukIfXCydZI7H0WBmRd7naq5xgm0Fxtv2z9jkVS1P5PuENp2
         qDfLUOSZjklq3sbcYOqNm2C6pXtsJPdkqbO7azjbjdyr1/xlM2VoOb4ewYXdwh7t+3aD
         v45w==
X-Gm-Message-State: APjAAAVWO4VXhUx/LCba1cdWSIpQu4xUCPwjmAhOr8cEe3x170XRGPQ+
        bNCmHbHENZZibAoFP//ZnGDZ5ZFqxTj9uRzR2ktAhA==
X-Google-Smtp-Source: APXvYqzSxaxcqctxZa5RITBEENPgzu/1OGXUYLJbWIF/dhksERQTojjrUppwO1XqQ1ZQFpYDc5ZJhHQMitFVWYudvZk=
X-Received: by 2002:a02:ba91:: with SMTP id g17mr15990319jao.11.1566487126538;
 Thu, 22 Aug 2019 08:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190821001445.32114-1-echron@arista.com> <alpine.DEB.2.21.1908202024300.141379@chino.kir.corp.google.com>
 <20190821064732.GW3111@dhcp22.suse.cz> <alpine.DEB.2.21.1908210017320.177871@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.21.1908210017320.177871@chino.kir.corp.google.com>
From:   Edward Chron <echron@arista.com>
Date:   Thu, 22 Aug 2019 08:18:35 -0700
Message-ID: <CAM3twVQO6DPND39RLyMGWc7FGVUkWa4j-yXsa8sfLTbiGpL+cw@mail.gmail.com>
Subject: Re: [PATCH] mm/oom: Add oom_score_adj value to oom Killed process message
To:     David Rientjes <rientjes@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ivan Delalande <colona@arista.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 12:19 AM David Rientjes <rientjes@google.com> wrote:
>
> On Wed, 21 Aug 2019, Michal Hocko wrote:
>
> > > vm.oom_dump_tasks is pretty useful, however, so it's curious why you
> > > haven't left it enabled :/
> >
> > Because it generates a lot of output potentially. Think of a workload
> > with too many tasks which is not uncommon.
>
> Probably better to always print all the info for the victim so we don't
> need to duplicate everything between dump_tasks() and dump_oom_summary().
>
> Edward, how about this?

It is worth mentioning that David's suggested change, while I agree with Michal
that it should be a separate issue from updating the OOM Killed process message,
certainly has merit.  Though, it's not strictly necessary for what I
was asking for.

If you have scripts that scan your logs from OOM events, having a regular format
to OOM output makes parsing easier. With David's suggestion there would always
be a "Tasks state" section and the vm.oom_dump_tasks still works but
it just prevents
all the tasks from being dumped not from dumping the killed process.

OOM output was reorganized not that long ago as we discussed earlier to provide
improved organization of data, so this proposal would be in line with
that change.

If there is interest in this I can submit a separate patch submission.

>
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -420,11 +420,17 @@ static int dump_task(struct task_struct *p, void *arg)
>   * State information includes task's pid, uid, tgid, vm size, rss,
>   * pgtables_bytes, swapents, oom_score_adj value, and name.
>   */
> -static void dump_tasks(struct oom_control *oc)
> +static void dump_tasks(struct oom_control *oc, struct task_struct *victim)
>  {
>         pr_info("Tasks state (memory values in pages):\n");
>         pr_info("[  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name\n");
>
> +       /* If vm.oom_dump_tasks is disabled, only show the victim */
> +       if (!sysctl_oom_dump_tasks) {
> +               dump_task(victim, oc);
> +               return;
> +       }
> +
>         if (is_memcg_oom(oc))
>                 mem_cgroup_scan_tasks(oc->memcg, dump_task, oc);
>         else {
> @@ -465,8 +471,8 @@ static void dump_header(struct oom_control *oc, struct task_struct *p)
>                 if (is_dump_unreclaim_slabs())
>                         dump_unreclaimable_slab();
>         }
> -       if (sysctl_oom_dump_tasks)
> -               dump_tasks(oc);
> +       if (p || sysctl_oom_dump_tasks)
> +               dump_tasks(oc, p);
>         if (p)
>                 dump_oom_summary(oc, p);
>  }
