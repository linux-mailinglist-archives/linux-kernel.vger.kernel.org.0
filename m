Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCA376BD86
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 15:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfGQNpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 09:45:04 -0400
Received: from foss.arm.com ([217.140.110.172]:47570 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfGQNpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 09:45:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 645C5337;
        Wed, 17 Jul 2019 06:45:03 -0700 (PDT)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C33683F71A;
        Wed, 17 Jul 2019 06:45:01 -0700 (PDT)
Subject: Re: [PATCH] KVM: arm/arm64: Assign pmc->idx before
 kvm_pmu_stop_counter()
To:     Zenghui Yu <yuzenghui@huawei.com>, maz@kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Cc:     marc.zyngier@arm.com, james.morse@arm.com, suzuki.poulose@arm.com,
        julien.thierry.kdev@gmail.com, linux-kernel@vger.kernel.org,
        wanghaibin.wang@huawei.com, andrew.murray@arm.com
References: <1563366019-31200-1-git-send-email-yuzenghui@huawei.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <01fa98c1-8274-445c-5e04-219372920ba2@arm.com>
Date:   Wed, 17 Jul 2019 14:44:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1563366019-31200-1-git-send-email-yuzenghui@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zenghui,

On 17/07/2019 13:20, Zenghui Yu wrote:
> We use "pmc->idx" and the "chained" bitmap to determine if the pmc is
> chained, in kvm_pmu_pmc_is_chained().  But idx might be uninitialized
> (and random) when we doing this decision, through a KVM_ARM_VCPU_INIT
> ioctl -> kvm_pmu_vcpu_reset(). And the test_bit() against this random
> idx will potentially hit a KASAN BUG [1].
> 
> Fix it by moving the assignment of idx before kvm_pmu_stop_counter().
> 
> [1] https://www.spinics.net/lists/kvm-arm/msg36700.html
> 
> Fixes: 80f393a23be6 ("KVM: arm/arm64: Support chained PMU counters")
> Suggested-by: Andrew Murray <andrew.murray@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>> ---
>  virt/kvm/arm/pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
> index 3dd8238..521bfdd 100644
> --- a/virt/kvm/arm/pmu.c
> +++ b/virt/kvm/arm/pmu.c
> @@ -225,8 +225,8 @@ void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu)
>  	struct kvm_pmu *pmu = &vcpu->arch.pmu;
>  
>  	for (i = 0; i < ARMV8_PMU_MAX_COUNTERS; i++) {
> -		kvm_pmu_stop_counter(vcpu, &pmu->pmc[i]);
>  		pmu->pmc[i].idx = i;

Yes, this is kind of a static property that should really be part of a
"kvm_pmu_vcpu_init()" or "kvm_pmu_vcpu_create()" and is not expected to
be modified across resets...

There is no such function at the time and I'm unsure whether this
warrants creating that separate function (I would still suggest creating
it to make things clearer).

> +		kvm_pmu_stop_counter(vcpu, &pmu->pmc[i]);

Whatever other opinions are on splitting pmu_vcpu_init/reset, that
change makes sense and fixes the issue:

Acked-by: Julien Thierry <julien.thierry@arm.com>

>  	}
>  
>  	bitmap_zero(vcpu->arch.pmu.chained, ARMV8_PMU_MAX_COUNTER_PAIRS);
> 

Cheers,

-- 
Julien Thierry
