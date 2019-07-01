Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 929D94F614
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2019 15:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfFVN4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jun 2019 09:56:09 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51362 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726136AbfFVN4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 09:56:09 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8BA39B392CC39294426D;
        Sat, 22 Jun 2019 21:56:03 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.96) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Sat, 22 Jun 2019
 21:56:01 +0800
Subject: Re: [PATCH -next v2] drm/amdgpu: return 'ret' in amdgpu_pmu_init
To:     Julia Lawall <julia.lawall@lip6.fr>
References: <20190622104318.GT28859@kadam>
 <20190622130527.182022-1-maowenan@huawei.com>
 <alpine.DEB.2.21.1906221504110.3253@hadrien>
CC:     <airlied@linux.ie>, <daniel@ffwll.ch>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <David1.Zhou@amd.com>,
        <dan.carpenter@oracle.com>, <kernel-janitors@vger.kernel.org>,
        <amd-gfx@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
From:   maowenan <maowenan@huawei.com>
Message-ID: <063c9726-8f16-f9b7-2d16-bc87a99085bb@huawei.com>
Date:   Sat, 22 Jun 2019 21:56:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1906221504110.3253@hadrien>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.96.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/6/22 21:06, Julia Lawall wrote:
> 
> 
> On Sat, 22 Jun 2019, Mao Wenan wrote:
> 
>> There is one warning:
>> drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c: In function ‘amdgpu_pmu_init’:
>> drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c:249:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
>>   int ret = 0;
>>       ^
>> amdgpu_pmu_init() is called by amdgpu_device_init() in drivers/gpu/drm/amd/amdgpu/amdgpu_device.c,
>> which will use the return value. So it returns 'ret' for caller.
>> amdgpu_device_init()
>> 	r = amdgpu_pmu_init(adev);
>>
>> Fixes: 9c7c85f7ea1f ("drm/amdgpu: add pmu counters")
>>
>> Signed-off-by: Mao Wenan <maowenan@huawei.com>
>> ---
>>  v1->v2: change the subject for this patch; change the indenting when it calls init_pmu_by_type; use the value 'ret' in
>>  amdgpu_pmu_init().
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
>> index 0e6dba9..145e720 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
>> @@ -252,8 +252,8 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)
>>  	case CHIP_VEGA20:
>>  		/* init df */
>>  		ret = init_pmu_by_type(adev, df_v3_6_attr_groups,
>> -				       "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,
>> -				       DF_V3_6_MAX_COUNTERS);
>> +							   "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,
>> +							   DF_V3_6_MAX_COUNTERS);
>>
>>  		/* other pmu types go here*/
> 
> I don't know what is the impact of the other pmu types that are planned
> for the future.  Perhaps it would be better to abort the function
> immediately in the case of a failure.

I guess it would be better to use new function or new switch case clause to process different PMU types
in future.

> 
> julia
> 
>>  		break;
>> @@ -261,7 +261,7 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)
>>  		return 0;
>>  	}
>>
>> -	return 0;
>> +	return ret;
>>  }
>>
>>
>> --
>> 2.7.4
>>
>>
> 

