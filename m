Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC72BF4F6D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 16:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfKHPY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 10:24:59 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:46493 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726199AbfKHPY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 10:24:58 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iT687-0001XH-4B; Fri, 08 Nov 2019 16:24:55 +0100
To:     Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH 01/11] irqchip/gic-v3-its: Free collection mapping on  device teardown
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 08 Nov 2019 16:34:15 +0109
From:   Marc Zyngier <maz@kernel.org>
Cc:     <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        <lorenzo.pieralisi@arm.com>, <andrew.murray@arm.com>,
        Heyi Guo <guoheyi@huawei.com>
In-Reply-To: <5c3034c6-7593-64c0-0cbe-43dc6a184bbb@huawei.com>
References: <20191105162258.22214-1-maz@kernel.org>
 <20191105162258.22214-2-maz@kernel.org>
 <5c3034c6-7593-64c0-0cbe-43dc6a184bbb@huawei.com>
Message-ID: <ace82bd937c69b9d2e3a3a6284d5deb4@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, linux-kernel@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, lorenzo.pieralisi@arm.com, andrew.murray@arm.com, guoheyi@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zenghui,

On 2019-11-08 14:09, Zenghui Yu wrote:
> Hi Marc,
>
> On 2019/11/6 0:22, Marc Zyngier wrote:
>> Somehow, we forgot to free the collection mapping when tearing down
>> a device, hence slowly leaking mapping arrays as devices get removed
>> from the system. That is, almost never.
>> Just to be safe, properly free the array on device teardown.
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> ---
>>   drivers/irqchip/irq-gic-v3-its.c | 1 +
>>   1 file changed, 1 insertion(+)
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
>> b/drivers/irqchip/irq-gic-v3-its.c
>> index 787e8eec9a7f..07d0bde60e16 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -2471,6 +2471,7 @@ static void its_free_device(struct its_device 
>> *its_dev)
>>   	raw_spin_lock_irqsave(&its_dev->its->lock, flags);
>>   	list_del(&its_dev->entry);
>>   	raw_spin_unlock_irqrestore(&its_dev->its->lock, flags);
>> +	kfree(its_dev->event_map.col_map);
>
> I agreed that this is the appropriate place to free the collection
> mapping (act as the counterpart of the allocation which happened in
> its_create_device).  But as pointed out by Heyi [1], this will
> introduce a double free issue.  We'd better also drop the kfree()
> in its_irq_domain_free() in this patch?
>
> (I find that it had been dropped in the last patch in your
> irq/gic-5.5-wip branch, but maybe better here.)

Ah, that hunk is in a separate patch that I wasn't really
planning to send for this round. Let me fix the series (again)
and resend it...

Thanks for the heads up,

         M.
-- 
Jazz is not dead. It just smells funny...
