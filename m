Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB36D05B0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 04:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730091AbfJICrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 22:47:31 -0400
Received: from mga02.intel.com ([134.134.136.20]:32127 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726490AbfJICrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 22:47:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2019 19:47:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,273,1566889200"; 
   d="scan'208";a="192748823"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga008.fm.intel.com with ESMTP; 08 Oct 2019 19:47:28 -0700
Cc:     baolu.lu@linux.intel.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] iommu/vt-d: Return the correct dma mask when we are
 bypassing the IOMMU
To:     Arvind Sankar <nivedita@alum.mit.edu>, linux-kernel@vger.kernel.org
References: <20191008143357.GA599223@rani.riverdale.lan>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <76d680ab-a454-4a69-597a-c0edbfc5014b@linux.intel.com>
Date:   Wed, 9 Oct 2019 10:45:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191008143357.GA599223@rani.riverdale.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/8/19 10:33 PM, Arvind Sankar wrote:
> We must return a mask covering the full physical RAM when bypassing the
> IOMMU mapping. Also, in iommu_need_mapping, we need to check using
> dma_direct_get_required_mask to ensure that the device's dma_mask can
> cover physical RAM before deciding to bypass IOMMU mapping.
> 
> Fixes: 249baa547901 ("dma-mapping: provide a better default ->get_required_mask")
> Reported-by: Arvind Sankar <nivedita@alum.mit.edu>
> Tested-by: Arvind Sankar <nivedita@alum.mit.edu>
> Originally-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Fixed-by: Arvind Sankar <nivedita@alum.mit.edu>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> ---
>   drivers/iommu/intel-iommu.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 3f974919d3bd..79e35b3180ac 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -3471,7 +3471,7 @@ static bool iommu_need_mapping(struct device *dev)
>   		if (dev->coherent_dma_mask && dev->coherent_dma_mask < dma_mask)
>   			dma_mask = dev->coherent_dma_mask;
>   
> -		if (dma_mask >= dma_get_required_mask(dev))
> +		if (dma_mask >= dma_direct_get_required_mask(dev))
>   			return false;
>   
>   		/*
> @@ -3775,6 +3775,13 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
>   	return nelems;
>   }
>   
> +static u64 intel_get_required_mask(struct device *dev)
> +{
> +	if (!iommu_need_mapping(dev))
> +		return dma_direct_get_required_mask(dev);
> +	return DMA_BIT_MASK(32);

Do you mind explaining why we always return 32 bit here?

Best regards,
Baolu

> +}
> +
>   static const struct dma_map_ops intel_dma_ops = {
>   	.alloc = intel_alloc_coherent,
>   	.free = intel_free_coherent,
> @@ -3787,6 +3794,7 @@ static const struct dma_map_ops intel_dma_ops = {
>   	.dma_supported = dma_direct_supported,
>   	.mmap = dma_common_mmap,
>   	.get_sgtable = dma_common_get_sgtable,
> +	.get_required_mask = intel_get_required_mask,
>   };
>   
>   static void
> 
