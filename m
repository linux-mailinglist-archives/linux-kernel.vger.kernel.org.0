Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 491FA10CC1E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 16:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfK1Pw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 10:52:56 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:25298 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726446AbfK1Pwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 10:52:55 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xASFfhvb011866;
        Thu, 28 Nov 2019 16:52:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=uZxHaoWzODz6bcYUYGGf3FPtR/YYwM5HK1xVVnnETUc=;
 b=rVcbcOdSr+ZZyamHhUPIishbOE/Zq7/Pzl+sbFjP232MAw32Rx6aYUbutP3ev4xFGe9X
 OUo6et9j9t3SSWycLHGZe7348HXQiQlDnm/nnI+G6qrEhHbHUbbFsD8f3l6Wx35UYLuD
 t2becxLz5AXAXxrxrqL4YJtLxrY3ucyJH3bUPAgPcwzEEFiT6xagwlcLJzkZ9QnYPIzm
 elEaRK9W1Unkd23pOUXIUq04wIt7m8ZtOzBN6ZlgVburk/yoazYGiiqhEPAXkjXK1szK
 ZP7aGyyXx/mmTMQp5GIYXvQoE9HwCNtG5HOjlaXLRioqayYt+o04Xy9WbTG/LxWmBfmR Dg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2whcxsjxw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Nov 2019 16:52:35 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 89ED310002A;
        Thu, 28 Nov 2019 16:52:33 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6F4C22BF9BF;
        Thu, 28 Nov 2019 16:52:33 +0100 (CET)
Received: from [10.201.23.29] (10.75.127.44) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 28 Nov
 2019 16:52:32 +0100
Subject: Re: mtd: Use mtd device name instead of mtd->name when registering
 nvmem device
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Boris Brezillon <bbrezillon@kernel.org>
References: <1574442222-19759-1-git-send-email-christophe.kerello@st.com>
 <20191125160503.1243f817@xps13> <20191125163745.26095b68@xps13>
From:   Christophe Kerello <christophe.kerello@st.com>
Message-ID: <d3c42dfc-8eb6-b6d1-de96-f7ded3830341@st.com>
Date:   Thu, 28 Nov 2019 16:52:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191125163745.26095b68@xps13>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-28_04:2019-11-28,2019-11-28 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On 11/25/19 4:37 PM, Miquel Raynal wrote:
> Miquel Raynal <miquel.raynal@bootlin.com> wrote on Mon, 25 Nov 2019
> 16:05:03 +0100:
> 
>> Hi Christophe,
>>
>> Christophe Kerello <christophe.kerello@st.com> wrote on Fri, 22 Nov
>> 2019 18:03:42 +0100:
>>
>>> MTD currently allows to have same partition name on different devices.
>>> Since nvmen device registration has been added, it is not more possible
>>> to have same partition name on different devices. We get following
>>> logs:
>>> sysfs: cannot create duplicate filename XXX
>>> Failed to register NVMEM device
>>>
>>> To avoid such issue, the proposed patch uses the mtd device name instead of
>>> the partition name.
>>>
>>> Fixes: c4dfa25ab307 ("mtd: add support for reading MTD devices via the nvmem API")
>>> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
>>> ---
>>> Hi,
>>>
>>> With latest mtd-next branch, we get following logs on our STM32MP1 eval board.
>>>
>>> [    1.979089] nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xd3
>>> [    1.984055] nand: Micron MT29F8G08ABACAH4
>>> [    1.988000] nand: 1024 MiB, SLC, erase size: 256 KiB, page size: 4096, OOB size: 224
>>> [    1.996378] Bad block table found at page 262080, version 0x01
>>> [    2.001945] Bad block table found at page 262016, version 0x01
>>> [    2.008002] 4 fixed-partitions partitions found on MTD device 58002000.nand-controller
>>> [    2.015398] Creating 4 MTD partitions on "58002000.nand-controller":
>>> [    2.021751] 0x000000000000-0x000000200000 : "fsbl"
>>> [    2.028506] 0x000000200000-0x000000400000 : "ssbl1"
>>> [    2.033741] 0x000000400000-0x000000600000 : "ssbl2"
>>> [    2.038924] 0x000000600000-0x000040000000 : "UBI"
>>> [    2.051336] spi-nor spi0.0: mx66l51235l (65536 Kbytes)
>>> [    2.055123] 4 fixed-partitions partitions found on MTD device spi0.0
>>> [    2.061378] Creating 4 MTD partitions on "spi0.0":
>>> [    2.066243] 0x000000000000-0x000000040000 : "fsbl"
>>> [    2.071429] sysfs: cannot create duplicate filename '/bus/nvmem/devices/fsbl'
>>> [    2.078157] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.4.0-rc4-00031-g589e1b6 #176
>>> [    2.085781] Hardware name: STM32 (Device Tree Support)
>>> [    2.090957] [<c0312830>] (unwind_backtrace) from [<c030cbe4>] (show_stack+0x10/0x14)
>>> [    2.098693] [<c030cbe4>] (show_stack) from [<c0e8d340>] (dump_stack+0xb4/0xc8)
>>> [    2.105929] [<c0e8d340>] (dump_stack) from [<c050fcdc>] (sysfs_warn_dup+0x58/0x64)
>>> [    2.113509] [<c050fcdc>] (sysfs_warn_dup) from [<c0510010>] (sysfs_do_create_link_sd+0xe4/0xe8)
>>> [    2.122224] [<c0510010>] (sysfs_do_create_link_sd) from [<c0956f60>] (bus_add_device+0x80/0xfc)
>>> [    2.130938] [<c0956f60>] (bus_add_device) from [<c0953f54>] (device_add+0x35c/0x608)
>>> [    2.138697] [<c0953f54>] (device_add) from [<c0d12e0c>] (nvmem_register.part.2+0x180/0x624)
>>> [    2.147065] [<c0d12e0c>] (nvmem_register.part.2) from [<c09ea5c8>] (add_mtd_device+0x2d8/0x4b8)
>>> [    2.155776] [<c09ea5c8>] (add_mtd_device) from [<c09edbd4>] (add_mtd_partitions+0x84/0x16c)
>>> [    2.164140] [<c09edbd4>] (add_mtd_partitions) from [<c09ed9ac>] (parse_mtd_partitions+0x220/0x3c4)
>>> [    2.173118] [<c09ed9ac>] (parse_mtd_partitions) from [<c09ea8d4>] (mtd_device_parse_register+0x40/0x164)
>>> [    2.182622] [<c09ea8d4>] (mtd_device_parse_register) from [<c0a22dfc>] (spi_nor_probe+0xd0/0x190)
>>> [    2.191513] [<c0a22dfc>] (spi_nor_probe) from [<c0a370a0>] (spi_drv_probe+0x80/0xa4)
>>> [    2.199268] [<c0a370a0>] (spi_drv_probe) from [<c0957f8c>] (really_probe+0x234/0x34c)
>>> [    2.207111] [<c0957f8c>] (really_probe) from [<c095821c>] (driver_probe_device+0x60/0x174)
>>> [    2.215391] [<c095821c>] (driver_probe_device) from [<c0956378>] (bus_for_each_drv+0x58/0xb8)
>>> [    2.223932] [<c0956378>] (bus_for_each_drv) from [<c0957ce4>] (__device_attach+0xd0/0x13c)
>>> [    2.232212] [<c0957ce4>] (__device_attach) from [<c0957060>] (bus_probe_device+0x84/0x8c)
>>> [    2.240404] [<c0957060>] (bus_probe_device) from [<c0953fb4>] (device_add+0x3bc/0x608)
>>> [    2.248334] [<c0953fb4>] (device_add) from [<c0a377b4>] (spi_add_device+0x9c/0x14c)
>>> [    2.256003] [<c0a377b4>] (spi_add_device) from [<c0a37b98>] (of_register_spi_device+0x234/0x370)
>>> [    2.264807] [<c0a37b98>] (of_register_spi_device) from [<c0a384ec>] (spi_register_controller+0x578/0x734)
>>> [    2.274394] [<c0a384ec>] (spi_register_controller) from [<c0a386dc>] (devm_spi_register_controller+0x34/0x6c)
>>> [    2.284331] [<c0a386dc>] (devm_spi_register_controller) from [<c0a4d0b8>] (stm32_qspi_probe+0x338/0x3bc)
>>> [    2.293831] [<c0a4d0b8>] (stm32_qspi_probe) from [<c0959ee0>] (platform_drv_probe+0x48/0x98)
>>> [    2.302285] [<c0959ee0>] (platform_drv_probe) from [<c0957f8c>] (really_probe+0x234/0x34c)
>>> [    2.310566] [<c0957f8c>] (really_probe) from [<c095821c>] (driver_probe_device+0x60/0x174)
>>> [    2.318847] [<c095821c>] (driver_probe_device) from [<c09584d8>] (device_driver_attach+0x58/0x60)
>>> [    2.327735] [<c09584d8>] (device_driver_attach) from [<c0958560>] (__driver_attach+0x80/0xbc)
>>> [    2.336276] [<c0958560>] (__driver_attach) from [<c09562cc>] (bus_for_each_dev+0x74/0xb4)
>>> [    2.344469] [<c09562cc>] (bus_for_each_dev) from [<c09572c4>] (bus_add_driver+0x164/0x1e8)
>>> [    2.352749] [<c09572c4>] (bus_add_driver) from [<c0958fd8>] (driver_register+0x74/0x108)
>>> [    2.360854] [<c0958fd8>] (driver_register) from [<c0302ec8>] (do_one_initcall+0x54/0x22c)
>>> [    2.369047] [<c0302ec8>] (do_one_initcall) from [<c1501024>] (kernel_init_freeable+0x150/0x1ec)
>>> [    2.377762] [<c1501024>] (kernel_init_freeable) from [<c0ea5e74>] (kernel_init+0x8/0x114)
>>> [    2.385951] [<c0ea5e74>] (kernel_init) from [<c03010e8>] (ret_from_fork+0x14/0x2c)
>>> [    2.393525] Exception stack(0xe68c1fb0 to 0xe68c1ff8)
>>> [    2.398583] 1fa0:                                     00000000 00000000 00000000 00000000
>>> [    2.406777] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>>> [    2.414967] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>>> [    2.421879] mtd mtd4: Failed to register NVMEM device
>>>
>>> Before nvmen device registration was added, it was possible to have same partition name on different devices.
>>> Instead of using the partition name, this patch proposes to use the MTD device name (mtdX).
>>>
>>> Regards,
>>> Christophe Kerello.
>>>
>>>   drivers/mtd/mtdcore.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
>>> index 5fac435..559b693 100644
>>> --- a/drivers/mtd/mtdcore.c
>>> +++ b/drivers/mtd/mtdcore.c
>>> @@ -551,7 +551,7 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
>>>   
>>>   	config.id = -1;
>>>   	config.dev = &mtd->dev;
>>> -	config.name = mtd->name;
>>> +	config.name = dev_name(&mtd->dev);
>>
>> What about creating an mtd->fullname field which would be, for
>> partitions: mtdX:<partition-name> and would be unique?
> 
> The actual mtd->name (driver name or label if given) instead of the mtd
> number would be better. That would give things like "nand0:mypart".

Based on Steve's comment, it seems better to abandon this proposed fix. 
We will use unique partition names on our side.

Regards,
Christophe Kerello.

> 
>>
>>>   	config.owner = THIS_MODULE;
>>>   	config.reg_read = mtd_nvmem_reg_read;
>>>   	config.size = mtd->size;
>>
>> Thanks,
>> Miquèl
> 
> Thanks,
> Miquèl
> 
