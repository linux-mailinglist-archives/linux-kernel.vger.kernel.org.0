Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41C95D661E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 17:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387560AbfJNPaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 11:30:22 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51624 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387516AbfJNPaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 11:30:22 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E38C5F1D64FFFA942B0A;
        Mon, 14 Oct 2019 23:30:17 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Mon, 14 Oct 2019
 23:30:14 +0800
Message-ID: <5DA49486.6010209@huawei.com>
Date:   Mon, 14 Oct 2019 23:30:14 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Jerome Pouiller <Jerome.Pouiller@silabs.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND v2] staging: wfx: fix an undefined reference error
 when CONFIG_MMC=m
References: <1570811647-64905-1-git-send-email-zhongjiang@huawei.com> <5DA13F17.6090409@huawei.com> <2927969.oKuMf0pyRb@pc-42> <2864258.2Qbmp6UNZe@pc-42>
In-Reply-To: <2864258.2Qbmp6UNZe@pc-42>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/14 18:06, Jerome Pouiller wrote:
> On Monday 14 October 2019 11:53:19 CEST Jérôme Pouiller wrote:
> [...]
>> Hello Zhong,
>>
>> Now, I see the problem. It happens when CONFIG_MMC=m and CONFIG_WFX=y
>> (if CONFIG_WFX=m, it works).
>>
>> I think the easiest way to solve problem is to disallow CONFIG_WFX=y if 
>> CONFIG_MMC=m.
>>
>> This solution impacts users who want to use SPI bus with configuration:
>> CONFIG_WFX=y + CONFIG_SPI=y + CONFIG_MMC=m. However, I think this is a
>> twisted case. So, I think it won't be missed.
>>
>> I think that patch below do the right thing:
>>
>> -----8<----------8<----------------------8<-----------------
>>
>> diff --git i/drivers/staging/wfx/Kconfig w/drivers/staging/wfx/Kconfig
>> index 9b8a1c7a9e90..833f3b05b6b4 100644
>> --- i/drivers/staging/wfx/Kconfig
>> +++ w/drivers/staging/wfx/Kconfig
>> @@ -1,7 +1,7 @@
>>  config WFX
>>         tristate "Silicon Labs wireless chips WF200 and further"
>>         depends on MAC80211
>> -       depends on (SPI || MMC)
>> +       depends on (MMC=m && m) || MMC=y || (SPI && MMC!=m)
>>         help
>>           This is a driver for Silicons Labs WFxxx series (WF200 and further)
>>           chipsets. This chip can be found on SPI or SDIO buses.
>>
>>
>>
> An alternative (more understandable?):
>
> diff --git i/drivers/staging/wfx/Kconfig w/drivers/staging/wfx/Kconfig
> index 9b8a1c7a9e90..83ee4d0ca8c6 100644
> --- i/drivers/staging/wfx/Kconfig
> +++ w/drivers/staging/wfx/Kconfig
> @@ -1,6 +1,7 @@
>  config WFX
>         tristate "Silicon Labs wireless chips WF200 and further"
>         depends on MAC80211
> +       depends on MMC || !MMC # do not allow WFX=y if MMC=m
>         depends on (SPI || MMC)
>         help
>           This is a driver for Silicons Labs WFxxx series (WF200 and further)
>
>
It's better and clear.  Thanks

sincerely,
zhong jiang

