Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35F788306F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 13:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732787AbfHFLPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 07:15:31 -0400
Received: from foss.arm.com ([217.140.110.172]:60356 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732724AbfHFLPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 07:15:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD37B337;
        Tue,  6 Aug 2019 04:15:29 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 770E23F694;
        Tue,  6 Aug 2019 04:15:28 -0700 (PDT)
Subject: Re: [PATCH v2 10/12] irqchip/gic-v3: Warn about inconsistent
 implementations of extended ranges
To:     Vladimir Murzin <vladimir.murzin@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Lokesh Vutla <lokeshvutla@ti.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org
References: <20190806100121.240767-1-maz@kernel.org>
 <20190806100121.240767-11-maz@kernel.org>
 <e5512fcc-e24e-c29a-8a57-011d194e3c41@arm.com>
From:   Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <26b27325-9b92-8152-7289-26561a7e468f@kernel.org>
Date:   Tue, 6 Aug 2019 12:15:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e5512fcc-e24e-c29a-8a57-011d194e3c41@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

On 06/08/2019 11:15, Vladimir Murzin wrote:
> Hi Marc,
> 
> On 8/6/19 11:01 AM, Marc Zyngier wrote:
>> As is it usual for the GIC, it isn't disallowed to put together a system
>> that is majorly inconsistent, with a distributor supporting the
>> extended ranges while some of the CPUs don't.
>>
>> Kindly tell the user that things are sailing isn't going to be smooth.
>>
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> ---
>>  drivers/irqchip/irq-gic-v3.c       | 5 +++++
>>  include/linux/irqchip/arm-gic-v3.h | 1 +
>>  2 files changed, 6 insertions(+)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
>> index f53e58d398ba..334a10d9dbfb 100644
>> --- a/drivers/irqchip/irq-gic-v3.c
>> +++ b/drivers/irqchip/irq-gic-v3.c
>> @@ -1014,6 +1014,11 @@ static void gic_cpu_init(void)
>>  
>>  	gic_enable_redist(true);
>>  
>> +	WARN((gic_data.ppi_nr > 16 || GIC_ESPI_NR != 0) &&
>> +	     !(gic_read_ctlr() & ICC_CTLR_EL1_ExtRange),
>> +	     "Distributor has extended ranges, but CPU%d doesn't\n",
>> +	     smp_processor_id());
>> +
> 
> Should such setup be tainted?

I'm not completely sure. The system isn't really dead, but a whole range
of interrupts will not be able to make it to the CPU. It won't be less
reliable though.

I expect this to be more for system integration purposes (simulation
setup, for example), where something hasn't been setup correctly. Or to
spot implementation creativity, such as in the last patch.

I'm happy either way, TBH.

Thanks,

	M.
-- 
Jazz is not dead, it just smells funny...
