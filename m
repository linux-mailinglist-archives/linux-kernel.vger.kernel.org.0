Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 691F711E266
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2019 11:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfLMKyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Dec 2019 05:54:11 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7685 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725928AbfLMKyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 05:54:10 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2A6E91B35A79113B855B;
        Fri, 13 Dec 2019 18:54:01 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Fri, 13 Dec 2019
 18:53:55 +0800
Subject: Re: [PATCH] KVM: arm/arm64: vgic-its: Fix restoration of unmapped
 collections
To:     Eric Auger <eric.auger@redhat.com>, <eric.auger.pro@gmail.com>,
        <maz@kernel.org>, <linux-kernel@vger.kernel.org>,
        <kvmarm@lists.cs.columbia.edu>
References: <20191213094237.19627-1-eric.auger@redhat.com>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <d36b75e7-bd83-e501-3bd4-76bf0489c5ce@huawei.com>
Date:   Fri, 13 Dec 2019 18:53:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191213094237.19627-1-eric.auger@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 2019/12/13 17:42, Eric Auger wrote:
> Saving/restoring an unmapped collection is a valid scenario. For
> example this happens if a MAPTI command was sent, featuring an
> unmapped collection. At the moment the CTE fails to be restored.
> Only compare against the number of online vcpus if the rdist
> base is set.

Have you actually seen a problem and this patch fixed it? To be honest,
I'm surprised to find that we can map a LPI to an unmapped collection ;)
(and prevent it to be delivered to vcpu with an INT_UNMAPPED_INTERRUPT
error, until someone had actually mapped the collection).
After a quick glance of spec (MAPTI), just as you said, this is valid.

If Marc has no objection to this fix, please add

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>


Thanks,
Zenghui

> 
> Cc: stable@vger.kernel.org # v4.11+
> Fixes: ea1ad53e1e31a ("KVM: arm64: vgic-its: Collection table save/restore")
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   virt/kvm/arm/vgic/vgic-its.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
> index 98c7360d9fb7..17920d1b350a 100644
> --- a/virt/kvm/arm/vgic/vgic-its.c
> +++ b/virt/kvm/arm/vgic/vgic-its.c
> @@ -2475,7 +2475,8 @@ static int vgic_its_restore_cte(struct vgic_its *its, gpa_t gpa, int esz)
>   	target_addr = (u32)(val >> KVM_ITS_CTE_RDBASE_SHIFT);
>   	coll_id = val & KVM_ITS_CTE_ICID_MASK;
>   
> -	if (target_addr >= atomic_read(&kvm->online_vcpus))
> +	if (target_addr != COLLECTION_NOT_MAPPED &&
> +	    target_addr >= atomic_read(&kvm->online_vcpus))
>   		return -EINVAL;
>   
>   	collection = find_collection(its, coll_id);
> 

