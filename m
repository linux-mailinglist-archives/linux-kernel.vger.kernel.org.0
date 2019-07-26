Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB8EB75F0C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 08:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbfGZG2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 02:28:54 -0400
Received: from verein.lst.de ([213.95.11.211]:41795 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbfGZG2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 02:28:53 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CA18068B02; Fri, 26 Jul 2019 08:28:49 +0200 (CEST)
Date:   Fri, 26 Jul 2019 08:28:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     dafna.hirschfeld@collabora.com, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dma-contiguous: do not overwrite align in
 dma_alloc_contiguous()
Message-ID: <20190726062849.GE22881@lst.de>
References: <20190725233959.15129-1-nicoleotsuka@gmail.com> <20190725233959.15129-2-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725233959.15129-2-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 04:39:58PM -0700, Nicolin Chen wrote:
> The dma_alloc_contiguous() limits align at CONFIG_CMA_ALIGNMENT for
> cma_alloc() however it does not restore it for the fallback routine.
> This will result in a size mismatch between the allocation and free
> when running in the fallback routines, if the align is larger than
> CONFIG_CMA_ALIGNMENT.
> 
> This patch adds a cma_align to take care of cma_alloc() and prevent
> the align from being overwritten.
> 
> Fixes: fdaeec198ada ("dma-contiguous: add dma_{alloc,free}_contiguous() helpers")
> Reported-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>  kernel/dma/contiguous.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index bfc0c17f2a3d..fa8cd0f0512e 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -233,6 +233,7 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
>  	int node = dev ? dev_to_node(dev) : NUMA_NO_NODE;
>  	size_t count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>  	size_t align = get_order(PAGE_ALIGN(size));
> +	size_t cma_align = CONFIG_CMA_ALIGNMENT;
>  	struct page *page = NULL;
>  	struct cma *cma = NULL;
>  
> @@ -241,11 +242,11 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
>  	else if (count > 1)
>  		cma = dma_contiguous_default_area;
>  
> +	cma_align = min_t(size_t, align, cma_align);
> +
>  	/* CMA can be used only in the context which permits sleeping */
> -	if (cma && gfpflags_allow_blocking(gfp)) {
> -		align = min_t(size_t, align, CONFIG_CMA_ALIGNMENT);
> -		page = cma_alloc(cma, count, align, gfp & __GFP_NOWARN);
> -	}
> +	if (cma && gfpflags_allow_blocking(gfp))
> +		page = cma_alloc(cma, count, cma_align, gfp & __GFP_NOWARN);

Shouldn't cma_align be confined to the block guarded by
"if (cma && gfpflags_allow_blocking(gfp))" so that we can optimize it
away for configurations that do not support CMA?
