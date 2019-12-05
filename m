Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5107A113DC5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 10:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbfLEJYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 04:24:50 -0500
Received: from foss.arm.com ([217.140.110.172]:55170 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbfLEJYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 04:24:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7CC41045;
        Thu,  5 Dec 2019 01:24:46 -0800 (PST)
Received: from [192.168.0.9] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56ACC3F802;
        Thu,  5 Dec 2019 01:24:44 -0800 (PST)
Subject: Re: [RFC 3/3] Allow sched_{get,set}attr to change latency_tolerance
 of the task
To:     Parth Shah <parth@linux.ibm.com>, Qais Yousef <qais.yousef@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, vincent.guittot@linaro.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com,
        pavel@ucw.cz, dhaval.giani@oracle.com, qperret@qperret.net,
        David.Laight@ACULAB.COM, morten.rasmussen@arm.com, pjt@google.com,
        tj@kernel.org, viresh.kumar@linaro.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
References: <20191125094618.30298-1-parth@linux.ibm.com>
 <20191125094618.30298-4-parth@linux.ibm.com>
 <20191203083915.yahl2qd3wnnkqxxs@e107158-lin.cambridge.arm.com>
 <cfb607c1-6be9-853d-cfad-6787f78fa6ad@linux.ibm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <ffe4f4de-d433-91be-00ce-20b625807f20@arm.com>
Date:   Thu, 5 Dec 2019 10:24:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <cfb607c1-6be9-853d-cfad-6787f78fa6ad@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2019 16:51, Parth Shah wrote:
>  
> On 12/3/19 2:09 PM, Qais Yousef wrote:
>> On 11/25/19 15:16, Parth Shah wrote:

[...]

>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>> index ea7abbf5c1bb..dfd36ec14404 100644
>>> --- a/kernel/sched/core.c
>>> +++ b/kernel/sched/core.c
>>> @@ -4695,6 +4695,9 @@ static void __setscheduler_params(struct task_struct *p,
>>>  	p->rt_priority = attr->sched_priority;
>>>  	p->normal_prio = normal_prio(p);
>>>  	set_load_weight(p, true);
>>> +
>>> +	/* Change latency tolerance of the task if !SCHED_FLAG_KEEP_PARAMS */

IMHO, this comment seems to be gratuitous.

>>> +	p->latency_tolerance = attr->sched_latency_tolerance;
>>>  }

[...]
