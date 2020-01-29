Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFB1F14CA65
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 13:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgA2MK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 07:10:57 -0500
Received: from foss.arm.com ([217.140.110.172]:40314 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbgA2MK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 07:10:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C50041FB;
        Wed, 29 Jan 2020 04:10:56 -0800 (PST)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B747E3F67D;
        Wed, 29 Jan 2020 04:10:55 -0800 (PST)
Subject: Re: [PATCH v3 1/3] sched/fair: Add asymmetric CPU capacity wakeup
 scan
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        morten.rasmussen@arm.com, qperret@google.com,
        adharmap@codeaurora.org
References: <20200126200934.18712-1-valentin.schneider@arm.com>
 <20200126200934.18712-2-valentin.schneider@arm.com>
 <a2f9e7d1-08c6-2545-2088-e0226ffd79e0@arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <40bfa77b-b695-5f53-848a-b72b67b33d69@arm.com>
Date:   Wed, 29 Jan 2020 12:10:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <a2f9e7d1-08c6-2545-2088-e0226ffd79e0@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/01/2020 11:04, Dietmar Eggemann wrote:
>> +		/*
>> +		 * It would be silly to keep looping when we've found a CPU
>> +		 * of highest available capacity. Just check that it's not been
>> +		 * too pressured lately.
>> +		 */
>> +		if (rq->cpu_capacity_orig == READ_ONCE(rq->rd->max_cpu_capacity) &&
> 
> There is a similar check in check_misfit_status(). Common helper function?

Mright, and check_misfit_status() is missing the READ_ONCE(). That said...

> 
>> +		    !check_cpu_capacity(rq, sd))
>> +			return cpu;
> 
> I wonder how this special treatment of a big CPU behaves in (LITTLE,
> medium, big) system like Pixel4 (Snapdragon 855):
> 
>  flame:/ $ cat /sys/devices/system/cpu/cpu*/cpu_capacity
> 
> 261
> 261
> 261
> 261
> 871
> 871
> 871
> 1024
> 
> Or on legacy systems where the sd->imbalance_pct is 25% instead of 17%?
> 

... This is a very valid point. When I wrote this bit I had the good old
big.LITTLE split in mind where there are big differences between the capacity
values. As you point out, that's not so true with DynamIQ systems sporting
> 2 capacity values. The issue here is that we could bail early picking a
(slightly) pressured big (1024 capacity_orig) when there was a non-pressured
idle medium (871 capacity orig).

It's borderline in this example - the threshold for a big to be seen as
pressured by check_cpu_capacity(), assuming a flat topology with just an MC
domain, is ~ 875. If we have e.g. mediums at 900 and bigs at 1024, this
logic is broken.

So this is pretty much a case of my trying to be too clever for my own good,
I'll remove that "fastpath" in v4. Thanks for pointing it out!
