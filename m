Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77A2642845
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 16:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439538AbfFLN7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 09:59:38 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50878 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437126AbfFLN7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 09:59:38 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F36B1AAB7E15BB89D9AB;
        Wed, 12 Jun 2019 21:47:25 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.32) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Wed, 12 Jun 2019
 21:47:19 +0800
From:   Xiang Zheng <zhengxiang9@huawei.com>
Subject: Re: [PATCH] KVM: ARM64: Update perf event when setting PMU count
 value
To:     Andrew Murray <andrew.murray@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        <marc.zyngier@arm.com>, Wang Haibin <wanghaibin.wang@huawei.com>
References: <20190519100559.7188-1-zhengxiang9@huawei.com>
 <20190521164445.GW8268@e119886-lin.cambridge.arm.com>
Message-ID: <482838e5-64a4-ef99-2e51-4b58e18ba4b4@huawei.com>
Date:   Wed, 12 Jun 2019 21:47:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20190521164445.GW8268@e119886-lin.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.32]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/5/22 0:44, Andrew Murray wrote:
> On Sun, May 19, 2019 at 06:05:59PM +0800, Xiang Zheng wrote:
>> Guest will adjust the sample period and set PMU counter value when
>> it takes a long time to handle the PMU interrupts.
>>
>> However, we don't have a corresponding change on the virtual PMU
>> which is emulated via a perf event. It could cause a large number
>> of PMU interrupts injected to guest. Then guest will get hang for
>> handling these interrupts.
> 
> Yes this is indeed an issue. I believe I've addressed this in my 'chained
> pmu' series - the relevant patch is here...
> 
> https://lists.cs.columbia.edu/pipermail/kvmarm/2019-May/035933.html
> 
> Some other comments below.
> 

Sorry for that I didn't notice your patches...
I will test your patch series.

>>
>> So update the sample_period of perf event if the counter value is
>> changed to avoid this case.
>>
>> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
>> ---
>>  virt/kvm/arm/pmu.c | 54 +++++++++++++++++++++++++++++++++++++++++++++---------
>>  1 file changed, 45 insertions(+), 9 deletions(-)
>>
>> diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
>> index 1c5b76c..cbad3ec 100644
>> --- a/virt/kvm/arm/pmu.c
>> +++ b/virt/kvm/arm/pmu.c
>> @@ -24,6 +24,11 @@
>>  #include <kvm/arm_pmu.h>
>>  #include <kvm/arm_vgic.h>
>>  
>> +static void kvm_pmu_stop_counter(struct kvm_vcpu *vcpu, struct kvm_pmc *pmc);
>> +static struct perf_event *kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu,
>> +						    struct kvm_pmc *pmc,
>> +						    struct perf_event_attr *attr);
>> +
>>  /**
>>   * kvm_pmu_get_counter_value - get PMU counter value
>>   * @vcpu: The vcpu pointer
>> @@ -57,11 +62,29 @@ u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u64 select_idx)
>>   */
>>  void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu, u64 select_idx, u64 val)
>>  {
>> -	u64 reg;
>> +	u64 reg, counter, old_sample_period;
>> +	struct kvm_pmu *pmu = &vcpu->arch.pmu;
>> +	struct kvm_pmc *pmc = &pmu->pmc[select_idx];
>> +	struct perf_event *event;
>> +	struct perf_event_attr attr;
>>  
>>  	reg = (select_idx == ARMV8_PMU_CYCLE_IDX)
>>  	      ? PMCCNTR_EL0 : PMEVCNTR0_EL0 + select_idx;
>>  	__vcpu_sys_reg(vcpu, reg) += (s64)val - kvm_pmu_get_counter_value(vcpu, select_idx);
>> +
>> +	if (pmc->perf_event) {
>> +		attr = pmc->perf_event->attr;
>> +		old_sample_period = attr.sample_period;
>> +		counter = kvm_pmu_get_counter_value(vcpu, select_idx);
>> +		attr.sample_period = (-counter) & pmc->bitmask;
>> +		if (attr.sample_period == old_sample_period)
>> +			return;
> 
> I'd be interested to know how often this would evaluate to true.
> 

I have counted it while running my test script, the result shows that there are 1552288
times evaluated to true and 8294235 times not.

I think different testcases may produce different results.

>> +
>> +		kvm_pmu_stop_counter(vcpu, pmc);
>> +		event = kvm_pmu_create_perf_event(vcpu, pmc, &attr);
> 
> I'm not sure it's necessary to change the prototype of kvm_pmu_create_perf_event
> as this function will recalculate the sample period based on the updated counter
> value anyway.
> 

In this patch, kvm_pmu_create_perf_event() will not recalculate the sample period. Maybe
you confuse it with your patch.:)

> Thanks,
> 
> Andrew Murray
> 
>> +		if (event)
>> +			pmc->perf_event = event;
>> +	}
>>  }
>>  
>>  /**
>> @@ -303,6 +326,24 @@ static void kvm_pmu_perf_overflow(struct perf_event *perf_event,
>>  	}
>>  }
>>  
>> +static struct perf_event *kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu,
>> +						    struct kvm_pmc *pmc,
>> +						    struct perf_event_attr *attr)
>> +{
>> +	struct perf_event *event;
>> +
>> +	event = perf_event_create_kernel_counter(attr, -1, current,
>> +						 kvm_pmu_perf_overflow, pmc);
>> +
>> +	if (IS_ERR(event)) {
>> +		pr_err_once("kvm: pmu event creation failed %ld\n",
>> +			    PTR_ERR(event));
>> +		return NULL;
>> +	}
>> +
>> +	return event;
>> +}
>> +
>>  /**
>>   * kvm_pmu_software_increment - do software increment
>>   * @vcpu: The vcpu pointer
>> @@ -416,15 +457,10 @@ void kvm_pmu_set_counter_event_type(struct kvm_vcpu *vcpu, u64 data,
>>  	/* The initial sample period (overflow count) of an event. */
>>  	attr.sample_period = (-counter) & pmc->bitmask;
>>  
>> -	event = perf_event_create_kernel_counter(&attr, -1, current,
>> -						 kvm_pmu_perf_overflow, pmc);
>> -	if (IS_ERR(event)) {
>> -		pr_err_once("kvm: pmu event creation failed %ld\n",
>> -			    PTR_ERR(event));
>> -		return;
>> -	}
>> +	event = kvm_pmu_create_perf_event(vcpu, pmc, &attr);
>>  
>> -	pmc->perf_event = event;
>> +	if (event)
>> +		pmc->perf_event = event;
>>  }
>>  
>>  bool kvm_arm_support_pmu_v3(void)
>> -- 
>> 1.8.3.1
>>
>>
>> _______________________________________________
>> kvmarm mailing list
>> kvmarm@lists.cs.columbia.edu
>> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
> 
> .
> 
-- 

Thanks,
Xiang


