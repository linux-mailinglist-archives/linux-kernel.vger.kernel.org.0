Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD589EA1DA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 17:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfJ3QgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 12:36:04 -0400
Received: from foss.arm.com ([217.140.110.172]:37870 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbfJ3QgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 12:36:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27E4131F;
        Wed, 30 Oct 2019 09:36:02 -0700 (PDT)
Received: from [10.188.222.161] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E77D53F6C4;
        Wed, 30 Oct 2019 09:35:57 -0700 (PDT)
Subject: Re: [PATCH v4 00/10] sched/fair: rework the CFS load balance
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Phil Auld <pauld@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
 <20191021075038.GA27361@gmail.com>
 <CAKfTPtCcvKuf1Gt0W-BeEbQxFP_co14jdv_L5zEpS==Ecibabg@mail.gmail.com>
 <20191024123844.GB2708@pauld.bos.csb> <20191024134650.GD2708@pauld.bos.csb>
 <CAKfTPtB0VruWXq+wGgvNOMFJvvZQiZyi2AgBoJP3Uaeduu2Lqg@mail.gmail.com>
 <20191025133325.GA2421@pauld.bos.csb>
 <CAKfTPtDWV7AkzMNuJtkN-pLmDcK41LwNiX0Wr8UT+vMFHAx6Qg@mail.gmail.com>
 <20191030143937.GC1686@pauld.bos.csb>
 <564ca629-5c34-dbd1-8e64-2da6910b18a3@arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <bf96be8a-2358-b9ab-b8eb-d0b8b94ed0d7@arm.com>
Date:   Wed, 30 Oct 2019 17:35:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <564ca629-5c34-dbd1-8e64-2da6910b18a3@arm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/10/2019 17:24, Dietmar Eggemann wrote:
> On 30.10.19 15:39, Phil Auld wrote:
>> Hi Vincent,
>>
>> On Mon, Oct 28, 2019 at 02:03:15PM +0100 Vincent Guittot wrote:
> 
> [...]
> 
>>>> When you say slow versus fast wakeup paths what do you mean? I'm still
>>>> learning my way around all this code.
>>>
>>> When task wakes up, we can decide to
>>> - speedup the wakeup and shorten the list of cpus and compare only
>>> prev_cpu vs this_cpu (in fact the group of cpu that share their
>>> respective LLC). That's the fast wakeup path that is used most of the
>>> time during a wakeup
>>> - or start to find the idlest CPU of the system and scan all domains.
>>> That's the slow path that is used for new tasks or when a task wakes
>>> up a lot of other tasks at the same time
> 
> [...]
> 
> Is the latter related to wake_wide()? If yes, is the SD_BALANCE_WAKE
> flag set on the sched domains on your machines? IMHO, otherwise those
> wakeups are not forced into the slowpath (if (unlikely(sd))?
> 
> I had this discussion the other day with Valentin S. on #sched and we
> were not sure how SD_BALANCE_WAKE is set on sched domains on
> !SD_ASYM_CPUCAPACITY systems.
> 

Well from the code nobody but us (asymmetric capacity systems) set
SD_BALANCE_WAKE. I was however curious if there were some folks who set it
with out of tree code for some reason.

As Dietmar said, not having SD_BALANCE_WAKE means you'll never go through
the slow path on wakeups, because there is no domain with SD_BALANCE_WAKE for
the domain loop to find. Depending on your topology you most likely will
go through it on fork or exec though.

IOW wake_wide() is not really widening the wakeup scan on wakeups using
mainline topology code (disregarding asymmetric capacity systems), which
sounds a bit... off.
