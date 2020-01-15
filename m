Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92A4713C392
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 14:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbgAONuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 08:50:13 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:48788 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726085AbgAONuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 08:50:12 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E0AF1764F196C96C2BC7;
        Wed, 15 Jan 2020 21:50:10 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Wed, 15 Jan 2020
 21:49:59 +0800
Subject: Re: [PATCH v3 29/32] KVM: arm64: GICv4.1: Allow SGIs to switch
 between HW and SW interrupts
To:     Marc Zyngier <maz@kernel.org>
CC:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <Andrew.Murray@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "Tangnianyao (ICT)" <tangnianyao@huawei.com>
References: <20191224111055.11836-1-maz@kernel.org>
 <20191224111055.11836-30-maz@kernel.org>
 <cc5fe20c-7a0c-c266-e78a-2a85963ab20f@hisilicon.com>
 <6e24d53e-64d9-a682-6753-9e16155c7fde@huawei.com>
 <c30b23cf220a4b2965a42ea87b27285f@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <99ed8894-9d30-7dac-9826-abf95b9a5e80@huawei.com>
Date:   Wed, 15 Jan 2020 21:49:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <c30b23cf220a4b2965a42ea87b27285f@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2020/1/15 21:32, Marc Zyngier wrote:
> On 2020-01-15 03:49, Zenghui Yu wrote:
>> Hi,
>>
>> On 2020/1/15 10:49, Shaokun Zhang wrote:
>>> Hi Marc, [This is from Nianyao]
>>>
>>> On 2019/12/24 19:10, Marc Zyngier wrote:
>>>> In order to let a guest buy in the new, active-less SGIs, we
>>>> need to be able to switch between the two modes.
>>>>
>>>> Handle this by stopping all guest activity, transfer the state
>>>> from one mode to the other, and resume the guest.
>>>>
>>>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>>>> ---
>>
>> [...]
>>
>>>> diff --git a/virt/kvm/arm/vgic/vgic-v4.c b/virt/kvm/arm/vgic/vgic-v4.c
>>>> index c2fcde104ea2..063785fd2dc7 100644
>>>> --- a/virt/kvm/arm/vgic/vgic-v4.c
>>>> +++ b/virt/kvm/arm/vgic/vgic-v4.c
>>>> @@ -97,6 +97,102 @@ static irqreturn_t vgic_v4_doorbell_handler(int 
>>>> irq, void *info)
>>>>       return IRQ_HANDLED;
>>>>   }
>>>>   +static void vgic_v4_sync_sgi_config(struct its_vpe *vpe, struct 
>>>> vgic_irq *irq)
>>>> +{
>>>> +    vpe->sgi_config[irq->intid].enabled    = irq->enabled;
>>>> +    vpe->sgi_config[irq->intid].group     = irq->group;
>>>> +    vpe->sgi_config[irq->intid].priority    = irq->priority;
>>>> +}
>>>> +
>>>> +static void vgic_v4_enable_vsgis(struct kvm_vcpu *vcpu)
>>>> +{
>>>> +    struct its_vpe *vpe = &vcpu->arch.vgic_cpu.vgic_v3.its_vpe;
>>>> +    int i;
>>>> +
>>>> +    /*
>>>> +     * With GICv4.1, every virtual SGI can be directly injected. So
>>>> +     * let's pretend that they are HW interrupts, tied to a host
>>>> +     * IRQ. The SGI code will do its magic.
>>>> +     */
>>>> +    for (i = 0; i < VGIC_NR_SGIS; i++) {
>>>> +        struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, i);
>>>> +        struct irq_desc *desc;
>>>> +        int ret;
>>>> +
>>>> +        if (irq->hw) {
>>>> +            vgic_put_irq(vcpu->kvm, irq);
>>>> +            continue;
>>>> +        }
>>>> +
>>>> +        irq->hw = true;
>>>> +        irq->host_irq = irq_find_mapping(vpe->sgi_domain, i);
>>>
>>> I think we need to check whether irq_find_mapping returns 0.
>>>
>>>> +        vgic_v4_sync_sgi_config(vpe, irq);
>>>> +        /*
>>>> +         * SGIs are initialised as disabled. Enable them if
>>>> +         * required by the rest of the VGIC init code.
>>>> +         */
>>>> +        desc = irq_to_desc(irq->host_irq);
>>>> +        ret = irq_domain_activate_irq(irq_desc_get_irq_data(desc),
>>>> +                          false);
>>>
>>> If irq->host_irq is not valid , in irq_domain_activate_irq, it will 
>>> trigger NULL pointer
>>> dereference in host kernel.
>>> I meet a problem here. When hw support GIC4.1, and host kernel is 
>>> started with
>>> kvm-arm.vgic_v4_enable=0, starting a virtual machine will trigger 
>>> NULL pointer
>>> dereference in host.
>>
>> I think the thing is that we should _not_ try to configure vSGIs at all
>> if kvm-arm.vgic_v4_enable=0 (which indicates we don't allow use of the
>> GICv4 of direct injection).
>>
>> We currently set kvm_vgic_global_state.has_gicv4_1 to true if HW support
>> GICv4.1, regardless whatever the gicv4_enable is (see patch#23 -
>> vgic_v3_probe).  I think this is what actually needs fixing.
> 
> Yes, my point exactly. I've pushed out a potential fix [1], and I'd be
> grateful if you could let me know whether that fixes it for you.

I haven't had the appropriate HW yet.. Nianyao or Shaokun can help to
test it tomorrow, I think.

> 
> Thanks,
> 
>          M.
> 
> [1] 
> https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/commit/?h=irq/gic-v4.1-devel&id=b82c2ee1d3fef66fb85793965c344260f618219d 

Anyway, this looks good to me.


Thanks,
Zenghui

