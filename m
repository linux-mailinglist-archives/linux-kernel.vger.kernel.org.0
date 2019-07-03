Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9915EA8F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 19:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfGCRgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 13:36:13 -0400
Received: from foss.arm.com ([217.140.110.172]:53918 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbfGCRgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 13:36:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3A06344;
        Wed,  3 Jul 2019 10:36:11 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B89013F718;
        Wed,  3 Jul 2019 10:36:10 -0700 (PDT)
Subject: Re: [RFC v2 14/14] kvm/arm: Align the VMID allocation with the arm64
 ASID one
To:     Julien Grall <julien.grall@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, marc.zyngier@arm.com,
        julien.thierry@arm.com, suzuki.poulose@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com
References: <20190620130608.17230-1-julien.grall@arm.com>
 <20190620130608.17230-15-julien.grall@arm.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <39d47f54-459f-ce07-91c0-0158896a6783@arm.com>
Date:   Wed, 3 Jul 2019 18:36:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190620130608.17230-15-julien.grall@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julien,

On 20/06/2019 14:06, Julien Grall wrote:
> At the moment, the VMID algorithm will send an SGI to all the CPUs to
> force an exit and then broadcast a full TLB flush and I-Cache
> invalidation.
> 
> This patch re-use the new ASID allocator. The
> benefits are:
>     - CPUs are not forced to exit at roll-over. Instead the VMID will be
>     marked reserved and the context will be flushed at next exit. This
>     will reduce the IPIs traffic.
>     - Context invalidation is now per-CPU rather than broadcasted.

+ Catalin has a model of the asid-allocator.


> With the new algo, the code is now adapted:
>     - The function __kvm_flush_vm_context() has been renamed to
>     __kvm_flush_cpu_vmid_context and now only flushing the current CPU context.
>     - The call to update_vttbr() will be done with preemption disabled
>     as the new algo requires to store information per-CPU.
>     - The TLBs associated to EL1 will be flushed when booting a CPU to
>     deal with stale information. This was previously done on the
>     allocation of the first VMID of a new generation.
> 
> The measurement was made on a Seattle based SoC (8 CPUs), with the
> number of VMID limited to 4-bit. The test involves running concurrently 40
> guests with 2 vCPUs. Each guest will then execute hackbench 5 times
> before exiting.

> diff --git a/arch/arm64/include/asm/kvm_asid.h b/arch/arm64/include/asm/kvm_asid.h
> new file mode 100644
> index 000000000000..8b586e43c094
> --- /dev/null
> +++ b/arch/arm64/include/asm/kvm_asid.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ARM64_KVM_ASID_H__
> +#define __ARM64_KVM_ASID_H__
> +
> +#include <asm/asid.h>
> +
> +#endif /* __ARM64_KVM_ASID_H__ */
> +
> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> index ff73f5462aca..06821f548c0f 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -62,7 +62,7 @@ extern char __kvm_hyp_init_end[];
>  
>  extern char __kvm_hyp_vector[];
>  
> -extern void __kvm_flush_vm_context(void);
> +extern void __kvm_flush_cpu_vmid_context(void);
>  extern void __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa);

As we've got a __kvm_tlb_flush_local_vmid(), would __kvm_tlb_flush_local_all() fit in
better? (This mirrors local_flush_tlb_all() too)


>  extern void __kvm_tlb_flush_vmid(struct kvm *kvm);
>  extern void __kvm_tlb_flush_local_vmid(struct kvm_vcpu *vcpu);
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 4bcd9c1291d5..7ef45b7da4eb 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -68,8 +68,8 @@ int kvm_arch_vm_ioctl_check_extension(struct kvm *kvm, long ext);
>  void __extended_idmap_trampoline(phys_addr_t boot_pgd, phys_addr_t idmap_start);
>  
>  struct kvm_vmid {
> -	/* The VMID generation used for the virt. memory system */
> -	u64    vmid_gen;
> +	/* The ASID used for the ASID allocator */
> +	atomic64_t asid;

Can we call this 'id' as happens in mm_context_t? (calling it asid is confusing)

>  	u32    vmid;

Can we filter out the generation bits in kvm_get_vttbr() in the same way the arch code
does in cpu_do_switch_mm().

I think this saves writing back a cached pre-filtered version every time, or needing
special hooks to know when the value changed. (so we can remove this variable)


>  };


> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index bd5c55916d0d..e906278a67cd 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -449,35 +447,17 @@ bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu)

(git made a mess of the diff here... squashed to just the new code:)


> +static void vmid_update_ctxt(void *ctxt)
>  {
> +	struct kvm_vmid *vmid = ctxt;
> +	u64 asid = atomic64_read(&vmid->asid);

> +	vmid->vmid = asid & ((1ULL << kvm_get_vmid_bits()) - 1);

I don't like having to poke this through the asid-allocator as a kvm-specific hack. Can we
do it in kvm_get_vttbr()?


>  }

> @@ -487,48 +467,11 @@ static bool need_new_vmid_gen(struct kvm_vmid *vmid)

(git made a mess of the diff here... squashed to just the new code:)

>  static void update_vmid(struct kvm_vmid *vmid)
>  {

> +	int cpu = get_cpu();
>  
> +	asid_check_context(&vmid_info, &vmid->asid, cpu, vmid);
>  
> +	put_cpu();

If we're calling update_vmid() in a pre-emptible context, aren't we already doomed?

Could we use smp_processor_id() instead.


>  }


> @@ -1322,6 +1271,8 @@ static void cpu_init_hyp_mode(void *dummy)
>  
>  	__cpu_init_hyp_mode(pgd_ptr, hyp_stack_ptr, vector_ptr);
>  	__cpu_init_stage2();


> +	kvm_call_hyp(__kvm_flush_cpu_vmid_context);

I think we only need to do this for VHE systems too. cpu_hyp_reinit() only does the call
to cpu_init_hyp_mode() if !is_kernel_in_hyp_mode().


>  }
>  
>  static void cpu_hyp_reset(void)
> @@ -1429,6 +1380,17 @@ static inline void hyp_cpu_pm_exit(void)
>  
>  static int init_common_resources(void)
>  {
> +	/*
> +	 * Initialize the ASID allocator telling it to allocate a single
> +	 * VMID per VM.
> +	 */
> +	if (asid_allocator_init(&vmid_info, kvm_get_vmid_bits(), 1,
> +				vmid_flush_cpu_ctxt, vmid_update_ctxt))
> +		panic("Failed to initialize VMID allocator\n");

Couldn't we return an error instead? The asid allocator is needed for user-space, its
pointless to keep running if it fails. The same isn't true here. (and it would make it
easier to debug what went wrong!)


> +	vmid_info.active = &active_vmids;
> +	vmid_info.reserved = &reserved_vmids;
> +
>  	kvm_set_ipa_limit();


Thanks,

James
