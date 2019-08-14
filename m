Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 538A08C532
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 02:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfHNAlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 20:41:52 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4683 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726533AbfHNAlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 20:41:52 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 509E972F8571B7ADFF66;
        Wed, 14 Aug 2019 08:41:48 +0800 (CST)
Received: from [127.0.0.1] (10.133.215.186) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Wed, 14 Aug 2019
 08:41:38 +0800
Subject: Re: [PATCH] iommu/arm-smmu-v3: add nr_ats_masters to avoid
 unnecessary operations
To:     Will Deacon <will@kernel.org>, John Garry <john.garry@huawei.com>
CC:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <jean-philippe@linaro.org>
References: <20190801122040.26024-1-thunder.leizhen@huawei.com>
 <b5866f7a-013a-5900-6fce-268052f2ba0a@huawei.com>
 <20190813171039.y64wslo4dzgyis3e@willie-the-truck>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <19e427af-7ff3-99a5-cfec-60ebce686cb2@huawei.com>
Date:   Wed, 14 Aug 2019 08:41:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190813171039.y64wslo4dzgyis3e@willie-the-truck>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.215.186]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/8/14 1:10, Will Deacon wrote:
> On Mon, Aug 12, 2019 at 11:42:17AM +0100, John Garry wrote:
>> On 01/08/2019 13:20, Zhen Lei wrote:
>>> When (smmu_domain->smmu->features & ARM_SMMU_FEAT_ATS) is true, even if a
>>> smmu domain does not contain any ats master, the operations of
>>> arm_smmu_atc_inv_to_cmd() and lock protection in arm_smmu_atc_inv_domain()
>>> are always executed. This will impact performance, especially in
>>> multi-core and stress scenarios. For my FIO test scenario, about 8%
>>> performance reduced.
>>>
>>> In fact, we can use a atomic member to record how many ats masters the
>>> smmu contains. And check that without traverse the list and check all
>>> masters one by one in the lock protection.
>>>
>>
>> Hi Will, Robin, Jean-Philippe,
>>
>> Can you kindly check this issue? We have seen a signifigant performance
>> regression here.
> 
> Sorry, John: Robin and Jean-Philippe are off at the moment and I've been
> swamped dealing with the arm64 queue. I'll try to get to this tomorrow.

Hi, all:
   I found my patch have some mistake, see below. I'm sorry I didn't see this coupling. 
I'm preparing v2. 

> @@ -1915,10 +1921,10 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
>  	list_del(&master->domain_head);
>  	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
>  
> -	master->domain = NULL;
>  	arm_smmu_install_ste_for_dev(master);

"master->domain = NULL" is needed in arm_smmu_install_ste_for_dev().

>  
>  	arm_smmu_disable_ats(master);
> +	master->domain = NULL;
>  }

> 
> Will
> 
> .
> 

