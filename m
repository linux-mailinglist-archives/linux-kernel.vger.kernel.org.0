Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFF920464
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 13:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfEPLQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 07:16:45 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42190 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727024AbfEPLQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 07:16:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4641219BF;
        Thu, 16 May 2019 04:16:44 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45FD93F71E;
        Thu, 16 May 2019 04:16:42 -0700 (PDT)
Subject: Re: [PATCH v3 6/7] iommu: Introduce IOMMU_RESV_DIRECT_RELAXABLE
 reserved memory regions
To:     Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
        joro@8bytes.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, dwmw2@infradead.org,
        lorenzo.pieralisi@arm.com, robin.murphy@arm.com,
        will.deacon@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com
Cc:     alex.williamson@redhat.com
References: <20190516100817.12076-1-eric.auger@redhat.com>
 <20190516100817.12076-7-eric.auger@redhat.com>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <3e21e370-135e-2eab-dd99-50e19cd53b86@arm.com>
Date:   Thu, 16 May 2019 12:16:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516100817.12076-7-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2019 11:08, Eric Auger wrote:
> Note: At the moment the sysfs ABI is not changed. However I wonder
> whether it wouldn't be preferable to report the direct region as
> "direct_relaxed" there. At the moment, in case the same direct
> region is used by 2 devices, one USB/GFX and another not belonging
> to the previous categories, the direct region will be output twice
> with "direct" type.
> 
> This would unblock Shameer's series:
> [PATCH v6 0/7] vfio/type1: Add support for valid iova list management
> https://patchwork.kernel.org/patch/10425309/

Thanks for doing this!

> which failed to get pulled for 4.18 merge window due to IGD
> device assignment regression.
> 
> v2 -> v3:
> - fix direct type check
> ---
>  drivers/iommu/iommu.c | 12 +++++++-----
>  include/linux/iommu.h |  6 ++++++
>  2 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index ae4ea5c0e6f9..28c3d6351832 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -73,10 +73,11 @@ struct iommu_group_attribute {
>  };
>  
>  static const char * const iommu_group_resv_type_string[] = {
> -	[IOMMU_RESV_DIRECT]	= "direct",
> -	[IOMMU_RESV_RESERVED]	= "reserved",
> -	[IOMMU_RESV_MSI]	= "msi",
> -	[IOMMU_RESV_SW_MSI]	= "msi",
> +	[IOMMU_RESV_DIRECT]			= "direct",
> +	[IOMMU_RESV_DIRECT_RELAXABLE]		= "direct",
> +	[IOMMU_RESV_RESERVED]			= "reserved",
> +	[IOMMU_RESV_MSI]			= "msi",
> +	[IOMMU_RESV_SW_MSI]			= "msi",
>  };
>  
>  #define IOMMU_GROUP_ATTR(_name, _mode, _show, _store)		\
> @@ -573,7 +574,8 @@ static int iommu_group_create_direct_mappings(struct iommu_group *group,
>  		start = ALIGN(entry->start, pg_size);
>  		end   = ALIGN(entry->start + entry->length, pg_size);
>  
> -		if (entry->type != IOMMU_RESV_DIRECT)
> +		if (entry->type != IOMMU_RESV_DIRECT &&
> +		    entry->type != IOMMU_RESV_DIRECT_RELAXABLE)

I'm trying to understand why you need to create direct mappings at all
for these relaxable regions. In the host the region is needed for legacy
device features, which are disabled (and cannot be re-enabled) when
assigning the device to a guest?

Thanks,
Jean

