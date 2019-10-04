Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83972CBEE2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 17:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389821AbfJDPRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 11:17:51 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56652 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388802AbfJDPRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 11:17:49 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CBC177038409EE3651A3;
        Fri,  4 Oct 2019 23:17:46 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.179) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Fri, 4 Oct 2019
 23:17:42 +0800
Subject: Re: [PATCH] mtd: spi-nor: Fix direction of the write_sr() transfer
To:     <Tudor.Ambarus@microchip.com>, <vigneshr@ti.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <c703dec2-dd11-5898-83ad-fb06127b6575@huawei.com>
 <20191004104746.23537-1-tudor.ambarus@microchip.com>
 <9156860e-d257-bee6-fac8-a1821e4b5bf2@microchip.com>
 <60f0c52f-1301-57eb-59ba-b2893107d5d6@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <6eecffe2-539f-f1a1-2008-3877c5f5c3ef@huawei.com>
Date:   Fri, 4 Oct 2019 16:17:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <60f0c52f-1301-57eb-59ba-b2893107d5d6@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2019 12:31, John Garry wrote:
> On 04/10/2019 11:48, Tudor.Ambarus@microchip.com wrote:
>> John, does this fix your problem?
>
> It fixes the problem in the flash_lock -u command no longer errors like
> this:
> root@ubuntu:/home/john# sudo flash_lock -u /dev/mtd0
> flash_lock: error!: could not unlock device: /dev/mtd0
>
> However, with this change, even when the flash is unlocked I cannot
> write, so there is something else wrong. It's probably a bug in my
> under-development driver. I'm looking at it now.

Just to confirm, I tested an earlier HW version with my driver and flash 
lock/unlock function is ok. There seems something wrong with the latest 
HW version which I need to understand.

Anyway:
Tested-by: John Garry <john.garry@huawei.com>

Thanks,
John

>
>>
>> On 10/04/2019 01:47 PM, Tudor Ambarus - M18064 wrote:
>>> From: Tudor Ambarus <tudor.ambarus@microchip.com>
>>>
>>> write_sr() sends data to the SPI memory, fix the direction.
>>>
>>> Fixes: b35b9a10362d ("mtd: spi-nor: Move m25p80 code in spi-nor.c")
>>> Reported-by: John Garry <john.garry@huawei.com>
>>> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>>> ---
>>>  drivers/mtd/spi-nor/spi-nor.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mtd/spi-nor/spi-nor.c
>>> b/drivers/mtd/spi-nor/spi-nor.c
>>> index 1d8621d43160..7acf4a93b592 100644
>>> --- a/drivers/mtd/spi-nor/spi-nor.c
>>> +++ b/drivers/mtd/spi-nor/spi-nor.c
>>> @@ -487,7 +487,7 @@ static int write_sr(struct spi_nor *nor, u8 val)
>>>              SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRSR, 1),
>>>                     SPI_MEM_OP_NO_ADDR,
>>>                     SPI_MEM_OP_NO_DUMMY,
>>> -                   SPI_MEM_OP_DATA_IN(1, nor->bouncebuf, 1));
>>> +                   SPI_MEM_OP_DATA_OUT(1, nor->bouncebuf, 1));
>>>
>>>          return spi_mem_exec_op(nor->spimem, &op);
>>>      }
>>>
>


