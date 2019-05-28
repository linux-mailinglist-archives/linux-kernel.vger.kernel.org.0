Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BADD32C42F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 12:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfE1KY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 06:24:59 -0400
Received: from foss.arm.com ([217.140.101.70]:54328 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbfE1KY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 06:24:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A2CC341;
        Tue, 28 May 2019 03:24:59 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6EFAE3F59C;
        Tue, 28 May 2019 03:24:55 -0700 (PDT)
Subject: Re: [PATCH 2/7] sched/fair: Replace source_load() & target_load() w/
 weighted_cpuload()
To:     Hillf Danton <hdanton@sina.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        linux-kernel@vger.kernel.org
References: <20190527062116.11512-1-dietmar.eggemann@arm.com>
 <20190527062116.11512-3-dietmar.eggemann@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <63ee8775-f159-e172-15f4-2ddf941870ee@arm.com>
Date:   Tue, 28 May 2019 12:24:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190527062116.11512-3-dietmar.eggemann@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/19 6:42 AM, Hillf Danton wrote:
> 
> On Mon, 27 May 2019 07:21:11 +0100 Dietmar Eggemann wrote:

[...]

>> @@ -5500,7 +5464,7 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
>>   		this_eff_load *= 100;
>>   	this_eff_load *= capacity_of(prev_cpu);
>>   
>> -	prev_eff_load = source_load(prev_cpu, sd->wake_idx);
>> +	prev_eff_load = weighted_cpuload(cpu_rq(this_cpu));
> 					 cpu_rq(prev_cpu)
> 
> Seems we have no need to see this cpu's load more than once.

Thanks for catching this! Will fix it in v2.
