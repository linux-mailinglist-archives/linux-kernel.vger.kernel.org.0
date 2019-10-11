Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00CD3D3948
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 08:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfJKGUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 02:20:22 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3731 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726401AbfJKGUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 02:20:22 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A265B27779FA3EAE2939;
        Fri, 11 Oct 2019 14:20:18 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Fri, 11 Oct 2019
 14:20:17 +0800
Message-ID: <5DA01F20.8020402@huawei.com>
Date:   Fri, 11 Oct 2019 14:20:16 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <jerome.pouiller@silabs.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: wfx: fix an undefined reference error when CONFIG_MMC=m
References: <1570762939-8735-1-git-send-email-zhongjiang@huawei.com> <20191011042609.GB938845@kroah.com>
In-Reply-To: <20191011042609.GB938845@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/11 12:26, Greg KH wrote:
> On Fri, Oct 11, 2019 at 11:02:19AM +0800, zhong jiang wrote:
>> I hit the following error when compile the kernel.
>>
>> drivers/staging/wfx/main.o: In function `wfx_core_init':
>> /home/z00352263/linux-next/linux-next/drivers/staging/wfx/main.c:488: undefined reference to `sdio_register_driver'
>> drivers/staging/wfx/main.o: In function `wfx_core_exit':
>> /home/z00352263/linux-next/linux-next/drivers/staging/wfx/main.c:496: undefined reference to `sdio_unregister_driver'
>> drivers/staging/wfx/main.o:(.debug_addr+0x1a8): undefined reference to `sdio_register_driver'
>> drivers/staging/wfx/main.o:(.debug_addr+0x6f0): undefined reference to `sdio_unregister_driver'
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>  drivers/staging/wfx/Kconfig  | 3 ++-
>>  drivers/staging/wfx/Makefile | 5 +++--
>>  2 files changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/staging/wfx/Kconfig b/drivers/staging/wfx/Kconfig
>> index 9b8a1c7..4d045513 100644
>> --- a/drivers/staging/wfx/Kconfig
>> +++ b/drivers/staging/wfx/Kconfig
>> @@ -1,7 +1,8 @@
>>  config WFX
>>  	tristate "Silicon Labs wireless chips WF200 and further"
>>  	depends on MAC80211
>> -	depends on (SPI || MMC)
>> +	depends on SPI
>> +	select MMC
> How about:
> 	depends on (SPI && MMC)
>
> instead?
Yep,  That is better.  Will repost in v2.  Thanks,

Sincerely,
zhong jiang
> thanks,
>
> greg k-h
>
> .
>


