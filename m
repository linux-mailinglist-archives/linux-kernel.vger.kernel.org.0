Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4B9E888F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 13:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387847AbfJ2Mpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 08:45:31 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5644 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726048AbfJ2Mpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 08:45:31 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5FDA78BCD0989B2D6C0A;
        Tue, 29 Oct 2019 20:45:26 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Tue, 29 Oct 2019
 20:45:17 +0800
Subject: Re: [PATCH 2/3] KVM: arm/arm64: vgic: Fix some comments typo
To:     Marc Zyngier <maz@kernel.org>
CC:     <eric.auger@redhat.com>, <james.morse@arm.com>,
        <julien.thierry.kdev@gmail.com>, <suzuki.poulose@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        <wanghaibin.wang@huawei.com>
References: <20191029071919.177-1-yuzenghui@huawei.com>
 <20191029071919.177-3-yuzenghui@huawei.com> <86o8xzylb1.wl-maz@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <7055e836-cdad-1cfa-66f3-fba88dad5f5b@huawei.com>
Date:   Tue, 29 Oct 2019 20:45:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <86o8xzylb1.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/29 17:04, Marc Zyngier wrote:
> Hi Zenghui,
> 
> On Tue, 29 Oct 2019 07:19:18 +0000,
> Zenghui Yu <yuzenghui@huawei.com> wrote:
>>
>> s/vgic_its_save_pending_tables/vgic_v3_save_pending_tables/
>> s/then/the/
>>
>> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
>> ---
>>   include/kvm/arm_vgic.h      | 2 +-
>>   virt/kvm/arm/vgic/vgic-v3.c | 2 +-
>>   virt/kvm/arm/vgic/vgic-v4.c | 2 +-
>>   3 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
>> index 0fb240ec0a2a..01f8b3739a09 100644
>> --- a/include/kvm/arm_vgic.h
>> +++ b/include/kvm/arm_vgic.h
>> @@ -240,7 +240,7 @@ struct vgic_dist {
>>   	 * Contains the attributes and gpa of the LPI configuration table.
>>   	 * Since we report GICR_TYPER.CommonLPIAff as 0b00, we can share
>>   	 * one address across all redistributors.
>> -	 * GICv3 spec: 6.1.2 "LPI Configuration tables"
>> +	 * GICv3 spec "LPI Configuration tables"

Ah, this part shouldn't have been in this patch, as the description in
the commit message.
(And I remember the reason is just that, it it "6.1.1" in IHI 0069E but
"6.1.2" in some older versions.)

> 
> Why the change here? Pointing to the chapter in the spec is pretty
> helpful, given that it is 800 pages long (although it should mention
> what revision of the spec this refers to). For example, it should say
> something like "IHI 0069E 6.1.1 ...".

Yes, I agreed with you.  Marc, please feel free to drop this part,
or I can resend it with your suggestion.


Thanks,
Zenghui

