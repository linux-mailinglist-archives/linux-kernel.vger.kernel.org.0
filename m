Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 762E5E7805
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 19:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404290AbfJ1SBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 14:01:54 -0400
Received: from smtprelay0145.hostedemail.com ([216.40.44.145]:39570 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730930AbfJ1SBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 14:01:54 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id D456E837F24C;
        Mon, 28 Oct 2019 18:01:52 +0000 (UTC)
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,rostedt@goodmis.org,:::::::::::::::::,RULES_HIT:41:355:379:541:599:800:960:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2525:2551:2553:2559:2563:2682:2685:2693:2859:2892:2903:2933:2937:2939:2942:2945:2947:2951:2954:2987:3022:3138:3139:3140:3141:3142:3355:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:5007:6119:6261:7875:7901:7903:9025:10004:10226:10400:10450:10455:10848:10967:11026:11232:11658:11914:12043:12050:12296:12297:12555:12663:12664:12740:12760:12895:12986:13439:13618:14096:14097:14181:14659:14721:19904:19999:21080:21324:21433:21627:21740:21811:21939:30054:30075:30090:30091,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: rest01_677b41b42430e
X-Filterd-Recvd-Size: 3864
Received: from grimm.local.home (100.50.158.77.rev.sfr.net [77.158.50.100])
        (Authenticated sender: rostedt@goodmis.org)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Mon, 28 Oct 2019 18:01:50 +0000 (UTC)
Date:   Mon, 28 Oct 2019 14:01:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Qais Yousef <qais.yousef@arm.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched: rt: Make RT capacity aware
Message-ID: <20191028140147.036a0001@grimm.local.home>
In-Reply-To: <20191028143749.GE4114@hirez.programming.kicks-ass.net>
References: <20191009104611.15363-1-qais.yousef@arm.com>
        <20191028143749.GE4114@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.4git49 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2019 15:37:49 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Oct 09, 2019 at 11:46:11AM +0100, Qais Yousef wrote:
> > Capacity Awareness refers to the fact that on heterogeneous systems
> > (like Arm big.LITTLE), the capacity of the CPUs is not uniform, hence
> > when placing tasks we need to be aware of this difference of CPU
> > capacities.
> > 
> > In such scenarios we want to ensure that the selected CPU has enough
> > capacity to meet the requirement of the running task. Enough capacity
> > means here that capacity_orig_of(cpu) >= task.requirement.
> > 
> > The definition of task.requirement is dependent on the scheduling class.
> > 
> > For CFS, utilization is used to select a CPU that has >= capacity value
> > than the cfs_task.util.
> > 
> > 	capacity_orig_of(cpu) >= cfs_task.util
> > 
> > DL isn't capacity aware at the moment but can make use of the bandwidth
> > reservation to implement that in a similar manner CFS uses utilization.
> > The following patchset implements that:
> > 
> > https://lore.kernel.org/lkml/20190506044836.2914-1-luca.abeni@santannapisa.it/
> > 
> > 	capacity_orig_of(cpu)/SCHED_CAPACITY >= dl_deadline/dl_runtime
> > 
> > For RT we don't have a per task utilization signal and we lack any
> > information in general about what performance requirement the RT task
> > needs. But with the introduction of uclamp, RT tasks can now control
> > that by setting uclamp_min to guarantee a minimum performance point.
> > 
> > ATM the uclamp value are only used for frequency selection; but on
> > heterogeneous systems this is not enough and we need to ensure that the
> > capacity of the CPU is >= uclamp_min. Which is what implemented here.
> > 
> > 	capacity_orig_of(cpu) >= rt_task.uclamp_min
> > 
> > Note that by default uclamp.min is 1024, which means that RT tasks will
> > always be biased towards the big CPUs, which make for a better more
> > predictable behavior for the default case.
> > 
> > Must stress that the bias acts as a hint rather than a definite
> > placement strategy. For example, if all big cores are busy executing
> > other RT tasks we can't guarantee that a new RT task will be placed
> > there.
> > 
> > On non-heterogeneous systems the original behavior of RT should be
> > retained. Similarly if uclamp is not selected in the config.
> > 
> > Signed-off-by: Qais Yousef <qais.yousef@arm.com>  
> 
> Works for me; Steve you OK with this?

Nothing against it, but I want to take a deeper look before we accept
it. Are you OK in waiting a week? I'm currently at Open Source Summit
and still have two more talks to write (giving them Thursday). I wont
have time to look till next week.

-- Steve
