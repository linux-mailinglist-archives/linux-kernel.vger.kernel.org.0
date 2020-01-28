Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE98B14B389
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 12:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgA1Le0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 06:34:26 -0500
Received: from foss.arm.com ([217.140.110.172]:55506 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgA1LeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 06:34:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 422A6101E;
        Tue, 28 Jan 2020 03:34:23 -0800 (PST)
Received: from [10.1.194.46] (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C8533F52E;
        Tue, 28 Jan 2020 03:34:22 -0800 (PST)
Subject: Re: [PATCH v3 0/3] sched/fair: Capacity aware wakeup rework
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        morten.rasmussen@arm.com, qperret@google.com,
        adharmap@codeaurora.org
References: <20200126200934.18712-1-valentin.schneider@arm.com>
 <35c18eee-7e92-8a7d-c59d-11dfd2b053ff@arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <9b6d0ea2-cf5e-ed89-6c08-6f43c345265f@arm.com>
Date:   Tue, 28 Jan 2020 11:34:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <35c18eee-7e92-8a7d-c59d-11dfd2b053ff@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/01/2020 09:24, Dietmar Eggemann wrote:
> On 26/01/2020 21:09, Valentin Schneider wrote:
> 
> [...]
> 
>> v2 -> v3
>> --------
>> o Added missing sync_entity_load_avg() (Quentin)
>> o Added fallback CPU selection (maximize capacity)
>> o Added special case for CPU hogs: task_fits_capacity() will always return 'false'
>>   for tasks that are simply too big, due to the margin.
> 
> v3 fixes the Geekbench multicore regression I saw on Pixel4 (Android 10,
> Android Common Kernel v4.14 based, Snapdragon 855) running v1.
> 
> I changed the Pixel4 kernel a bit (PELT instead WALT, mainline
> select_idle_sibling() instead the csctate aware one), mainline
> task_fits_capacity()) for base, v1 & v3.
> 
> Since it's not mainline kernel the results have to be taken with a pinch
> of salt but they probably show that the new condition:
> 
> if (rq->cpu_capacity_orig == READ_ONCE(rq->rd->max_cpu_capacity) && ...
>     return cpu;
> 
> has an effect when dealing with tasks with util_est values > 0.8 * 1024.
> 

Thanks for going through that hassle! I'm quite pleased with the results
of that change - if you also look at e.g. the stddev for sysbench on Juno,
runs are much more consistent now.
