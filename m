Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5079D10B314
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 17:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfK0QUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 11:20:24 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2128 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726514AbfK0QUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 11:20:24 -0500
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id F114EA7B67EB051CEB9B;
        Wed, 27 Nov 2019 16:20:21 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML713-CAH.china.huawei.com (10.201.108.36) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 27 Nov 2019 16:20:21 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 27 Nov
 2019 16:20:21 +0000
Subject: Re: [PATCH] iommu/arm-smmu: support SMMU module probing from the IORT
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
CC:     <will@kernel.org>, <bhelgaas@google.com>,
        <gregkh@linuxfoundation.org>, <iommu@lists.linuxfoundation.org>,
        <isaacm@codeaurora.org>, <jcrouse@codeaurora.org>,
        <jean-philippe@linaro.org>, <joro@8bytes.org>,
        <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>,
        <saravanak@google.com>
References: <20191121114918.2293-1-will@kernel.org>
 <20191122174125.21030-1-ardb@kernel.org>
 <20191125160445.GA24078@e121166-lin.cambridge.arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <bf5b8665-c599-511c-25d2-f9ebadb41870@huawei.com>
Date:   Wed, 27 Nov 2019 16:20:20 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191125160445.GA24078@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2019 16:04, Lorenzo Pieralisi wrote:
> On Fri, Nov 22, 2019 at 06:41:25PM +0100, Ard Biesheuvel wrote:
>> Add support for SMMU drivers built as modules to the ACPI/IORT device
>> probing path, by deferring the probe of the master if the SMMU driver is
>> known to exist but has not been loaded yet. Given that the IORT code
>> registers a platform device for each SMMU that it discovers, we can
>> easily trigger the udev based autoloading of the SMMU drivers by making
>> the platform device identifier part of the module alias.
>>
>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>> ---
>>   drivers/acpi/arm64/iort.c   | 4 ++--
>>   drivers/iommu/arm-smmu-v3.c | 1 +
>>   drivers/iommu/arm-smmu.c    | 1 +
>>   3 files changed, 4 insertions(+), 2 deletions(-)
> 
> I think it is best if Will picks this up and add it to the
> series that modularize the SMMU drivers:
> 
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Tested-by: John Garry <john.garry@huawei.com> # only manual smmu ko loading

> 
>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>> index 5a7551d060f2..a696457a9b11 100644
>> --- a/drivers/acpi/arm64/iort.c
>> +++ b/drivers/acpi/arm64/iort.c
>> @@ -850,9 +850,9 @@ static inline bool iort_iommu_driver_enabled(u8 type)
>>   {
>>   	switch (type) {
>>   	case ACPI_IORT_NODE_SMMU_V3:
>> -		return IS_BUILTIN(CONFIG_ARM_SMMU_V3);
>> +		return IS_ENABLED(CONFIG_ARM_SMMU_V3);
>>   	case ACPI_IORT_NODE_SMMU:
>> -		return IS_BUILTIN(CONFIG_ARM_SMMU);
>> +		return IS_ENABLED(CONFIG_ARM_SMMU);
>>   	default:
>>   		pr_warn("IORT node type %u does not describe an SMMU\n", type);
>>   		return false;
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index 7669beafc493..bf6a1e8eb9b0 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -3733,4 +3733,5 @@ module_platform_driver(arm_smmu_driver);
>>   
>>   MODULE_DESCRIPTION("IOMMU API for ARM architected SMMUv3 implementations");
>>   MODULE_AUTHOR("Will Deacon <will@kernel.org>");
>> +MODULE_ALIAS("platform:arm-smmu-v3");
>>   MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index d55acc48aee3..db5106b0955b 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -2292,4 +2292,5 @@ module_platform_driver(arm_smmu_driver);
>>   
>>   MODULE_DESCRIPTION("IOMMU API for ARM architected SMMU implementations");
>>   MODULE_AUTHOR("Will Deacon <will@kernel.org>");
>> +MODULE_ALIAS("platform:arm-smmu");
>>   MODULE_LICENSE("GPL v2");
>> -- 
>> 2.20.1
>>
> .
> 

