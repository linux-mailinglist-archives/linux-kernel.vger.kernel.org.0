Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10C13CBF1C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 17:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389679AbfJDP1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 11:27:42 -0400
Received: from foss.arm.com ([217.140.110.172]:48300 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389210AbfJDP1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 11:27:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 345CB1597;
        Fri,  4 Oct 2019 08:27:41 -0700 (PDT)
Received: from [10.1.196.133] (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E854B3F68E;
        Fri,  4 Oct 2019 08:27:39 -0700 (PDT)
Subject: Re: drm_sched with panfrost crash on T820
To:     Neil Armstrong <narmstrong@baylibre.com>,
        "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
        Hillf Danton <hdanton@sina.com>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        Erico Nunes <nunes.erico@gmail.com>
References: <e450fbe6-dec7-2704-59c2-db7e869d67f5@baylibre.com>
 <f0ab487e-8d49-987b-12b8-7a115a6543e1@amd.com>
 <20190930145228.14000-1-hdanton@sina.com>
 <d2888614-8644-7d04-b73b-3ab7c6623e9a@amd.com>
 <7339b7a1-2d1c-4379-89a0-daf8b28d81c8@baylibre.com>
 <94096e4e-0f60-79d1-69b5-c7c3e59a4d78@amd.com>
 <f44204b4-ce5c-b26e-580d-5bb21314be1f@baylibre.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <8c4ecad8-c2e2-eec1-9132-48e126577baa@arm.com>
Date:   Fri, 4 Oct 2019 16:27:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <f44204b4-ce5c-b26e-580d-5bb21314be1f@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2019 16:03, Neil Armstrong wrote:
> On 04/10/2019 16:53, Grodzovsky, Andrey wrote:
>>
>> On 10/3/19 4:34 AM, Neil Armstrong wrote:
>>> Hi Andrey,
>>>
>>> Le 02/10/2019 à 16:40, Grodzovsky, Andrey a écrit :
>>>> On 9/30/19 10:52 AM, Hillf Danton wrote:
>>>>> On Mon, 30 Sep 2019 11:17:45 +0200 Neil Armstrong wrote:
>>>>>> Did a new run from 5.3:
>>>>>>
>>>>>> [   35.971972] Call trace:
>>>>>> [   35.974391]  drm_sched_increase_karma+0x5c/0xf0
>>>>>> 			ffff000010667f38	FFFF000010667F94
>>>>>> 			drivers/gpu/drm/scheduler/sched_main.c:335
>>>>>>
>>>>>> The crashing line is :
>>>>>>                                   if (bad->s_fence->scheduled.context ==
>>>>>>                                       entity->fence_context) {
>>>>>>
>>>>>> Doesn't seem related to guilty job.
>>>>> Bail out if s_fence is no longer fresh.
>>>>>
>>>>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>>>>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>>>>> @@ -333,6 +333,10 @@ void drm_sched_increase_karma(struct drm
>>>>>    
>>>>>    			spin_lock(&rq->lock);
>>>>>    			list_for_each_entry_safe(entity, tmp, &rq->entities, list) {
>>>>> +				if (!smp_load_acquire(&bad->s_fence)) {
>>>>> +					spin_unlock(&rq->lock);
>>>>> +					return;
>>>>> +				}
>>>>>    				if (bad->s_fence->scheduled.context ==
>>>>>    				    entity->fence_context) {
>>>>>    					if (atomic_read(&bad->karma) >
>>>>> @@ -543,7 +547,7 @@ EXPORT_SYMBOL(drm_sched_job_init);
>>>>>    void drm_sched_job_cleanup(struct drm_sched_job *job)
>>>>>    {
>>>>>    	dma_fence_put(&job->s_fence->finished);
>>>>> -	job->s_fence = NULL;
>>>>> +	smp_store_release(&job->s_fence, 0);
>>>>>    }
>>>>>    EXPORT_SYMBOL(drm_sched_job_cleanup);
>>> This fixed the problem on the 10 CI runs.
>>>
>>> Neil
>>
>>
>> These are good news but I still fail to see how this fixes the problem - 
>> Hillf, do you mind explaining how you came up with this particular fix - 
>> what was the bug you saw ?
> 
> As Steven explained, seems the same job was submitted on both HW slots,
> and then when timeout occurs each thread calls panfrost_job_timedout
> which leads to drm_sched_stop() on the first call and on the
> second call the job was already freed.
> 
> Steven proposed a working fix, and this one does the same but on
> the drm_sched side. This one looks cleaner, but panfrost should
> not call drm_sched_stop() twice for the same job.

I'm not sure that Hillf's fix is sufficient. In particular in
drm_sched_increase_karma() I don't understand how the smp_load_acquire()
call prevents bad->s_fence becoming NULL immediately afterwards (but
admittedly the window is much smaller). But really this is just a
Panfrost bug (calling drm_sched_stop() twice on the same job).

The part of my change that I'd welcome feedback on is changing
cancel_delayed_work() to cancel_delayed_work_sync() in drm_sched_stop()
when called on different scheduler to the bad job. It's not clear to me
exactly what the semantics of the function should be, and I haven't
tested the effect of the change on drivers other than Panfrost.

Steve

> Neil
> 
>>
>> Andrey
>>
>>>
>>>> Does this change help the problem ? Note that drm_sched_job_cleanup is
>>>> called from scheduler thread which is stopped at all times when work_tdr
>>>> thread is running and anyway the 'bad' job is still in the
>>>> ring_mirror_list while it's being accessed from
>>>> drm_sched_increase_karma so I don't think drm_sched_job_cleanup can be
>>>> called for it BEFORE or while drm_sched_increase_karma is executed.
>>>>
>>>> Andrey
>>>>
>>>>
>>>>>    
>>>>> --
>>>>>
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 

