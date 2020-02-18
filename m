Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 716B3162F0C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 19:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgBRSw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 13:52:59 -0500
Received: from foss.arm.com ([217.140.110.172]:58972 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbgBRSw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 13:52:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B25D231B;
        Tue, 18 Feb 2020 10:52:58 -0800 (PST)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 642823F703;
        Tue, 18 Feb 2020 10:52:57 -0800 (PST)
Date:   Tue, 18 Feb 2020 18:52:54 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] sched/rt: cpupri_find: implement fallback mechanism
 for !fit case
Message-ID: <20200218185253.yryfozr7jf2ve4lv@e107158-lin>
References: <20200214163949.27850-1-qais.yousef@arm.com>
 <20200214163949.27850-2-qais.yousef@arm.com>
 <c0772fca-0a4b-c88d-fdf2-5715fcf8447b@arm.com>
 <20200217234549.rpv3ns7bd7l6twqu@e107158-lin>
 <20200218114658.74236b3c@gandalf.local.home>
 <20200218172745.hd7fxjqnzqkhfqx3@e107158-lin.cambridge.arm.com>
 <20200218130300.679f77ea@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200218130300.679f77ea@gandalf.local.home>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/18/20 13:03, Steven Rostedt wrote:
> On Tue, 18 Feb 2020 17:27:46 +0000
> Qais Yousef <qais.yousef@arm.com> wrote:
> 
> > > If we are going to use static branches, then lets just remove the
> > > parameter totally. That is, make two functions (with helpers), where
> > > one needs this fitness function the other does not.
> > > 
> > > 	if (static_branch_unlikely(&sched_asym_cpu_capacity))
> > > 		ret = cpupri_find_fitness(...);
> > > 	else
> > > 		ret = cpupri_find(...);
> > > 
> > > 	if (!ret)
> > > 		return -1;
> > > 
> > > Something like that?  
> > 
> > Is there any implication on code generation here?
> > 
> > I like my flavour better tbh. But I don't mind refactoring the function out if
> > it does make it more readable.
> 
> I just figured we remove the passing of the parameter (which does make
> an impact on the code generation).

Ok. My mind went to protecting the whole function call with the static key
could be better.

> Also, perhaps it would be better to not have to pass functions to the
> cpupri_find(). Is there any other function that needs to be past, or
> just this one in this series?

I had that discussion in the past with Dietmar [1]

My argument was this way the code is generic and self contained and allows for
easy extension for other potential users.

I'm happy to split the function into cpupri_find_fitness() (with a fn ptr) and
cpupri_find() (original) like you suggest above - if you're still okay with
that..

[1] https://lore.kernel.org/lkml/39c08971-5d07-8018-915b-9c6284f89d5d@arm.com/

Thanks

--
Qais Youesf
