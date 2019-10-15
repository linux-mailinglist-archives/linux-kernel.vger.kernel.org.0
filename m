Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67EB1D74D9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 13:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfJOLYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 07:24:05 -0400
Received: from foss.arm.com ([217.140.110.172]:36282 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbfJOLYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 07:24:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EAE3D1000;
        Tue, 15 Oct 2019 04:24:04 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC9373F68E;
        Tue, 15 Oct 2019 04:24:02 -0700 (PDT)
Subject: Re: [PATCH v3 4/7] iommu/mediatek: Delete the leaf in the tlb flush
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will.deacon@arm.com>, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>,
        cui.zhang@mediatek.com, srv_heupstream@mediatek.com,
        chao.hao@mediatek.com, edison.hsieh@mediatek.com,
        linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <1571035101-4213-1-git-send-email-yong.wu@mediatek.com>
 <1571035101-4213-5-git-send-email-yong.wu@mediatek.com>
 <20c74c20-864e-88af-3c58-ad3bb7600bcc@arm.com>
 <1571117118.19130.81.camel@mhfsdcap03>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <888d299a-b314-2735-bc73-dd68b92c33af@arm.com>
Date:   Tue, 15 Oct 2019 12:24:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1571117118.19130.81.camel@mhfsdcap03>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/10/2019 06:25, Yong Wu wrote:
> On Mon, 2019-10-14 at 15:22 +0100, Robin Murphy wrote:
>> On 14/10/2019 07:38, Yong Wu wrote:
>>> In our tlb range flush, we don't care the "leaf". Remove it to simplify
>>> the code. no functional change.
>>
>> Presumably you don't care about the granule either?
> 
> Yes. I only keep "granule" to satisfy the format of "tlb_flush_walk",
> then it's no need add a new helper function.

Ah, I'd failed to make the connection that it ends up wired in directly 
to the callbacks in patch #5 - indeed there's no point churning the 
mtk_iommu_tlb_add_flush_nosync() callsites here if they're just getting 
removed later anyway. In that case,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

>>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>>> ---
>>>    drivers/iommu/mtk_iommu.c | 16 ++++------------
>>>    1 file changed, 4 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
>>> index 8712afc..19f936c 100644
>>> --- a/drivers/iommu/mtk_iommu.c
>>> +++ b/drivers/iommu/mtk_iommu.c
>>> @@ -174,8 +174,7 @@ static void mtk_iommu_tlb_flush_all(void *cookie)
>>>    }
>>>    
>>>    static void mtk_iommu_tlb_add_flush_nosync(unsigned long iova, size_t size,
>>> -					   size_t granule, bool leaf,
>>> -					   void *cookie)
>>> +					   size_t granule, void *cookie)
>>>    {
>>>    	struct mtk_iommu_data *data = cookie;
>>>    
>>> @@ -219,14 +218,7 @@ static void mtk_iommu_tlb_sync(void *cookie)
>>>    static void mtk_iommu_tlb_flush_walk(unsigned long iova, size_t size,
>>>    				     size_t granule, void *cookie)
>>>    {
>>> -	mtk_iommu_tlb_add_flush_nosync(iova, size, granule, false, cookie);
>>> -	mtk_iommu_tlb_sync(cookie);
>>> -}
>>> -
>>> -static void mtk_iommu_tlb_flush_leaf(unsigned long iova, size_t size,
>>> -				     size_t granule, void *cookie)
>>> -{
>>> -	mtk_iommu_tlb_add_flush_nosync(iova, size, granule, true, cookie);
>>> +	mtk_iommu_tlb_add_flush_nosync(iova, size, granule, cookie);
>>>    	mtk_iommu_tlb_sync(cookie);
>>>    }
>>>    
>>> @@ -245,7 +237,7 @@ static void mtk_iommu_tlb_flush_page_nosync(struct iommu_iotlb_gather *gather,
>>>    static const struct iommu_flush_ops mtk_iommu_flush_ops = {
>>>    	.tlb_flush_all = mtk_iommu_tlb_flush_all,
>>>    	.tlb_flush_walk = mtk_iommu_tlb_flush_walk,
>>> -	.tlb_flush_leaf = mtk_iommu_tlb_flush_leaf,
>>> +	.tlb_flush_leaf = mtk_iommu_tlb_flush_walk,
>>>    	.tlb_add_page = mtk_iommu_tlb_flush_page_nosync,
>>>    };
>>>    
>>> @@ -475,7 +467,7 @@ static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
>>>    		spin_lock_irqsave(&dom->pgtlock, flags);
>>>    
>>>    	mtk_iommu_tlb_add_flush_nosync(gather->start, length, gather->pgsize,
>>> -				       false, data);
>>> +				       data);
>>>    	mtk_iommu_tlb_sync(data);
>>>    
>>>    	if (!is_in_gather)
>>>
>>
>> _______________________________________________
>> Linux-mediatek mailing list
>> Linux-mediatek@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-mediatek
> 
> 
