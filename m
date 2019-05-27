Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3812B895
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 17:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfE0PrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 11:47:15 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59835 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfE0PrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 11:47:15 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 72102804CA; Mon, 27 May 2019 17:47:02 +0200 (CEST)
Date:   Mon, 27 May 2019 17:46:47 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 4.19 049/114] iommu/tegra-smmu: Fix invalid ASID bits on
 Tegra30/114
Message-ID: <20190527154647.GA4050@xo-6d-61-c0.localdomain>
References: <20190523181731.372074275@linuxfoundation.org>
 <20190523181736.156742338@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523181736.156742338@linuxfoundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-05-23 21:05:48, Greg Kroah-Hartman wrote:
> From: Dmitry Osipenko <digetx@gmail.com>
> 
> commit 43a0541e312f7136e081e6bf58f6c8a2e9672688 upstream.
> 
> Both Tegra30 and Tegra114 have 4 ASID's and the corresponding bitfield of
> the TLB_FLUSH register differs from later Tegra generations that have 128
> ASID's.
> 
> In a result the PTE's are now flushed correctly from TLB and this fixes
> problems with graphics (randomly failing tests) on Tegra30.


Three copies of same code... maybe its time to introduce helper function?

> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -102,7 +102,6 @@ static inline u32 smmu_readl(struct tegr
>  #define  SMMU_TLB_FLUSH_VA_MATCH_ALL     (0 << 0)
>  #define  SMMU_TLB_FLUSH_VA_MATCH_SECTION (2 << 0)
>  #define  SMMU_TLB_FLUSH_VA_MATCH_GROUP   (3 << 0)
> -#define  SMMU_TLB_FLUSH_ASID(x)          (((x) & 0x7f) << 24)
>  #define  SMMU_TLB_FLUSH_VA_SECTION(addr) ((((addr) & 0xffc00000) >> 12) | \
>  					  SMMU_TLB_FLUSH_VA_MATCH_SECTION)
>  #define  SMMU_TLB_FLUSH_VA_GROUP(addr)   ((((addr) & 0xffffc000) >> 12) | \
> @@ -205,8 +204,12 @@ static inline void smmu_flush_tlb_asid(s
>  {
>  	u32 value;
>  
> -	value = SMMU_TLB_FLUSH_ASID_MATCH | SMMU_TLB_FLUSH_ASID(asid) |
> -		SMMU_TLB_FLUSH_VA_MATCH_ALL;
> +	if (smmu->soc->num_asids == 4)
> +		value = (asid & 0x3) << 29;
> +	else
> +		value = (asid & 0x7f) << 24;
> +
> +	value |= SMMU_TLB_FLUSH_ASID_MATCH | SMMU_TLB_FLUSH_VA_MATCH_ALL;
>  	smmu_writel(smmu, value, SMMU_TLB_FLUSH);
>  }
>  
> @@ -216,8 +219,12 @@ static inline void smmu_flush_tlb_sectio
>  {
>  	u32 value;
>  
> -	value = SMMU_TLB_FLUSH_ASID_MATCH | SMMU_TLB_FLUSH_ASID(asid) |
> -		SMMU_TLB_FLUSH_VA_SECTION(iova);
> +	if (smmu->soc->num_asids == 4)
> +		value = (asid & 0x3) << 29;
> +	else
> +		value = (asid & 0x7f) << 24;
> +
> +	value |= SMMU_TLB_FLUSH_ASID_MATCH | SMMU_TLB_FLUSH_VA_SECTION(iova);
>  	smmu_writel(smmu, value, SMMU_TLB_FLUSH);
>  }
>  
> @@ -227,8 +234,12 @@ static inline void smmu_flush_tlb_group(
>  {
>  	u32 value;
>  
> -	value = SMMU_TLB_FLUSH_ASID_MATCH | SMMU_TLB_FLUSH_ASID(asid) |
> -		SMMU_TLB_FLUSH_VA_GROUP(iova);
> +	if (smmu->soc->num_asids == 4)
> +		value = (asid & 0x3) << 29;
> +	else
> +		value = (asid & 0x7f) << 24;
> +
> +	value |= SMMU_TLB_FLUSH_ASID_MATCH | SMMU_TLB_FLUSH_VA_GROUP(iova);
>  	smmu_writel(smmu, value, SMMU_TLB_FLUSH);
>  }
>  
> 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
