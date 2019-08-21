Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 840F4987A9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 01:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731333AbfHUXMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 19:12:22 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46977 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729763AbfHUXMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 19:12:21 -0400
Received: by mail-io1-f66.google.com with SMTP id x4so7998640iog.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 16:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0KVJzgs8EgORbeJXXQubNPgw1WiUGBr9OYGA7l6xlcE=;
        b=eDrUlZ1sAmJkYbQSimlYWKmC1dUR+CGjg15fVmd1/JPfkySdGgd52llMp900L9A9hQ
         xYCXspJbD486cUNWl0/vHQefQh4ROBps1vwmCGTQrj0xn4lK2BmEmSjR4zqihmxL0Vmv
         v7SpuHz+28jBLO5xIB1jvjKV/0SjBjvjJG+fvcoP8THQk3rqzGv9l3FAHn1QHRoXwLPI
         hJK4Zj3oUmIFYSV9I78tLqwFRk0/xZpZj76fvCFuDkXwwgXho67oM3Ir9m0oawERpcIJ
         tjAwoiHFgGoi+9brArrSyzUTwbjpy9F5g9otqjnxC5V64fO44nqxNWscO/6okRf9PX0K
         eq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0KVJzgs8EgORbeJXXQubNPgw1WiUGBr9OYGA7l6xlcE=;
        b=LrQopEKtsef6g4BfQAR55mtaySpuSVcOjtCEFQYjCu032lzlNuK2l2kppo0//Y2NL4
         pm6mQWe11SkJVfO8iD7hZbGuOrwGn+mxOxNt6S40jxlbYOjuoMVdpuYyF8Oml9H1Yw1D
         L5A+cnp6qLjZmGgKWXINC2qOzkkB77rn7emTlPHZj4ynY3wM9/mMCpwPD42JRPy5+qTj
         abYKoRmLK6jp5F7EOL6dqrv6pNARhTKNiSmPZrHWBbv+rLTVkKZxowQRSjDlFityKW8J
         uFfSK3cGn6+FZuXRm60GXvzKqwOXptoaFaLLWnx2Yc8hFYcfT8lHECZm+PZ1jIJSOJnB
         LEgw==
X-Gm-Message-State: APjAAAXgqun/avMgrHR7bQI8vsIKUDaKP8GtycmtfRIsOGsJ5r+A5D14
        xRtiQSjLfc+ubmkG2d1CcfKz5Hy/Usr13iQ+xZikmQ==
X-Google-Smtp-Source: APXvYqyloKzz7NgWTchmsnc7qXwItkNgE6mhmz6hYsrxditmjwnLHbvLORRpP5EyOywTjcrApKlY50azf7yp8TQmbak=
X-Received: by 2002:a02:390c:: with SMTP id l12mr4178791jaa.76.1566429140549;
 Wed, 21 Aug 2019 16:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190821001445.32114-1-echron@arista.com> <alpine.DEB.2.21.1908202024300.141379@chino.kir.corp.google.com>
 <20190821064732.GW3111@dhcp22.suse.cz> <alpine.DEB.2.21.1908210017320.177871@chino.kir.corp.google.com>
 <20190821074721.GY3111@dhcp22.suse.cz>
In-Reply-To: <20190821074721.GY3111@dhcp22.suse.cz>
From:   Edward Chron <echron@arista.com>
Date:   Wed, 21 Aug 2019 16:12:08 -0700
Message-ID: <CAM3twVR5Z1LG4+pqMF94mCw8R0sJ3VJtnggQnu+047c7jxJVug@mail.gmail.com>
Subject: Re: [PATCH] mm/oom: Add oom_score_adj value to oom Killed process message
To:     Michal Hocko <mhocko@kernel.org>
Cc:     David Rientjes <rientjes@google.com>,
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

On Wed, Aug 21, 2019 at 12:47 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Wed 21-08-19 00:19:37, David Rientjes wrote:
> > On Wed, 21 Aug 2019, Michal Hocko wrote:
> >
> > > > vm.oom_dump_tasks is pretty useful, however, so it's curious why you
> > > > haven't left it enabled :/
> > >
> > > Because it generates a lot of output potentially. Think of a workload
> > > with too many tasks which is not uncommon.
> >
> > Probably better to always print all the info for the victim so we don't
> > need to duplicate everything between dump_tasks() and dump_oom_summary().
>
> I believe that the motivation was to have a one line summary that is already
> parsed by log consumers. And that is in __oom_kill_process one.
>

Yes the motivation was one line summary that the OOM Killed Process
message supplies along
with the fact it is error priority as I mentioned. It is a very
desirable place to put summarized
information.

> Also I do not think this patch improves things much for two reasons
> at leasts a) it doesn't really give you the whole list of killed tasks
> (this might be the whole memcg) and b) we already do have most important
> information in __oom_kill_process. If something is missing there I do
> not see a strong reason we cannot add it there. Like in this case.
>

This is a good point.

Additionally (which you know, but mentioning for reference) the OOM
output used to look like this:

Nov 14 15:23:48 oldserver kernel: [337631.991218] Out of memory: Kill
process 19961 (python) score 17 or sacrifice child
Nov 14 15:23:48 oldserver kernel: [337631.991237] Killed process 31357
(sh) total-vm:5400kB, anon-rss:252kB, file-rss:4kB, shmem-rss:0kB

It now looks like this with 5.3.0-rc5 (minus the oom_score_adj):

Jul 22 10:42:40 newserver kernel:
oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),cpuset=/,mems_allowed=0,global_oom,task_memcg=/user.slice/user-10383.slice/user@10383.service,task=oomprocs,pid=3035,uid=10383
Jul 22 10:42:40 newserver kernel: Out of memory: Killed process 3035
(oomprocs) total-vm:1056800kB, anon-rss:8kB, file-rss:4kB,
shmem-rss:0kB
Jul 22 10:42:40 newserver kernel: oom_reaper: reaped process 3035
(oomprocs), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB

The old output did explain that a oom_score of 17 must have either
tied for highest or was the highest.
This did document why OOM selected the process it did, even if ends up
killing the related sh process.

With the newer format that added constraint message, it does provide
uid which can be helpful and
the oom_reaper showing that the memory was reclaimed is certainly reassuring.

My understanding now is that printing the oom_score is discouraged.
This seems unfortunate.  The oom_score_adj can be adjusted
appropriately if oom_score is known.
So It would be useful to have both.

But at least if oom_score_adj is printed you can confirm the value at
the time of the OOM event.

Thank-you,
-Edward Chron
Arista Networks

> > Edward, how about this?
> >
> > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > --- a/mm/oom_kill.c
> > +++ b/mm/oom_kill.c
> > @@ -420,11 +420,17 @@ static int dump_task(struct task_struct *p, void *arg)
> >   * State information includes task's pid, uid, tgid, vm size, rss,
> >   * pgtables_bytes, swapents, oom_score_adj value, and name.
> >   */
> > -static void dump_tasks(struct oom_control *oc)
> > +static void dump_tasks(struct oom_control *oc, struct task_struct *victim)
> >  {
> >       pr_info("Tasks state (memory values in pages):\n");
> >       pr_info("[  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name\n");
> >
> > +     /* If vm.oom_dump_tasks is disabled, only show the victim */
> > +     if (!sysctl_oom_dump_tasks) {
> > +             dump_task(victim, oc);
> > +             return;
> > +     }
> > +
> >       if (is_memcg_oom(oc))
> >               mem_cgroup_scan_tasks(oc->memcg, dump_task, oc);
> >       else {
> > @@ -465,8 +471,8 @@ static void dump_header(struct oom_control *oc, struct task_struct *p)
> >               if (is_dump_unreclaim_slabs())
> >                       dump_unreclaimable_slab();
> >       }
> > -     if (sysctl_oom_dump_tasks)
> > -             dump_tasks(oc);
> > +     if (p || sysctl_oom_dump_tasks)
> > +             dump_tasks(oc, p);
> >       if (p)
> >               dump_oom_summary(oc, p);
> >  }
>
> --
> Michal Hocko
> SUSE Labs
