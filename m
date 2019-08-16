Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB3628FDD3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 10:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfHPIbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 04:31:22 -0400
Received: from foss.arm.com ([217.140.110.172]:53428 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbfHPIbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 04:31:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8992528;
        Fri, 16 Aug 2019 01:31:21 -0700 (PDT)
Received: from [10.1.196.133] (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CCE73F718;
        Fri, 16 Aug 2019 01:31:20 -0700 (PDT)
Subject: Re: [PATCH -next] drm/panfrost: Fix missing unlock on error in
 panfrost_mmu_map_fault_addr()
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20190814044814.102294-1-weiyongjun1@huawei.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <ee7063ab-6dd9-0854-3b25-0617d194bfec@arm.com>
Date:   Fri, 16 Aug 2019 09:31:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814044814.102294-1-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/2019 05:48, Wei Yongjun wrote:
> Add the missing unlock before return from function panfrost_mmu_map_fault_addr()
> in the error handling case.
> 
> Fixes: 187d2929206e ("drm/panfrost: Add support for GPU heap allocations")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Well spotted.

Reviewed-by: Steven Price <steven.price@arm.com>

Steve

> ---
>  drivers/gpu/drm/panfrost/panfrost_mmu.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> index 2ed411f09d80..06f1a563e940 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> @@ -327,14 +327,17 @@ int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as, u64 addr)
>  	if (!bo->base.pages) {
>  		bo->sgts = kvmalloc_array(bo->base.base.size / SZ_2M,
>  				     sizeof(struct sg_table), GFP_KERNEL | __GFP_ZERO);
> -		if (!bo->sgts)
> +		if (!bo->sgts) {
> +			mutex_unlock(&bo->base.pages_lock);
>  			return -ENOMEM;
> +		}
>  
>  		pages = kvmalloc_array(bo->base.base.size >> PAGE_SHIFT,
>  				       sizeof(struct page *), GFP_KERNEL | __GFP_ZERO);
>  		if (!pages) {
>  			kfree(bo->sgts);
>  			bo->sgts = NULL;
> +			mutex_unlock(&bo->base.pages_lock);
>  			return -ENOMEM;
>  		}
>  		bo->base.pages = pages;
> 
> 
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 

