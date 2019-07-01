Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E436255EE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 18:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbfEUQot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 12:44:49 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38660 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727925AbfEUQos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 12:44:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60B49374;
        Tue, 21 May 2019 09:44:48 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EAC5F3F718;
        Tue, 21 May 2019 09:44:47 -0700 (PDT)
Date:   Tue, 21 May 2019 17:44:46 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Xiang Zheng <zhengxiang9@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, marc.zyngier@arm.com
Subject: Re: [PATCH] KVM: ARM64: Update perf event when setting PMU count
 value
Message-ID: <20190521164445.GW8268@e119886-lin.cambridge.arm.com>
References: <20190519100559.7188-1-zhengxiang9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190519100559.7188-1-zhengxiang9@huawei.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 19, 2019 at 06:05:59PM +0800, Xiang Zheng wrote:
> Guest will adjust the sample period and set PMU counter value when
> it takes a long time to handle the PMU interrupts.
> 
> However, we don't have a corresponding change on the virtual PMU
> which is emulated via a perf event. It could cause a large number
> of PMU interrupts injected to guest. Then guest will get hang for
> handling these interrupts.

Yes this is indeed an issue. I believe I've addressed this in my 'chained
pmu' series - the relevant patch is here...

https://lists.cs.columbia.edu/pipermail/kvmarm/2019-May/035933.html

Some other comments below.

> 
> So update the sample_period of perf event if the counter value is
> changed to avoid this case.
> 
> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
> ---
>  virt/kvm/arm/pmu.c | 54 +++++++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 45 insertions(+), 9 deletions(-)
> 
> diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
> index 1c5b76c..cbad3ec 100644
> --- a/virt/kvm/arm/pmu.c
> +++ b/virt/kvm/arm/pmu.c
> @@ -24,6 +24,11 @@
>  #include <kvm/arm_pmu.h>
>  #include <kvm/arm_vgic.h>
>  
> +static void kvm_pmu_stop_counter(struct kvm_vcpu *vcpu, struct kvm_pmc *pmc);
> +static struct perf_event *kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu,
> +						    struct kvm_pmc *pmc,
> +						    struct perf_event_attr *attr);
> +
>  /**
>   * kvm_pmu_get_counter_value - get PMU counter value
>   * @vcpu: The vcpu pointer
> @@ -57,11 +62,29 @@ u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u64 select_idx)
>   */
>  void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu, u64 select_idx, u64 val)
>  {
> -	u64 reg;
> +	u64 reg, counter, old_sample_period;
> +	struct kvm_pmu *pmu = &vcpu->arch.pmu;
> +	struct kvm_pmc *pmc = &pmu->pmc[select_idx];
> +	struct perf_event *event;
> +	struct perf_event_attr attr;
>  
>  	reg = (select_idx == ARMV8_PMU_CYCLE_IDX)
>  	      ? PMCCNTR_EL0 : PMEVCNTR0_EL0 + select_idx;
>  	__vcpu_sys_reg(vcpu, reg) += (s64)val - kvm_pmu_get_counter_value(vcpu, select_idx);
> +
> +	if (pmc->perf_event) {
> +		attr = pmc->perf_event->attr;
> +		old_sample_period = attr.sample_period;
> +		counter = kvm_pmu_get_counter_value(vcpu, select_idx);
> +		attr.sample_period = (-counter) & pmc->bitmask;
> +		if (attr.sample_period == old_sample_period)
> +			return;

I'd be interested to know how often this would evaluate to true.

> +
> +		kvm_pmu_stop_counter(vcpu, pmc);
> +		event = kvm_pmu_create_perf_event(vcpu, pmc, &attr);

I'm not sure it's necessary to change the prototype of kvm_pmu_create_perf_event
as this function will recalculate the sample period based on the updated counter
value anyway.

Thanks,

Andrew Murray

> +		if (event)
> +			pmc->perf_event = event;
> +	}
>  }
>  
>  /**
> @@ -303,6 +326,24 @@ static void kvm_pmu_perf_overflow(struct perf_event *perf_event,
>  	}
>  }
>  
> +static struct perf_event *kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu,
> +						    struct kvm_pmc *pmc,
> +						    struct perf_event_attr *attr)
> +{
> +	struct perf_event *event;
> +
> +	event = perf_event_create_kernel_counter(attr, -1, current,
> +						 kvm_pmu_perf_overflow, pmc);
> +
> +	if (IS_ERR(event)) {
> +		pr_err_once("kvm: pmu event creation failed %ld\n",
> +			    PTR_ERR(event));
> +		return NULL;
> +	}
> +
> +	return event;
> +}
> +
>  /**
>   * kvm_pmu_software_increment - do software increment
>   * @vcpu: The vcpu pointer
> @@ -416,15 +457,10 @@ void kvm_pmu_set_counter_event_type(struct kvm_vcpu *vcpu, u64 data,
>  	/* The initial sample period (overflow count) of an event. */
>  	attr.sample_period = (-counter) & pmc->bitmask;
>  
> -	event = perf_event_create_kernel_counter(&attr, -1, current,
> -						 kvm_pmu_perf_overflow, pmc);
> -	if (IS_ERR(event)) {
> -		pr_err_once("kvm: pmu event creation failed %ld\n",
> -			    PTR_ERR(event));
> -		return;
> -	}
> +	event = kvm_pmu_create_perf_event(vcpu, pmc, &attr);
>  
> -	pmc->perf_event = event;
> +	if (event)
> +		pmc->perf_event = event;
>  }
>  
>  bool kvm_arm_support_pmu_v3(void)
> -- 
> 1.8.3.1
> 
> 
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
