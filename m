Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5858F761F1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 11:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfGZJYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 05:24:21 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35880 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725903AbfGZJYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 05:24:21 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 67D8CFC61B5C23688CC1;
        Fri, 26 Jul 2019 17:24:19 +0800 (CST)
Received: from [127.0.0.1] (10.74.221.148) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Fri, 26 Jul 2019
 17:24:13 +0800
Subject: Re: [PATCH] irqchip/gic-v3-its: Free unused vpt_page when alloc vpe
 table fail
To:     Marc Zyngier <marc.zyngier@arm.com>
References: <1564105905-15410-1-git-send-email-zhangshaokun@hisilicon.com>
 <20190726101844.79cb10b5@why>
CC:     <linux-kernel@vger.kernel.org>,
        Nianyao Tang <tangnianyao@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
From:   Zhangshaokun <zhangshaokun@hisilicon.com>
Message-ID: <d33b8161-3ed0-07d6-af8a-d7fcca47f300@hisilicon.com>
Date:   Fri, 26 Jul 2019 17:24:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <20190726101844.79cb10b5@why>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.221.148]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2019/7/26 17:18, Marc Zyngier wrote:
> On Fri, 26 Jul 2019 09:51:45 +0800
> Shaokun Zhang <zhangshaokun@hisilicon.com> wrote:
> 
>> From: Nianyao Tang <tangnianyao@huawei.com>
>>
>> In its_vpe_init, when its_alloc_vpe_table fails, we should free
>> vpt_page allocated just before, instead of vpe->vpt_page.
>> Let's fix it.
>>
>> Cc: Thomas Gleixner <tglx@linutronix.de> 
>> Cc: Jason Cooper <jason@lakedaemon.net>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Signed-off-by: Nianyao Tang <tangnianyao@huawei.com>
>> ---
>>  drivers/irqchip/irq-gic-v3-its.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index 730fbe0..1b5c367 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -3010,7 +3010,7 @@ static int its_vpe_init(struct its_vpe *vpe)
>>  
>>  	if (!its_alloc_vpe_table(vpe_id)) {
>>  		its_vpe_id_free(vpe_id);
>> -		its_free_pending_table(vpe->vpt_page);
>> +		its_free_pending_table(vpt_page);
>>  		return -ENOMEM;
>>  	}
>>  
> 
> Oops, well caught. Please repost this patch with your own SoB added
> though, as you're posting the patch on behalf of someone else.
> 

Thanks your reminder and I will do it in v2 version.

Shaokun

> Thanks,
> 
> 	M.
> 

