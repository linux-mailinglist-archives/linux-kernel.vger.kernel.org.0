Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 706FDD452F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 18:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbfJKQQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 12:16:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbfJKQQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 12:16:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DD24206A1;
        Fri, 11 Oct 2019 16:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570810613;
        bh=SK33dO3xJOl9SGBm7lxVYFaCYzgwPb8MMJCvL1ykG0g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NUErgLmoEUrgJitmNIYwWNROq+kplAPoRZvbSbwSAUGMW5xRSxztSC/vk3fB2bRXI
         vJRzGC1Cvy6Cts1wzZw1J9n3Ap4Ni91n5Q3o6BUVnDsOlhFcJt7K/0R5fmI7dPOMma
         fL4gVEm6pFKGMEnwYqlKKiINPhLgxzjytUSoWHkI=
Date:   Fri, 11 Oct 2019 18:16:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     Jerome Pouiller <Jerome.Pouiller@silabs.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: wfx: fix an undefined reference error when
 CONFIG_MMC=m
Message-ID: <20191011161650.GA1286849@kroah.com>
References: <1570762939-8735-1-git-send-email-zhongjiang@huawei.com>
 <20191011042609.GB938845@kroah.com>
 <3864047.FfxYVOUlJ1@pc-42>
 <20191011090256.GC1076760@kroah.com>
 <5DA0A4F4.4050103@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5DA0A4F4.4050103@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 11:51:16PM +0800, zhong jiang wrote:
> On 2019/10/11 17:02, Greg KH wrote:
> > On Fri, Oct 11, 2019 at 08:40:08AM +0000, Jerome Pouiller wrote:
> >> On Friday 11 October 2019 06:26:16 CEST Greg KH wrote:
> >>> CAUTION: This email originated from outside of the organization. Do not 
> >> click links or open attachments unless you recognize the sender and know the 
> >> content is safe.
> >>>
> >>> On Fri, Oct 11, 2019 at 11:02:19AM +0800, zhong jiang wrote:
> >>>> I hit the following error when compile the kernel.
> >>>>
> >>>> drivers/staging/wfx/main.o: In function `wfx_core_init':
> >>>> /home/z00352263/linux-next/linux-next/drivers/staging/wfx/main.c:488: 
> >> undefined reference to `sdio_register_driver'
> >>>> drivers/staging/wfx/main.o: In function `wfx_core_exit':
> >>>> /home/z00352263/linux-next/linux-next/drivers/staging/wfx/main.c:496: 
> >> undefined reference to `sdio_unregister_driver'
> >>>> drivers/staging/wfx/main.o:(.debug_addr+0x1a8): undefined reference to 
> >> `sdio_register_driver'
> >>>> drivers/staging/wfx/main.o:(.debug_addr+0x6f0): undefined reference to 
> >> `sdio_unregister_driver'
> >>>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> >>>> ---
> >>>>  drivers/staging/wfx/Kconfig  | 3 ++-
> >>>>  drivers/staging/wfx/Makefile | 5 +++--
> >>>>  2 files changed, 5 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/drivers/staging/wfx/Kconfig b/drivers/staging/wfx/Kconfig
> >>>> index 9b8a1c7..4d045513 100644
> >>>> --- a/drivers/staging/wfx/Kconfig
> >>>> +++ b/drivers/staging/wfx/Kconfig
> >>>> @@ -1,7 +1,8 @@
> >>>>  config WFX
> >>>>       tristate "Silicon Labs wireless chips WF200 and further"
> >>>>       depends on MAC80211
> >>>> -     depends on (SPI || MMC)
> >>>> +     depends on SPI
> >>>> +     select MMC
> >>> How about:
> >>>         depends on (SPI && MMC)
> >> I dislike to force user to enable both buses while only one of them is 
> >> sufficient. I would prefer to keep current dependencies and to add
> >> #ifdef around problematic functions.
> > Yes, that's the better thing to do here overall.
> >
> > zhong, can you work on that?
> How about the following patch ?
> 
> diff --git a/drivers/staging/wfx/Makefile b/drivers/staging/wfx/Makefile
> index 0d9c1ed..77d68b7 100644
> --- a/drivers/staging/wfx/Makefile
> +++ b/drivers/staging/wfx/Makefile
> @@ -19,6 +19,6 @@ wfx-y := \
>         sta.o \
>         debug.o
>  wfx-$(CONFIG_SPI) += bus_spi.o
> -wfx-$(subst m,y,$(CONFIG_MMC)) += bus_sdio.o
> +wfx-$(CONFIG_MMC) += bus_sdio.o
> 
>  obj-$(CONFIG_WFX) += wfx.o
> diff --git a/drivers/staging/wfx/main.c b/drivers/staging/wfx/main.c
> index d2508bc..26720a4 100644
> --- a/drivers/staging/wfx/main.c
> +++ b/drivers/staging/wfx/main.c
> @@ -484,16 +484,19 @@ static int __init wfx_core_init(void)
> 
>         if (IS_ENABLED(CONFIG_SPI))
>                 ret = spi_register_driver(&wfx_spi_driver);
> -       if (IS_ENABLED(CONFIG_MMC) && !ret)
> +#ifdef CONFIG_MMC
> +       if (!ret)
>                 ret = sdio_register_driver(&wfx_sdio_driver);

Put this in an inline function in the .h file so that you just call:
	wfx_register_sdio_driver()
and it does what is needed to be done depending on if CONFIG_MMC is
enabled or not (note, your check here isn't quite correct, I think you
need to do IS_ENABLED())

Same for spi.

We really do not like #ifdefs in .c files.

thanks,

greg k-h
