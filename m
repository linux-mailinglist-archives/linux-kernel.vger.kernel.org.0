Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D115495AD1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 11:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729573AbfHTJTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 05:19:01 -0400
Received: from foss.arm.com ([217.140.110.172]:37114 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728414AbfHTJTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 05:19:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5821344;
        Tue, 20 Aug 2019 02:18:59 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57B3B3F706;
        Tue, 20 Aug 2019 02:18:58 -0700 (PDT)
Subject: Re: [PATCH v2 04/12] irqchip/gic-v3: Add ESPI range support
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org
References: <20190806100121.240767-1-maz@kernel.org>
 <20190806100121.240767-5-maz@kernel.org>
 <9cbd6fc8-3fe9-39fc-10ca-724a1ec06e8d@huawei.com>
From:   Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <30fe07e9-0670-d755-2173-dc71549a797b@kernel.org>
Date:   Tue, 20 Aug 2019 10:18:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9cbd6fc8-3fe9-39fc-10ca-724a1ec06e8d@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/08/2019 15:25, Zenghui Yu wrote:
> Hi Marc,
> 
> On 2019/8/6 18:01, Marc Zyngier wrote:
>> Add the required support for the ESPI range, which behave exactly like
>> the SPIs of old, only with new funky INTIDs.
>>
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> ---
>>   drivers/irqchip/irq-gic-v3.c       | 85 ++++++++++++++++++++++++------
>>   include/linux/irqchip/arm-gic-v3.h | 17 +++++-
>>   2 files changed, 85 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
>> index db3bdedd7241..1ca4dde32034 100644
>> --- a/drivers/irqchip/irq-gic-v3.c
>> +++ b/drivers/irqchip/irq-gic-v3.c
>> @@ -51,13 +51,16 @@ struct gic_chip_data {
>>   	u32			nr_redist_regions;
>>   	u64			flags;
>>   	bool			has_rss;
>> -	unsigned int		irq_nr;
>>   	struct partition_desc	*ppi_descs[16];
>>   };
>>   
>>   static struct gic_chip_data gic_data __read_mostly;
>>   static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
>>   
>> +#define GIC_ID_NR	(1U << GICD_TYPER_ID_BITS(gic_data.rdists.gicd_typer))
>> +#define GIC_LINE_NR	GICD_TYPER_SPIS(gic_data.rdists.gicd_typer)
> 
> This indicates the maximum SPI INTID that the GIC implementation
> supports, should we restrict it to no more than 1020?

I guess we could write it as max(GICD_TYPER_SPIS(...), 1020), but that's
not a material change (the registers backing the special range do exist).

> ITLinesNumber can be '11111', and I saw the following info on my host:
>      "GICv3: 992 SPIs implemented"

Yeah, the above should fix the print.

Thanks,

	M.
-- 
Jazz is not dead, it just smells funny...
