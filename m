Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0756E16A78C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 14:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbgBXNra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 08:47:30 -0500
Received: from foss.arm.com ([217.140.110.172]:37300 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbgBXNra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 08:47:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C6EE30E;
        Mon, 24 Feb 2020 05:47:29 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A7993F534;
        Mon, 24 Feb 2020 05:47:28 -0800 (PST)
Date:   Mon, 24 Feb 2020 13:47:25 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] sched/rt: Remove unnecessary assignment in
 inc/dec_rt_migration
Message-ID: <20200224134725.lnccpprgrx5rj4di@e107158-lin.cambridge.arm.com>
References: <20200223184001.14248-1-qais.yousef@arm.com>
 <20200223184001.14248-7-qais.yousef@arm.com>
 <a000f6b4-7548-1964-ba30-e8396c727d31@arm.com>
 <20200224123123.gbox3tcqcist7bbg@e107158-lin.cambridge.arm.com>
 <90e4af9c-b4e3-00bf-ebe6-5d4fe6f892aa@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <90e4af9c-b4e3-00bf-ebe6-5d4fe6f892aa@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/24/20 13:03, Dietmar Eggemann wrote:
> On 24.02.20 12:31, Qais Yousef wrote:
> > On 02/24/20 00:16, Dietmar Eggemann wrote:
> >> On 23.02.20 19:40, Qais Yousef wrote:
> 
> [...]
> 
> >>> -	rt_rq = &rq_of_rt_rq(rt_rq)->rt;
> >>
> >> IMHO, this is here to get the root rt_rq from any rt_rq (task_groups).
> >> Looks like that e.g rt_nr_total is only maintained on root rt_rq's.
> >>
> >> Similar to CFS' &rq_of(cfs_rq)->cfs (cfs_rq_util_change()) to get root
> >> cfs_rq.
> >>
> >> Not sure where CONFIG_RT_GROUP_SCHED=y is used but it's part of the rt
> >> class implementation.
> > 
> > Ah I see. That was obvious.. How about the below comment?
> > 
> > This code is executed only if rt_entity_is_task(), I don't think this grantees
> > that the rt_rq isn't for a group?
> 
> No, an rt task can run in this taskgroup (e.g. "/tg/tg1"), i.e. in
> tg1->rt_rq[cpu].
> 
> The taskgroup skeleton rt_se of e.g. "/tg/tg1/tg11" would also run in
> tg1->rt_rq[cpu] but for those rt_se's we bail out of [inc/dec]_rt_migration.
> 
> > 
> > I need to go and unravel the layers maybe.
> > 
> > Thanks!
> > 
> > --
> > Qais Yousef
> > 
> > -->8--
> > 
> > diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> > index b35e49cdafcc..f929867215c4 100644
> > --- a/kernel/sched/rt.c
> > +++ b/kernel/sched/rt.c
> > @@ -343,6 +343,8 @@ static void inc_rt_migration(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
> >                 return;
> > 
> >         p = rt_task_of(rt_se);
> > +
> > +       /* get the root rt_rq if this is the rt_rq of a group */
> 
> Not sure if a comment like this will help since:
> 
> (a) the definition of rq_of_rt_rq() for the !CONFIG_RT_GROUP_SCHED case
> 
> (b) rt_rq might already be the root rt_rq in case the task runs in "/"

I thought the comment explains that.

FWIW I don't think someone looking at the code need to look at rq_of_rt_rq() to
get the dependency, but if the above doesn't help I have no better suggestion.
So I'll drop it.

Thanks

--
Qais Yousef
