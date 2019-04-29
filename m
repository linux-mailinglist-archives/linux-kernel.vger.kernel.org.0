Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2BAE387
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 15:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbfD2NSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 09:18:05 -0400
Received: from foss.arm.com ([217.140.101.70]:56722 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbfD2NSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 09:18:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4441AA78;
        Mon, 29 Apr 2019 06:18:05 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCF433F71A;
        Mon, 29 Apr 2019 06:18:03 -0700 (PDT)
Subject: Re: [PATCH 13/26] iommu/dma: Remove __iommu_dma_free
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190422175942.18788-1-hch@lst.de>
 <20190422175942.18788-14-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <9c53d0e6-3692-e151-c64b-0070a89ca725@arm.com>
Date:   Mon, 29 Apr 2019 14:18:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190422175942.18788-14-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2019 18:59, Christoph Hellwig wrote:
> We only have a single caller of this function left, so open code it there.

Heh, I even caught myself out for a moment thinking this looked 
redundant with #18 now, but no :)

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/iommu/dma-iommu.c | 21 ++-------------------
>   1 file changed, 2 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index b8e46e89a60a..4632b9d301a1 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -534,24 +534,6 @@ static struct page **__iommu_dma_get_pages(void *cpu_addr)
>   	return area->pages;
>   }
>   
> -/**
> - * iommu_dma_free - Free a buffer allocated by iommu_dma_alloc_remap()
> - * @dev: Device which owns this buffer
> - * @pages: Array of buffer pages as returned by __iommu_dma_alloc_remap()
> - * @size: Size of buffer in bytes
> - * @handle: DMA address of buffer
> - *
> - * Frees both the pages associated with the buffer, and the array
> - * describing them
> - */
> -static void __iommu_dma_free(struct device *dev, struct page **pages,
> -		size_t size, dma_addr_t *handle)
> -{
> -	__iommu_dma_unmap(dev, *handle, size);
> -	__iommu_dma_free_pages(pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
> -	*handle = DMA_MAPPING_ERROR;
> -}
> -
>   /**
>    * iommu_dma_alloc_remap - Allocate and map a buffer contiguous in IOVA space
>    * @dev: Device to allocate memory for. Must be a real device
> @@ -1034,7 +1016,8 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
>   
>   		if (WARN_ON(!pages))
>   			return;
> -		__iommu_dma_free(dev, pages, iosize, &handle);
> +		__iommu_dma_unmap(dev, handle, iosize);
> +		__iommu_dma_free_pages(pages, size >> PAGE_SHIFT);
>   		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
>   	} else {
>   		__iommu_dma_unmap(dev, handle, iosize);
> 
