Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C74D29A9BE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 10:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389628AbfHWIKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 04:10:50 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34422 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733287AbfHWIKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 04:10:49 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id F2834D33158D16DFF868;
        Fri, 23 Aug 2019 16:10:44 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Fri, 23 Aug 2019
 16:10:43 +0800
Subject: Re: [PATCH v2 -next] soundwire: Fix -Wunused-function warning
To:     Vinod Koul <vkoul@kernel.org>
References: <20190816141409.49940-1-yuehaibing@huawei.com>
 <20190822145408.76272-1-yuehaibing@huawei.com>
 <20190823064417.GC2672@vkoul-mobl>
CC:     <sanyog.r.kale@intel.com>, <pierre-louis.bossart@linux.intel.com>,
        <ladis@linux-mips.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <d4eb9dc5-ac74-2055-003a-7c15f258aaf5@huawei.com>
Date:   Fri, 23 Aug 2019 16:10:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190823064417.GC2672@vkoul-mobl>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/8/23 14:44, Vinod Koul wrote:
> On 22-08-19, 22:54, YueHaibing wrote:
>> If CONFIG_ACPI is not set, gcc warning this:
>>
>> drivers/soundwire/slave.c:16:12: warning:
>>  'sdw_slave_add' defined but not used [-Wunused-function]
>>
>> Now all code in slave.c is only used on ACPI enabled,
>> so compiles it while CONFIG_ACPI is set.
> 
> Sorry YueHaibing as I have said to other patch doing this, this slave.c
> is acpi specific but Srini has already send DT support for this so it
> doesn't become acpi only and this warn also goes away. We should get the
> DT support soon

Ok, thanks!

> 
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Suggested-by: Ladislav Michl <ladis@linux-mips.org>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>> v2: use obj-$(CONFIG_ACPI) += slave.o
>> ---
>>  drivers/soundwire/Makefile | 3 ++-
>>  drivers/soundwire/slave.c  | 3 ---
>>  2 files changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
>> index 45b7e50..a28bf3e 100644
>> --- a/drivers/soundwire/Makefile
>> +++ b/drivers/soundwire/Makefile
>> @@ -4,8 +4,9 @@
>>  #
>>  
>>  #Bus Objs
>> -soundwire-bus-objs := bus_type.o bus.o slave.o mipi_disco.o stream.o
>> +soundwire-bus-objs := bus_type.o bus.o mipi_disco.o stream.o
>>  obj-$(CONFIG_SOUNDWIRE) += soundwire-bus.o
>> +obj-$(CONFIG_ACPI) += slave.o
>>  
>>  #Cadence Objs
>>  soundwire-cadence-objs := cadence_master.o
>> diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
>> index f39a581..0dc188e 100644
>> --- a/drivers/soundwire/slave.c
>> +++ b/drivers/soundwire/slave.c
>> @@ -60,7 +60,6 @@ static int sdw_slave_add(struct sdw_bus *bus,
>>  	return ret;
>>  }
>>  
>> -#if IS_ENABLED(CONFIG_ACPI)
>>  /*
>>   * sdw_acpi_find_slaves() - Find Slave devices in Master ACPI node
>>   * @bus: SDW bus instance
>> @@ -110,5 +109,3 @@ int sdw_acpi_find_slaves(struct sdw_bus *bus)
>>  
>>  	return 0;
>>  }
>> -
>> -#endif
>> -- 
>> 2.7.4
>>
> 

