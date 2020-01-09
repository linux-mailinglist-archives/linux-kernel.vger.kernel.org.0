Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD2F6135A00
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 14:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731035AbgAINXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 08:23:17 -0500
Received: from foss.arm.com ([217.140.110.172]:58962 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727861AbgAINXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 08:23:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C00EE31B;
        Thu,  9 Jan 2020 05:23:16 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DAA833F534;
        Thu,  9 Jan 2020 05:23:15 -0800 (PST)
Subject: Re: [PATCH] iommu/arm-smmu-v3: fix resource_size check
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
References: <20191226095056.30256-1-yamada.masahiro@socionext.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <2cd8ed11-56df-b46b-aa21-5ecc0e2e3082@arm.com>
Date:   Thu, 9 Jan 2020 13:23:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191226095056.30256-1-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/12/2019 9:50 am, Masahiro Yamada wrote:
> This is an off-by-one mistake.
> 
> resource_size() returns res->end - res->start + 1.

Heh, despite the optimism of "Avoid one-off errors by introducing a 
resource_size() function", life finds a way...

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>   drivers/iommu/arm-smmu-v3.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index d9e0d9c19b4f..b463599559d2 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -3599,7 +3599,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>   
>   	/* Base address */
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (resource_size(res) + 1 < arm_smmu_resource_size(smmu)) {
> +	if (resource_size(res) < arm_smmu_resource_size(smmu)) {
>   		dev_err(dev, "MMIO region too small (%pr)\n", res);
>   		return -EINVAL;
>   	}
> 
