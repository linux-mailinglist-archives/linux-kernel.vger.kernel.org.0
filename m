Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD93320AE
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2019 22:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfFAUVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jun 2019 16:21:33 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:60179 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbfFAUVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 16:21:33 -0400
Received: from tarshish (unknown [10.0.8.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id F354044077F;
        Sat,  1 Jun 2019 23:21:11 +0300 (IDT)
References: <20190531133733.16243-1-wangkefeng.wang@huawei.com>
User-agent: mu4e 1.0; emacs 26.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] tty/serial: digicolor: Fix digicolor-usart already registered warning
In-reply-to: <20190531133733.16243-1-wangkefeng.wang@huawei.com>
Date:   Sat, 01 Jun 2019 23:21:28 +0300
Message-ID: <8736ktoy47.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kefeng,

On Fri, May 31 2019, Kefeng Wang wrote:
> When modprobe/rmmod/modprobe module, if platform_driver_register() fails,
> the kernel complained,
>
>   proc_dir_entry 'driver/digicolor-usart' already registered
>   WARNING: CPU: 1 PID: 5636 at fs/proc/generic.c:360 proc_register+0x19d/0x270
>
> Fix this by adding uart_unregister_driver() when platform_driver_register() fails.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Acked-by: Baruch Siach <baruch@tkos.co.il>

Thanks,
baruch

> ---
>  drivers/tty/serial/digicolor-usart.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/digicolor-usart.c b/drivers/tty/serial/digicolor-usart.c
> index f460cca139e2..13ac36e2da4f 100644
> --- a/drivers/tty/serial/digicolor-usart.c
> +++ b/drivers/tty/serial/digicolor-usart.c
> @@ -541,7 +541,11 @@ static int __init digicolor_uart_init(void)
>  	if (ret)
>  		return ret;
>  
> -	return platform_driver_register(&digicolor_uart_platform);
> +	ret = platform_driver_register(&digicolor_uart_platform);
> +	if (ret)
> +		uart_unregister_driver(&digicolor_uart);
> +
> +	return ret;
>  }
>  module_init(digicolor_uart_init);

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
