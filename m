Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55CC2186AA3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 13:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730987AbgCPMMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 08:12:14 -0400
Received: from foss.arm.com ([217.140.110.172]:47152 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730977AbgCPMMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 08:12:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A81F930E;
        Mon, 16 Mar 2020 05:12:13 -0700 (PDT)
Received: from [192.168.1.123] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD2393F52E;
        Mon, 16 Mar 2020 05:12:12 -0700 (PDT)
Subject: Re: [RFC][PATCH] dma-mapping: align default segment_boundary_mask
 with dma_mask
To:     Nicolin Chen <nicoleotsuka@gmail.com>, m.szyprowski@samsung.com,
        hch@lst.de
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
References: <20200314000007.13778-1-nicoleotsuka@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f36ac67e-0eca-46df-78ec-c8b1c4fbe951@arm.com>
Date:   Mon, 16 Mar 2020 12:12:08 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200314000007.13778-1-nicoleotsuka@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-14 12:00 am, Nicolin Chen wrote:
> More and more drivers set dma_masks above DMA_BIT_MAKS(32) while
> only a handful of drivers call dma_set_seg_boundary(). This means
> that most drivers have a 4GB segmention boundary because DMA API
> returns DMA_BIT_MAKS(32) as a default value, though they might be
> able to handle things above 32-bit.

Don't assume the boundary mask and the DMA mask are related. There do 
exist devices which can DMA to a 64-bit address space in general, but 
due to descriptor formats/hardware design/whatever still require any 
single transfer not to cross some smaller boundary. XHCI is 64-bit yet 
requires most things not to cross a 64KB boundary. EHCI's 64-bit mode is 
an example of the 4GB boundary (not the best example, admittedly, but it 
undeniably exists).

> This might result in a situation that iommu_map_sg() cuts an IOVA
> region, larger than 4GB, into discontiguous pieces and creates a
> faulty IOVA mapping that overlaps some physical memory being out
> of the scatter list, which might lead to some random kernel panic
> after DMA overwrites that faulty IOVA space.

If that's really a problem, then what about users who set a non-default 
mask?

Furthermore, scatterlist segments are just DMA duffers - if there is no 
IOMMU and a device accesses outside a buffer, Bad Things can and will 
happen; if the ends of the buffer don't line up exactly to page 
boundaries even with an IOMMU, if the device accesses outside the buffer 
then Bad Things can happen; even if an IOMMU can map a buffer perfectly, 
accesses outside it will either hit other buffers or generate unexpected 
faults, which are both - you guessed it - Bad Things.

In short, if this is happening then something is certainly broken, but 
it isn't the DMA layer.

> We have CONFIG_DMA_API_DEBUG_SG in kernel/dma/debug.c that checks
> such situations to prevent bad things from happening. However, it
> is not a mandatory check. And one might not think of enabling it
> when debugging a random kernel panic until figuring out that it's
> related to iommu_map_sg().
> 
> A safer solution may be to align the default segmention boundary
> with the configured dma_mask, so DMA API may create a contiguous
> IOVA space as a device "expect" -- what tries to make sense is:
> Though it's device driver's responsibility to set dma_parms, it
> is not fair or even safe to apply a 4GB boundary here, which was
> added a decade ago to work for up-to-4GB mappings at that time.
> 
> This patch updates the default segment_boundary_mask by aligning
> it with dma_mask.

Why bother even interrogating the device? You can trivially express "no 
limit" as "~0UL", which is arguably less confusing than pretending this 
bears any relation to DMA masks. However, like Christoph I'm concerned 
that we don't know how many drivers are relying on the current default 
(and to a lesser extent that it leads to a subtle difference in 
behaviour between 32-bit PAE and 'proper' 64-bit builds).

And in the specific case of iommu-dma, this only comes into the picture 
at all if a single scatterlist maps more than 4GB at once, which isn't 
exactly typical streaming DMA behaviour - given that that implies a 
rather absurd figure of more than 65536 entries at the default 
max_segment_size, the relevant device probably doesn't want to be 
relying on the default dma_parms in the first place.

[ I though I'd replied to your previous mail already; let me go see what 
happened to that... ]

Robin.

> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>   include/linux/dma-mapping.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 330ad58fbf4d..0df0ee92eba1 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -736,7 +736,7 @@ static inline unsigned long dma_get_seg_boundary(struct device *dev)
>   {
>   	if (dev->dma_parms && dev->dma_parms->segment_boundary_mask)
>   		return dev->dma_parms->segment_boundary_mask;
> -	return DMA_BIT_MASK(32);
> +	return (unsigned long)dma_get_mask(dev);
>   }
>   
>   static inline int dma_set_seg_boundary(struct device *dev, unsigned long mask)
> 
