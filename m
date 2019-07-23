Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44C11713BB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 10:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733148AbfGWIRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 04:17:15 -0400
Received: from foss.arm.com ([217.140.110.172]:50648 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727892AbfGWIRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 04:17:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF7CD344;
        Tue, 23 Jul 2019 01:17:13 -0700 (PDT)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F2393F71F;
        Tue, 23 Jul 2019 01:17:12 -0700 (PDT)
Subject: Re: [PATCH v2] KVM: arm/arm64: Introduce kvm_pmu_vcpu_init() to setup
 PMU counter idx
To:     Zenghui Yu <yuzenghui@huawei.com>, maz@kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Cc:     marc.zyngier@arm.com, james.morse@arm.com, suzuki.poulose@arm.com,
        julien.thierry.kdev@gmail.com, linux-kernel@vger.kernel.org,
        wanghaibin.wang@huawei.com, andrew.murray@arm.com
References: <1563437710-30756-1-git-send-email-yuzenghui@huawei.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <f3f6f9a9-9735-e253-7b5b-3ccf97619a16@arm.com>
Date:   Tue, 23 Jul 2019 09:17:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1563437710-30756-1-git-send-email-yuzenghui@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zenghui,

On 18/07/2019 09:15, Zenghui Yu wrote:
> We use "pmc->idx" and the "chained" bitmap to determine if the pmc is
> chained, in kvm_pmu_pmc_is_chained().  But idx might be uninitialized
> (and random) when we doing this decision, through a KVM_ARM_VCPU_INIT
> ioctl -> kvm_pmu_vcpu_reset(). And the test_bit() against this random
> idx will potentially hit a KASAN BUG [1].
> 
> In general, idx is the static property of a PMU counter that is not
> expected to be modified across resets, as suggested by Julien.  It
> looks more reasonable if we can setup the PMU counter idx for a vcpu
> in its creation time. Introduce a new function - kvm_pmu_vcpu_init()
> for this basic setup. Oh, and the KASAN BUG will get fixed this way.
> 
> [1] https://www.spinics.net/lists/kvm-arm/msg36700.html
> 
> Fixes: 80f393a23be6 ("KVM: arm/arm64: Support chained PMU counters")
> Suggested-by: Andrew Murray <andrew.murray@arm.com>
> Suggested-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
> 
> Changes since v1:
>  - Introduce kvm_pmu_vcpu_init() in vcpu's creation time, move the
>    assignment of pmc->idx into it.
>  - Thus change the subject. The old one is "KVM: arm/arm64: Assign
>    pmc->idx before kvm_pmu_stop_counter()".
> 
> Julien, I haven't collected your Acked-by into this version. If you're
> still happy with the change, please Ack again. Thanks!
> 

Thanks for making the change. This looks good to me:

Acked-by: Julien Thierry <julien.thierry@arm.com>

Thanks,

Julien

>  include/kvm/arm_pmu.h |  2 ++
>  virt/kvm/arm/arm.c    |  2 ++
>  virt/kvm/arm/pmu.c    | 18 +++++++++++++++---
>  3 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
> index 16c769a..6db0304 100644
> --- a/include/kvm/arm_pmu.h
> +++ b/include/kvm/arm_pmu.h
> @@ -34,6 +34,7 @@ struct kvm_pmu {
>  u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u64 select_idx);
>  void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu, u64 select_idx, u64 val);
>  u64 kvm_pmu_valid_counter_mask(struct kvm_vcpu *vcpu);
> +void kvm_pmu_vcpu_init(struct kvm_vcpu *vcpu);
>  void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu);
>  void kvm_pmu_vcpu_destroy(struct kvm_vcpu *vcpu);
>  void kvm_pmu_disable_counter_mask(struct kvm_vcpu *vcpu, u64 val);
> @@ -71,6 +72,7 @@ static inline u64 kvm_pmu_valid_counter_mask(struct kvm_vcpu *vcpu)
>  {
>  	return 0;
>  }
> +static inline void kvm_pmu_vcpu_init(struct kvm_vcpu *vcpu) {}
>  static inline void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu) {}
>  static inline void kvm_pmu_vcpu_destroy(struct kvm_vcpu *vcpu) {}
>  static inline void kvm_pmu_disable_counter_mask(struct kvm_vcpu *vcpu, u64 val) {}
> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index f645c0f..c704fa6 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -340,6 +340,8 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
>  	/* Set up the timer */
>  	kvm_timer_vcpu_init(vcpu);
>  
> +	kvm_pmu_vcpu_init(vcpu);
> +
>  	kvm_arm_reset_debug_ptr(vcpu);
>  
>  	return kvm_vgic_vcpu_init(vcpu);
> diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
> index 3dd8238..362a018 100644
> --- a/virt/kvm/arm/pmu.c
> +++ b/virt/kvm/arm/pmu.c
> @@ -215,6 +215,20 @@ static void kvm_pmu_stop_counter(struct kvm_vcpu *vcpu, struct kvm_pmc *pmc)
>  }
>  
>  /**
> + * kvm_pmu_vcpu_init - assign pmu counter idx for cpu
> + * @vcpu: The vcpu pointer
> + *
> + */
> +void kvm_pmu_vcpu_init(struct kvm_vcpu *vcpu)
> +{
> +	int i;
> +	struct kvm_pmu *pmu = &vcpu->arch.pmu;
> +
> +	for (i = 0; i < ARMV8_PMU_MAX_COUNTERS; i++)
> +		pmu->pmc[i].idx = i;
> +}
> +
> +/**
>   * kvm_pmu_vcpu_reset - reset pmu state for cpu
>   * @vcpu: The vcpu pointer
>   *
> @@ -224,10 +238,8 @@ void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu)
>  	int i;
>  	struct kvm_pmu *pmu = &vcpu->arch.pmu;
>  
> -	for (i = 0; i < ARMV8_PMU_MAX_COUNTERS; i++) {
> +	for (i = 0; i < ARMV8_PMU_MAX_COUNTERS; i++)
>  		kvm_pmu_stop_counter(vcpu, &pmu->pmc[i]);
> -		pmu->pmc[i].idx = i;
> -	}
>  
>  	bitmap_zero(vcpu->arch.pmu.chained, ARMV8_PMU_MAX_COUNTER_PAIRS);
>  }
> 

-- 
Julien Thierry
