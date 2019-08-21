Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECDA798711
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 00:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731122AbfHUWWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 18:22:20 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36860 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731104AbfHUWWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 18:22:19 -0400
Received: by mail-io1-f67.google.com with SMTP id o9so7926441iom.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 15:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1n1EqLNQaVBykjrc6gwB/kJFS9Ls04rvVpImZ/x3es0=;
        b=CYsF6BJGJdSPA7AbVCKU7VpXyzx9FVJZzR3CqqYlqbawduDvrFSyZo6ah0QQ6MHy9A
         qAqzbTq6NujyUK4lznGOC3JS0N/DJegldMLMpihJ7TPdki7dqCRPgxGMCcuwqBuFIbgv
         1bcaZPiwfAjo7aaoIbJ8Sn/udLpisl62i8aXL//XnSpvoIg3VuQIIaeymrcwdBeQxr7D
         7OskJ2JihhelcLKVLvUbePycluFv3HcEY2T6yWj9JSJveiM9fDr8/7woLK+QlNdeqf2J
         QEjpkA2taXlg+ai+QRi51Q4S0I1VImxTfSdYxmBKxA6UXk7PKKIMCjS9e4HuhGQzwFSq
         a0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1n1EqLNQaVBykjrc6gwB/kJFS9Ls04rvVpImZ/x3es0=;
        b=dFGHhcBcFU+2oDXcxK5Huw35/+OOqV85pJBl0XUX07tJYMu+zCghb/TkZoKCBWgl7k
         Q1C7SQVMVmcXv9tSHAmLY2RziKcQ3mRf10iqRwBOFtR5XoUq02WUHRIHLHTgFGsxcPMe
         XAy4WQwnCkkbZf0Gj97E9RiJiGYPxKGyTf7dDmXGXRR6VenWBZKOcdrBcjm6MfOCHZIf
         kx17hpXvjfiGxXMMwnQqERRt9qlhmrE1R8f/G9kvz69FBpUyqtfT4TF63mBQzpdtV8dA
         RWWP/kqTCjcfXqiuHnXMQyBfr3jT3U+1iL31WgLi303qK+gYT4DPes5MUP/iVsfPcIwF
         p3Sg==
X-Gm-Message-State: APjAAAVIvtmfYghRIvQHjBrJJuM53TG9xyf0IcJyvxJ5x8yN+8R4zE0f
        YbkSd+5Ev0iKd4niT0eH/ylHOcq1NKARX60ZcPQkfw==
X-Google-Smtp-Source: APXvYqzvag+OaQujSvk5p6H9EQ7CwvYSnMX/0Cx6iGEf7IytGcg/9JK5V/Tm+mb8GzPjJP8pE0g5ezJKByyL9zPUvY8=
X-Received: by 2002:a5d:8484:: with SMTP id t4mr7355672iom.5.1566426138770;
 Wed, 21 Aug 2019 15:22:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190821001445.32114-1-echron@arista.com> <alpine.DEB.2.21.1908202024300.141379@chino.kir.corp.google.com>
 <20190821064732.GW3111@dhcp22.suse.cz> <alpine.DEB.2.21.1908210017320.177871@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.21.1908210017320.177871@chino.kir.corp.google.com>
From:   Edward Chron <echron@arista.com>
Date:   Wed, 21 Aug 2019 15:22:07 -0700
Message-ID: <CAM3twVQ4Z7dOx+bFn3O6ERstQ4wm3ojhM624NVzc=CAZw1OUUA@mail.gmail.com>
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

I would be willing to accept this, though as Michal mentions in his
post, it would be very helpful to have the oom_score_adj on the Killed
process message.

One reason for that is that the Killed process message is the one
message that is printed with error priority (pr_err)
and so that message can be filtered out and sent to notify support
that an OOM event occurred.
Putting any information that can be shared in that message is useful
from my experience as it the initial point of triage for an OOM event.
Even if the full log with per user process is available it the
starting point for triage for an OOM event.

So from my perspective I would be happy having both, with David's
proposal providing a bit of extra information as shown here:

Jul 21 20:07:48 linuxserver kernel: [  pid  ]   uid  tgid total_vm
 rss pgtables_bytes swapents oom_score_adj name
Jul 21 20:07:48 linuxserver kernel: [    547]     0   547    31664
615             299008              0                       0
systemd-journal

The OOM Killed process message will print as:

Jul 21 20:07:48 linuxserver kernel: Out of memory: Killed process 2826
(oomprocs) total-vm:1056800kB, anon-rss:1052784kB, file-rss:4kB,
shmem-rss:0kB oom_score_adj:1000

But if only one one output change is allowed I'd favor the Killed
process message since that can be singled due to it's print priority
and forwarded.

By the way, right now there is redundancy in that the Killed process
message is printing vm, rss even if vm.oom_dump_tasks is enabled.
I don't see why that is a big deal.
It is very useful to have all the information that is there.
Wouldn't mind also having pgtables too but we would be able to get
that from the output of dump_task if that is enabled.

If it is acceptable to also add the dump_task for the killed process
for !sysctl_oom_dump_tasks I can repost the patch including that as
well.

Thank-you,

Edward Chron
Arista Networks
