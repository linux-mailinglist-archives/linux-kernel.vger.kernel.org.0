Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2DC8CB834
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 12:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbfJDK1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 06:27:06 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3200 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726111AbfJDK1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 06:27:05 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A76BFFD8EF33CB53B3BE;
        Fri,  4 Oct 2019 18:26:59 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.179) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Fri, 4 Oct 2019
 18:26:57 +0800
Subject: Re: [PATCH v2 10/22] mtd: spi-nor: Rework write_sr()
To:     <Tudor.Ambarus@microchip.com>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>, <marek.vasut@gmail.com>,
        <linux-mtd@lists.infradead.org>, <geert+renesas@glider.be>,
        <jonas@norrbonn.se>
References: <20190924074533.6618-1-tudor.ambarus@microchip.com>
 <20190924074533.6618-11-tudor.ambarus@microchip.com>
 <83d62334-bd1c-20b7-3c58-225392c819f8@huawei.com>
 <e5d9b91f-cb86-0b82-5631-af0868ba4796@microchip.com>
CC:     <linux-aspeed@lists.ozlabs.org>, <andrew@aj.id.au>,
        <richard@nod.at>, <linux-kernel@vger.kernel.org>, <vz@mleia.com>,
        <linux-mediatek@lists.infradead.org>, <joel@jms.id.au>,
        <miquel.raynal@bootlin.com>, <matthias.bgg@gmail.com>,
        <computersforpeace@gmail.com>, <dwmw2@infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <c703dec2-dd11-5898-83ad-fb06127b6575@huawei.com>
Date:   Fri, 4 Oct 2019 11:26:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <e5d9b91f-cb86-0b82-5631-af0868ba4796@microchip.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2019 11:03, Tudor.Ambarus@microchip.com wrote:
> Hi, John,
>
> On 10/04/2019 12:39 PM, John Garry wrote:
>> External E-Mail
>>
>>
>> On 24/09/2019 08:46, Tudor.Ambarus@microchip.com wrote:
>>> +}
>>> +
>>> +/**
>>> + * spi_nor_write_sr() - Write the Status Register.
>>> + * @nor:    pointer to 'struct spi_nor'.
>>> + * @sr:        buffer to write to the Status Register.
>>> + * @len:    number of bytes to write to the Status Register.
>>> + *
>>> + * Return: 0 on success, -errno otherwise.
>>>   */
>>> -static int write_sr(struct spi_nor *nor, u8 val)
>>> +static int spi_nor_write_sr(struct spi_nor *nor, const u8 *sr, size_t len)
>>>  {
>>> -    nor->bouncebuf[0] = val;
>>> +    int ret;
>>> +
>>> +    ret = spi_nor_write_enable(nor);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>
>> Hi Tudor,
>>
>>>      if (nor->spimem) {
>>>          struct spi_mem_op op =
>>>              SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRSR, 1),
>>>                     SPI_MEM_OP_NO_ADDR,
>>>                     SPI_MEM_OP_NO_DUMMY,
>>> -                   SPI_MEM_OP_DATA_IN(1, nor->bouncebuf, 1));
>>
>> This be SPI_MEM_OP_DATA_OUT() in the current mainline code also, right?

Hi Tudor,

>
> In v5.4-rc1 this is defined as SPI_MEM_OP_DATA_IN, so the Mainline code should
> fail. This looks like a bug. I didn't noticed it when doing the patch.
>
>>
>> I'm testing my under development driver on top of v5.4-rc1, and flash_lock -u is broken.
>
> It's not clear to me, does flash_lock fail with my patches on top of v5.4-rc1?

No, I haven't tested these patches. I'm just testing my out-of-tree 
driver on top of vanilla v5.4-rc1. I'm just mentioning the issue here as 
it seemed like a reasonably appropriate place.

However it looks like I will also need to test on top of these patches.

> Or it fails when testing v5.4-rc1?
>
> Can you test v5.4-rc1 and see if flash_lock works on you flash or not?

flash_lock -u errors for my driver on top of vanilla v5.4-rc1.

When I make the change, as above, flash_lock -u and -l succeed, but I 
can still write to the flash - I need to check that more - it may be my 
buggy driver.

IIRC, it did work for my driver based on v5.3

>
> Please specify which flash do you use, and which controller.

The flash is n25q128a11:
[   14.917868] spi-nor spi-PRP0001:00: n25q128a11 (16384 Kbytes)

As for the driver, it's another HiSilicon SPI NOR controller driver 
which I'm developing - I eluded to it here already: 
https://lore.kernel.org/linux-mtd/c5e063e8-5025-8206-f819-6ce5228ef0fb@huawei.com/

Cheers,
John

>
> Thanks for testing this!
> ta
>


