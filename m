Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B70EA2A3E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 00:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbfH2WtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 18:49:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:32986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727686AbfH2WtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 18:49:06 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B748021874;
        Thu, 29 Aug 2019 22:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567118945;
        bh=eZr58+WOf6N/N5qzupHqv/5s/W5SJ5hJvzzBfJ5JjAY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=K/tyd1jXYrmcFvFvvXRZM9PeqHCpnielu362H6/Wg0t2yvT9MqjU6J0KDWTtrN9QB
         e9QWr1DGH/CM8Fg9iSRTiLh+QUza9dchoTkIf8wnhlf29nyhv2B76GqpE7Srrc8MFt
         EZr/UBWetxbDl3MqWxWlUxuTs2xFIbKJQGNZQYKE=
Date:   Thu, 29 Aug 2019 15:49:04 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Christoph Hellwig <hch@lst.de>
cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 03/11] xen/arm: simplify dma_cache_maint
In-Reply-To: <20190827063754.GA32045@lst.de>
Message-ID: <alpine.DEB.2.21.1908281528110.8175@sstabellini-ThinkPad-T480s>
References: <20190826121944.515-1-hch@lst.de> <20190826121944.515-4-hch@lst.de> <20190827063754.GA32045@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Aug 2019, Christoph Hellwig wrote:
> And this was still buggy I think, it really needs some real Xen/Arm
> testing which I can't do.  Hopefully better version below:
> 
> --
> >From 5ad4b6e291dbb49f65480c9b769414931cbd485a Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Wed, 24 Jul 2019 15:26:08 +0200
> Subject: xen/arm: simplify dma_cache_maint
> 
> Calculate the required operation in the caller, and pass it directly
> instead of recalculating it for each page, and use simple arithmetics
> to get from the physical address to Xen page size aligned chunks.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm/xen/mm.c | 61 ++++++++++++++++-------------------------------
>  1 file changed, 21 insertions(+), 40 deletions(-)
> 
> diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
> index 90574d89d0d4..2fde161733b0 100644
> --- a/arch/arm/xen/mm.c
> +++ b/arch/arm/xen/mm.c
> @@ -35,64 +35,45 @@ unsigned long xen_get_swiotlb_free_pages(unsigned int order)
>  	return __get_free_pages(flags, order);
>  }
>  
> -enum dma_cache_op {
> -       DMA_UNMAP,
> -       DMA_MAP,
> -};
>  static bool hypercall_cflush = false;
>  
> -/* functions called by SWIOTLB */
> -
> -static void dma_cache_maint(dma_addr_t handle, unsigned long offset,
> -	size_t size, enum dma_data_direction dir, enum dma_cache_op op)
> +/* buffers in highmem or foreign pages cannot cross page boundaries */
> +static void dma_cache_maint(dma_addr_t handle, size_t size, u32 op)
>  {
>  	struct gnttab_cache_flush cflush;
> -	unsigned long xen_pfn;
> -	size_t left = size;
>  
> -	xen_pfn = (handle >> XEN_PAGE_SHIFT) + offset / XEN_PAGE_SIZE;
> -	offset %= XEN_PAGE_SIZE;
> +	cflush.a.dev_bus_addr = handle & XEN_PAGE_MASK;
> +	cflush.offset = xen_offset_in_page(handle);
> +	cflush.op = op;
>  
>  	do {
> -		size_t len = left;
> -	
> -		/* buffers in highmem or foreign pages cannot cross page
> -		 * boundaries */
> -		if (len + offset > XEN_PAGE_SIZE)
> -			len = XEN_PAGE_SIZE - offset;
> -
> -		cflush.op = 0;
> -		cflush.a.dev_bus_addr = xen_pfn << XEN_PAGE_SHIFT;
> -		cflush.offset = offset;
> -		cflush.length = len;
> -
> -		if (op == DMA_UNMAP && dir != DMA_TO_DEVICE)
> -			cflush.op = GNTTAB_CACHE_INVAL;
> -		if (op == DMA_MAP) {
> -			if (dir == DMA_FROM_DEVICE)
> -				cflush.op = GNTTAB_CACHE_INVAL;
> -			else
> -				cflush.op = GNTTAB_CACHE_CLEAN;
> -		}
> -		if (cflush.op)
> -			HYPERVISOR_grant_table_op(GNTTABOP_cache_flush, &cflush, 1);
> +		if (size + cflush.offset > XEN_PAGE_SIZE)
> +			cflush.length = XEN_PAGE_SIZE - cflush.offset;
> +		else
> +			cflush.length = size;
> +
> +		HYPERVISOR_grant_table_op(GNTTABOP_cache_flush, &cflush, 1);
>  
> -		offset = 0;
> -		xen_pfn++;
> -		left -= len;
> -	} while (left);
> +		cflush.offset = 0;
> +		cflush.a.dev_bus_addr += cflush.length;
> +		size -= cflush.length;

Yes that's better

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> +	} while (size);
>  }
>  
>  static void __xen_dma_page_dev_to_cpu(struct device *hwdev, dma_addr_t handle,
>  		size_t size, enum dma_data_direction dir)
>  {
> -	dma_cache_maint(handle & PAGE_MASK, handle & ~PAGE_MASK, size, dir, DMA_UNMAP);
> +	if (dir != DMA_TO_DEVICE)
> +		dma_cache_maint(handle, size, GNTTAB_CACHE_INVAL);
>  }
>  
>  static void __xen_dma_page_cpu_to_dev(struct device *hwdev, dma_addr_t handle,
>  		size_t size, enum dma_data_direction dir)
>  {
> -	dma_cache_maint(handle & PAGE_MASK, handle & ~PAGE_MASK, size, dir, DMA_MAP);
> +	if (dir == DMA_FROM_DEVICE)
> +		dma_cache_maint(handle, size, GNTTAB_CACHE_INVAL);
> +	else
> +		dma_cache_maint(handle, size, GNTTAB_CACHE_CLEAN);
>  }
>  
>  void __xen_dma_map_page(struct device *hwdev, struct page *page,
> -- 
> 2.20.1
> 
