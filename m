Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA4BD11541A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2019 16:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfLFPVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Dec 2019 10:21:46 -0500
Received: from foss.arm.com ([217.140.110.172]:47756 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbfLFPVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 10:21:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B89F131B;
        Fri,  6 Dec 2019 07:21:44 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30CE83F718;
        Fri,  6 Dec 2019 07:21:44 -0800 (PST)
Date:   Fri, 6 Dec 2019 15:21:42 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Auger Eric <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        james.morse@arm.com, suzuki.poulose@arm.com, drjones@redhat.com
Subject: Re: [RFC 2/3] KVM: arm64: pmu: Fix chained SW_INCR counters
Message-ID: <20191206152141.GN18399@e119886-lin.cambridge.arm.com>
References: <20191204204426.9628-1-eric.auger@redhat.com>
 <20191204204426.9628-3-eric.auger@redhat.com>
 <561ac6df385e977cc51d51a8ab28ee49@www.loen.fr>
 <2b30c1ca-3bc0-9f73-4bea-ee42bb74cbac@redhat.com>
 <15507faca89a980056df7119e105e82a@www.loen.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15507faca89a980056df7119e105e82a@www.loen.fr>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 02:52:26PM +0000, Marc Zyngier wrote:
> On 2019-12-05 14:06, Auger Eric wrote:
> > Hi Marc,
> > 
> > On 12/5/19 10:43 AM, Marc Zyngier wrote:
> > > Hi Eric,
> > > 
> > > On 2019-12-04 20:44, Eric Auger wrote:
> > > > At the moment a SW_INCR counter always overflows on 32-bit
> > > > boundary, independently on whether the n+1th counter is
> > > > programmed as CHAIN.
> > > > 
> > > > Check whether the SW_INCR counter is a 64b counter and if so,
> > > > implement the 64b logic.
> > > > 
> > > > Fixes: 80f393a23be6 ("KVM: arm/arm64: Support chained PMU
> > > > counters")
> > > > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > > > ---
> > > > �virt/kvm/arm/pmu.c | 16 +++++++++++++++-
> > > > �1 file changed, 15 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
> > > > index c3f8b059881e..7ab477db2f75 100644
> > > > --- a/virt/kvm/arm/pmu.c
> > > > +++ b/virt/kvm/arm/pmu.c
> > > > @@ -491,6 +491,8 @@ void kvm_pmu_software_increment(struct kvm_vcpu
> > > > *vcpu, u64 val)
> > > > 
> > > > ���� enable = __vcpu_sys_reg(vcpu, PMCNTENSET_EL0);
> > > > ���� for (i = 0; i < ARMV8_PMU_CYCLE_IDX; i++) {
> > > > +������� bool chained = test_bit(i >> 1, vcpu->arch.pmu.chained);
> > > > +
> > > 
> > > I'd rather you use kvm_pmu_pmc_is_chained() rather than open-coding
> > > this. But see below:
> > > 
> > > > �������� if (!(val & BIT(i)))
> > > > ������������ continue;
> > > > �������� type = __vcpu_sys_reg(vcpu, PMEVTYPER0_EL0 + i)
> > > > @@ -500,8 +502,20 @@ void kvm_pmu_software_increment(struct
> > > > kvm_vcpu
> > > > *vcpu, u64 val)
> > > > ������������ reg = __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i) + 1;
> > > > ������������ reg = lower_32_bits(reg);
> > > > ������������ __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i) = reg;
> > > > -����������� if (!reg)
> > > > +����������� if (reg) /* no overflow */
> > > > +��������������� continue;
> > > > +����������� if (chained) {
> > > > +��������������� reg = __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i +
> > > > 1) + 1;
> > > > +��������������� reg = lower_32_bits(reg);
> > > > +��������������� __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i + 1) = reg;
> > > > +��������������� if (reg)
> > > > +������������������� continue;
> > > > +��������������� /* mark an overflow on high counter */
> > > > +��������������� __vcpu_sys_reg(vcpu, PMOVSSET_EL0) |= BIT(i + 1);
> > > > +����������� } else {
> > > > +��������������� /* mark an overflow */
> > > > ���������������� __vcpu_sys_reg(vcpu, PMOVSSET_EL0) |= BIT(i);
> > > > +����������� }
> > > > �������� }
> > > > ���� }
> > > > �}
> > > 
> > > I think the whole function is a bit of a mess, and could be better
> > > structured to treat 64bit counters as a first class citizen.
> > > 
> > > I'm suggesting something along those lines, which tries to
> > > streamline things a bit and keep the flow uniform between the
> > > two word sizes. IMHO, it helps reasonning about it and gives
> > > scope to the ARMv8.5 full 64bit counters... It is of course
> > > completely untested.
> > 
> > Looks OK to me as well. One remark though, don't we need to test if the
> > n+1th reg is enabled before incrementing it?

Indeed - we don't want to indicate an overflow on a disabled counter.


> 
> Hmmm. I'm not sure. I think we should make sure that we don't flag
> a counter as being chained if the odd counter is disabled, rather
> than checking it here. As long as the odd counter is not chained
> *and* enabled, we shouldn't touch it.

Does this mean that we don't care if the low counter is enabled or not
when deciding if the pair is chained?

I would find the code easier to follow if we had an explicit 'is the
high counter enabled here' check (at the point of deciding where to
put the overflow).


> 
> Again, untested:
> 
> diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
> index cf371f643ade..47366817cd2a 100644
> --- a/virt/kvm/arm/pmu.c
> +++ b/virt/kvm/arm/pmu.c
> @@ -15,6 +15,7 @@
>  #include <kvm/arm_vgic.h>
> 
>  static void kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu, u64
> select_idx);
> +static void kvm_pmu_update_pmc_chained(struct kvm_vcpu *vcpu, u64
> select_idx);
> 
>  #define PERF_ATTR_CFG1_KVM_PMU_CHAINED 0x1
> 
> @@ -298,6 +299,7 @@ void kvm_pmu_enable_counter_mask(struct kvm_vcpu *vcpu,
> u64 val)
>  		 * For high counters of chained events we must recreate the
>  		 * perf event with the long (64bit) attribute set.
>  		 */
> +		kvm_pmu_update_pmc_chained(vcpu, i);
>  		if (kvm_pmu_pmc_is_chained(pmc) &&
>  		    kvm_pmu_idx_is_high_counter(i)) {
>  			kvm_pmu_create_perf_event(vcpu, i);
> @@ -645,7 +647,8 @@ static void kvm_pmu_update_pmc_chained(struct kvm_vcpu
> *vcpu, u64 select_idx)
>  	struct kvm_pmu *pmu = &vcpu->arch.pmu;
>  	struct kvm_pmc *pmc = &pmu->pmc[select_idx];
> 
> -	if (kvm_pmu_idx_has_chain_evtype(vcpu, pmc->idx)) {
> +	if (kvm_pmu_idx_has_chain_evtype(vcpu, pmc->idx) &&
> +	    kvm_pmu_counter_is_enabled(vcpu, pmc->idx)) {

I.e. here we don't care what the state of enablement is for the low counter.

Also at present, this may break the following use-case

 - User creates and uses a pair of chained counters
 - User disables odd/high counter
 - User reads values of both counters
 - User rewrites CHAIN event to odd/high counter OR user re-enables just the even/low counter
 - User reads value of both counters <- this may now different to the last read

Thanks,

Andrew Murray

>  		/*
>  		 * During promotion from !chained to chained we must ensure
>  		 * the adjacent counter is stopped and its event destroyed
> 
> What do you think?
> 
>         M.
> -- 
> Jazz is not dead. It just smells funny...
