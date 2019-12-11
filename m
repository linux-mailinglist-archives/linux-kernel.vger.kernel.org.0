Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA1411A46D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 07:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfLKGWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 01:22:43 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:43406 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726357AbfLKGWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 01:22:43 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 996C79077831BCF46300;
        Wed, 11 Dec 2019 14:22:40 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Wed, 11 Dec 2019
 14:22:31 +0800
Subject: Re: [PATCH] perf/smmuv3: Remove the leftover put_cpu() in error path
To:     Will Deacon <will@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1575974784-55046-1-git-send-email-guohanjun@huawei.com>
 <20191210132458.GA19183@willie-the-truck>
 <d251a136-2722-93ba-1bea-0000bf257db2@huawei.com>
 <20191210141029.GB19183@willie-the-truck>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <7dd33c04-3755-3eb6-d310-8e40207b16d9@huawei.com>
Date:   Wed, 11 Dec 2019 14:22:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20191210141029.GB19183@willie-the-truck>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/12/10 22:10, Will Deacon wrote:
> On Tue, Dec 10, 2019 at 09:55:28PM +0800, Hanjun Guo wrote:
>> On 2019/12/10 21:24, Will Deacon wrote:
>>> On Tue, Dec 10, 2019 at 06:46:24PM +0800, Hanjun Guo wrote:
>>>> In smmu_pmu_probe(), there is put_cpu() in the error path,
>>>> which is wrong because we use raw_smp_processor_id() to
>>>> get the cpu ID, not get_cpu(), remove it.
>>>>
>>>> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
>>>> ---
>>>>  drivers/perf/arm_smmuv3_pmu.c | 1 -
>>>>  1 file changed, 1 deletion(-)
>>>>
>>>> diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
>>>> index 773128f..fd1d46a 100644
>>>> --- a/drivers/perf/arm_smmuv3_pmu.c
>>>> +++ b/drivers/perf/arm_smmuv3_pmu.c
>>>> @@ -834,7 +834,6 @@ static int smmu_pmu_probe(struct platform_device *pdev)
>>>>  out_unregister:
>>>>  	cpuhp_state_remove_instance_nocalls(cpuhp_state_num, &smmu_pmu->node);
>>>>  out_cpuhp_err:
>>>> -	put_cpu();
>>>>  	return err;
>>>
>>> Can we kill 'out_cpuhp_err' altogether then and just return err if we fail
>>> to add the hotplug instance?
>>
>> Makes sense, but I think we can go further to kill both 'out_cpuhp_err' and
>> 'out_register' as below [1], what do you think?
> 
> Although that's functionally correct, I'd prefer to keep out_unregister(),
> since it acts as good reminder to anybody extending this function in future
> that they need to unregister the hotplug instance on failure.

OK, I will add Robin's ACK and resend.

Thanks
Hanjun

