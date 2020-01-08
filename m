Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10F2D13446B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 14:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbgAHN70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 08:59:26 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9135 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726699AbgAHN70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 08:59:26 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CDE15511EA4AE1C5E960;
        Wed,  8 Jan 2020 21:59:23 +0800 (CST)
Received: from [127.0.0.1] (10.177.131.64) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Wed, 8 Jan 2020
 21:59:19 +0800
Subject: Re: [PATCH next] drm/i915/gtt: add missing include file asm/smp.h
To:     Jani Nikula <jani.nikula@linux.intel.com>, <airlied@linux.ie>,
        <chris@chris-wilson.co.uk>
References: <20200108133610.92714-1-chenzhou10@huawei.com>
 <877e22qczw.fsf@intel.com>
CC:     <intel-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
From:   Chen Zhou <chenzhou10@huawei.com>
Message-ID: <6081a507-c11a-749e-df6a-c59649ee5d65@huawei.com>
Date:   Wed, 8 Jan 2020 21:59:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <877e22qczw.fsf@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.131.64]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/1/8 21:44, Jani Nikula wrote:
> On Wed, 08 Jan 2020, Chen Zhou <chenzhou10@huawei.com> wrote:
>> Fix build error:
>> lib/crypto/chacha.c: In function chacha_permute:
>> lib/crypto/chacha.c:65:1: warning: the frame size of 3384 bytes is larger than 2048 bytes [-Wframe-larger-than=]
>>  }
>>   ^
> 
> IMO this needs a better explanation of why not having the include leads
> to the above failure.
> 
> BR,
> Jani.
> 

Sorry, i made a mistake. The error is as follows:

drivers/gpu/drm/i915/gt/intel_ggtt.c: In function ggtt_restore_mappings:
drivers/gpu/drm/i915/gt/intel_ggtt.c:1239:3: error: implicit declaration of function wbinvd_on_all_cpus; did you mean wrmsr_on_cpus? [-Werror=implicit-function-declaration]
   wbinvd_on_all_cpus();
   ^~~~~~~~~~~~~~~~~~
   wrmsr_on_cpus


Thanks,
Chen Zhou

>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
>> ---
>>  drivers/gpu/drm/i915/gt/intel_ggtt.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/i915/gt/intel_ggtt.c b/drivers/gpu/drm/i915/gt/intel_ggtt.c
>> index 1a2b5dc..9ef8ed8 100644
>> --- a/drivers/gpu/drm/i915/gt/intel_ggtt.c
>> +++ b/drivers/gpu/drm/i915/gt/intel_ggtt.c
>> @@ -6,6 +6,7 @@
>>  #include <linux/stop_machine.h>
>>  
>>  #include <asm/set_memory.h>
>> +#include <asm/smp.h>
>>  
>>  #include "intel_gt.h"
>>  #include "i915_drv.h"
> 

