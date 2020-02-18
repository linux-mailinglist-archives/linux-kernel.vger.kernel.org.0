Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFAFE1628B9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 15:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgBROmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 09:42:12 -0500
Received: from foss.arm.com ([217.140.110.172]:53570 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbgBROmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 09:42:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C9EA1FB;
        Tue, 18 Feb 2020 06:42:11 -0800 (PST)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC79E3F6CF;
        Tue, 18 Feb 2020 06:42:09 -0800 (PST)
Subject: Re: [PATCH v2 2/5] sched/numa: Replace runnable_load_avg by load_avg
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Parth Shah <parth@linux.ibm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Hillf Danton <hdanton@sina.com>
References: <20200214152729.6059-1-vincent.guittot@linaro.org>
 <20200214152729.6059-3-vincent.guittot@linaro.org>
 <ecbf5317-e6cf-fc20-9871-4ea06a987952@arm.com>
 <20200218135059.GE3420@suse.de>
 <CAKfTPtA9yOoPRMYgE1V22FJMpo+jr=VS1kQHqYrArG-GXMN18g@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <1f820379-c58e-05fb-1745-28f2ed62d5ed@arm.com>
Date:   Tue, 18 Feb 2020 15:42:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtA9yOoPRMYgE1V22FJMpo+jr=VS1kQHqYrArG-GXMN18g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/02/2020 15:17, Vincent Guittot wrote:
> On Tue, 18 Feb 2020 at 14:51, Mel Gorman <mgorman@suse.de> wrote:
>>
>> On Tue, Feb 18, 2020 at 01:37:45PM +0100, Dietmar Eggemann wrote:
>>> On 14/02/2020 16:27, Vincent Guittot wrote:

[...]

>>> -static void update_numa_stats(struct task_numa_env *env,
>>> +static void update_numa_stats(unsigned int imbalance_pct,
>>>                               struct numa_stats *ns, int nid)
>>>
>>> -    update_numa_stats(&env, &env.src_stats, env.src_nid);
>>> +    update_numa_stats(env.imbalance_pct, &env.src_stats, env.src_nid);
>>>
>>
>> You'd also have to pass in env->p and while it could be done, I do not
>> think its worthwhile.
> 
> I agree

Ah, another patch in Mel's patch-set:
https://lore.kernel.org/r/20200217104402.11643-11-mgorman@techsingularity.net

I see.

[...]
