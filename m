Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0576A49C17
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 10:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbfFRIgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 04:36:12 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18635 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725913AbfFRIgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 04:36:11 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 93B4A53BE9FF0D970C0F;
        Tue, 18 Jun 2019 16:36:02 +0800 (CST)
Received: from [127.0.0.1] (10.133.217.137) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Tue, 18 Jun 2019
 16:35:55 +0800
Subject: Re: [PATCH] irqchip/mbigen: stop printing kernel addresses
To:     Marc Zyngier <marc.zyngier@arm.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        <linux-kernel@vger.kernel.org>, <guohanjun@huawei.com>
References: <20190618032202.11087-1-wangkefeng.wang@huawei.com>
 <86h88npc47.wl-marc.zyngier@arm.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <d529faf2-9edd-8362-c208-fd1902d539e7@huawei.com>
Date:   Tue, 18 Jun 2019 16:35:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <86h88npc47.wl-marc.zyngier@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.217.137]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/6/18 15:48, Marc Zyngier wrote:
> Hi Kefeng,
> 
> On Tue, 18 Jun 2019 04:22:02 +0100,
> Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>>
>> After commit ad67b74d2469d9b8 ("printk: hash addresses printed with %p"),
>> it will print "____ptrval____" instead of actual addresses when mbigen
>> create domain fails,
>>
>>   Hisilicon MBIGEN-V2 HISI0152:00: Failed to create mbi-gen@(____ptrval____) irqdomain
>>   Hisilicon MBIGEN-V2: probe of HISI0152:00 failed with error -12
>>
>> Instead of changing the print to "%px", and leaking kernel addresses,
>> just remove the print completely.
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>  drivers/irqchip/irq-mbigen.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
>> index 98b6e1d4b1a6..d0cf596c801b 100644
>> --- a/drivers/irqchip/irq-mbigen.c
>> +++ b/drivers/irqchip/irq-mbigen.c
>> @@ -355,8 +355,7 @@ static int mbigen_device_probe(struct platform_device *pdev)
>>  		err = -EINVAL;
>>  
>>  	if (err) {
>> -		dev_err(&pdev->dev, "Failed to create mbi-gen@%p irqdomain",
>> -			mgn_chip->base);
>> +		dev_err(&pdev->dev, "Failed to create mbi-gen irqdomain");
> 
> The alternative would be to print res as a resource, which would still
> help identifying the offending device by printing its physical
> layout, and still not reveal much.

It's better to print res to show the physical layout, and add missing "\n",
will resend v2.

Thanks.

> 
> Just let me know what you prefer.
> 
> Thanks,
> 
> 	M.
> 
>>  		return err;
>>  	}
>>  
>> -- 
>> 2.20.1
>>
> 

