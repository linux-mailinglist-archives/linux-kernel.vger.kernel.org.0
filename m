Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE234BCA3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 17:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbfFSPST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 11:18:19 -0400
Received: from foss.arm.com ([217.140.110.172]:44722 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbfFSPST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 11:18:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75D91344;
        Wed, 19 Jun 2019 08:18:18 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE8683F246;
        Wed, 19 Jun 2019 08:18:16 -0700 (PDT)
Subject: Re: [PATCH 1/8] sched: introduce task_se_h_load helper
To:     Rik van Riel <riel@surriel.com>, peterz@infradead.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, kernel-team@fb.com,
        morten.rasmussen@arm.com, tglx@linutronix.de,
        dietmar.eggeman@arm.com, mgorman@techsingularity.com,
        vincent.guittot@linaro.org
References: <20190612193227.993-1-riel@surriel.com>
 <20190612193227.993-2-riel@surriel.com>
 <55d914d2-fba2-48c0-e7ff-3c7337c8cf8e@arm.com>
 <c8c3a78884be6c1b3a5e0984750ed8968230c976.camel@surriel.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <9e75dd03-23e5-8ab3-8f5c-789b2581b3a7@arm.com>
Date:   Wed, 19 Jun 2019 17:18:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <c8c3a78884be6c1b3a5e0984750ed8968230c976.camel@surriel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/19 3:57 PM, Rik van Riel wrote:
> On Wed, 2019-06-19 at 14:52 +0200, Dietmar Eggemann wrote:
> 
>>> @@ -7833,14 +7834,19 @@ static void update_cfs_rq_h_load(struct
>>> cfs_rq *cfs_rq)
>>>  	}
>>>  }
>>>  
>>> -static unsigned long task_h_load(struct task_struct *p)
>>> +static unsigned long task_se_h_load(struct sched_entity *se)
>>>  {
>>> -	struct cfs_rq *cfs_rq = task_cfs_rq(p);
>>> +	struct cfs_rq *cfs_rq = cfs_rq_of(se);
>>>  
>>>  	update_cfs_rq_h_load(cfs_rq);
>>> -	return div64_ul(p->se.avg.load_avg * cfs_rq->h_load,
>>> +	return div64_ul(se->avg.load_avg * cfs_rq->h_load,
>>>  			cfs_rq_load_avg(cfs_rq) + 1);
>>>  }
>>
>> I wonder if this is necessary. I placed a BUG_ON(!entity_is_task(se))
>> into task_se_h_load() after I applied the whole patch-set and ran
>> some
>> taskgroup related testcases. It didn't hit.
>>
>> So why not use task_h_load(task_of(se)) instead?
>>
>> [...]
> 
> That would work, but task_h_load then dereferences
> task->se to get the se->avg.load_avg value.
> 
> Going back to task from the se, only to then get the
> se from the task seems a little unnecessary :)
> 
> Can you explain why you think task_h_load(task_of(se))
> would be better? I think I may be overlooking something.

Ah, OK, I just wanted to avoid having task_se_h_load() and task_h_load()
at the same time. You could replace the remaining calls to
task_h_load(p) with task_se_h_load(&p->se) in this case.

- task_load = task_h_load(p);
+ task_load = task_se_h_load(&p->se);

Not that important though right now ...

