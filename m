Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 318C4D44C5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 17:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbfJKPvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 11:51:25 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3697 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726521AbfJKPvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 11:51:25 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A6F1743842456073C202;
        Fri, 11 Oct 2019 23:51:21 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Fri, 11 Oct 2019
 23:51:16 +0800
Message-ID: <5DA0A4F4.4050103@huawei.com>
Date:   Fri, 11 Oct 2019 23:51:16 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Jerome Pouiller <Jerome.Pouiller@silabs.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: wfx: fix an undefined reference error when CONFIG_MMC=m
References: <1570762939-8735-1-git-send-email-zhongjiang@huawei.com> <20191011042609.GB938845@kroah.com> <3864047.FfxYVOUlJ1@pc-42> <20191011090256.GC1076760@kroah.com>
In-Reply-To: <20191011090256.GC1076760@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/11 17:02, Greg KH wrote:
> On Fri, Oct 11, 2019 at 08:40:08AM +0000, Jerome Pouiller wrote:
>> On Friday 11 October 2019 06:26:16 CEST Greg KH wrote:
>>> CAUTION: This email originated from outside of the organization. Do not 
>> click links or open attachments unless you recognize the sender and know the 
>> content is safe.
>>>
>>> On Fri, Oct 11, 2019 at 11:02:19AM +0800, zhong jiang wrote:
>>>> I hit the following error when compile the kernel.
>>>>
>>>> drivers/staging/wfx/main.o: In function `wfx_core_init':
>>>> /home/z00352263/linux-next/linux-next/drivers/staging/wfx/main.c:488: 
>> undefined reference to `sdio_register_driver'
>>>> drivers/staging/wfx/main.o: In function `wfx_core_exit':
>>>> /home/z00352263/linux-next/linux-next/drivers/staging/wfx/main.c:496: 
>> undefined reference to `sdio_unregister_driver'
>>>> drivers/staging/wfx/main.o:(.debug_addr+0x1a8): undefined reference to 
>> `sdio_register_driver'
>>>> drivers/staging/wfx/main.o:(.debug_addr+0x6f0): undefined reference to 
>> `sdio_unregister_driver'
>>>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>>>> ---
>>>>  drivers/staging/wfx/Kconfig  | 3 ++-
>>>>  drivers/staging/wfx/Makefile | 5 +++--
>>>>  2 files changed, 5 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/staging/wfx/Kconfig b/drivers/staging/wfx/Kconfig
>>>> index 9b8a1c7..4d045513 100644
>>>> --- a/drivers/staging/wfx/Kconfig
>>>> +++ b/drivers/staging/wfx/Kconfig
>>>> @@ -1,7 +1,8 @@
>>>>  config WFX
>>>>       tristate "Silicon Labs wireless chips WF200 and further"
>>>>       depends on MAC80211
>>>> -     depends on (SPI || MMC)
>>>> +     depends on SPI
>>>> +     select MMC
>>> How about:
>>>         depends on (SPI && MMC)
>> I dislike to force user to enable both buses while only one of them is 
>> sufficient. I would prefer to keep current dependencies and to add
>> #ifdef around problematic functions.
> Yes, that's the better thing to do here overall.
>
> zhong, can you work on that?
How about the following patch ?

diff --git a/drivers/staging/wfx/Makefile b/drivers/staging/wfx/Makefile
index 0d9c1ed..77d68b7 100644
--- a/drivers/staging/wfx/Makefile
+++ b/drivers/staging/wfx/Makefile
@@ -19,6 +19,6 @@ wfx-y := \
        sta.o \
        debug.o
 wfx-$(CONFIG_SPI) += bus_spi.o
-wfx-$(subst m,y,$(CONFIG_MMC)) += bus_sdio.o
+wfx-$(CONFIG_MMC) += bus_sdio.o

 obj-$(CONFIG_WFX) += wfx.o
diff --git a/drivers/staging/wfx/main.c b/drivers/staging/wfx/main.c
index d2508bc..26720a4 100644
--- a/drivers/staging/wfx/main.c
+++ b/drivers/staging/wfx/main.c
@@ -484,16 +484,19 @@ static int __init wfx_core_init(void)

        if (IS_ENABLED(CONFIG_SPI))
                ret = spi_register_driver(&wfx_spi_driver);
-       if (IS_ENABLED(CONFIG_MMC) && !ret)
+#ifdef CONFIG_MMC
+       if (!ret)
                ret = sdio_register_driver(&wfx_sdio_driver);
+#endif
        return ret;
 }
 module_init(wfx_core_init);

 static void __exit wfx_core_exit(void)
 {
-       if (IS_ENABLED(CONFIG_MMC))
-               sdio_unregister_driver(&wfx_sdio_driver);
+#ifdef CONFIG_MMC
+       sdio_unregister_driver(&wfx_sdio_driver);
+#endif
        if (IS_ENABLED(CONFIG_SPI))
                spi_unregister_driver(&wfx_spi_driver);
 }
--

Thanks,
zhong jiang
> thanks,
>
> greg k-h
>
> .
>


