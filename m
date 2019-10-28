Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E681DE73A9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 15:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390088AbfJ1O3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 10:29:54 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53402 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727148AbfJ1O3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 10:29:53 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 046DD41B2FBE9E855C1C;
        Mon, 28 Oct 2019 22:29:49 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Mon, 28 Oct 2019
 22:29:47 +0800
Subject: Re: [PATCH 3/3] drm/amd/powerplay: Make two functions static
To:     Alex Deucher <alexdeucher@gmail.com>
References: <20191028133621.21400-1-yuehaibing@huawei.com>
 <CADnq5_Ow+W_Syo6G3ZUXJeiLbc4YU=DL1FtznaTKm=RGj4tq1g@mail.gmail.com>
CC:     Rex Zhu <rex.zhu@amd.com>, "Quan, Evan" <evan.quan@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Maling list - DRI developers" <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <afe3b6b3-ef75-50be-f133-f7febdc9e01a@huawei.com>
Date:   Mon, 28 Oct 2019 22:29:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_Ow+W_Syo6G3ZUXJeiLbc4YU=DL1FtznaTKm=RGj4tq1g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/10/28 22:06, Alex Deucher wrote:
> On Mon, Oct 28, 2019 at 9:37 AM YueHaibing <yuehaibing@huawei.com> wrote:
>>
>> Fix sparse warnings:
>>
>> drivers/gpu/drm/amd/amdgpu/../powerplay/arcturus_ppt.c:2050:5:
>>  warning: symbol 'arcturus_i2c_eeprom_control_init' was not declared. Should it be static?
>> drivers/gpu/drm/amd/amdgpu/../powerplay/arcturus_ppt.c:2068:6:
>>  warning: symbol 'arcturus_i2c_eeprom_control_fini' was not declared. Should it be static?
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> Applied.  Thanks.  Is there more to this series?  I don't see patches 1 or 2.

No, only this one. I forget to change the patch title. Sorry for confusion.
> 
> Alex
> 
>> ---
>>  drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
>> index d48a49d..3099ac2 100644
>> --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
>> +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
>> @@ -2047,7 +2047,7 @@ static const struct i2c_algorithm arcturus_i2c_eeprom_i2c_algo = {
>>         .functionality = arcturus_i2c_eeprom_i2c_func,
>>  };
>>
>> -int arcturus_i2c_eeprom_control_init(struct i2c_adapter *control)
>> +static int arcturus_i2c_eeprom_control_init(struct i2c_adapter *control)
>>  {
>>         struct amdgpu_device *adev = to_amdgpu_device(control);
>>         int res;
>> @@ -2065,7 +2065,7 @@ int arcturus_i2c_eeprom_control_init(struct i2c_adapter *control)
>>         return res;
>>  }
>>
>> -void arcturus_i2c_eeprom_control_fini(struct i2c_adapter *control)
>> +static void arcturus_i2c_eeprom_control_fini(struct i2c_adapter *control)
>>  {
>>         i2c_del_adapter(control);
>>  }
>> --
>> 2.7.4
>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> 
> .
> 

