Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99AFAF472D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 12:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390899AbfKHLsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 06:48:18 -0500
Received: from foss.arm.com ([217.140.110.172]:41468 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389983AbfKHLry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:47:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00B0531B;
        Fri,  8 Nov 2019 03:47:54 -0800 (PST)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 604333F719;
        Fri,  8 Nov 2019 03:47:51 -0800 (PST)
Subject: Re: NULL pointer dereference in pick_next_task_fair
To:     Quentin Perret <qperret@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>, linux-kernel@vger.kernel.org,
        aaron.lwe@gmail.com, mingo@kernel.org, pauld@redhat.com,
        jdesfossez@digitalocean.com, naravamudan@digitalocean.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, kernel-team@android.com, john.stultz@linaro.org
References: <20191028174603.GA246917@google.com>
 <20191106120525.GX4131@hirez.programming.kicks-ass.net>
 <33643a5b-1b83-8605-2347-acd1aea04f93@virtuozzo.com>
 <20191106165437.GX4114@hirez.programming.kicks-ass.net>
 <20191106172737.GM5671@hirez.programming.kicks-ass.net>
 <831c2cd4-40a4-31b2-c0aa-b5f579e770d6@virtuozzo.com>
 <20191107132628.GZ4114@hirez.programming.kicks-ass.net>
 <20191107153848.GA31774@google.com>
 <20191107184356.GF4114@hirez.programming.kicks-ass.net>
 <20191107192907.GA30258@worktop.programming.kicks-ass.net>
 <20191108110212.GA204618@google.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <07d30588-22e6-e098-b591-29c7cd3c8054@arm.com>
Date:   Fri, 8 Nov 2019 11:47:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191108110212.GA204618@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2019 11:02, Quentin Perret wrote:
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index a14487462b6c..6b983214e00f 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6746,10 +6746,18 @@ done: __maybe_unused;
>>  	return NULL;
>>  }
>>
>> +static int balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>> +{
>> +	if (rq->cfs.nr_running)
>> +		return 1;
>> +
>> +	return newidle_balance(rq, rf) != 0;
> 
> And you can ignore the RETRY_TASK case here under the assumption that
> we must have tried to pull from RT/DL before ending up here ?
> 

I think we can ignore RETRY_TASK because this happens before the picking loop,
so we'll observe any new DL/RT task that got enqueued while newidle released
the lock. This also means we can safely break the balance loop in
pick_next_task() when we get RETRY_TASK, because we've got something to pick
(some new RT/DL task). This wants a comment though, methinks.

Other than that I agree with Quentin, it's a much cleaner approach and I quite
like it.

> Thanks,
> Quentin
> 
