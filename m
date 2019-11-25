Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0B1108DB3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2019 13:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfKYMQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 07:16:58 -0500
Received: from foss.arm.com ([217.140.110.172]:49588 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbfKYMQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 07:16:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D0BF31B;
        Mon, 25 Nov 2019 04:16:57 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F28363F52E;
        Mon, 25 Nov 2019 04:16:55 -0800 (PST)
Subject: Re: [PATCH] iommu/arm-smmu: support SMMU module probing from the IORT
To:     Ard Biesheuvel <ardb@kernel.org>, will@kernel.org
Cc:     bhelgaas@google.com, gregkh@linuxfoundation.org,
        iommu@lists.linuxfoundation.org, isaacm@codeaurora.org,
        jcrouse@codeaurora.org, jean-philippe@linaro.org,
        john.garry@huawei.com, joro@8bytes.org,
        linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com,
        saravanak@google.com
References: <20191121114918.2293-1-will@kernel.org>
 <20191122174125.21030-1-ardb@kernel.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <37aa4c74-b29a-637c-e434-287089f1e170@arm.com>
Date:   Mon, 25 Nov 2019 12:16:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191122174125.21030-1-ardb@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2019 5:41 pm, Ard Biesheuvel wrote:
> Add support for SMMU drivers built as modules to the ACPI/IORT device
> probing path, by deferring the probe of the master if the SMMU driver is
> known to exist but has not been loaded yet. Given that the IORT code
> registers a platform device for each SMMU that it discovers, we can
> easily trigger the udev based autoloading of the SMMU drivers by making
> the platform device identifier part of the module alias.

Thanks Ard, I was just gearing up to check the ACPI fallout myself :)

AFAICS this looks sufficient to avoid any unexpected behaviour if users 
start playing with the rest of the series on ACPI systems, so we can 
investigate 'proper' device links for IORT at some point in future.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>   drivers/acpi/arm64/iort.c   | 4 ++--
>   drivers/iommu/arm-smmu-v3.c | 1 +
>   drivers/iommu/arm-smmu.c    | 1 +
>   3 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 5a7551d060f2..a696457a9b11 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -850,9 +850,9 @@ static inline bool iort_iommu_driver_enabled(u8 type)
>   {
>   	switch (type) {
>   	case ACPI_IORT_NODE_SMMU_V3:
> -		return IS_BUILTIN(CONFIG_ARM_SMMU_V3);
> +		return IS_ENABLED(CONFIG_ARM_SMMU_V3);
>   	case ACPI_IORT_NODE_SMMU:
> -		return IS_BUILTIN(CONFIG_ARM_SMMU);
> +		return IS_ENABLED(CONFIG_ARM_SMMU);
>   	default:
>   		pr_warn("IORT node type %u does not describe an SMMU\n", type);
>   		return false;
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 7669beafc493..bf6a1e8eb9b0 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -3733,4 +3733,5 @@ module_platform_driver(arm_smmu_driver);
>   
>   MODULE_DESCRIPTION("IOMMU API for ARM architected SMMUv3 implementations");
>   MODULE_AUTHOR("Will Deacon <will@kernel.org>");
> +MODULE_ALIAS("platform:arm-smmu-v3");
>   MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index d55acc48aee3..db5106b0955b 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -2292,4 +2292,5 @@ module_platform_driver(arm_smmu_driver);
>   
>   MODULE_DESCRIPTION("IOMMU API for ARM architected SMMU implementations");
>   MODULE_AUTHOR("Will Deacon <will@kernel.org>");
> +MODULE_ALIAS("platform:arm-smmu");
>   MODULE_LICENSE("GPL v2");
> 
