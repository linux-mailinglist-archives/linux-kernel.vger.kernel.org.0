Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48BD7B4DF9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 14:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfIQMjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 08:39:41 -0400
Received: from foss.arm.com ([217.140.110.172]:55332 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727821AbfIQMjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 08:39:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8AD211000;
        Tue, 17 Sep 2019 05:39:39 -0700 (PDT)
Received: from [10.37.9.122] (unknown [10.37.9.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 281AE3F59C;
        Tue, 17 Sep 2019 05:39:37 -0700 (PDT)
Subject: Re: [PATCH] drm/panfrost: Prevent race when handling page fault
To:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20190905121141.42820-1-steven.price@arm.com>
 <20190913172454.GA5387@kevin>
From:   Steven Price <steven.price@arm.com>
Message-ID: <15e36fa5-df70-ba46-489a-71b258776c5f@arm.com>
Date:   Tue, 17 Sep 2019 13:39:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190913172454.GA5387@kevin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2019 18:24, Alyssa Rosenzweig wrote:
> I'm conflicted on this series.

I'm on holiday, but thought I had to reply...

> On the one hand, userspace should obviously not be able to crash the
> kernel. So the crash should be fixed in one way or another.
> 
> On the other hand, userspace really has to supply all the BOs it uses
> for correctness. I realize the DDK doesn't do this but... it probably
> should, umm...

It turns out you don't need the missing BOs to trigger this - see the 
test case I added to IGT[1], referenced from v2 of this patch[2].

[1] https://patchwork.freedesktop.org/patch/330513/
[2] 
https://lore.kernel.org/lkml/20190913160310.50444-1-steven.price@arm.com/

> Would it be possible to check for the NULL pointer in the kernel and
> skip printing information that would require a dereference? (Without
> having to play games with reference counts). Presumably that might fix
> crashes in other corner cases.

I think we should try to do the right thing here and keep the reference 
counts correct. While it might be possible to handle the NULL pointer in 
practise the code has looked up the BO and is operating on it - so we 
should ensure that it can't disappear while that is happening.

This isn't about supporting the quirks of the DDK - at the moment the 
DDK-on-Panfrost work I've been doing is really just a hack to be able to 
test the feasibility and it may yet never be published externally. But 
when I can trigger kernel bugs I might as well fix them!

Steve

> On Thu, Sep 05, 2019 at 01:11:41PM +0100, Steven Price wrote:
>> When handling a GPU page fault addr_to_drm_mm_node() is used to
>> translate the GPU address to a buffer object. However it is possible for
>> the buffer object to be freed after the function has returned resulting
>> in a use-after-free of the BO.
>>
>> Change addr_to_drm_mm_node to return the panfrost_gem_object with an
>> extra reference on it, preventing the BO from being freed until after
>> the page fault has been handled.
>>
>> Signed-off-by: Steven Price <steven.price@arm.com>
>> ---
>>
>> I've managed to trigger this, generating the following stack trace.
>>
>> Unable to handle kernel NULL pointer dereference at virtual address 00000090
>> pgd = 33a6a181
>> [00000090] *pgd=00000000
>> Internal error: Oops: 5 [#1] SMP ARM
>> Modules linked in:
>> CPU: 0 PID: 81 Comm: irq/60-mmu Not tainted 5.3.0-rc1+ #4
>> Hardware name: Rockchip (Device Tree)
>> PC is at panfrost_mmu_map_fault_addr+0x140/0x3a0
>> LR is at _raw_spin_unlock+0x20/0x3c
>> pc : [<c0508944>]    lr : [<c07ced10>]    psr: 20030013
>> sp : ec643e88  ip : ea70ce24  fp : ec5fe840
>> r10: 00000001  r9 : 00000000  r8 : 000178c9
>> r7 : 00000000  r6 : 178c9f00  r5 : ec5fe940  r4 : ea70ce08
>> r3 : 00000000  r2 : 00000000  r1 : ec640e00  r0 : ec5fe940
>> Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
>> Control: 10c5387d  Table: 29f8406a  DAC: 00000051
>> Process irq/60-mmu (pid: 81, stack limit = 0x4b907106)
>> Stack: (0xec643e88 to 0xec644000)
>> 3e80:                   ec640e00 c07cede0 c0c0b200 ec640e00 00000000 00000000
>> 3ea0: 000178c9 00000000 c0c0b200 c07cede0 eef91040 ec5fe840 00000001 00000000
>> 3ec0: 00010001 010003c3 000000c3 00000001 178c9f00 c0508c98 eef91050 00000000
>> 3ee0: ec643f34 c07c9188 00000001 c0167854 00000000 ec643ef8 c0c08448 c07c933c
>> 3f00: 00000000 ec643f04 fffefffe 3d182b17 ee193468 ee193400 ec5db3c0 ec5db3c0
>> 3f20: c0183840 ec5db3e4 c0cb2874 c0183b08 00000001 c018385c ffffe000 ee193400
>> 3f40: ec5db3c0 c0183b8c c0c08448 00000000 60000013 00000000 c01839b8 3d182b17
>> 3f60: ffffe000 ec5d0500 ec5db380 ec642000 ec5db3c0 c0183a64 00000000 ed025cd8
>> 3f80: ec5d0538 c0146cfc ec642000 ec5db380 c0146bc0 00000000 00000000 00000000
>> 3fa0: 00000000 00000000 00000000 c01010b4 00000000 00000000 00000000 00000000
>> 3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>> 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
>> [<c0508944>] (panfrost_mmu_map_fault_addr) from [<c0508c98>] (panfrost_mmu_irq_handler_thread+0xf4/0x248)
>> [<c0508c98>] (panfrost_mmu_irq_handler_thread) from [<c018385c>] (irq_thread_fn+0x1c/0x58)
>> [<c018385c>] (irq_thread_fn) from [<c0183b8c>] (irq_thread+0x128/0x240)
>> [<c0183b8c>] (irq_thread) from [<c0146cfc>] (kthread+0x13c/0x154)
>> [<c0146cfc>] (kthread) from [<c01010b4>] (ret_from_fork+0x14/0x20)
>> Exception stack(0xec643fb0 to 0xec643ff8)
>> 3fa0:                                     00000000 00000000 00000000 00000000
>> 3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>> 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>> Code: 1affffec eaffffe8 e5143004 e59d2014 (e5933090)
>> ---[ end trace 04eadc3009b8f507 ]---
>> ---
>>   drivers/gpu/drm/panfrost/panfrost_mmu.c | 38 ++++++++++++++++---------
>>   1 file changed, 24 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
>> index 842bdd7cf6be..115925e7460a 100644
>> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
>> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
>> @@ -392,9 +392,11 @@ void panfrost_mmu_pgtable_free(struct panfrost_file_priv *priv)
>>   	free_io_pgtable_ops(mmu->pgtbl_ops);
>>   }
>>   
>> -static struct drm_mm_node *addr_to_drm_mm_node(struct panfrost_device *pfdev, int as, u64 addr)
>> +static struct panfrost_gem_object *
>> +addr_to_drm_mm_node(struct panfrost_device *pfdev, int as, u64 addr)
>>   {
>> -	struct drm_mm_node *node = NULL;
>> +	struct panfrost_gem_object *bo = NULL;
>> +	struct drm_mm_node *node;
>>   	u64 offset = addr >> PAGE_SHIFT;
>>   	struct panfrost_mmu *mmu;
>>   
>> @@ -406,14 +408,17 @@ static struct drm_mm_node *addr_to_drm_mm_node(struct panfrost_device *pfdev, in
>>   
>>   		priv = container_of(mmu, struct panfrost_file_priv, mmu);
>>   		drm_mm_for_each_node(node, &priv->mm) {
>> -			if (offset >= node->start && offset < (node->start + node->size))
>> +			if (offset >= node->start &&
>> +			    offset < (node->start + node->size)) {
>> +				bo = drm_mm_node_to_panfrost_bo(node);
>> +				drm_gem_object_get(&bo->base.base);
>>   				goto out;
>> +			}
>>   		}
>>   	}
>> -
>>   out:
>>   	spin_unlock(&pfdev->as_lock);
>> -	return node;
>> +	return bo;
>>   }
>>   
>>   #define NUM_FAULT_PAGES (SZ_2M / PAGE_SIZE)
>> @@ -421,29 +426,28 @@ static struct drm_mm_node *addr_to_drm_mm_node(struct panfrost_device *pfdev, in
>>   int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as, u64 addr)
>>   {
>>   	int ret, i;
>> -	struct drm_mm_node *node;
>>   	struct panfrost_gem_object *bo;
>>   	struct address_space *mapping;
>>   	pgoff_t page_offset;
>>   	struct sg_table *sgt;
>>   	struct page **pages;
>>   
>> -	node = addr_to_drm_mm_node(pfdev, as, addr);
>> -	if (!node)
>> +	bo = addr_to_drm_mm_node(pfdev, as, addr);
>> +	if (!bo)
>>   		return -ENOENT;
>>   
>> -	bo = drm_mm_node_to_panfrost_bo(node);
>>   	if (!bo->is_heap) {
>>   		dev_WARN(pfdev->dev, "matching BO is not heap type (GPU VA = %llx)",
>> -			 node->start << PAGE_SHIFT);
>> -		return -EINVAL;
>> +			 bo->node.start << PAGE_SHIFT);
>> +		ret = -EINVAL;
>> +		goto err_bo;
>>   	}
>>   	WARN_ON(bo->mmu->as != as);
>>   
>>   	/* Assume 2MB alignment and size multiple */
>>   	addr &= ~((u64)SZ_2M - 1);
>>   	page_offset = addr >> PAGE_SHIFT;
>> -	page_offset -= node->start;
>> +	page_offset -= bo->node.start;
>>   
>>   	mutex_lock(&bo->base.pages_lock);
>>   
>> @@ -452,7 +456,8 @@ int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as, u64 addr)
>>   				     sizeof(struct sg_table), GFP_KERNEL | __GFP_ZERO);
>>   		if (!bo->sgts) {
>>   			mutex_unlock(&bo->base.pages_lock);
>> -			return -ENOMEM;
>> +			ret = -ENOMEM;
>> +			goto err_bo;
>>   		}
>>   
>>   		pages = kvmalloc_array(bo->base.base.size >> PAGE_SHIFT,
>> @@ -461,7 +466,8 @@ int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as, u64 addr)
>>   			kfree(bo->sgts);
>>   			bo->sgts = NULL;
>>   			mutex_unlock(&bo->base.pages_lock);
>> -			return -ENOMEM;
>> +			ret = -ENOMEM;
>> +			goto err_bo;
>>   		}
>>   		bo->base.pages = pages;
>>   		bo->base.pages_use_count = 1;
>> @@ -499,12 +505,16 @@ int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as, u64 addr)
>>   
>>   	dev_dbg(pfdev->dev, "mapped page fault @ AS%d %llx", as, addr);
>>   
>> +	drm_gem_object_put_unlocked(&bo->base.base);
>> +
>>   	return 0;
>>   
>>   err_map:
>>   	sg_free_table(sgt);
>>   err_pages:
>>   	drm_gem_shmem_put_pages(&bo->base);
>> +err_bo:
>> +	drm_gem_object_put_unlocked(&bo->base.base);
>>   	return ret;
>>   }
>>   
>> -- 
>> 2.20.1
>>
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel

