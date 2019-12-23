Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C96A129207
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Dec 2019 07:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbfLWGvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Dec 2019 01:51:02 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7728 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725810AbfLWGvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 01:51:02 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 48FF52AF828E5AFB0898;
        Mon, 23 Dec 2019 14:51:00 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Mon, 23 Dec 2019
 14:50:53 +0800
Subject: Re: [PATCH] KVM: arm/arm64: vgic: Handle GICR_PENDBASER.PTZ filed as
 RAZ
To:     Marc Zyngier <maz@kernel.org>, <eric.auger@redhat.com>
CC:     <andre.przywara@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        <wanghaibin.wang@huawei.com>
References: <20191220111833.1422-1-yuzenghui@huawei.com>
 <71e3dcc00ad5ab8dffd732bfe7381705@www.loen.fr>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <5f5f499a-d025-cc9f-66f3-37fe958df246@huawei.com>
Date:   Mon, 23 Dec 2019 14:50:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <71e3dcc00ad5ab8dffd732bfe7381705@www.loen.fr>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc, Eric,

On 2019/12/20 21:07, Marc Zyngier wrote:
> On 2019-12-20 11:18, Zenghui Yu wrote:
>> Although guest will hardly read and use the PTZ (Pending Table Zero)
>> bit in GICR_PENDBASER, let us emulate the architecture strictly.
>> As per IHI 0069E 9.11.30, PTZ field is WO, and reads as 0.
>>
>> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
>> ---
>>
>> Noticed when checking all fields of GICR_PENDBASER register.
>> But _not_ sure whether it's worth a fix, as Linux never sets
>> the PTZ bit before enabling LPI (set GICR_CTLR_ENABLE_LPIS).
>>
>> And I wonder under which scenarios can this bit be written as 1.
>> It seems difficult for software to determine whether the pending
>> table contains all zeros when writing this bit.
> 
> This is a useless HW optimization, where it can avoid reading the
> pending table the very first time you write to this register if
> it is told that it is all zero. A decent ITS implementation
> already has a mechanism to find out about the pending bits by
> looking into the IMPDEF area (the first 1kB) of the pending table.

Yeah, AFAICT this is what Hisilicon has already implemented today.

> PTZ is just yet another way to do the same thing.
> 
> This can only happen once in the lifetime of the system (when allocating
> the table), and Linux doesn't really care.

I now get it, thanks for teaching me that!

> As usual, the GIC is setting
> the level of useless complexity pretty high...
> 
>>
>>  virt/kvm/arm/vgic/vgic-mmio-v3.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/virt/kvm/arm/vgic/vgic-mmio-v3.c
>> b/virt/kvm/arm/vgic/vgic-mmio-v3.c
>> index 7dfd15dbb308..ebc218840fc2 100644
>> --- a/virt/kvm/arm/vgic/vgic-mmio-v3.c
>> +++ b/virt/kvm/arm/vgic/vgic-mmio-v3.c
>> @@ -414,8 +414,11 @@ static unsigned long
>> vgic_mmio_read_pendbase(struct kvm_vcpu *vcpu,
>>                           gpa_t addr, unsigned int len)
>>  {
>>      struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
>> +    u64 value = vgic_cpu->pendbaser;
>>
>> -    return extract_bytes(vgic_cpu->pendbaser, addr & 7, len);
>> +    value &= ~GICR_PENDBASER_PTZ;
>> +
>> +    return extract_bytes(value, addr & 7, len);
>>  }
>>
>>  static void vgic_mmio_write_pendbase(struct kvm_vcpu *vcpu,
> 
> Otherwise looks good. I'll queue it with Eric's correction
> to the subject line.

Thanks both and Merry Christmas!

Zenghui

