Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A729151F56
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 18:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgBDRXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 12:23:19 -0500
Received: from foss.arm.com ([217.140.110.172]:39110 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727382AbgBDRXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 12:23:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9F29101E;
        Tue,  4 Feb 2020 09:23:18 -0800 (PST)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3AD373F68E;
        Tue,  4 Feb 2020 09:23:17 -0800 (PST)
Subject: Re: [PATCH v2] sched: rt: Make RT capacity aware
To:     Qais Yousef <qais.yousef@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
References: <20191009104611.15363-1-qais.yousef@arm.com>
 <20200131100629.GC27398@codeaurora.org>
 <20200131153405.2ejp7fggqtg5dodx@e107158-lin.cambridge.arm.com>
 <CAEU1=PnYryM26F-tNAT0JVUoFcygRgE374JiBeJPQeTEoZpANg@mail.gmail.com>
 <20200203142712.a7yvlyo2y3le5cpn@e107158-lin>
 <20200203111451.0d1da58f@oasis.local.home>
 <20200203171745.alba7aswajhnsocj@e107158-lin>
 <20200203131203.20bf3fc3@oasis.local.home>
 <20200203190259.bnly7hfp3wfiteof@e107158-lin>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <c30eddd3-143e-03f1-6975-97f5af1d3075@arm.com>
Date:   Tue, 4 Feb 2020 18:23:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203190259.bnly7hfp3wfiteof@e107158-lin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2020 20:03, Qais Yousef wrote:
> On 02/03/20 13:12, Steven Rostedt wrote:
>> On Mon, 3 Feb 2020 17:17:46 +0000
>> Qais Yousef <qais.yousef@arm.com> wrote:

[...]

> In the light of strictly adhering to priority based scheduling; yes this makes
> sense. Though I still think the migration will produce worse performance, but
> I can appreciate even if that was true it breaks the strict priority rule.
> 
>>
>> You can add to the logic that you do not take over an RT task that is
>> pinned and can't move itself. Perhaps that may be the only change to
> 
> I get this.
> 
>> cpu_find(), is that it will only pick a big CPU if little CPUs are
>> available if the big CPU doesn't have a pinned RT task on it.
> 
> But not that. Do you mind rephrasing it?
> 
> Or let me try first:
> 
> 	1. Search all priority levels for a fitting CPU

Just so I get this right: All _lower_ prio levels than p->prio, right?

> 	2. If failed, return the first lowest mask found
> 	3. If it succeeds, remove any CPU that has a pinned task in it
> 	4. If the lowest_mask is empty, return (2).
> 	5. Else return the lowest_mask with the fitting CPU(s)

Mapping this to the 5 FIFO tasks rt-tasks of Pavan's example (all
p->prio=89 (dflt rt-app prio), dflt min_cap=1024 max_cap=1024) on a 4
big (Cpu Capacity=1024) 4 little (Cpu capacity < 1024) system:

You search from idx 1 to 11 [p->prio=89 eq. idx (task_pri)=12] and since
there are no lower prior RT tasks the lowest mask of idx=1 (CFS or Idle)
for the 5th RT task is returned.

But that means that CPU capacity trumps priority?

[...]
