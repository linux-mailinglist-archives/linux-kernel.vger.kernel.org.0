Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4E8F2EAA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 14:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388728AbfKGNAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 08:00:30 -0500
Received: from foss.arm.com ([217.140.110.172]:55734 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbfKGNAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:00:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 865C331B;
        Thu,  7 Nov 2019 05:00:29 -0800 (PST)
Received: from [192.168.0.9] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1BAE3F6C4;
        Thu,  7 Nov 2019 05:00:27 -0800 (PST)
Subject: Re: [Patch v5 5/6] thermal/cpu-cooling: Update thermal pressure in
 case of a maximum frequency capping
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com, qperret@google.com
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
References: <1572979786-20361-1-git-send-email-thara.gopinath@linaro.org>
 <1572979786-20361-6-git-send-email-thara.gopinath@linaro.org>
 <05c53b6f-fd16-3e8b-e8da-ea56325cec33@arm.com>
Message-ID: <b97dab99-6796-3427-0c6d-57ea6c3dfb1f@arm.com>
Date:   Thu, 7 Nov 2019 14:00:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <05c53b6f-fd16-3e8b-e8da-ea56325cec33@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/11/2019 13:50, Dietmar Eggemann wrote:
> On 05/11/2019 19:49, Thara Gopinath wrote:
> 
> [...]
> 
>> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
>> index 391f397..c65b7c4 100644
>> --- a/drivers/thermal/cpu_cooling.c
>> +++ b/drivers/thermal/cpu_cooling.c
>> @@ -218,6 +218,27 @@ static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_cdev,
>>  }
>>  
>>  /**
>> + * update_sched_max_capacity - update scheduler about change in cpu
>> + *				max frequency.
>> + * @cpus: list of cpus whose max capacity needs udating in scheduler.
>> + * @cur_max_freq: current maximum frequency.
>> + * @max_freq: highest possible frequency.
>> + */
>> +static void update_sched_max_capacity(struct cpumask *cpus,
>> +				      unsigned int cur_max_freq,
>> +				      unsigned int max_freq)
>> +{
>> +	int cpu;
>> +	unsigned long capacity;
>> +
>> +	for_each_cpu(cpu, cpus) {
>> +		capacity = cur_max_freq * arch_scale_cpu_capacity(cpu);
>> +		capacity /= max_freq;
>> +		update_thermal_pressure(cpu, capacity);
>> +	}
>> +}
>> +
>> +/**
> 
> Have you seen
> https://lore.kernel.org/r/2b19d7da-412c-932f-7251-110eadbef3e3@arm.com ?
> 
> Also the naming 'update_thermal_pressure()' is not really suitable for
> an external task scheduler interface. If I see this called in the
> cooling device code, I wouldn't guess that this is a task scheduler
> interface.
> 
> [...]

The current interface to bring in frequency and uarch (CPU) invariance
information into the task scheduler is arch_scale_[freq|cpu]_capacity.

So why not follow this approach for the thermal->sched interface?

+#ifndef arch_scale_thermal_capacity
+static __always_inline
+unsigned long arch_scale_thermal_capacity(int cpu)
+{
+       return 0;
+}
+#endif

Leave per_cpu(thermal_pressure, cpu) within cpu cooling and let cpu
cooling (or even platform) #define arch_scale_thermal_capacity.
