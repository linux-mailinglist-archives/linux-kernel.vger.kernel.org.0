Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 206DB1627EB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 15:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgBRORW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 09:17:22 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35032 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbgBRORV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 09:17:21 -0500
Received: by mail-lf1-f65.google.com with SMTP id z18so14647100lfe.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 06:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bcfw/WtwA7TkxKO8UeI2AZjb5CE4kKKsLOYA3/v/NYk=;
        b=y0R0X22df9E5JDDebI/9+dhuUi+bCGARz+i3v9UCdAhzDaXbHdRNxwb6JV8PhHO0QC
         Z2ZXb4yvZ+JMqwsdcwSk/UeEh3UPWQuLo8Q4yzKNIcOGPD3HzC593vmoYsP4UP+TcvaG
         OZ4I4gpTv077Xf7SZspcYtnivCbQXGd/M4i++NPG0eM2KqjywO/ZNS7eoZoWLyhx/cCa
         XkbqLx7AnNVJvPv9aZKa5FEcnROzYKbOCh5nO/Arlb6EE9i8rzb0TPNh8zCJl9QfB1Fo
         idU3bZirDKoJc1qk3OZNRkpeYSRKl4SIKeVv4ty3blHsqWOG+CTI67LLvIvZHMZzgi6k
         LYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bcfw/WtwA7TkxKO8UeI2AZjb5CE4kKKsLOYA3/v/NYk=;
        b=UwA0giGMRlv16fn7OM+fPfYyoJ046zlPP8607uYHl2mFBZyc9RYpNb2gUUZjmSDxyh
         XET6ZELNavraF2gDA1u66omWVe5fnR8PF1AYP39pLceeW1ucLFi37ASpvOxImuffrekU
         Lpv4pYKg+P693N5YmVVEPVp3yOk4S5Qao/4W8SNYeeM6t0Ue7UvCb+IBATfQJbLtN9L9
         O9PdhvWdrGZAXl5jT4bp+nuSKxPubP8KjcupNVY+M4MLGvP5RQ+/qxsCFrNyMB+PESBN
         gRpX9GwufQdBsEHtlFxWYrH71XFZcROXM7/qTvtsawjsmxsMq2J9tAre2RtSKRqstWZY
         ov4g==
X-Gm-Message-State: APjAAAW4z3pXIfqhCzEMcytMlWEamOKzSLbFkj3phtj7agNZvGgeRA3O
        cuZjUHoikBVD5KcI47SGKEVs7zqHmkCzv6B06UGhNg==
X-Google-Smtp-Source: APXvYqyYM5aKaTIZbnjBJk7cvPf+hh1cDE8hbWKUFZnrNneTz6TIGYoJTE/iNm2P4no4DHhhMAjH2fz/RxCQHopvh0Q=
X-Received: by 2002:ac2:5e9b:: with SMTP id b27mr10933970lfq.184.1582035439659;
 Tue, 18 Feb 2020 06:17:19 -0800 (PST)
MIME-Version: 1.0
References: <20200214152729.6059-1-vincent.guittot@linaro.org>
 <20200214152729.6059-3-vincent.guittot@linaro.org> <ecbf5317-e6cf-fc20-9871-4ea06a987952@arm.com>
 <20200218135059.GE3420@suse.de>
In-Reply-To: <20200218135059.GE3420@suse.de>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 18 Feb 2020 15:17:08 +0100
Message-ID: <CAKfTPtA9yOoPRMYgE1V22FJMpo+jr=VS1kQHqYrArG-GXMN18g@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] sched/numa: Replace runnable_load_avg by load_avg
To:     Mel Gorman <mgorman@suse.de>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Parth Shah <parth@linux.ibm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2020 at 14:51, Mel Gorman <mgorman@suse.de> wrote:
>
> On Tue, Feb 18, 2020 at 01:37:45PM +0100, Dietmar Eggemann wrote:
> > On 14/02/2020 16:27, Vincent Guittot wrote:
> >
> > [...]
> >
> > >     /*
> > >      * The load is corrected for the CPU capacity available on each node.
> > >      *
> > > @@ -1788,10 +1831,10 @@ static int task_numa_migrate(struct task_struct *p)
> > >     dist = env.dist = node_distance(env.src_nid, env.dst_nid);
> > >     taskweight = task_weight(p, env.src_nid, dist);
> > >     groupweight = group_weight(p, env.src_nid, dist);
> > > -   update_numa_stats(&env.src_stats, env.src_nid);
> > > +   update_numa_stats(&env, &env.src_stats, env.src_nid);
> >
> > This looks strange. Can you do:
> >
> > -static void update_numa_stats(struct task_numa_env *env,
> > +static void update_numa_stats(unsigned int imbalance_pct,
> >                               struct numa_stats *ns, int nid)
> >
> > -    update_numa_stats(&env, &env.src_stats, env.src_nid);
> > +    update_numa_stats(env.imbalance_pct, &env.src_stats, env.src_nid);
> >
>
> You'd also have to pass in env->p and while it could be done, I do not
> think its worthwhile.

I agree

>
> > [...]
> >
> > > +static unsigned long cpu_runnable_load(struct rq *rq)
> > > +{
> > > +   return cfs_rq_runnable_load_avg(&rq->cfs);
> > > +}
> > > +
> >
> > Why not remove cpu_runnable_load() in this patch rather moving it?
> >
> > kernel/sched/fair.c:5492:22: warning: ???cpu_runnable_load??? defined but
> > not used [-Wunused-function]
> >  static unsigned long cpu_runnable_load(struct rq *rq)
> >
>
> I took the liberty of addressing that when I picked up Vincent's patches
> for "Reconcile NUMA balancing decisions with the load balancer v3" to fix
> a build warning. I did not highlight it when I posted because it was such
> a trivial change.

yes I have noticed that.
Thanks

>
> --
> Mel Gorman
> SUSE Labs
